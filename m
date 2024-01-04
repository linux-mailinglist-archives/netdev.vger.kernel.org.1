Return-Path: <netdev+bounces-61689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFB9824A40
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 22:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70741287B52
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 21:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783E52C6A0;
	Thu,  4 Jan 2024 21:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LotKH7lg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4DC2C858
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 21:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maheshb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5e73e6a17d5so20415877b3.0
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 13:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704403479; x=1705008279; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3EcDyhJpXfuqwObCE0OlLjCVuMesE+JcrTbbaHS7TvA=;
        b=LotKH7lgllB4kBU5B5E+oVZQl97UZumqcsTNzKaAycUxfsJBWL0Qe6PawMZ96UUYjx
         83Zbglq/FID45oO/tQbsB35VDrlu5ZTIfaHO7YQgoz+yebbbOpJXZh98lwLRZA0qiA/G
         QmqWZaIZN784CcZO9BE77GrsGta+VG4GFQix6z/tenaWdm5+wKEKvC7boPdWjbci14Xs
         acdsVbIf3ZcsqLb4E35MojRUjjFicmsJF97rpfP+cX+nB0r87fZyXDb4EYSxX7WpZ67B
         XAxUKEEILStPAF61yU0Top6xba12ZrN27HFX36A0GB9Ucngjdh02GAxMNlThCnawamtg
         Hsbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704403479; x=1705008279;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3EcDyhJpXfuqwObCE0OlLjCVuMesE+JcrTbbaHS7TvA=;
        b=KM56DzgHTag3qg8d7W+lK7oSHY734rwkcZYdgEB0zz7BFNKZ4valoUKtVa+2dceFC7
         RF1WQ8zSoCX6LC58wUN2Oh8sxG8rVJ1Xtb0xAKNMtrPpN65Zhjrc48+9CDd6AcnWIYTT
         GeI1yJwE0g8l0iFmzmwjEMPB81zQ5CnP5Z9tMc4bB5y5fZ4YsuZrizsm58nNnSogAmIk
         CtP3wJy9deV+yJgMvLwHRhAUzDijbOe/jQ3wDxl0vJnO8B115Y8lIkslpbyApeCy0Wed
         C9cIfoECmuFS1x0ggwbi7PqLMyURhmCS3ShzdtxjKCJzZzbev/ReCCE6gyLe5hXeDaVw
         vQYw==
X-Gm-Message-State: AOJu0YzGKEdNuqCYchLWmksKdcglsMQq9CzH1qcuAKVMJDaXSQUyAoVU
	8ZzaGQ/VNCluTSwNa6gQSc47S+nixFkqHcuHz35ZyYqMy6kXweXzh2/k0VH+2kngyQvcQJYvFbw
	bCSlTWErySgrIH0DfEbrPGFdqTJL5AYYtvvBctYHaqqn5Ww/oBcL7Ui/W48JIcQ6VBl1bhac=
X-Google-Smtp-Source: AGHT+IFyGuvvGsK4MYW1STDNxBXNcWnNz2TEZSC2WyHSKJfWvjhnBymy4PreKpmWN+Yt326Lq1gIuzLNjad2
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2b7a])
 (user=maheshb job=sendgmr) by 2002:a05:690c:3389:b0:5e5:c7de:e7ac with SMTP
 id fl9-20020a05690c338900b005e5c7dee7acmr598138ywb.1.1704403479494; Thu, 04
 Jan 2024 13:24:39 -0800 (PST)
Date: Thu,  4 Jan 2024 13:24:36 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.195.gebba966016-goog
Message-ID: <20240104212436.3276057-1-maheshb@google.com>
Subject: [PATCHv3 net-next 1/3] ptp: add new method ptp_gettimex64any()
From: Mahesh Bandewar <maheshb@google.com>
To: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>, Don Hatchett <hatch@google.com>, 
	Yuliang Li <yuliangli@google.com>, Mahesh Bandewar <mahesh@bandewar.net>, 
	Mahesh Bandewar <maheshb@google.com>, Richard Cochran <richardcochran@gmail.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

The current method that gets pre/post timestamps for PHC-read
supports only CLOCK_REALTIME timebase while most of the systems
have their clock disciplined by NTP service. There are applications
that can benefit from pre/post timestamps that are not changing
or have different timebases.

This patch adds the new API ptp_gettimex64any() which allows user
to specify the timebase for these pre/post timestamps.  The options
supported are CLOCK_REALTIME, CLOCK_MONOTONIC, and CLOCK_MONOTONIC_RAW

Option of CLOCK_REALTIME is equivalent to using ptp_gettimex64().

Signed-off-by: Mahesh Bandewar <maheshb@google.com>
CC: Richard Cochran <richardcochran@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>
CC: John Stultz <jstultz@google.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: "Willem de Bruijn" <willemb@google.com>
CC: netdev@vger.kernel.org
---
 include/linux/ptp_clock_kernel.h | 50 ++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 1ef4e0f9bd2a..b1316d82721a 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -102,6 +102,17 @@ struct ptp_system_timestamp {
  *               reading the lowest bits of the PHC timestamp and the second
  *               reading immediately follows that.
  *
+ * @gettimex64any: Reads the current time from the hardware clock and
+ *                 optionally also any of the MONO, MONO_RAW, or SYS clock
+ *                 parameter ts: Holds the PHC timestamp.
+ *                 parameter sts: If not NULL, it holds a pair of
+ *                 timestamps from the clock of choice. The first reading
+ *                 is made right before reading the lowest bits of the
+ *                 PHC timestamp and the second reading immediately
+ *                 follows that.
+ *                 parameter clkid: any one of the supported clockids
+ *                 (CLOCK_REALTIME, CLOCK_MONOTONIC, CLOCK_MONOTONIC_RAW)
+ *
  * @getcrosststamp:  Reads the current time from the hardware clock and
  *                   system clock simultaneously.
  *                   parameter cts: Contains timestamp (device,system) pair,
@@ -180,6 +191,10 @@ struct ptp_clock_info {
 	int (*gettime64)(struct ptp_clock_info *ptp, struct timespec64 *ts);
 	int (*gettimex64)(struct ptp_clock_info *ptp, struct timespec64 *ts,
 			  struct ptp_system_timestamp *sts);
+	int (*gettimex64any)(struct ptp_clock_info *ptp,
+			     struct timespec64 *ts,
+			     struct ptp_system_timestamp *sts,
+			     clockid_t clockid);
 	int (*getcrosststamp)(struct ptp_clock_info *ptp,
 			      struct system_device_crosststamp *cts);
 	int (*settime64)(struct ptp_clock_info *p, const struct timespec64 *ts);
@@ -452,16 +467,47 @@ static inline ktime_t ptp_convert_timestamp(const ktime_t *hwtstamp,
 
 #endif
 
+static inline void ptp_read_any_ts64(struct timespec64 *ts,
+				     clockid_t clkid)
+{
+	switch (clkid) {
+	case CLOCK_REALTIME:
+		ktime_get_real_ts64(ts);
+		break;
+	case CLOCK_MONOTONIC:
+		ktime_get_ts64(ts);
+		break;
+	case CLOCK_MONOTONIC_RAW:
+		ktime_get_raw_ts64(ts);
+		break;
+	default:
+		break;
+	}
+}
+
 static inline void ptp_read_system_prets(struct ptp_system_timestamp *sts)
 {
 	if (sts)
-		ktime_get_real_ts64(&sts->pre_ts);
+		ptp_read_any_ts64(&sts->pre_ts, CLOCK_REALTIME);
 }
 
 static inline void ptp_read_system_postts(struct ptp_system_timestamp *sts)
 {
 	if (sts)
-		ktime_get_real_ts64(&sts->post_ts);
+		ptp_read_any_ts64(&sts->pre_ts, CLOCK_REALTIME);
 }
 
+static inline void ptp_read_any_prets(struct ptp_system_timestamp *sts,
+				      clockid_t clkid)
+{
+	if (sts)
+		ptp_read_any_ts64(&sts->pre_ts, clkid);
+}
+
+static inline void ptp_read_any_postts(struct ptp_system_timestamp *sts,
+				       clockid_t clkid)
+{
+	if (sts)
+		ptp_read_any_ts64(&sts->post_ts, clkid);
+}
 #endif
-- 
2.43.0.195.gebba966016-goog


