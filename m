Return-Path: <netdev+bounces-36956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3A17B2A57
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 04:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A74882827DA
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 02:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948773D67;
	Fri, 29 Sep 2023 02:37:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B313C29
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 02:37:43 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CDF199
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 19:37:41 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a23ad271d7so6895217b3.1
        for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 19:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695955061; x=1696559861; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iULIiWyEAnuPU2ttI+NrM06ywk49WbVfQ4RXn/AgPAM=;
        b=I/vZll7uA9wegcqanJIdqng8EUrnkYnt1GPJQk9KYWu0nQrPVfLJnIJQeL5ihRTOQ2
         Bi9U18bswSfQ8qi6PRzovsHzHOUfUXi13ftMHlkuu892LRQ1R5VAxiYWYmwu6/rT3YwS
         IZuUgqFUHqRYOC6YRwfPHIsUrAcfXxP4yqz1KPN4Ba5S7k92U5M44DZQLs9Q6dO5q/WK
         8dvyzihu4CngajBUvBj7HvCZNTu4+IDvvbWP04nkrr6TYL+na1yeC0hUbj8sZkBm2Til
         89vLuJZJsm91MQQ0+V++GZ835VN43y5ku5eDKZSuqnefUhDTyOqTGy/U+478ZXQQVrYZ
         agEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695955061; x=1696559861;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iULIiWyEAnuPU2ttI+NrM06ywk49WbVfQ4RXn/AgPAM=;
        b=MUZTCdhUtNh5KNdD/MwslgJDwuyWbFrMr+VTmJDCSGpjUI7u1SzU9F4l2+WNThHxrI
         8vU6yltxs6KfyVyEqHjIEO4AIxI1KxrcTyfWUGbOsqTJURrdBSNOkhD+rz6uSXakGC5U
         dAY46uMMxp90ebwu9VERvFczUqERxChNMlBdN65MCq2UKj7THHOP1OBe/VkJMHYx126F
         zhDy5OP0fv9k0FePK0HGTiEMi01HwswNcSZS4Xmvowcg+a4wKPkDqVsP9xgX0JHzcuow
         Yc6CiEdtXkkwTt75IBuvjv8HwwkVaxyGP/2RMK5L+SVrd0nnhiZ1+Ds+if3mAiwBQF/k
         XUYg==
X-Gm-Message-State: AOJu0YypWgZPXP2LU2TvjQGNAqd/ZCOODNRiVz49dce11UmzPMkxxYn9
	pCE2myKlrfYS9LyHhPh/6EaCyyf/3s6SWOaboqkEtjMZioCv1lVoo+kZlDRSIf4K6c+TTjlas3s
	/hLhub2fpC47njjLkIvdL7bN+T+mk4G+7kNPznDr+tPU3beo43k7Wdllm9kA3vBZj
X-Google-Smtp-Source: AGHT+IF2UHiH6MYgJLyQsGuGuNbtJkhEi9ISCxSd9hNIt5Rms531nuclGSwkAHF9z6nkcArPAwGZzrrkT3Yr
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2b7a])
 (user=maheshb job=sendgmr) by 2002:a25:6812:0:b0:d13:856b:c10a with SMTP id
 d18-20020a256812000000b00d13856bc10amr38603ybc.3.1695955060095; Thu, 28 Sep
 2023 19:37:40 -0700 (PDT)
Date: Thu, 28 Sep 2023 19:37:37 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20230929023737.1610865-1-maheshb@google.com>
Subject: [PATCH 1/4] time: add ktime_get_cycles64() api
From: Mahesh Bandewar <maheshb@google.com>
To: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Don Hatchett <hatch@google.com>, Yuliang Li <yuliangli@google.com>, 
	Mahesh Bandewar <mahesh@bandewar.net>, Mahesh Bandewar <maheshb@google.com>, 
	John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

add a method to retrieve raw cycles in the same fashion as there are
ktime_get_* methods available for supported time-bases. The method
continues using the 'struct timespec64' since the UAPI uses 'struct
ptp_clock_time'.

The caller can perform operation equivalent of timespec64_to_ns() to
retrieve raw-cycles value. The precision loss because of this conversion
should be none for 64 bit cycle counters and nominal at 96 bit counters
(considering UAPI of s64 + u32 of 'struct ptp_clock_time).

Signed-off-by: Mahesh Bandewar <maheshb@google.com>
CC: John Stultz <jstultz@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Stephen Boyd <sboyd@kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>
CC: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 include/linux/timekeeping.h |  1 +
 kernel/time/timekeeping.c   | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index fe1e467ba046..5537700ad113 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -43,6 +43,7 @@ extern void ktime_get_ts64(struct timespec64 *ts);
 extern void ktime_get_real_ts64(struct timespec64 *tv);
 extern void ktime_get_coarse_ts64(struct timespec64 *ts);
 extern void ktime_get_coarse_real_ts64(struct timespec64 *ts);
+extern void ktime_get_cycles64(struct timespec64 *ts);
 
 void getboottime64(struct timespec64 *ts);
 
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 266d02809dbb..35d603d21bd5 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -989,6 +989,30 @@ void ktime_get_ts64(struct timespec64 *ts)
 }
 EXPORT_SYMBOL_GPL(ktime_get_ts64);
 
+/**
+ * ktime_get_cycles64 - get the raw clock cycles in timespec64 format
+ * @ts:		pointer to timespec variable
+ *
+ * This function converts the raw clock cycles into timespce64 format
+ * in the varibale pointed to by @ts
+ */
+void ktime_get_cycles64(struct timespec64 *ts)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+	unsigned int seq;
+	u64 now;
+
+	WARN_ON_ONCE(timekeeping_suspended);
+
+	do {
+		seq = read_seqcount_begin(&tk_core.seq);
+		now = tk_clock_read(&tk->tkr_mono);
+	} while (read_seqcount_retry(&tk_core.seq, seq));
+
+	*ts = ns_to_timespec64(now);
+}
+EXPORT_SYMBOL_GPL(ktime_get_cycles64);
+
 /**
  * ktime_get_seconds - Get the seconds portion of CLOCK_MONOTONIC
  *
-- 
2.42.0.582.g8ccd20d70d-goog


