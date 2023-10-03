Return-Path: <netdev+bounces-37557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624A27B5FBA
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 06:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id B3B381C20912
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 04:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11CC111D;
	Tue,  3 Oct 2023 04:17:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74A310F3
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 04:17:07 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AB6CC
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 21:17:05 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a23fed55d7so8469217b3.2
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 21:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696306624; x=1696911424; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aGh7NZY3G/0+YsZGvHoKe2ZjMznUVNFroVuVfb1sCeU=;
        b=4DxFbGdLAcLEZW/nYnlExMyot3rLmOaPvn16YQb3HxUjP9JiEkA/Wtfyphh3w4FzBX
         4po+XgWtuyIWaxUjkxMl+xRl0Bln9kmA5jojlOldippa0aR6tBBAUY9ypxxYicd75z2L
         bvTpFhp0RZ7bD+p7QuB6nf+WSWZNDvOG65KaDkW1AW69YdKJe5LqnKzYf6HEwqTTqxC9
         c4dtQcIpmLhmQ0fv6+ZRO3zwUM+xSeI1k/W5xYa7qseFYZANq4g6NVYgYhq5VSpDDFdt
         oSyvZuTw4P5LclTmLUUNpsy8LFaH0cV05ED6Q9YhOOWGSFjvcSdBpz0yQquKWzni8Wac
         SigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696306624; x=1696911424;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aGh7NZY3G/0+YsZGvHoKe2ZjMznUVNFroVuVfb1sCeU=;
        b=RKIOqdhmCaCRctwYXAeP25N4A/hjkcNeqi5VMaoTp1Id1I+egABdUYUWDYfAveEKUN
         j4T5LRk4VkGKRlFvlStW9rJuwHqouYNO0Etpn/cH02CBjFusV4MX9ySi0xLNfrwi5IlL
         G7rHr4PR139mO+ho3KShTdSSwDlXXC1T8aDGmcAdtZliBbsBfOtFrArOSTJA3APJYP+P
         oZ+urTpp0MW4bMUjeR1A6yF8/FA9csHS1CsxjcKUYSUeA2kYMHf5m5vHGLtccBGuquOP
         BdUk+aqjHK3WrM0kMvXrDtqv6Nvz6Yk6qfxStgd3jYp2JJUOsD2aTz3BxxpaVp9JuvZs
         hX+g==
X-Gm-Message-State: AOJu0Yxr9xn+qArTvZMro/LVCslMAu5xVkN+tvgCINpDCP9do5cfBO2J
	JUqmKmv5Y/PdpfydHVKJlx2r+Gw+W2ZfNUFC+SiMHQ6iXLF4HfJmEBJyMO7uqAjALPGFBUe6VEV
	M8T2cklZ0BdoKJuWnH0AbZ/lB/s9DR7FnihH5wDDxcAG4DCedlCqdC0qKNZbl9g6A
X-Google-Smtp-Source: AGHT+IFbk7fg0MfySoTbN9JFW98cBRoCCraNT8L733mRlsZTKHztkNB7g7HHmIW1/cNnkcpT656oF4V+5E57
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2b7a])
 (user=maheshb job=sendgmr) by 2002:a81:ca41:0:b0:59b:e684:3c76 with SMTP id
 y1-20020a81ca41000000b0059be6843c76mr215109ywk.2.1696306623933; Mon, 02 Oct
 2023 21:17:03 -0700 (PDT)
Date: Mon,  2 Oct 2023 21:17:01 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231003041701.1745953-1-maheshb@google.com>
Subject: [PATCHv2 next 1/3] ptp: add ptp_gettimex64any() support
From: Mahesh Bandewar <maheshb@google.com>
To: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>, Don Hatchett <hatch@google.com>, 
	Yuliang Li <yuliangli@google.com>, Mahesh Bandewar <mahesh@bandewar.net>, 
	Mahesh Bandewar <maheshb@google.com>, Richard Cochran <richardcochran@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

add support for TS sandwich of the user preferred timebase. The options
supported are PTP_TS_REAL (CLOCK_REALTIME), PTP_TS_MONO (CLOCK_MONOTONIC),
and PTP_TS_RAW (CLOCK_MONOTONIC_RAW)

Option of PTP_TS_REAL is equivalent of using ptp_gettimex64().

Signed-off-by: Mahesh Bandewar <maheshb@google.com>
CC: Richard Cochran <richardcochran@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>
CC: netdev@vger.kernel.org
---
 include/linux/ptp_clock_kernel.h | 51 ++++++++++++++++++++++++++++++++
 include/uapi/linux/ptp_clock.h   |  7 +++++
 2 files changed, 58 insertions(+)

diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 1ef4e0f9bd2a..fd7be98e7bba 100644
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
@@ -464,4 +476,43 @@ static inline void ptp_read_system_postts(struct ptp_system_timestamp *sts)
 		ktime_get_real_ts64(&sts->post_ts);
 }
 
+static inline void ptp_read_any_prets(struct ptp_system_timestamp *sts,
+				      enum ptp_ts_types type)
+{
+	if (sts) {
+		switch (type) {
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
index 05cc35fc94ac..dc44e34f8146 100644
--- a/include/uapi/linux/ptp_clock.h
+++ b/include/uapi/linux/ptp_clock.h
@@ -69,6 +69,13 @@
  */
 #define PTP_PEROUT_V1_VALID_FLAGS	(0)
 
+enum ptp_ts_types {
+	PTP_TS_REAL = 0,
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


