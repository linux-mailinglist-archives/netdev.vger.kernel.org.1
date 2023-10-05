Return-Path: <netdev+bounces-38254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 254E37B9DA7
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 15:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 666ADB209D2
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 13:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744B3266AE;
	Thu,  5 Oct 2023 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWhcAI42"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BF3262A4
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 13:53:33 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05DB59F3
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 06:53:31 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-313e742a787so630792f8f.1
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 06:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696514010; x=1697118810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5l79ELEC177954p8KfIqyoHpaDyURH4GFKzihEM2Xew=;
        b=VWhcAI42uqjrnotqGjdR8+GoSuLn/+zLKJookxuqeJOOR66B0ugjUWlOLDbJf1NeDF
         5Gapc4nwoNbXCdOqepjGxPJaXjb2CZP6rqdF3qc63MbpRTvq8/10q85PGJH3AGwZD1u9
         ikwPDyC4luTO6yERamzziqmhOOjXOYfVFdBtlNov47CGRiYBZZ9ilMI7GybrPbTmHM1f
         N+zGAlBsPXEBVJqQrbpw0EQSN6tZOgMg0B6ussUT3Q7qO59Asp+hfhPj/FoYMKGV/ywZ
         Vujr+jGnKDjA+qK/wySMYnArHq3g8oLxpBcoKDRRoWRAiAidi5xxgBdX7FtSVxS6hEwn
         //6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696514010; x=1697118810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5l79ELEC177954p8KfIqyoHpaDyURH4GFKzihEM2Xew=;
        b=gBAW0siQjDJ/9Kq/07gnJvEoUdeu0wlLKQIcmpsfUHFHf7mL9Jk45Z+FR3zQst14iw
         U4WcBjl76qg08h16D9VZpQItNIhxxf6q6MwS0X59iqJuW76fdTbR9UPM9kCOufSGrUVg
         ZPrtbteMwstl2AjaYkct/kZFfg4oMhfIjcZl7u6XBv4zxy2jYGaRuF3BsnLF0ElGSEl6
         Wlow2nSfgtTVnv9JRb9/KgmhGL7ls4LtYEN0jqnQ4QOYwFuwkkhpH/faQ+gSmqCni9Sv
         Vf7qXOAtcb1waf/Sit562S1os023FCunflKi4tvpeEzIk3D3skk4xrLOkqXy21u1K1Qa
         08/Q==
X-Gm-Message-State: AOJu0Yx0H/dEUg4Ek0tazG80rZDy8n6S7LCJAl9cHfepaEr3Vf5IdoBj
	+rfjnso0EyoZi3bHUUdU85Jp1L3mPzvyVA==
X-Google-Smtp-Source: AGHT+IF3MPW6FjzEstWpgNf3E9QzK236opHqO+6rLCdOl0BTjiN2lkp4YjaJkgtmnrtJO9Dl7DoKTg==
X-Received: by 2002:a5d:56c1:0:b0:31f:eb45:462e with SMTP id m1-20020a5d56c1000000b0031feb45462emr2318715wrw.28.1696514009866;
        Thu, 05 Oct 2023 06:53:29 -0700 (PDT)
Received: from xmarquiegui-HP-ZBook-15-G6.internal.ainguraiiot.com (210.212-55-6.static.clientes.euskaltel.es. [212.55.6.210])
        by smtp.gmail.com with ESMTPSA id h4-20020a056000000400b00327df8fcbd9sm1867041wrx.9.2023.10.05.06.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 06:53:29 -0700 (PDT)
From: Xabier Marquiegui <reibax@gmail.com>
To: netdev@vger.kernel.org
Cc: richardcochran@gmail.com,
	tglx@linutronix.de,
	jstultz@google.com,
	horms@kernel.org,
	chrony-dev@chrony.tuxfamily.org,
	mlichvar@redhat.com,
	reibax@gmail.com,
	ntp-lists@mattcorallo.com,
	vinicius.gomes@intel.com,
	alex.maftei@amd.com,
	davem@davemloft.net,
	rrameshbabu@nvidia.com,
	shuah@kernel.org
Subject: [PATCH net-next v4 1/6] posix-clock: introduce posix_clock_context concept
Date: Thu,  5 Oct 2023 15:53:11 +0200
Message-Id: <35e1e4f96e8ad58b4ee6a7fd46424f4cd6294353.1696511486.git.reibax@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696511486.git.reibax@gmail.com>
References: <cover.1696511486.git.reibax@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add the necessary structure to support custom private-data per
posix-clock user.

The previous implementation of posix-clock assumed all file open
instances need access to the same clock structure on private_data.

The need for individual data structures per file open instance has been
identified when developing support for multiple timestamp event queue
users for ptp_clock.

This patch introduces a generic posix_clock_context data structure as a
solution to that, and simmilar problems.

Signed-off-by: Xabier Marquiegui <reibax@gmail.com>
Suggested-by: Richard Cochran <richardcochran@gmail.com>
Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
v2:
  - split from previous patch that combined more changes
  - rename posix_clock_user to posix_clock_context
  - remove unnecessary flush_users clock operation
  - remove unnecessary tests
v1: https://lore.kernel.org/netdev/20230928133544.3642650-3-reibax@gmail.com/
---
 drivers/ptp/ptp_chardev.c   | 21 +++++++++++++--------
 drivers/ptp/ptp_private.h   | 16 +++++++++-------
 include/linux/posix-clock.h | 22 ++++++++++++++--------
 kernel/time/posix-clock.c   | 36 +++++++++++++++++++++++++++---------
 4 files changed, 63 insertions(+), 32 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 362bf756e6b7..0ba3e7064df2 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -101,14 +101,16 @@ int ptp_set_pinfunc(struct ptp_clock *ptp, unsigned int pin,
 	return 0;
 }
 
-int ptp_open(struct posix_clock *pc, fmode_t fmode)
+int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
 {
 	return 0;
 }
 
-long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
+long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
+	       unsigned long arg)
 {
-	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
+	struct ptp_clock *ptp =
+		container_of(pccontext->clk, struct ptp_clock, clock);
 	struct ptp_sys_offset_extended *extoff = NULL;
 	struct ptp_sys_offset_precise precise_offset;
 	struct system_device_crosststamp xtstamp;
@@ -432,9 +434,11 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
 	return err;
 }
 
-__poll_t ptp_poll(struct posix_clock *pc, struct file *fp, poll_table *wait)
+__poll_t ptp_poll(struct posix_clock_context *pccontext, struct file *fp,
+		  poll_table *wait)
 {
-	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
+	struct ptp_clock *ptp =
+		container_of(pccontext->clk, struct ptp_clock, clock);
 
 	poll_wait(fp, &ptp->tsev_wq, wait);
 
@@ -443,10 +447,11 @@ __poll_t ptp_poll(struct posix_clock *pc, struct file *fp, poll_table *wait)
 
 #define EXTTS_BUFSIZE (PTP_BUF_TIMESTAMPS * sizeof(struct ptp_extts_event))
 
-ssize_t ptp_read(struct posix_clock *pc,
-		 uint rdflags, char __user *buf, size_t cnt)
+ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
+		 char __user *buf, size_t cnt)
 {
-	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
+	struct ptp_clock *ptp =
+		container_of(pccontext->clk, struct ptp_clock, clock);
 	struct timestamp_event_queue *queue = &ptp->tsevq;
 	struct ptp_extts_event *event;
 	unsigned long flags;
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index 75f58fc468a7..a3110c85f694 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -117,16 +117,18 @@ extern struct class *ptp_class;
 int ptp_set_pinfunc(struct ptp_clock *ptp, unsigned int pin,
 		    enum ptp_pin_function func, unsigned int chan);
 
-long ptp_ioctl(struct posix_clock *pc,
-	       unsigned int cmd, unsigned long arg);
+long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
+	       unsigned long arg);
 
-int ptp_open(struct posix_clock *pc, fmode_t fmode);
+int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode);
 
-ssize_t ptp_read(struct posix_clock *pc,
-		 uint flags, char __user *buf, size_t cnt);
+int ptp_release(struct posix_clock_context *pccontext);
 
-__poll_t ptp_poll(struct posix_clock *pc,
-	      struct file *fp, poll_table *wait);
+ssize_t ptp_read(struct posix_clock_context *pccontext, uint flags, char __user *buf,
+		 size_t cnt);
+
+__poll_t ptp_poll(struct posix_clock_context *pccontext, struct file *fp,
+		  poll_table *wait);
 
 /*
  * see ptp_sysfs.c
diff --git a/include/linux/posix-clock.h b/include/linux/posix-clock.h
index 468328b1e1dd..d7c6f126575f 100644
--- a/include/linux/posix-clock.h
+++ b/include/linux/posix-clock.h
@@ -14,6 +14,7 @@
 #include <linux/rwsem.h>
 
 struct posix_clock;
+struct posix_clock_context;
 
 /**
  * struct posix_clock_operations - functional interface to the clock
@@ -50,18 +51,18 @@ struct posix_clock_operations {
 	/*
 	 * Optional character device methods:
 	 */
-	long    (*ioctl)   (struct posix_clock *pc,
-			    unsigned int cmd, unsigned long arg);
+	long (*ioctl)(struct posix_clock_context *pccontext, unsigned int cmd,
+		      unsigned long arg);
 
-	int     (*open)    (struct posix_clock *pc, fmode_t f_mode);
+	int (*open)(struct posix_clock_context *pccontext, fmode_t f_mode);
 
-	__poll_t (*poll)   (struct posix_clock *pc,
-			    struct file *file, poll_table *wait);
+	__poll_t (*poll)(struct posix_clock_context *pccontext, struct file *file,
+			 poll_table *wait);
 
-	int     (*release) (struct posix_clock *pc);
+	int (*release)(struct posix_clock_context *pccontext);
 
-	ssize_t (*read)    (struct posix_clock *pc,
-			    uint flags, char __user *buf, size_t cnt);
+	ssize_t (*read)(struct posix_clock_context *pccontext, uint flags,
+			char __user *buf, size_t cnt);
 };
 
 /**
@@ -90,6 +91,11 @@ struct posix_clock {
 	bool zombie;
 };
 
+struct posix_clock_context {
+	struct posix_clock *clk;
+	void *private_clkdata;
+};
+
 /**
  * posix_clock_register() - register a new clock
  * @clk:   Pointer to the clock. Caller must provide 'ops' field
diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index 77c0c2370b6d..9de66bbbb3d1 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -19,7 +19,8 @@
  */
 static struct posix_clock *get_posix_clock(struct file *fp)
 {
-	struct posix_clock *clk = fp->private_data;
+	struct posix_clock_context *pccontext = fp->private_data;
+	struct posix_clock *clk = pccontext->clk;
 
 	down_read(&clk->rwsem);
 
@@ -39,6 +40,7 @@ static void put_posix_clock(struct posix_clock *clk)
 static ssize_t posix_clock_read(struct file *fp, char __user *buf,
 				size_t count, loff_t *ppos)
 {
+	struct posix_clock_context *pccontext = fp->private_data;
 	struct posix_clock *clk = get_posix_clock(fp);
 	int err = -EINVAL;
 
@@ -46,7 +48,7 @@ static ssize_t posix_clock_read(struct file *fp, char __user *buf,
 		return -ENODEV;
 
 	if (clk->ops.read)
-		err = clk->ops.read(clk, fp->f_flags, buf, count);
+		err = clk->ops.read(pccontext, fp->f_flags, buf, count);
 
 	put_posix_clock(clk);
 
@@ -55,6 +57,7 @@ static ssize_t posix_clock_read(struct file *fp, char __user *buf,
 
 static __poll_t posix_clock_poll(struct file *fp, poll_table *wait)
 {
+	struct posix_clock_context *pccontext = fp->private_data;
 	struct posix_clock *clk = get_posix_clock(fp);
 	__poll_t result = 0;
 
@@ -62,7 +65,7 @@ static __poll_t posix_clock_poll(struct file *fp, poll_table *wait)
 		return EPOLLERR;
 
 	if (clk->ops.poll)
-		result = clk->ops.poll(clk, fp, wait);
+		result = clk->ops.poll(pccontext, fp, wait);
 
 	put_posix_clock(clk);
 
@@ -72,6 +75,7 @@ static __poll_t posix_clock_poll(struct file *fp, poll_table *wait)
 static long posix_clock_ioctl(struct file *fp,
 			      unsigned int cmd, unsigned long arg)
 {
+	struct posix_clock_context *pccontext = fp->private_data;
 	struct posix_clock *clk = get_posix_clock(fp);
 	int err = -ENOTTY;
 
@@ -79,7 +83,7 @@ static long posix_clock_ioctl(struct file *fp,
 		return -ENODEV;
 
 	if (clk->ops.ioctl)
-		err = clk->ops.ioctl(clk, cmd, arg);
+		err = clk->ops.ioctl(pccontext, cmd, arg);
 
 	put_posix_clock(clk);
 
@@ -90,6 +94,7 @@ static long posix_clock_ioctl(struct file *fp,
 static long posix_clock_compat_ioctl(struct file *fp,
 				     unsigned int cmd, unsigned long arg)
 {
+	struct posix_clock_context *pccontext = fp->private_data;
 	struct posix_clock *clk = get_posix_clock(fp);
 	int err = -ENOTTY;
 
@@ -97,7 +102,7 @@ static long posix_clock_compat_ioctl(struct file *fp,
 		return -ENODEV;
 
 	if (clk->ops.ioctl)
-		err = clk->ops.ioctl(clk, cmd, arg);
+		err = clk->ops.ioctl(pccontext, cmd, arg);
 
 	put_posix_clock(clk);
 
@@ -110,6 +115,7 @@ static int posix_clock_open(struct inode *inode, struct file *fp)
 	int err;
 	struct posix_clock *clk =
 		container_of(inode->i_cdev, struct posix_clock, cdev);
+	struct posix_clock_context *pccontext;
 
 	down_read(&clk->rwsem);
 
@@ -117,14 +123,20 @@ static int posix_clock_open(struct inode *inode, struct file *fp)
 		err = -ENODEV;
 		goto out;
 	}
+	pccontext = kzalloc(sizeof(*pccontext), GFP_KERNEL);
+	if (!pccontext) {
+		err = -ENOMEM;
+		goto out;
+	}
+	pccontext->clk = clk;
+	fp->private_data = pccontext;
 	if (clk->ops.open)
-		err = clk->ops.open(clk, fp->f_mode);
+		err = clk->ops.open(pccontext, fp->f_mode);
 	else
 		err = 0;
 
 	if (!err) {
 		get_device(clk->dev);
-		fp->private_data = clk;
 	}
 out:
 	up_read(&clk->rwsem);
@@ -133,14 +145,20 @@ static int posix_clock_open(struct inode *inode, struct file *fp)
 
 static int posix_clock_release(struct inode *inode, struct file *fp)
 {
-	struct posix_clock *clk = fp->private_data;
+	struct posix_clock_context *pccontext = fp->private_data;
+	struct posix_clock *clk;
 	int err = 0;
 
+	if (!pccontext)
+		return -ENODEV;
+	clk = pccontext->clk;
+
 	if (clk->ops.release)
-		err = clk->ops.release(clk);
+		err = clk->ops.release(pccontext);
 
 	put_device(clk->dev);
 
+	kfree(pccontext);
 	fp->private_data = NULL;
 
 	return err;
-- 
2.34.1


