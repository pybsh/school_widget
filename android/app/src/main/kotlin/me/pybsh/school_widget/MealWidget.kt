package me.pybsh.school_widget

import HomeWidgetGlanceState
import HomeWidgetGlanceStateDefinition
import android.content.Context
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.glance.GlanceId
import androidx.glance.GlanceModifier
import androidx.glance.ImageProvider
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.action.actionRunCallback
import androidx.glance.appwidget.components.CircleIconButton
import androidx.glance.appwidget.provideContent
import androidx.glance.background
import androidx.glance.currentState
import androidx.glance.layout.Alignment
import androidx.glance.layout.Box
import androidx.glance.layout.Column
import androidx.glance.layout.fillMaxSize
import androidx.glance.layout.fillMaxWidth
import androidx.glance.layout.padding
import androidx.glance.layout.Row
import androidx.glance.state.GlanceStateDefinition
import androidx.glance.text.Text
import androidx.glance.text.TextStyle

class MealWidget : GlanceAppWidget() {
    override val stateDefinition: GlanceStateDefinition<*>?
        get() = HomeWidgetGlanceStateDefinition()

    override suspend fun provideGlance(context: Context, id: GlanceId) {
        provideContent {
            GlanceContent(context, currentState())
        }
    }

    @Composable
    private fun GlanceContent(context: Context, currentState: HomeWidgetGlanceState) {
        val prefs = currentState.preferences
        val meal = prefs.getString("meal", "-")

        Box(modifier = GlanceModifier.background(Color.White).padding(8.dp)) {
            Column(modifier = GlanceModifier.fillMaxSize()) {
                Row(modifier = GlanceModifier.fillMaxWidth(), horizontalAlignment = Alignment.End) {
                    CircleIconButton(
                        imageProvider = ImageProvider(R.drawable.refresh_24px),
                        contentDescription = "Refresh Meal",
                        onClick = actionRunCallback<MealInteractionAction>(),
                        modifier = GlanceModifier.padding(4.dp)
                    )
                }

                Box(modifier = GlanceModifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                    Text(
                        meal.toString(),
                        style = TextStyle(fontSize = 13.sp),
                        modifier = GlanceModifier.padding(16.dp)
                    )
                }
            }
        }
    }
}