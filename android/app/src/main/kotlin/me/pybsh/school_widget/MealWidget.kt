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
import androidx.glance.layout.wrapContentHeight
import androidx.glance.state.GlanceStateDefinition
import androidx.glance.text.FontWeight
import androidx.glance.text.Text
import androidx.glance.text.TextAlign
import androidx.glance.text.TextStyle
import androidx.glance.unit.ColorProvider
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

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
        val dateFormat = SimpleDateFormat("MM/dd", Locale.getDefault())
        val currentDate = dateFormat.format(Date())

        Column(modifier = GlanceModifier.fillMaxSize().background(Color.White), horizontalAlignment = Alignment.CenterHorizontally) {
            Box(
                modifier = GlanceModifier.fillMaxWidth(),
                contentAlignment = Alignment.TopEnd
            ) {
                CircleIconButton(
                    imageProvider = ImageProvider(R.drawable.refresh_24px),
                    contentDescription = "Refresh Meal",
                    onClick = actionRunCallback<MealInteractionAction>(),
                    backgroundColor = null,
                    modifier = GlanceModifier.padding(4.dp)
                )
            }

            Text(
                text = "[$currentDate] 급식🍔",
                style = TextStyle(
                    fontSize = 14.sp,
                    color = ColorProvider(Color(0xFFFFA500)),
                    fontWeight = FontWeight.Bold,
                    textAlign = TextAlign.Center
                ),
            )
            Text(
                meal.toString(),
                style = TextStyle(fontSize = 13.sp, textAlign = TextAlign.Center),
            )
        }
    }
}