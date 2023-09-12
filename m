Return-Path: <netdev+bounces-33392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DB579DB8B
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 00:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E8CC1C20DD7
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 22:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E281BA3B;
	Tue, 12 Sep 2023 22:02:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBF2BA29
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 22:02:34 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204F810DD
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 15:02:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31768ce2e81so6257811f8f.1
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 15:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694556151; x=1695160951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRZNSdP60g3qhYw+9NkB+2cckjXOfrOOXxcNI7EXbk8=;
        b=iPZko5XIRObRyQZ68Z3eupgWycobinUMEn7po1rfZBNwQYqkSW3d8sJfaXSzazlSVA
         zsy28PpMu+lOrZxbTxouKdJTLNXwpiJfcqAoEMPveXmPXkbDlY0SenJ91yp6MwlYHMN2
         lOf7A/iwxihp3/3QWQdsXm0SBbi891ARsywTbkjZZ3uRKG/K+KsE4O/Hofddg5/zJOx8
         ZbmOxc+rcvI4vz4vBJys5lzYWVwPpDLokp67fucSGdmRTwSPza3haoWgLosmIrEDNJPK
         VL/zNWEZ97wbd8z/wk61B8g9vSXgqpkVp2ZzFWB3ST1XI0GDaCcAWcDdzxM4/l6aP/Rl
         aVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694556151; x=1695160951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRZNSdP60g3qhYw+9NkB+2cckjXOfrOOXxcNI7EXbk8=;
        b=o8QCII/51K5Z2g1GVAQdOVdTTpCu9fqG5/RAFVds/hSLfDjKQfelM+VTRDw8BMP7df
         9flt18NlceGGgm586TUz7/fMgVNty7rDDFWTD4C4QC/p0AY4z12kylXh5Se1v1WXIHmw
         ixafuN1W4NCvMOA4aNHTi8a7Th6eLDX0WnQXoiZfItaKSU15DnUJhVJDB5KVELACK2T7
         AGRZeKSzOrqasK5u0+wfozXEozNvLEH1lKW/iFa/8/1VcjUoh0i1/ew/2ktPJLgLVw8L
         52V1vWnvVPbT2smsmC91Z58kTfd5FUTvXfF7xp8/4J2Mfv+s+i+Z05LOtGegR3KWr+Ss
         szLw==
X-Gm-Message-State: AOJu0YxkOPPFqCxmPjrQctiuZRsI4Hz1zrGj2/HHzlW8zGxxFOlOi/KJ
	KK7p8aDkXgAAuGBBIVQ3je4lQEi8t7QkHA==
X-Google-Smtp-Source: AGHT+IGUQwG9R6+WCiIoTcqFACdP9oaRiOb8ZHnGS5T1NURVCtulDTOQ9aDoQ/2+CC+WTfqwgxUbAg==
X-Received: by 2002:adf:f98a:0:b0:317:5f04:bc00 with SMTP id f10-20020adff98a000000b003175f04bc00mr597523wrr.27.1694556150940;
        Tue, 12 Sep 2023 15:02:30 -0700 (PDT)
Received: from xmarquiegui-HP-ZBook-15-G6.internal.ainguraiiot.com (210.212-55-6.static.clientes.euskaltel.es. [212.55.6.210])
        by smtp.gmail.com with ESMTPSA id a3-20020adfeec3000000b003196e992567sm13799082wrp.115.2023.09.12.15.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 15:02:30 -0700 (PDT)
From: Xabier Marquiegui <reibax@gmail.com>
To: netdev@vger.kernel.org
Cc: richardcochran@gmail.com,
	horms@kernel.org,
	chrony-dev@chrony.tuxfamily.org,
	mlichvar@redhat.com,
	reibax@gmail.com,
	ntp-lists@mattcorallo.com,
	shuah@kernel.org,
	davem@davemloft.net,
	rrameshbabu@nvidia.com,
	alex.maftei@amd.com
Subject: [PATCH net-next v2 3/3] ptp: support event queue reader channel masks
Date: Wed, 13 Sep 2023 00:02:17 +0200
Message-Id: <20230912220217.2008895-3-reibax@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912220217.2008895-1-reibax@gmail.com>
References: <20230912220217.2008895-1-reibax@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement ioctl to support filtering of external timestamp event queue
channels per reader based on the process PID accessing the timestamp
queue.

Can be tested using testptp test binary. Use lsof to figure out readers
of the DUT. LSB of the timestamp channel mask is channel 0.

eg: To allow PID 3000 to access only ts channel 0:
```
 # testptp -F 3000,0x1
```

eg: To allow PID 3000 to access any channel:
```
 # testptp -F 3000,0xFFFFFFFF
```

Signed-off-by: Xabier Marquiegui <reibax@gmail.com>
Suggested-by: Richard Cochran <richardcochran@gmail.com>
---
v2:
  - fix testptp compilation error: unknown type name 'pid_t'
  - rename mask variable for easier code traceability
  - more detailed commit message with two examples
v1: https://lore.kernel.org/netdev/20230906104754.1324412-4-reibax@gmail.com/

 drivers/ptp/ptp_chardev.c             | 17 +++++++++++++++++
 drivers/ptp/ptp_clock.c               |  4 +++-
 drivers/ptp/ptp_private.h             |  1 +
 include/uapi/linux/ptp_clock.h        |  7 +++++++
 tools/testing/selftests/ptp/testptp.c | 26 +++++++++++++++++++++++++-
 5 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index c9da0f27d204..007f7710421e 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -109,6 +109,7 @@ int ptp_open(struct posix_clock *pc, fmode_t fmode)
 	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
 	if (!queue)
 		return -EINVAL;
+	queue->tsevqmask = 0xFFFFFFFF;
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
+			if (tsevq->reader_pid == (pid_t)tsfilter_req.reader_pid) {
+				tsevq->tsevqmask = tsfilter_req.tsevqmask;
+				break;
+			}
+		}
+		break;
+
 	default:
 		err = -ENOTTY;
 		break;
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index d52fc23e20a8..9ebb78eb333f 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -247,6 +247,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	if (!queue)
 		goto no_memory_queue;
 	queue->reader_pid = 0;
+	queue->tsevqmask = 0xFFFFFFFF;
 	spin_lock_init(&queue->lock);
 	list_add_tail(&queue->qlist, &ptp->tsevqs);
 	mutex_init(&ptp->pincfg_mux);
@@ -406,7 +407,8 @@ void ptp_clock_event(struct ptp_clock *ptp, struct ptp_clock_event *event)
 	case PTP_CLOCK_EXTTS:
 		/* Enqueue timestamp on all other queues */
 		list_for_each_entry_safe(tsevq, tsevq_alt, &ptp->tsevqs, qlist) {
-			enqueue_external_timestamp(tsevq, event);
+			if (tsevq->tsevqmask & (0x1 << event->index))
+				enqueue_external_timestamp(tsevq, event);
 		}
 		wake_up_interruptible(&ptp->tsev_wq);
 		break;
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index 046d1482bcee..6888ecb26e82 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -28,6 +28,7 @@ struct timestamp_event_queue {
 	spinlock_t lock;
 	struct list_head qlist;
 	pid_t reader_pid;
+	int tsevqmask;
 };
 
 struct ptp_clock {
diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
index 05cc35fc94ac..a13ab8e27703 100644
--- a/include/uapi/linux/ptp_clock.h
+++ b/include/uapi/linux/ptp_clock.h
@@ -105,6 +105,11 @@ struct ptp_extts_request {
 	unsigned int rsv[2]; /* Reserved for future use. */
 };
 
+struct ptp_tsfilter_request {
+	unsigned int reader_pid; /* PID of process reading the timestamp event queue */
+	unsigned int tsevqmask; /* Channel mask. LSB = channel 0 */
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
index c9f6cca4feb4..e84ff689c6be 100644
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
+	tsfilter_req.tsevqmask = 0xFFFFFFFF;
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
+				     &tsfilter_req.tsevqmask);
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
+			       (int)tsfilter_req.tsevqmask, tsfilter_req.reader_pid);
+		}
+	}
+
 	close(fd);
 	return 0;
 }
-- 
2.34.1


