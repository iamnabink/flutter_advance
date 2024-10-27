package app.nabrajkhadka.flutter_advance

import android.Manifest
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.widget.RemoteViews
import androidx.core.app.ActivityCompat
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import app.nabrajkhadka.flutter_advance.flutter_advance.MainActivity
import app.nabrajkhadka.flutter_advance.flutter_advance.R


class CustomNotification {

    companion object {
        fun showCustomNotification(context: Context) {
            val channelId = "custom_channel_id"
            val channelName = "Custom Notification"
            val notificationId = 101

            // Step 2.1: Create Notification Channel (For Android O and above)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                val channel = NotificationChannel(
                    channelId,
                    channelName,
                    NotificationManager.IMPORTANCE_HIGH,
                )
                val notificationManager = context.getSystemService(NotificationManager::class.java)
                channel.enableVibration(true)
                notificationManager?.createNotificationChannel(channel)

            }


            // Step 2.2: Create an Intent for when notification is clicked
            val intent = Intent(context, MainActivity::class.java).apply {
                flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
            }
            val pendingIntent: PendingIntent = PendingIntent.getActivity(
                context, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )

            // Step 2.3: Inflate the custom notification layout
            val customLayout = RemoteViews(context.packageName, R.layout.custom_notification)

            // Step 2.4: Customize the content (e.g., set the text dynamically)
            customLayout.setTextViewText(R.id.notification_title, "New Custom Title")
            customLayout.setTextViewText(R.id.notification_text, "This is the custom notification content")

            // Step 2.5: Build the notification
            val notification = NotificationCompat.Builder(context, channelId)
                .setSmallIcon(R.drawable.ic_launcher_foreground)
                .setCustomContentView(customLayout)
                .setContentIntent(pendingIntent)
                .setAutoCancel(true)
                .build()

            // Step 2.6: Show the notification

            with(NotificationManagerCompat.from(context)) {
                if (ActivityCompat.checkSelfPermission(
                        context,
                        Manifest.permission.POST_NOTIFICATIONS
                    ) != PackageManager.PERMISSION_GRANTED
                ) {
                    //    ActivityCompat#requestPermissions
                    // here to request the missing permissions, and then overriding
                    return
                }
                notify(notificationId, notification)
            }
        }
    }

}