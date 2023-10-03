Return-Path: <netdev+bounces-37559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C147B5FBC
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 06:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 7B1051C20991
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 04:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36288ED8;
	Tue,  3 Oct 2023 04:17:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F7D1398
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 04:17:12 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994BBCC
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 21:17:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d86dac81f8fso708218276.1
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 21:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696306630; x=1696911430; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xVHKEQiikdMgbU+y27225hg2LnDyDOWoRLfGIfsc16c=;
        b=0U/Z3kCJttS7atNniTMaDYdXA8Yw8ZGiE2tZ/+72SyS/+HugQMWMxTeV9I+mWhHPhO
         EW0BhySSwZ/I3gct/YSiHnPkdi6UWMQBsiA2MqZDPA4eYWxdwCfQmNhaBbsCnmt+Fy4y
         gXMgQdMl9e1ZPN9yK7WbJ+F4SWOCEOb4o53stY6LF5DnyB4lNKvqZY2wzpKgDhR/Y/90
         OSAtZE20HEfrbwsIB86FzoX1QufryaHkP9+/bM04dvg4C5dIJG1bYW2afdUjvBCoWHlP
         Vid14Gv58kq6EAgSa3CoaZK9VsW7/y7VW+GZPNyfii54fCqklACp8MhsybrF6U1tlIt8
         tz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696306630; x=1696911430;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xVHKEQiikdMgbU+y27225hg2LnDyDOWoRLfGIfsc16c=;
        b=NNoU+Sa9qmtAIWPOc0Z2FgDWfhlgyetbz7OY89nUitS76yW6Ar03ar4D8hIuF8+/3T
         2NOGZ+blgKDkEeo2Q9CNGKMfWfOcWzxUNE7uFt+sh8rHr8CX0tTzdfRWeiAB8FHvjN8d
         tZ3eeVMIJlha6wyb7WFObX7A9xo6tZGKZo/i9SJ/R56AmzHg05Qhb/7EuH57i6nLUiqX
         CgFfinbRjM0QbOYHFcF9oy9GUc+CDOoiZy9FDO28Z9G58zl2WbLG9/HJTQVZ+sqw4kz4
         VS51YzhqXoRiDxjRXAw/3WmOOVJaKjZgm2c+YTbmEaDo121DoQUUZMYb7wzJnk8Xsti7
         DHeQ==
X-Gm-Message-State: AOJu0YyxWimv43FoaNDFgGzMsLvYUYyktduXRSsVKe7xEE6H8W3xgs6M
	0JyiHO3TtalhVJ8gjY3maSgHT4kCx/O55+gWb0Kmu4zoeF3WbgB8lcsj6VyLuzvDZccqsBFjgqm
	Y/reobDzTXfV7Z/hWF3uFtQbe5sDOMhpcwqMsPPW/MQ3D5dAZzMynvNsOWlaVGru4
X-Google-Smtp-Source: AGHT+IFqdsv7HPhJyVpjFa70cd8lqSqqjzyGMmf+x/TfZsWhqaKDgORtG52OMlda2Z5v7xXb0p2XiHtPY4bs
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2b7a])
 (user=maheshb job=sendgmr) by 2002:a25:abaf:0:b0:d7b:9830:c172 with SMTP id
 v44-20020a25abaf000000b00d7b9830c172mr211752ybi.0.1696306629637; Mon, 02 Oct
 2023 21:17:09 -0700 (PDT)
Date: Mon,  2 Oct 2023 21:17:06 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231003041706.1746634-1-maheshb@google.com>
Subject: [PATCHv2 next 3/3] selftes/ptp: extend test to include ptp_gettimex64any()
From: Mahesh Bandewar <maheshb@google.com>
To: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>, Don Hatchett <hatch@google.com>, 
	Yuliang Li <yuliangli@google.com>, Mahesh Bandewar <mahesh@bandewar.net>, 
	Mahesh Bandewar <maheshb@google.com>, Shuah Khan <shuah@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

add -y/-Y options to support PTP_SYS_OFFSET_ANY2 op. where -y represents
samples to collect while -Y is to choose the timebase from available
options of cycles, real, mono, or raw.

Signed-off-by: Mahesh Bandewar <maheshb@google.com>
CC: Shuah Khan <shuah@kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>
CC: Rahul Rameshbabu <rrameshbabu@nvidia.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: linux-kselftest@vger.kernel.org
CC: netdev@vger.kernel.org
---
 tools/testing/selftests/Makefile      |  1 +
 tools/testing/selftests/ptp/testptp.c | 76 ++++++++++++++++++++++++++-
 2 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 42806add0114..c5e59cfc9830 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -66,6 +66,7 @@ TARGETS += powerpc
 TARGETS += prctl
 TARGETS += proc
 TARGETS += pstore
+TARGETS += ptp
 TARGETS += ptrace
 TARGETS += openat2
 TARGETS += resctrl
diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index c9f6cca4feb4..549f0861e897 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -37,6 +37,12 @@
 
 #define NSEC_PER_SEC 1000000000LL
 
+static char *time_base_arr[PTP_TS_MAX] = {
+	"system time",
+	"monotonic time",
+	"raw-monotonic time",
+};
+
 /* clock_adjtime is not available in GLIBC < 2.14 */
 #if !__GLIBC_PREREQ(2, 14)
 #include <sys/syscall.h>
@@ -145,8 +151,10 @@ static void usage(char *progname)
 		" -T val     set the ptp clock time to 'val' seconds\n"
 		" -x val     get an extended ptp clock time with the desired number of samples (up to %d)\n"
 		" -X         get a ptp clock cross timestamp\n"
+		" -y val     get an extended-any ptp clock time with the desired number of samples (up to %d) with given time-base for sandwich (with -Y opt)\n"
+		" -Y val     sandwich timebase to use {real|mono|raw}\n"
 		" -z         test combinations of rising/falling external time stamp flags\n",
-		progname, PTP_MAX_SAMPLES);
+		progname, PTP_MAX_SAMPLES, PTP_MAX_SAMPLES);
 }
 
 int main(int argc, char *argv[])
@@ -162,6 +170,7 @@ int main(int argc, char *argv[])
 	struct ptp_sys_offset *sysoff;
 	struct ptp_sys_offset_extended *soe;
 	struct ptp_sys_offset_precise *xts;
+	struct ptp_sys_offset_any *ats;
 
 	char *progname;
 	unsigned int i;
@@ -182,6 +191,8 @@ int main(int argc, char *argv[])
 	int pct_offset = 0;
 	int getextended = 0;
 	int getcross = 0;
+	int get_ext_any = 0;
+	int ext_any_type = -1;
 	int n_samples = 0;
 	int pin_index = -1, pin_func;
 	int pps = -1;
@@ -196,7 +207,7 @@ int main(int argc, char *argv[])
 
 	progname = strrchr(argv[0], '/');
 	progname = progname ? 1+progname : argv[0];
-	while (EOF != (c = getopt(argc, argv, "cd:e:f:ghH:i:k:lL:n:o:p:P:sSt:T:w:x:Xz"))) {
+	while (EOF != (c = getopt(argc, argv, "cd:e:f:ghH:i:k:lL:n:o:p:P:sSt:T:w:x:Xy:Y:z"))) {
 		switch (c) {
 		case 'c':
 			capabilities = 1;
@@ -273,6 +284,29 @@ int main(int argc, char *argv[])
 		case 'X':
 			getcross = 1;
 			break;
+		case 'y':
+			get_ext_any = atoi(optarg);
+			if (get_ext_any < 1 || get_ext_any > PTP_MAX_SAMPLES) {
+				fprintf(stderr,
+					"number of extended-any timestamp samples must be between 1 and %d; was asked for %d\n",
+					PTP_MAX_SAMPLES, get_ext_any);
+				return -1;
+			}
+			break;
+		case 'Y':
+			if (!strcasecmp(optarg, "real"))
+				ext_any_type = PTP_TS_REAL;
+			else if (!strcasecmp(optarg, "mono"))
+				ext_any_type = PTP_TS_MONO;
+			else if (!strcasecmp(optarg, "raw"))
+				ext_any_type = PTP_TS_RAW;
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
@@ -286,6 +320,14 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	/* For ptp_sys_offset_any both options 'y' and 'Y' must be given */
+	if (get_ext_any > 0 && ext_any_type == -1) {
+		fprintf(stderr,
+			"For extended-any TS both options -y, and -Y are required.\n");
+		usage(progname);
+		return -1;
+	}
+
 	fd = open(device, O_RDWR);
 	if (fd < 0) {
 		fprintf(stderr, "opening %s: %s\n", device, strerror(errno));
@@ -604,6 +646,36 @@ int main(int argc, char *argv[])
 		free(xts);
 	}
 
+	if (get_ext_any) {
+		ats = calloc(1, sizeof(*ats));
+		if (!ats) {
+			perror("calloc");
+			return -1;
+		}
+
+		ats->n_samples = get_ext_any;
+		ats->ts_type = ext_any_type;
+
+		if (ioctl(fd, PTP_SYS_OFFSET_ANY2, ats)) {
+			perror("PTP_SYS_OFFSET_ANY2");
+		} else {
+			printf("extended-any timestamp request returned %d samples\n",
+			       get_ext_any);
+
+			for (i = 0; i < get_ext_any; i++) {
+				printf("sample #%2d: %s before: %lld.%09u\n",
+				       i, time_base_arr[ext_any_type],
+				       ats->ts[i][0].sec, ats->ts[i][0].nsec);
+				printf("            phc time: %lld.%09u\n",
+				       ats->ts[i][1].sec, ats->ts[i][1].nsec);
+				printf("            %s after: %lld.%09u\n",
+				       time_base_arr[ext_any_type],
+				       ats->ts[i][2].sec, ats->ts[i][2].nsec);
+			}
+		}
+
+		free(ats);
+	}
 	close(fd);
 	return 0;
 }
-- 
2.42.0.582.g8ccd20d70d-goog


