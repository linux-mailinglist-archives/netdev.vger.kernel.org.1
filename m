Return-Path: <netdev+bounces-36957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EBC7B2A56
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 04:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 120F91C20B1F
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 02:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849C317D5;
	Fri, 29 Sep 2023 02:37:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA70D46AE
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 02:37:45 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260351A5
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 19:37:44 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f8188b718so173652337b3.1
        for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 19:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695955063; x=1696559863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nIHaxhAoJd7uqW2IBjHfoZybMFoN9LgbXxplOyXZzn8=;
        b=bPuh26LGYqk1JacugXDz8GvIhf08jQ7HS1VIUdM9HaKGEHRAcpwvsywdpmzStfaU6x
         6U3NMhmQbVR/6WqmE6qrnlbNlNz8l5HZuRchJBZe9gkp49ovHKQSDWKiVFjrylUSUBwY
         3kN5g1R5VusA3wPQKqWDCyCe33hHn7FPYsN54SxxPYWOxOGvEFitqzhMP5VpWLXq3psy
         BSmNlhFML0K2KLGEhlAgITBi3fPfyYew+H0Wj7fXKTToF792DZzkKHY7ANTUjQ3WfEZz
         Ok51cih6JuIJ1bkC7fnmeIvlGOqV79jtaPFBm18iv70t6jVOx53Zeb40nxQwAU0fR1TY
         xAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695955063; x=1696559863;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nIHaxhAoJd7uqW2IBjHfoZybMFoN9LgbXxplOyXZzn8=;
        b=Mnx2TCvSmD5I4ysCHdauKukq/08ERyYdiyWkURa3DmA0SHGFBmB3OBKeVpzD65n7nq
         U+ZmRbZGzwaAyIGL96U1El4T5Sreu3HPQziseK0yj4PViscRYFuLlPLLjl3Skwf4YQgK
         N1NubmJziOLuY/KwfrjvEjsBLY1K4nCCatq7FvlecYoUoZPZYh4ZMalga2Mo+Xq4WEeS
         nj5uQaf3U6jAfCRpilZ82WoGa/AiicCM0/oSWQ2qQzqQmSZBaGotIReDQ06mH9M4i/pz
         4lfBWl6m57G2pcoMJYN3J9rBRFdFLJr5VQHHt/N+ipv4aI0oPupKFogNKGn8aL7uU8aN
         yH6Q==
X-Gm-Message-State: AOJu0YzOg6/NS5IKOggiSAAqHGM1kHa1QK7RzkdTWX/LRIEpgmy7HAj/
	v6K1yJ2X+4CaK8fb4bjTSp2/W+GsFs0aWNJuI+pQv73qIm85LBtPq9aNkhImXZoyzLJq4ExTArD
	PLL31d/M37hu7c9nzJ8hJelWbTzpxTVE5jNPFj6HjNrXpCiSdzLGb4o/ZpqvCH2T1
X-Google-Smtp-Source: AGHT+IEf1Ys0iOiiWuTEzqwmd93QceZy824b+kpoVoMGTZ1j9BHorHAPDC1Gqx1O1ZgwJF04wu+0I4WHCms4
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2b7a])
 (user=maheshb job=sendgmr) by 2002:a05:6902:136b:b0:d81:4107:7a1 with SMTP id
 bt11-20020a056902136b00b00d81410707a1mr40041ybb.2.1695955063070; Thu, 28 Sep
 2023 19:37:43 -0700 (PDT)
Date: Thu, 28 Sep 2023 19:37:40 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20230929023740.1611161-1-maheshb@google.com>
Subject: [PATCH 2/4] ptp: add ptp_gettimex64any() support
From: Mahesh Bandewar <maheshb@google.com>
To: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Don Hatchett <hatch@google.com>, Yuliang Li <yuliangli@google.com>, 
	Mahesh Bandewar <mahesh@bandewar.net>, Mahesh Bandewar <maheshb@google.com>, 
	Richard Cochran <richardcochran@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

add support for TS sandwich of the user preferred timebase. The options
supported are PTP_TS_REAL (CLOCK_REALTIME), PTP_TS_MONO (CLOCK_MONOTONIC),
PTP_TS_RAW (CLOCK_MONOTONIC_RAW), PTP_TS_CYCLES (raw-cycles)

The option PTP_TS_CYCLES will return the cycles in 'struct timespec64'
format so something equivalent of timespec64_to_ns() need to be applied to
covert back into cycles.

Option of PTP_TS_REAL is equivalent of using ptp_gettimex64().

Signed-off-by: Mahesh Bandewar <maheshb@google.com>
CC: Richard Cochran <richardcochran@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>
CC: netdev@vger.kernel.org
---
 include/linux/ptp_clock_kernel.h | 57 ++++++++++++++++++++++++++++++++
 include/uapi/linux/ptp_clock.h   |  8 +++++
 2 files changed, 65 insertions(+)

diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 1ef4e0f9bd2a..87e75354d687 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -102,6 +102,15 @@ struct ptp_system_timestamp {
  *               reading the lowest bits of the PHC timestamp and the second
  *               reading immediately follows that.
  *
+ * @gettimex64any:  Reads the current time from the hardware clock and
+                 optionally also any of the MONO, MONO_RAW, or SYS clock.
+ *               parameter ts: Holds the PHC timestamp.
+ *               parameter sts: If not NULL, it holds a pair of timestamps from
+ *               the clock of choice. The first reading is made right before
+ *               reading the lowest bits of the PHC timestamp and the second
+ *               reading immediately follows that.
+ *               parameter type: any one of the TS opt from ptp_timestamp_types.
+ *
  * @getcrosststamp:  Reads the current time from the hardware clock and
  *                   system clock simultaneously.
  *                   parameter cts: Contains timestamp (device,system) pair,
@@ -180,6 +189,9 @@ struct ptp_clock_info {
 	int (*gettime64)(struct ptp_clock_info *ptp, struct timespec64 *ts);
 	int (*gettimex64)(struct ptp_clock_info *ptp, struct timespec64 *ts,
 			  struct ptp_system_timestamp *sts);
+	int (*gettimex64any)(struct ptp_clock_info *ptp, struct timespec64 *ts,
+			     struct ptp_system_timestamp *sts,
+			     enum ptp_ts_types type);
 	int (*getcrosststamp)(struct ptp_clock_info *ptp,
 			      struct system_device_crosststamp *cts);
 	int (*settime64)(struct ptp_clock_info *p, const struct timespec64 *ts);
@@ -464,4 +476,49 @@ static inline void ptp_read_system_postts(struct ptp_system_timestamp *sts)
 		ktime_get_real_ts64(&sts->post_ts);
 }
 
+static inline void ptp_read_any_prets(struct ptp_system_timestamp *sts,
+				      enum ptp_ts_types type)
+{
+	if (sts) {
+		switch (type) {
+		case PTP_TS_CYCLES:
+			ktime_get_cycles64(&sts->pre_ts);
+			break;
+		case PTP_TS_REAL:
+			ktime_get_real_ts64(&sts->pre_ts);
+			break;
+		case PTP_TS_MONO:
+			ktime_get_ts64(&sts->pre_ts);
+			break;
+		case PTP_TS_RAW:
+			ktime_get_raw_ts64(&sts->pre_ts);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+static inline void ptp_read_any_postts(struct ptp_system_timestamp *sts,
+				       enum ptp_ts_types type)
+{
+	if (sts) {
+		switch (type) {
+		case PTP_TS_CYCLES:
+			ktime_get_cycles64(&sts->post_ts);
+			break;
+		case PTP_TS_REAL:
+			ktime_get_real_ts64(&sts->post_ts);
+			break;
+		case PTP_TS_MONO:
+			ktime_get_ts64(&sts->post_ts);
+			break;
+		case PTP_TS_RAW:
+			ktime_get_raw_ts64(&sts->post_ts);
+			break;
+		default:
+			break;
+		}
+	}
+}
 #endif
diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
index 05cc35fc94ac..1f1e98966cff 100644
--- a/include/uapi/linux/ptp_clock.h
+++ b/include/uapi/linux/ptp_clock.h
@@ -69,6 +69,14 @@
  */
 #define PTP_PEROUT_V1_VALID_FLAGS	(0)
 
+enum ptp_ts_types {
+	PTP_TS_CYCLES = 0,
+	PTP_TS_REAL,
+	PTP_TS_MONO,
+	PTP_TS_RAW,
+	PTP_TS_MAX,
+};
+
 /*
  * struct ptp_clock_time - represents a time value
  *
-- 
2.42.0.582.g8ccd20d70d-goog


