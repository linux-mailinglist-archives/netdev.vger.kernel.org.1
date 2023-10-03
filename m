Return-Path: <netdev+bounces-37558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846637B5FBD
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 06:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D3F39281D02
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 04:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57844EC8;
	Tue,  3 Oct 2023 04:17:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AA210E8
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 04:17:08 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B526BBF
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 21:17:07 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a22f833405so8509597b3.0
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 21:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696306626; x=1696911426; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yYq0uo4Y2Gfz3+tHCOAtr3XBow0LxI3rKbo8nyoJx34=;
        b=CF0TrnO8ODXXQxMLO0w0W8vDQlGw8ZPRStKeLzEqdnP5FM9GLXOs1lOAC4VZFJoI1M
         7ULmb4edrRabkakzGDHptpU2KUFPmy2WgAt026+jTDr+c4qI18AHkdqcw5PBaHXDBFfu
         Erw1k/qW4NJgMvw6neszxKga5cL/Azvc1Ww/sSqUsq09VcKn0d8TNE4qNcvwg8V7t7af
         Doc2IuNcziJPPnPRMDF0xS2NyWumX3Mv6KLgMk2zxBAmvjOo22ijb/4Z62KD+ZNJtueV
         9NsRQVIMqJ2JdtcCTzJoSenR++CDsTNPTc+MWAW9gegp9A+kAJNngAJtOUdur/PEgA7D
         3dqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696306626; x=1696911426;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yYq0uo4Y2Gfz3+tHCOAtr3XBow0LxI3rKbo8nyoJx34=;
        b=cUgxb8gRPesgZfVbqQzh7o1m6PJLYH7DEIKUWOB7oOvZpT/rs+hk4RUC1gVHzbtkvh
         Qer8Bss/8BXaVOunvyRagmSvUT8U5FlFREaWuc3RYLDriEDAjzAxHagEzIBeAXYd71J9
         fNqKzH8vjGOMR7wUWleNYq0ccgWZojnU7DOwqHHdQIseg86fuD/aPaxZSHHXmb0fiviq
         fLZQ4hFhXKzluf+LjwUyT8LH2UGi9LnG80fxB615UwqO7znXJQrYi26zxwZzOKPNgaDI
         tR314E0G56E0l9RlmBLh0n4TfRQ9Kg7wLGPeG0GUN9R5PvPGF58cKLSPg46J3Pm3z8Zq
         dYEQ==
X-Gm-Message-State: AOJu0Yyxrr1+vtGsJK96HYjFwNtyVt3w1/kFj8CMQNApEYI4gsfqXZSQ
	yWqFJRMYglMkB2geYbo9GRmciVAJ6k48gdwOR0wjMw7DlMc6H3oPk3Zsn6PvTI9qqE3Se+onpW6
	vjI8uN/87hEx9/8sk9OjhRMoZqX/H7LMfVI/8IauM5NRs2RIDk3V5+ipM2AEy9f/i
X-Google-Smtp-Source: AGHT+IGC0X7QovnW4gsRVEbo+jsI2T4w9x2kNqBi7zQkcFcnlkyZ8/QUK9c25Bvx/HsSn8VAHB3e5NWoSPgA
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2b7a])
 (user=maheshb job=sendgmr) by 2002:a81:7611:0:b0:59b:eace:d465 with SMTP id
 r17-20020a817611000000b0059beaced465mr225387ywc.2.1696306626466; Mon, 02 Oct
 2023 21:17:06 -0700 (PDT)
Date: Mon,  2 Oct 2023 21:17:04 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231003041704.1746303-1-maheshb@google.com>
Subject: [PATCHv2 next 2/3] ptp: add ioctl interface for ptp_gettimex64any()
From: Mahesh Bandewar <maheshb@google.com>
To: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>, Don Hatchett <hatch@google.com>, 
	Yuliang Li <yuliangli@google.com>, Mahesh Bandewar <mahesh@bandewar.net>, 
	Mahesh Bandewar <maheshb@google.com>, Richard Cochran <richardcochran@gmail.com>, 
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
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
index dc44e34f8146..b4e71e754b35 100644
--- a/include/uapi/linux/ptp_clock.h
+++ b/include/uapi/linux/ptp_clock.h
@@ -165,6 +165,18 @@ struct ptp_sys_offset_extended {
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
@@ -231,6 +243,8 @@ struct ptp_pin_desc {
 	_IOWR(PTP_CLK_MAGIC, 17, struct ptp_sys_offset_precise)
 #define PTP_SYS_OFFSET_EXTENDED2 \
 	_IOWR(PTP_CLK_MAGIC, 18, struct ptp_sys_offset_extended)
+#define PTP_SYS_OFFSET_ANY2 \
+	_IOWR(PTP_CLK_MAGIC, 19, struct ptp_sys_offset_any)
 
 struct ptp_extts_event {
 	struct ptp_clock_time t; /* Time event occured. */
-- 
2.42.0.582.g8ccd20d70d-goog


