Return-Path: <netdev+bounces-32225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 378C5793A4F
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 12:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1EF8281422
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 10:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87E446B9;
	Wed,  6 Sep 2023 10:48:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CC97E
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 10:48:22 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D166119AE
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 03:48:05 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31ad779e6b3so2945566f8f.2
        for <netdev@vger.kernel.org>; Wed, 06 Sep 2023 03:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693997284; x=1694602084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1x2ARNgqgBpb5WeTLouss9577WddXe/XTJzMBKADGg=;
        b=IQN3YAzRTjlL/DOPLtqXVqJfNmV75xKOu1sxNa2S7bbyoVpA28UwlRHcyQFSP50iM6
         myyM63moSDz0EtBCbaFUyny466xsbNytn2FGIbZsSVefRHItn1Kkt0r2m815a57CuZuy
         IU71ZOcyHOkzfPCx6XWKhzvwpoIGUPCxYzgB4aJTPEaaQwqQJ7setXgbyzSCXXVyyUi0
         qGuW+Au0tHNcKq0ef9h+HW9hxHo7GN6aYpQyuDzg2h4MexTUDOgh2QXWvbprAZ2IwhC9
         K/3+YOIZdP8NYqBlNxbBF42zVeMfNklTr1u0McmwpG+HLZzrxhsEQu7fHdKA34m/wOAw
         up1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693997284; x=1694602084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1x2ARNgqgBpb5WeTLouss9577WddXe/XTJzMBKADGg=;
        b=mAEqZEwtXf2rY+xNrL2GK7MqW7QaUZ7+Nel67cHav60hTU44OWFCHakWYw6dizaZgx
         LROOZZUfps49iDSnOx1y+8Fxp7XEn4/NQIVG/tknlRE6B9oH4GNUzh9qhJqLImTCbPh8
         fQoP8XSan8A6JALQWIikG8Jr8pJFgxAUhraFk/V1Mafy3hvyR60DNhdrnCszOieSB4Gu
         WvXQ2JQ9+1ph5rSi75o6C0On2M4glMZ+a3B0qoInm1tbTuZplAbl/YMKeJw5k4kyBGLj
         1uATSwu7sfqUwqHXpVC+T4QVslynZhXn8KWtmaxtAIre57JkxjoGxALxwnOuVKKtmixk
         HEqA==
X-Gm-Message-State: AOJu0Yxm34JRWrRgaiYYfNOkLg33Zu0i1fnMlNmFqO53EjTCB7RaTEFr
	CSHeOBgAfMIMMKP02X620xk=
X-Google-Smtp-Source: AGHT+IH/ZX/O1bflMQW1o0cz02tFkVkvyj+Uw7NqBvWz0cC587h92qO9BZcWtr1MZ8/IJiPomRFvlw==
X-Received: by 2002:adf:f6cc:0:b0:317:5c36:913b with SMTP id y12-20020adff6cc000000b003175c36913bmr2016067wrp.48.1693997284082;
        Wed, 06 Sep 2023 03:48:04 -0700 (PDT)
Received: from xmarquiegui-HP-ZBook-15-G6.internal.ainguraiiot.com (210.212-55-6.static.clientes.euskaltel.es. [212.55.6.210])
        by smtp.gmail.com with ESMTPSA id l7-20020a7bc447000000b003fe1fe56202sm19508728wmi.33.2023.09.06.03.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 03:48:03 -0700 (PDT)
From: Xabier Marquiegui <reibax@gmail.com>
To: richardcochran@gmail.com
Cc: chrony-dev@chrony.tuxfamily.org,
	mlichvar@redhat.com,
	netdev@vger.kernel.org,
	ntp-lists@mattcorallo.com,
	reibax@gmail.com
Subject: [PATCH 3/3] ptp: support event queue reader channel masks
Date: Wed,  6 Sep 2023 12:47:54 +0200
Message-Id: <20230906104754.1324412-4-reibax@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906104754.1324412-1-reibax@gmail.com>
References: <ZO+8Mlk0yMxz7Tn+@hoboy.vegasvil.org>
 <20230906104754.1324412-1-reibax@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement ioctl to support filtering of external timestamp event queue
channels per reader based on the process PID accessing the timestamp
queue.

Can be tested using testptp test binary. Use lsof to figure out readers
of the DUT.

Signed-off-by: Xabier Marquiegui <reibax@gmail.com>
---
 drivers/ptp/ptp_chardev.c             | 17 +++++++++++++++++
 drivers/ptp/ptp_clock.c               |  4 +++-
 drivers/ptp/ptp_private.h             |  1 +
 include/uapi/linux/ptp_clock.h        |  7 +++++++
 tools/testing/selftests/ptp/testptp.c | 26 +++++++++++++++++++++++++-
 5 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index c65dc6fefaa6..72697189ac59 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -109,6 +109,7 @@ int ptp_open(struct posix_clock *pc, fmode_t fmode)
 	queue = kzalloc(sizeof(struct timestamp_event_queue), GFP_KERNEL);
 	if (queue == NULL)
 		return -EINVAL;
+	queue->mask = 0xFFFFFFFF;
 	queue->reader_pid = task_pid_nr(current);
 	list_add_tail(&queue->qlist, &ptp->tsevqs);
 
@@ -139,9 +140,11 @@ int ptp_release(struct posix_clock *pc)
 long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
 {
 	struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
+	struct timestamp_event_queue *tsevq, *tsevq_alt;
 	struct ptp_sys_offset_extended *extoff = NULL;
 	struct ptp_sys_offset_precise precise_offset;
 	struct system_device_crosststamp xtstamp;
+	struct ptp_tsfilter_request tsfilter_req;
 	struct ptp_clock_info *ops = ptp->info;
 	struct ptp_sys_offset *sysoff = NULL;
 	struct ptp_system_timestamp sts;
@@ -451,6 +454,20 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd, unsigned long arg)
 		mutex_unlock(&ptp->pincfg_mux);
 		break;
 
+	case PTP_FILTERTS_REQUEST:
+		if (copy_from_user(&tsfilter_req, (void __user *)arg,
+				   sizeof(tsfilter_req))) {
+			err = -EFAULT;
+			break;
+		}
+		list_for_each_entry_safe(tsevq, tsevq_alt, &ptp->tsevqs, qlist) {
+			if (tsevq->reader_pid == tsfilter_req.reader_pid) {
+				tsevq->mask = tsfilter_req.mask;
+				break;
+			}
+		}
+		break;
+
 	default:
 		err = -ENOTTY;
 		break;
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index dc2f045cacbd..360bd5f9d759 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -247,6 +247,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	if (queue == NULL)
 		goto no_memory_queue;
 	queue->reader_pid = 0;
+	queue->mask = 0xFFFFFFFF;
 	spin_lock_init(&queue->lock);
 	list_add_tail(&queue->qlist, &ptp->tsevqs);
 	mutex_init(&ptp->pincfg_mux);
@@ -406,7 +407,8 @@ void ptp_clock_event(struct ptp_clock *ptp, struct ptp_clock_event *event)
 	case PTP_CLOCK_EXTTS:
 		/* Enqueue timestamp on all other queues */
 		list_for_each_entry_safe(tsevq, tsevq_alt, &ptp->tsevqs, qlist) {
-			enqueue_external_timestamp(tsevq, event);
+			if (tsevq->mask & (0x1 << event->index))
+				enqueue_external_timestamp(tsevq, event);
 		}
 		wake_up_interruptible(&ptp->tsev_wq);
 		break;
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index 56b0c9df188d..07f9e6b64e99 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -28,6 +28,7 @@ struct timestamp_event_queue {
 	spinlock_t lock;
 	struct list_head qlist; /* Link to other queues */
 	pid_t reader_pid;
+	int mask;
 };
 
 struct ptp_clock {
diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
index 05cc35fc94ac..372d0a1dc6f7 100644
--- a/include/uapi/linux/ptp_clock.h
+++ b/include/uapi/linux/ptp_clock.h
@@ -105,6 +105,11 @@ struct ptp_extts_request {
 	unsigned int rsv[2]; /* Reserved for future use. */
 };
 
+struct ptp_tsfilter_request {
+	pid_t reader_pid; /* PID of process reading the timestamp event queue */
+	unsigned int mask; /* Channel mask. LSB = channel 0 */
+};
+
 struct ptp_perout_request {
 	union {
 		/*
@@ -224,6 +229,8 @@ struct ptp_pin_desc {
 	_IOWR(PTP_CLK_MAGIC, 17, struct ptp_sys_offset_precise)
 #define PTP_SYS_OFFSET_EXTENDED2 \
 	_IOWR(PTP_CLK_MAGIC, 18, struct ptp_sys_offset_extended)
+#define PTP_FILTERTS_REQUEST \
+	_IOW(PTP_CLK_MAGIC, 19, struct ptp_tsfilter_request)
 
 struct ptp_extts_event {
 	struct ptp_clock_time t; /* Time event occured. */
diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index c9f6cca4feb4..8c4d40c16cdf 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -121,6 +121,7 @@ static void usage(char *progname)
 		" -d name    device to open\n"
 		" -e val     read 'val' external time stamp events\n"
 		" -f val     adjust the ptp clock frequency by 'val' ppb\n"
+		" -F pid,msk apply ts channel mask to queue open by pid\n"
 		" -g         get the ptp clock time\n"
 		" -h         prints this message\n"
 		" -i val     index for event/trigger\n"
@@ -162,6 +163,7 @@ int main(int argc, char *argv[])
 	struct ptp_sys_offset *sysoff;
 	struct ptp_sys_offset_extended *soe;
 	struct ptp_sys_offset_precise *xts;
+	struct ptp_tsfilter_request tsfilter_req;
 
 	char *progname;
 	unsigned int i;
@@ -194,9 +196,14 @@ int main(int argc, char *argv[])
 	int64_t pulsewidth = -1;
 	int64_t perout = -1;
 
+	tsfilter_req.reader_pid = 0;
+	tsfilter_req.mask = 0xFFFFFFFF;
+
 	progname = strrchr(argv[0], '/');
 	progname = progname ? 1+progname : argv[0];
-	while (EOF != (c = getopt(argc, argv, "cd:e:f:ghH:i:k:lL:n:o:p:P:sSt:T:w:x:Xz"))) {
+	while (EOF !=
+	       (c = getopt(argc, argv,
+			   "cd:e:f:F:ghH:i:k:lL:n:o:p:P:sSt:T:w:x:Xz"))) {
 		switch (c) {
 		case 'c':
 			capabilities = 1;
@@ -210,6 +217,14 @@ int main(int argc, char *argv[])
 		case 'f':
 			adjfreq = atoi(optarg);
 			break;
+		case 'F':
+			cnt = sscanf(optarg, "%d,%X", &tsfilter_req.reader_pid,
+				     &tsfilter_req.mask);
+			if (cnt != 2) {
+				usage(progname);
+				return -1;
+			}
+			break;
 		case 'g':
 			gettime = 1;
 			break;
@@ -604,6 +619,15 @@ int main(int argc, char *argv[])
 		free(xts);
 	}
 
+	if (tsfilter_req.reader_pid != 0) {
+		if (ioctl(fd, PTP_FILTERTS_REQUEST, &tsfilter_req)) {
+			perror("PTP_FILTERTS_REQUEST");
+		} else {
+			printf("Timestamp event queue mask 0x%X applied to reader with PID: %d\n",
+			       (int)tsfilter_req.mask, tsfilter_req.reader_pid);
+		}
+	}
+
 	close(fd);
 	return 0;
 }
-- 
2.34.1


