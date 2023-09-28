Return-Path: <netdev+bounces-36824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3854E7B1E92
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 15:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 6EE991C20A3B
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 13:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56153B790;
	Thu, 28 Sep 2023 13:36:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C543B78E
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 13:35:59 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F3F11F
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 06:35:55 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40652e5718cso5021445e9.3
        for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 06:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695908154; x=1696512954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UiyRUxjojuiFB63gcdUVPWU8E5Ro+y1h5lmPhPXqPBw=;
        b=HwuNe9rHVL9akdLyDYyGrpW6jCnY9SEOTXdDgeTeDeii1CQXbFllsDkWXA9bLnuwrJ
         WKJnzVWZ1w8qx/XKhgINR4nscgG+y8j4vsCIqs13idDlrOSR7ttESKdkdG9YtFBuNGPM
         i3Bbv0GWXv2Nl87yHab1KYaeP+yr31Eg7so7x6HwbKTN0xTYBF3QxNHx7Gg8W0SfICAB
         SSbiQ4n7n7zSMLsceglFWbcV4cKkCcBdaQQzgsbAr69+Pb1YXGu77y0CybOCVeeyVeuG
         5U2CNrVe1RgkP6mWgw+KKw7KFSi7igD3/PYmxKInMVoC9nhn4+cb803f6n8LNtMxFotc
         T4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695908154; x=1696512954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UiyRUxjojuiFB63gcdUVPWU8E5Ro+y1h5lmPhPXqPBw=;
        b=kOUnt7P8IW8UB+MPop0YY2Y67BbCByKLpejzJq2zC8tEwlnF2+x3EjoAfTBo5oSECx
         xaLKU5lTGS42gc4fRyi3q5o7YYsY/zX1SlAhk5fMqj2ICaBRuS5udts/pHQYchZ+di2O
         QFMBeXmJJrd/0H1eAjJfVxf7xFdxCl6aLN80zTxFjb8vxmKVTBEXiDXYQ83bpn+PAN3k
         RuTjkFK6EAtNvvgtvZS3KzhorM02ZTEbEGoO/M7OnVdmm1ZMlyv4Yoe4kWqKBEtiCeJh
         8rg7VCRF944eBFrxSP58ZwPr/2iFJsUiTMf/ZXqdxf5d+9/ENLSmU6YyZH9pbFvrRKrB
         S8Rw==
X-Gm-Message-State: AOJu0Yx53eJo8nm6nBYHCV9sfh7QkrqXgBRTvCOoRGDhyKMoiaFikPiX
	3O6Y7hzJUASLfmvZbPOo9ESCDyZAvSO21A==
X-Google-Smtp-Source: AGHT+IEfd1gxvJj6T9tWGjREW4+6cOWucwT6DfnzP55r0iQKRs2tqjMe62dKRHOaLKMw7ZtmDFDkCA==
X-Received: by 2002:a1c:4b13:0:b0:405:3dee:3515 with SMTP id y19-20020a1c4b13000000b004053dee3515mr1279424wma.27.1695908153521;
        Thu, 28 Sep 2023 06:35:53 -0700 (PDT)
Received: from xmarquiegui-HP-ZBook-15-G6.internal.ainguraiiot.com (210.212-55-6.static.clientes.euskaltel.es. [212.55.6.210])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c378b00b00406443c8b4fsm4011871wmr.19.2023.09.28.06.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 06:35:53 -0700 (PDT)
From: Xabier Marquiegui <reibax@gmail.com>
To: netdev@vger.kernel.org
Cc: richardcochran@gmail.com,
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
Subject: [PATCH net-next v3 3/3] ptp: support event queue reader channel masks
Date: Thu, 28 Sep 2023 15:35:44 +0200
Message-Id: <20230928133544.3642650-4-reibax@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928133544.3642650-1-reibax@gmail.com>
References: <20230928133544.3642650-1-reibax@gmail.com>
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

Implement ioctl to support filtering of external timestamp event queue
channels per reader based on the process PID accessing the timestamp
queue.

Can be tested using testptp test binary. Use lsof to figure out readers
of the DUT. LSB of the timestamp channel mask is channel 0.

eg: To view all current users of the device:
```
 # testptp -F  /dev/ptp0 
(USER PID)     TSEVQ FILTER ID:MASK
(3234)              1:0x00000001
(3692)              2:0xFFFFFFFF
(3792)              3:0xFFFFFFFF
(8713)              4:0xFFFFFFFF
```

eg: To allow ID 1 to access only ts channel 0:
```
 # testptp -F 1,0x1
```

eg: To allow ID 1 to access any channel:
```
 # testptp -F 1,0xFFFFFFFF
```

Signed-off-by: Xabier Marquiegui <reibax@gmail.com>
Suggested-by: Richard Cochran <richardcochran@gmail.com>
---
v3:
  - filter application by object id, aided by process id
  - friendlier testptp implementation of event queue channel filters
v2: https://lore.kernel.org/netdev/20230912220217.2008895-3-reibax@gmail.com/
  - fix testptp compilation error: unknown type name 'pid_t'
  - rename mask variable for easier code traceability
  - more detailed commit message with two examples
v1: https://lore.kernel.org/netdev/20230906104754.1324412-4-reibax@gmail.com/

 drivers/ptp/ptp_chardev.c             |  85 +++++++++++++-
 drivers/ptp/ptp_clock.c               |   4 +-
 drivers/ptp/ptp_private.h             |   1 +
 include/uapi/linux/ptp_clock.h        |  12 ++
 tools/testing/selftests/ptp/testptp.c | 158 ++++++++++++++++++++------
 5 files changed, 221 insertions(+), 39 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 65e7acaa40a9..14b5bd7e7ca2 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -114,6 +114,7 @@ int ptp_open(struct posix_clock_user *pcuser, fmode_t fmode)
 	if (!queue)
 		return -EINVAL;
 	queue->close_req = false;
+	queue->mask = 0xFFFFFFFF;
 	queue->reader_pid = task_pid_nr(current);
 	spin_lock_init(&queue->lock);
 	queue->ida = ida;
@@ -169,19 +170,28 @@ long ptp_ioctl(struct posix_clock_user *pcuser, unsigned int cmd,
 {
 	struct ptp_clock *ptp =
 		container_of(pcuser->clk, struct ptp_clock, clock);
+	struct ptp_tsfilter tsfilter_set, *tsfilter_get = NULL;
 	struct ptp_sys_offset_extended *extoff = NULL;
 	struct ptp_sys_offset_precise precise_offset;
 	struct system_device_crosststamp xtstamp;
 	struct ptp_clock_info *ops = ptp->info;
 	struct ptp_sys_offset *sysoff = NULL;
+	struct timestamp_event_queue *tsevq;
 	struct ptp_system_timestamp sts;
 	struct ptp_clock_request req;
 	struct ptp_clock_caps caps;
 	struct ptp_clock_time *pct;
+	int lsize, enable, err = 0;
 	unsigned int i, pin_index;
 	struct ptp_pin_desc pd;
 	struct timespec64 ts;
-	int enable, err = 0;
+
+	tsevq = pcuser->private_clkdata;
+
+	if (tsevq->close_req) {
+		err = -EPIPE;
+		return err;
+	}
 
 	switch (cmd) {
 
@@ -481,6 +491,79 @@ long ptp_ioctl(struct posix_clock_user *pcuser, unsigned int cmd,
 		mutex_unlock(&ptp->pincfg_mux);
 		break;
 
+	case PTP_FILTERCOUNT_REQUEST:
+		/* Calculate amount of device users */
+		if (tsevq) {
+			lsize = list_count_nodes(&tsevq->qlist);
+			if (copy_to_user((void __user *)arg, &lsize,
+					 sizeof(lsize)))
+				err = -EFAULT;
+		}
+		break;
+	case PTP_FILTERTS_GET_REQUEST:
+		/* Read operation */
+		/* Read amount of entries expected */
+		if (copy_from_user(&tsfilter_set, (void __user *)arg,
+				   sizeof(tsfilter_set))) {
+			err = -EFAULT;
+			break;
+		}
+		if (tsfilter_set.ndevusers <= 0) {
+			err = -EINVAL;
+			break;
+		}
+		/* Allocate the necessary memory space to dump the requested filter
+		 * list
+		 */
+		tsfilter_get = kzalloc(tsfilter_set.ndevusers *
+					       sizeof(struct ptp_tsfilter),
+				       GFP_KERNEL);
+		if (!tsfilter_get) {
+			err = -ENOMEM;
+			break;
+		}
+		if (!tsevq) {
+			err = -EFAULT;
+			break;
+		}
+		/* Set the whole region to 0 in case the current list is shorter than
+		 * anticipated
+		 */
+		memset(tsfilter_get, 0,
+		       tsfilter_set.ndevusers * sizeof(struct ptp_tsfilter));
+		i = 0;
+		/* Format data */
+		list_for_each_entry(tsevq, &ptp->tsevqs, qlist) {
+			tsfilter_get[i].reader_rpid = tsevq->reader_pid;
+			tsfilter_get[i].reader_oid = tsevq->oid;
+			tsfilter_get[i].mask = tsevq->mask;
+			i++;
+			/* Current list is longer than anticipated */
+			if (i >= tsfilter_set.ndevusers)
+				break;
+		}
+		/* Dump data */
+		if (copy_to_user((void __user *)arg, tsfilter_get,
+				 tsfilter_set.ndevusers *
+					 sizeof(struct ptp_tsfilter)))
+			err = -EFAULT;
+		break;
+
+	case PTP_FILTERTS_SET_REQUEST:
+		/* Write Operation */
+		if (copy_from_user(&tsfilter_set, (void __user *)arg,
+				   sizeof(tsfilter_set))) {
+			err = -EFAULT;
+			break;
+		}
+		if (tsevq) {
+			list_for_each_entry(tsevq, &ptp->tsevqs, qlist) {
+				if (tsevq->oid == tsfilter_set.reader_oid)
+					tsevq->mask = tsfilter_set.mask;
+			}
+		}
+		break;
+
 	default:
 		err = -ENOTTY;
 		break;
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 9e271ad66933..6284eaad5f53 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -280,6 +280,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	if (!queue)
 		goto no_memory_queue;
 	queue->close_req = false;
+	queue->mask = 0xFFFFFFFF;
 	queue->ida = kzalloc(sizeof(*queue->ida), GFP_KERNEL);
 	if (!queue->ida)
 		goto no_memory_queue;
@@ -449,7 +450,8 @@ void ptp_clock_event(struct ptp_clock *ptp, struct ptp_clock_event *event)
 	case PTP_CLOCK_EXTTS:
 		/* Enqueue timestamp on all other queues */
 		list_for_each_entry(tsevq, &ptp->tsevqs, qlist) {
-			enqueue_external_timestamp(tsevq, event);
+			if (tsevq->mask & (0x1 << event->index))
+				enqueue_external_timestamp(tsevq, event);
 		}
 		wake_up_interruptible(&ptp->tsev_wq);
 		break;
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index 529d3d421ba0..c8ff2272f837 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -32,6 +32,7 @@ struct timestamp_event_queue {
 	pid_t reader_pid;
 	struct ida *ida;
 	int oid;
+	int mask;
 	bool close_req;
 };
 
diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
index 05cc35fc94ac..6bbf11dc4a05 100644
--- a/include/uapi/linux/ptp_clock.h
+++ b/include/uapi/linux/ptp_clock.h
@@ -105,6 +105,15 @@ struct ptp_extts_request {
 	unsigned int rsv[2]; /* Reserved for future use. */
 };
 
+struct ptp_tsfilter {
+	union {
+		unsigned int reader_rpid; /* PID of device user */
+		unsigned int ndevusers; /* Device user count */
+	};
+	int reader_oid; /* Object ID of the timestamp event queue */
+	unsigned int mask; /* Channel mask. LSB = channel 0 */
+};
+
 struct ptp_perout_request {
 	union {
 		/*
@@ -224,6 +233,9 @@ struct ptp_pin_desc {
 	_IOWR(PTP_CLK_MAGIC, 17, struct ptp_sys_offset_precise)
 #define PTP_SYS_OFFSET_EXTENDED2 \
 	_IOWR(PTP_CLK_MAGIC, 18, struct ptp_sys_offset_extended)
+#define PTP_FILTERTS_SET_REQUEST _IOW(PTP_CLK_MAGIC, 19, struct ptp_tsfilter)
+#define PTP_FILTERCOUNT_REQUEST _IOR(PTP_CLK_MAGIC, 20, int)
+#define PTP_FILTERTS_GET_REQUEST _IOWR(PTP_CLK_MAGIC, 21, struct ptp_tsfilter)
 
 struct ptp_extts_event {
 	struct ptp_clock_time t; /* Time event occured. */
diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index c9f6cca4feb4..e7ff22d60d63 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -22,6 +22,7 @@
 #include <sys/types.h>
 #include <time.h>
 #include <unistd.h>
+#include <stdbool.h>
 
 #include <linux/ptp_clock.h>
 
@@ -117,35 +118,36 @@ static void usage(char *progname)
 {
 	fprintf(stderr,
 		"usage: %s [options]\n"
-		" -c         query the ptp clock's capabilities\n"
-		" -d name    device to open\n"
-		" -e val     read 'val' external time stamp events\n"
-		" -f val     adjust the ptp clock frequency by 'val' ppb\n"
-		" -g         get the ptp clock time\n"
-		" -h         prints this message\n"
-		" -i val     index for event/trigger\n"
-		" -k val     measure the time offset between system and phc clock\n"
-		"            for 'val' times (Maximum 25)\n"
-		" -l         list the current pin configuration\n"
-		" -L pin,val configure pin index 'pin' with function 'val'\n"
-		"            the channel index is taken from the '-i' option\n"
-		"            'val' specifies the auxiliary function:\n"
-		"            0 - none\n"
-		"            1 - external time stamp\n"
-		"            2 - periodic output\n"
-		" -n val     shift the ptp clock time by 'val' nanoseconds\n"
-		" -o val     phase offset (in nanoseconds) to be provided to the PHC servo\n"
-		" -p val     enable output with a period of 'val' nanoseconds\n"
-		" -H val     set output phase to 'val' nanoseconds (requires -p)\n"
-		" -w val     set output pulse width to 'val' nanoseconds (requires -p)\n"
-		" -P val     enable or disable (val=1|0) the system clock PPS\n"
-		" -s         set the ptp clock time from the system time\n"
-		" -S         set the system time from the ptp clock time\n"
-		" -t val     shift the ptp clock time by 'val' seconds\n"
-		" -T val     set the ptp clock time to 'val' seconds\n"
-		" -x val     get an extended ptp clock time with the desired number of samples (up to %d)\n"
-		" -X         get a ptp clock cross timestamp\n"
-		" -z         test combinations of rising/falling external time stamp flags\n",
+		" -c           query the ptp clock's capabilities\n"
+		" -d name      device to open\n"
+		" -e val       read 'val' external time stamp events\n"
+		" -f val       adjust the ptp clock frequency by 'val' ppb\n"
+		" -F [oid,msk] with no arguments, list the users of the device\n"
+		" -g           get the ptp clock time\n"
+		" -h           prints this message\n"
+		" -i val       index for event/trigger\n"
+		" -k val       measure the time offset between system and phc clock\n"
+		"              for 'val' times (Maximum 25)\n"
+		" -l           list the current pin configuration\n"
+		" -L pin,val   configure pin index 'pin' with function 'val'\n"
+		"              the channel index is taken from the '-i' option\n"
+		"              'val' specifies the auxiliary function:\n"
+		"              0 - none\n"
+		"              1 - external time stamp\n"
+		"              2 - periodic output\n"
+		" -n val       shift the ptp clock time by 'val' nanoseconds\n"
+		" -o val       phase offset (in nanoseconds) to be provided to the PHC servo\n"
+		" -p val       enable output with a period of 'val' nanoseconds\n"
+		" -H val       set output phase to 'val' nanoseconds (requires -p)\n"
+		" -w val       set output pulse width to 'val' nanoseconds (requires -p)\n"
+		" -P val       enable or disable (val=1|0) the system clock PPS\n"
+		" -s           set the ptp clock time from the system time\n"
+		" -S           set the system time from the ptp clock time\n"
+		" -t val       shift the ptp clock time by 'val' seconds\n"
+		" -T val       set the ptp clock time to 'val' seconds\n"
+		" -x val       get an extended ptp clock time with the desired number of samples (up to %d)\n"
+		" -X           get a ptp clock cross timestamp\n"
+		" -z           test combinations of rising/falling external time stamp flags\n",
 		progname, PTP_MAX_SAMPLES);
 }
 
@@ -162,6 +164,7 @@ int main(int argc, char *argv[])
 	struct ptp_sys_offset *sysoff;
 	struct ptp_sys_offset_extended *soe;
 	struct ptp_sys_offset_precise *xts;
+	struct ptp_tsfilter tsfilter, *tsfilter_read;
 
 	char *progname;
 	unsigned int i;
@@ -187,6 +190,7 @@ int main(int argc, char *argv[])
 	int pps = -1;
 	int seconds = 0;
 	int settime = 0;
+	int rvalue = 0;
 
 	int64_t t1, t2, tp;
 	int64_t interval, offset;
@@ -194,9 +198,17 @@ int main(int argc, char *argv[])
 	int64_t pulsewidth = -1;
 	int64_t perout = -1;
 
+	tsfilter_read = NULL;
+	tsfilter.ndevusers = 0;
+	tsfilter.reader_oid = 0;
+	tsfilter.mask = 0xFFFFFFFF;
+	bool opt_tsfilter = false;
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
@@ -210,6 +222,15 @@ int main(int argc, char *argv[])
 		case 'f':
 			adjfreq = atoi(optarg);
 			break;
+		case 'F':
+			opt_tsfilter = true;
+			cnt = sscanf(optarg, "%d,%X", &tsfilter.reader_oid,
+				     &tsfilter.mask);
+			if (cnt != 2 && cnt != 0) {
+				usage(progname);
+				return -1;
+			}
+			break;
 		case 'g':
 			gettime = 1;
 			break;
@@ -295,7 +316,8 @@ int main(int argc, char *argv[])
 	clkid = get_clockid(fd);
 	if (CLOCK_INVALID == clkid) {
 		fprintf(stderr, "failed to read clock id\n");
-		return -1;
+		rvalue = -1;
+		goto exit;
 	}
 
 	if (capabilities) {
@@ -464,18 +486,21 @@ int main(int argc, char *argv[])
 
 	if (pulsewidth >= 0 && perout < 0) {
 		puts("-w can only be specified together with -p");
-		return -1;
+		rvalue = -1;
+		goto exit;
 	}
 
 	if (perout_phase >= 0 && perout < 0) {
 		puts("-H can only be specified together with -p");
-		return -1;
+		rvalue = -1;
+		goto exit;
 	}
 
 	if (perout >= 0) {
 		if (clock_gettime(clkid, &ts)) {
 			perror("clock_gettime");
-			return -1;
+			rvalue = -1;
+			goto exit;
 		}
 		memset(&perout_request, 0, sizeof(perout_request));
 		perout_request.index = index;
@@ -516,13 +541,15 @@ int main(int argc, char *argv[])
 		if (n_samples <= 0 || n_samples > 25) {
 			puts("n_samples should be between 1 and 25");
 			usage(progname);
-			return -1;
+			rvalue = -1;
+			goto exit;
 		}
 
 		sysoff = calloc(1, sizeof(*sysoff));
 		if (!sysoff) {
 			perror("calloc");
-			return -1;
+			rvalue = -1;
+			goto exit;
 		}
 		sysoff->n_samples = n_samples;
 
@@ -604,6 +631,63 @@ int main(int argc, char *argv[])
 		free(xts);
 	}
 
+	if (opt_tsfilter) {
+		if (tsfilter.reader_oid) {
+			/* Set a filter for a specific object id */
+			if (ioctl(fd, PTP_FILTERTS_SET_REQUEST, &tsfilter)) {
+				perror("PTP_FILTERTS_SET_REQUEST");
+				rvalue = -1;
+				goto exit;
+			}
+			printf("Timestamp event queue mask 0x%X applied to reader with oid: %d\n",
+			       (int)tsfilter.mask, tsfilter.reader_oid);
+
+		} else {
+			/* List all filters */
+			if (ioctl(fd, PTP_FILTERCOUNT_REQUEST,
+				  &tsfilter.ndevusers)) {
+				perror("PTP_FILTERTS_SET_REQUEST");
+				rvalue = -1;
+				goto exit;
+			}
+			tsfilter_read = calloc(tsfilter.ndevusers,
+					       sizeof(*tsfilter_read));
+			/*
+			 * Get a variable length result from the IOCTL. We use a value
+			 * inside the structure we are willing to read to communicate the
+			 * IOCTL how many elements we are expecting to get.
+			 * It's ok if the size of the list changed between these two operations,
+			 * this is just an approximation to be able to test the concept.
+			 */
+			tsfilter_read[0].ndevusers = tsfilter.ndevusers;
+			if (!tsfilter_read) {
+				perror("tsfilter_read calloc");
+				rvalue = -1;
+				goto exit;
+			}
+			if (ioctl(fd, PTP_FILTERTS_GET_REQUEST,
+				  tsfilter_read)) {
+				perror("PTP_FILTERTS_GET_REQUEST");
+				rvalue = -1;
+				goto exit;
+			}
+			printf("(USER PID)\tTSEVQ FILTER ID:MASK\n");
+			for (i = 0; i < tsfilter.ndevusers; i++) {
+				if (tsfilter_read[i].reader_oid)
+					printf("(%d)\t\t%5d:0x%08X\n",
+					       tsfilter_read[i].reader_rpid,
+					       tsfilter_read[i].reader_oid,
+					       tsfilter_read[i].mask);
+			}
+		}
+	}
+
+exit:
+	if (tsfilter_read) {
+		free(tsfilter_read);
+		tsfilter_read = NULL;
+	}
+
 	close(fd);
-	return 0;
+	return rvalue;
 }
-- 
2.34.1


