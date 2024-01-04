Return-Path: <netdev+bounces-61691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58343824A45
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 22:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E108F2828D1
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 21:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CCA2C6BE;
	Thu,  4 Jan 2024 21:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w1QGQnmR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7192D048
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 21:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maheshb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ee22efe5eeso15149747b3.3
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 13:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704403486; x=1705008286; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xENgso4n4fwY8PEdZvKR4PshgcWGW2WWHOQxmwL55XE=;
        b=w1QGQnmRnSapbn02YeSMy17CMYtfiwO1/QEOWIAxbGpnzxiZEFmSl+hhv6xMF/vh3m
         rXyMO73OXFyi0XpuEomG/1UyMupseEBQadDlYAvobdo35gqChndnSRxfhCGN33My+vQD
         MMjjS6ho0EXHdxr2dBRMUXnP8X2Db6Af+a5I+1QVupoPXRCew1XV+s333XY+Pz6q+/+d
         Pvl+uxhGEUVBDqLSQGi+f2s2LUJH25T40I9MdalXrDdWvCm6qwWyvoRDVvQ8DuRGxBMc
         IvZ6vj/rJP+xzeOrg3voss13rRFfxTQc+POTXRIrsVH8Pas08M+kc6ZKdQrYghzTomkx
         gpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704403486; x=1705008286;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xENgso4n4fwY8PEdZvKR4PshgcWGW2WWHOQxmwL55XE=;
        b=aYEZxufUUu6lI0HQsiSwlrlh1gpzcj1C9Nm+9alwraQV2mpuNgC06aZTVkI67JP+qK
         0mDA2cTbShvk/vSDIXOovr4YLOCIuF+gfp6KeEIKAcasqrbZ0W1geUNM0DA7zXveuraZ
         gIsCaqUsVo4bT7UanVRW2nMJBb/96PciFNOaEa87gFNU8E+Wy6Xm4p8ftWduc58KRVwK
         d7vB4exkDB12VwbbWi5/qGTGhyPxqfw5kGjOLF7jpJ5eIN9ibKxx8i6m1oSk+Aru2Yai
         EsT+90O6k0avlHdyFpaUUR12ntoPgeTBGtWR30RLsSteSmuSmFyLekNyNQdgxdWH7CpN
         JCMQ==
X-Gm-Message-State: AOJu0Yy+8wd5LSU8yJ9LlXrF8VJwT3eEfsSyUUPEjcoFclesxBUwIjZq
	XJpKXZw6Ea+vKl+ct8M5A1DP/eUNKos1iKGIRIfVddEI7SWE1vwEiJWgcPK56zQ+hzLcxYR3OHL
	jAxpFazR9+dX6tBLsYbVZFFj6cf8xRSP8G4JcIp23N+3kF4FkAMn6qsPiWTLpDBJjIj//ELQ=
X-Google-Smtp-Source: AGHT+IET83VvDAOj7JZXvBx/xaIF5a53RRUZ4JeEWaaMQjz8Wpcmfjbtpny2NCSB1F0J2HSWux18PBjjMx+4
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2b7a])
 (user=maheshb job=sendgmr) by 2002:a05:690c:303:b0:5d3:b449:e58e with SMTP id
 bg3-20020a05690c030300b005d3b449e58emr494691ywb.6.1704403485511; Thu, 04 Jan
 2024 13:24:45 -0800 (PST)
Date: Thu,  4 Jan 2024 13:24:42 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.195.gebba966016-goog
Message-ID: <20240104212442.3276812-1-maheshb@google.com>
Subject: [PATCHv3 net-next 3/3] selftest/ptp: extend test to include ptp_gettimex64any()
From: Mahesh Bandewar <maheshb@google.com>
To: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>, Don Hatchett <hatch@google.com>, 
	Yuliang Li <yuliangli@google.com>, Mahesh Bandewar <mahesh@bandewar.net>, 
	Mahesh Bandewar <maheshb@google.com>, Richard Cochran <richardcochran@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Update testptp.c to exercise the new ptp method gettimex64any().

When only -x option is given the PTP_SYS_OFFSET_EXTENDED or
gettimex64() method is exercised while presence of -x with -y
will exercise PTP_SYS_OFFSET_ANY or gettimex64any() method.
-y option is to choose the timebase from available options
of real, mono, or raw.

Signed-off-by: Mahesh Bandewar <maheshb@google.com>
CC: Richard Cochran <richardcochran@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>
CC: John Stultz <jstultz@google.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: "Willem de Bruijn" <willemb@google.com>
CC: linux-kselftest@vger.kernel.org
CC: netdev@vger.kernel.org
---
 tools/testing/selftests/ptp/testptp.c | 96 ++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index 011252fe238c..dd390062b883 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -146,8 +146,9 @@ static void usage(char *progname)
 		" -T val     set the ptp clock time to 'val' seconds\n"
 		" -x val     get an extended ptp clock time with the desired number of samples (up to %d)\n"
 		" -X         get a ptp clock cross timestamp\n"
+		" -y val     sandwich timebase to use {real|mono|raw}\n"
 		" -z         test combinations of rising/falling external time stamp flags\n",
-		progname, PTP_MAX_SAMPLES);
+		progname, PTP_MAX_SAMPLES, PTP_MAX_SAMPLES);
 }
 
 int main(int argc, char *argv[])
@@ -163,6 +164,7 @@ int main(int argc, char *argv[])
 	struct ptp_sys_offset *sysoff;
 	struct ptp_sys_offset_extended *soe;
 	struct ptp_sys_offset_precise *xts;
+	struct ptp_sys_offset_any *ats;
 
 	char *progname;
 	unsigned int i;
@@ -183,6 +185,8 @@ int main(int argc, char *argv[])
 	int pct_offset = 0;
 	int getextended = 0;
 	int getcross = 0;
+	int get_ext_any = 0;
+	clockid_t ext_any_clkid = -1;
 	int n_samples = 0;
 	int pin_index = -1, pin_func;
 	int pps = -1;
@@ -198,7 +202,7 @@ int main(int argc, char *argv[])
 
 	progname = strrchr(argv[0], '/');
 	progname = progname ? 1+progname : argv[0];
-	while (EOF != (c = getopt(argc, argv, "cd:e:f:F:ghH:i:k:lL:n:o:p:P:sSt:T:w:x:Xz"))) {
+	while (EOF != (c = getopt(argc, argv, "cd:e:f:F:ghH:i:k:lL:n:o:p:P:sSt:T:w:x:Xy:z"))) {
 		switch (c) {
 		case 'c':
 			capabilities = 1;
@@ -278,6 +282,20 @@ int main(int argc, char *argv[])
 		case 'X':
 			getcross = 1;
 			break;
+		case 'y':
+			if (!strcasecmp(optarg, "real"))
+				ext_any_clkid = CLOCK_REALTIME;
+			else if (!strcasecmp(optarg, "mono"))
+				ext_any_clkid = CLOCK_MONOTONIC;
+			else if (!strcasecmp(optarg, "raw"))
+				ext_any_clkid = CLOCK_MONOTONIC_RAW;
+			else {
+				fprintf(stderr,
+					"type needs to be one of real,mono,raw only; was given %s\n",
+					optarg);
+				return -1;
+			}
+			break;
 		case 'z':
 			flagtest = 1;
 			break;
@@ -291,6 +309,18 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	/* For ptp_sys_offset_any both options 'x', 'y' must be given */
+	if (ext_any_clkid > -1) {
+		if (getextended == 0) {
+			fprintf(stderr,
+				"For extended-any TS both options -x, and -y are required.\n");
+			usage(progname);
+			return -1;
+		}
+		get_ext_any = getextended;
+		getextended = 0;
+	}
+
 	fd = open(device, O_RDWR);
 	if (fd < 0) {
 		fprintf(stderr, "opening %s: %s\n", device, strerror(errno));
@@ -621,6 +651,68 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (get_ext_any) {
+		ats = calloc(1, sizeof(*ats));
+		if (!ats) {
+			perror("calloc");
+			return -1;
+		}
+
+		ats->n_samples = get_ext_any;
+		ats->clockid = ext_any_clkid;
+
+		if (ioctl(fd, PTP_SYS_OFFSET_ANY, ats)) {
+			perror("PTP_SYS_OFFSET_ANY");
+		} else {
+			printf("extended-any timestamp request returned %d samples\n",
+			       get_ext_any);
+
+			for (i = 0; i < get_ext_any; i++) {
+				switch (ext_any_clkid) {
+				case CLOCK_REALTIME:
+					printf("sample #%2d: system time before: %lld.%09u\n",
+					       i, ats->ts[i][0].sec,
+					       ats->ts[i][0].nsec);
+					break;
+				case CLOCK_MONOTONIC:
+					printf("sample #%2d: monotonic time before: %lld.%09u\n",
+					       i, ats->ts[i][0].sec,
+					       ats->ts[i][0].nsec);
+					break;
+				case CLOCK_MONOTONIC_RAW:
+					printf("sample #%2d: raw-monotonic time before: %lld.%09u\n",
+					       i, ats->ts[i][0].sec,
+					       ats->ts[i][0].nsec);
+					break;
+				default:
+					break;
+				}
+				printf("            phc time: %lld.%09u\n",
+				       ats->ts[i][1].sec, ats->ts[i][1].nsec);
+				switch (ext_any_clkid) {
+				case CLOCK_REALTIME:
+					printf("            system time after: %lld.%09u\n",
+					       ats->ts[i][2].sec,
+					       ats->ts[i][2].nsec);
+					break;
+				case CLOCK_MONOTONIC:
+					printf("            monotonic time after: %lld.%09u\n",
+					       ats->ts[i][2].sec,
+					       ats->ts[i][2].nsec);
+					break;
+				case CLOCK_MONOTONIC_RAW:
+					printf("            raw-monotonic time after: %lld.%09u\n",
+					       ats->ts[i][2].sec,
+					       ats->ts[i][2].nsec);
+					break;
+				default:
+					break;
+				}
+			}
+		}
+
+		free(ats);
+	}
 	close(fd);
 	return 0;
 }
-- 
2.43.0.195.gebba966016-goog


