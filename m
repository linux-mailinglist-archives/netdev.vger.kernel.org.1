Return-Path: <netdev+bounces-36958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A907B2A58
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 04:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id AA8D71C20B4B
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 02:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6322117D5;
	Fri, 29 Sep 2023 02:37:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5CE3D67
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 02:37:48 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2A91A7
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 19:37:47 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59f8134ec00so174712717b3.3
        for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 19:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695955066; x=1696559866; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lqddVV7lEvzc1PVC4l13jtQo0ILYRjKD+2QyANiZoos=;
        b=ThPgjp8HumPnZygQEdqfj+AMQ7/gwrbgp9JnRffJGAeVrCn2MnH4Ask+NxAgde3Zwf
         zjUfw4FxmdHLqg2ZNo6F8+kM8pOIHq84nEaVP7f3jq9N1B1Jkkr99J50aydr05WCr7PS
         SW9jtIugb306IU5p3ljLkIJ5er7tyV2nPD7XYbnYFR2T6/XjM1G4T6/rdwa3keHActIs
         Abfcjhceco1w1RXYyU973auO1ma6cQ5z6lVs3z7bBC7DPNXsMgJXvHnszrX9XA+1B4tK
         Ru3DawxuwnCnXpWDF9aLZeW+RyGk4elRoASVDvAKavNc0HXrKisAcN2o2+2+l0hhhMwM
         azCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695955066; x=1696559866;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lqddVV7lEvzc1PVC4l13jtQo0ILYRjKD+2QyANiZoos=;
        b=r4ou2NAy3J/DzEvNpRkQuuGGSj783sCApH10uiHrEzgPqSyny9xtSTYGnez/p626XW
         LkhniwHemA+Wu4X86JNc9QEsb9seBcn3ynb+Fzgvio6C/HOvm+kE80UDAL7/rOzJdXQq
         jKCrmUJTjVXiBYrGIqfvfoSc8EGn3QF1aKhsvRZjryfTLssyWbqI7PSyiSK/fIs1TKhT
         neUGXvWpLb71kEv/23co8+qRaTEfvciS9TIc9azcxdhn+q1cri+T9/JxdVP3pg2xlk9m
         bYPcHt8nQVVqws6lVCu5IqT/Mf5FUJmuZxWnInMZ2716xxjRADCILw+mGE3SXDD2PHtC
         maUQ==
X-Gm-Message-State: AOJu0YwTHTjZt6BpN4NfuFmuRcCGi6xyd2Czu3lxsHXTBmmeYpWW/IKW
	7ICZik7D3ZpCuA6ZRW+PpdTHOzQIzmTPV2yheXE6AZOZHgoKjVp5OI32p5CvY6m9Lf+ECAm91/n
	79pQPg9k13mUQAocV+W5MiFc6Xh5PlbTpVWZjciLw6duFlhHaKoRIO6U7QaTmSBbQ
X-Google-Smtp-Source: AGHT+IHGbL/PIFGONu27JjSbRgA0yNsOz82qS235Cd/7Is9loYVYaFFROcCTi2MDrziho8IDGG/6gC04f7Yr
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2b7a])
 (user=maheshb job=sendgmr) by 2002:a25:6f54:0:b0:d77:bcce:eb11 with SMTP id
 k81-20020a256f54000000b00d77bcceeb11mr41975ybc.10.1695955065762; Thu, 28 Sep
 2023 19:37:45 -0700 (PDT)
Date: Thu, 28 Sep 2023 19:37:43 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20230929023743.1611460-1-maheshb@google.com>
Subject: [PATCH 3/4] ptp: add ioctl interface for ptp_gettimex64any()
From: Mahesh Bandewar <maheshb@google.com>
To: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Don Hatchett <hatch@google.com>, Yuliang Li <yuliangli@google.com>, 
	Mahesh Bandewar <mahesh@bandewar.net>, Mahesh Bandewar <maheshb@google.com>, 
	Richard Cochran <richardcochran@gmail.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

add an ioctl op PTP_SYS_OFFSET_ANY2 to support ptp_gettimex64any() method

Signed-off-by: Mahesh Bandewar <maheshb@google.com>
CC: Richard Cochran <richardcochran@gmail.com>
CC: Rahul Rameshbabu <rrameshbabu@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>
CC: netdev@vger.kernel.org
---
 drivers/ptp/ptp_chardev.c      | 34 ++++++++++++++++++++++++++++++++++
 include/uapi/linux/ptp_clock.h | 14 ++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 362bf756e6b7..fef1c7e7e6e6 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -110,6 +110,7 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
 {
 	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
 	struct ptp_sys_offset_extended *extoff = NULL;
+	struct ptp_sys_offset_any *anyoff = NULL;
 	struct ptp_sys_offset_precise precise_offset;
 	struct system_device_crosststamp xtstamp;
 	struct ptp_clock_info *ops = ptp->info;
@@ -324,6 +325,39 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
 			err = -EFAULT;
 		break;
 
+	case PTP_SYS_OFFSET_ANY2:
+		if (!ptp->info->gettimex64any) {
+			err = -EOPNOTSUPP;
+			break;
+		}
+		anyoff = memdup_user((void __user *)arg, sizeof(*anyoff));
+		if (IS_ERR(anyoff)) {
+			err = PTR_ERR(anyoff);
+			anyoff = NULL;
+			break;
+		}
+		if (anyoff->n_samples > PTP_MAX_SAMPLES
+		    || anyoff->ts_type >= PTP_TS_MAX
+		    || anyoff->rsv[0] || anyoff->rsv[1]) {
+			err = -EINVAL;
+			break;
+		}
+		for (i = 0; i < anyoff->n_samples; i++) {
+			err = ptp->info->gettimex64any(ptp->info, &ts, &sts,
+						       anyoff->ts_type);
+			if (err)
+				goto out;
+			anyoff->ts[i][0].sec = sts.pre_ts.tv_sec;
+			anyoff->ts[i][0].nsec = sts.pre_ts.tv_nsec;
+			anyoff->ts[i][1].sec = ts.tv_sec;
+			anyoff->ts[i][1].nsec = ts.tv_nsec;
+			anyoff->ts[i][2].sec = sts.post_ts.tv_sec;
+			anyoff->ts[i][2].nsec = sts.post_ts.tv_nsec;
+		}
+		if (copy_to_user((void __user *)arg, anyoff, sizeof(*anyoff)))
+			err = -EFAULT;
+		break;
+
 	case PTP_SYS_OFFSET:
 	case PTP_SYS_OFFSET2:
 		sysoff = memdup_user((void __user *)arg, sizeof(*sysoff));
diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
index 1f1e98966cff..73bd17055a37 100644
--- a/include/uapi/linux/ptp_clock.h
+++ b/include/uapi/linux/ptp_clock.h
@@ -166,6 +166,18 @@ struct ptp_sys_offset_extended {
 	struct ptp_clock_time ts[PTP_MAX_SAMPLES][3];
 };
 
+struct ptp_sys_offset_any {
+	unsigned int n_samples;		/* Desired number of measurements. */
+	enum ptp_ts_types ts_type;	/* One of the TS types */
+	unsigned int rsv[2];		/* Reserved for future use. */
+	/*
+	 * Array of [TS, phc, TS] time stamps. The kernel will provide
+	 * 3*n_samples time stamps.
+	 * TS is any of the ts_type requested.
+	 */
+	struct ptp_clock_time ts[PTP_MAX_SAMPLES][3];
+};
+
 struct ptp_sys_offset_precise {
 	struct ptp_clock_time device;
 	struct ptp_clock_time sys_realtime;
@@ -232,6 +244,8 @@ struct ptp_pin_desc {
 	_IOWR(PTP_CLK_MAGIC, 17, struct ptp_sys_offset_precise)
 #define PTP_SYS_OFFSET_EXTENDED2 \
 	_IOWR(PTP_CLK_MAGIC, 18, struct ptp_sys_offset_extended)
+#define PTP_SYS_OFFSET_ANY2 \
+	_IOWR(PTP_CLK_MAGIC, 19, struct ptp_sys_offset_any)
 
 struct ptp_extts_event {
 	struct ptp_clock_time t; /* Time event occured. */
-- 
2.42.0.582.g8ccd20d70d-goog


