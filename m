Return-Path: <netdev+bounces-34361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0151F7A36BE
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 19:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811CD281DB6
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 17:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58775568A;
	Sun, 17 Sep 2023 17:09:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ED623BD
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 17:09:00 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE7C135
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 10:08:36 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bf55a81eeaso26503885ad.0
        for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 10:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1694970516; x=1695575316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3jo/vszTOCnc89dktIXU8bmK8aj6GpdMK1Q+j/KsmWk=;
        b=GCb67owodn/ZYgby3waFO+L2zdQu2uqIB9piwHGKH3tocwlTh6OAFrnC2odFAv7zBD
         OXPFNh6kJyyDH7oniHo5XlEl2Z/iXGNeYkkiI/PwnssWBk7mj2MnLQ6DtgJ+Tec29VJv
         N0hFbQlMSqQG3cgTzMxv8Romlv+Ec84URD/rcLvo0UOb6FELPBtpVPHDGtI0vy4Ay5aU
         PcrARp3j5nmGjRWEG9p82OSXggpidwShLm26P49eEXH+ZpdU2eo5UI7BMIdgUx0iFeVL
         UT3xbgpBtzSjswPCob65zSg5k1mtZMg97Y3FxAOnHwBGhQh4WarEDrNyTj5x26ka8MEj
         L5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694970516; x=1695575316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3jo/vszTOCnc89dktIXU8bmK8aj6GpdMK1Q+j/KsmWk=;
        b=Tx9KuEdCEnfBTrON9ASShFfXmqivQkIOcApB8HVIkNaRReDN9MUg9pYTdo9Pd4kO8b
         sEW/FCxRfNpu69IMAKyOGxDi8P2nzlQ1FcC+3vBPLLVaQKFYSZZ6qKzC9mWzrQIDDci1
         tLRL0Lpn17O7p5D7djNLMD/BHNhIVDUYNdCH6ooQr4AwIH9ZGE44626+evZ41cOjA5Md
         etc+AOu/8SGy5bIQ36Tfxsx2cH+pfKq+zr4KhEULDW5/s9FumNp8g883DqOl024s1fsr
         o5v0HYZ7LwTGvdetQOnjPC9qpzbYnis5fiFkDKU5Nmw+vVuyLpc3W1O2Vi/0JWP0YGHd
         RXKw==
X-Gm-Message-State: AOJu0YymUINqbJNKEo/uV14x7Ro8/BGRKGI+U+rszrqhxsK+SeZ4zpi9
	ynStbwbOSHw4KV81yJLRrV8zLp10DKZYfEgM5SE=
X-Google-Smtp-Source: AGHT+IE8+OWRrv/4cYW1gXmIFPL/j58vnVg6EkINrFCnyi3Jx2B+9fXZr0mFQHoVEJ5JhPoZcK/2pg==
X-Received: by 2002:a17:902:d904:b0:1c4:6613:82a3 with SMTP id c4-20020a170902d90400b001c4661382a3mr2033904plz.16.1694970515650;
        Sun, 17 Sep 2023 10:08:35 -0700 (PDT)
Received: from hermes.local (204-195-112-131.wavecable.com. [204.195.112.131])
        by smtp.gmail.com with ESMTPSA id e1-20020a17090301c100b001b8953365aesm6862418plh.22.2023.09.17.10.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 10:08:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] fix set-not-used warnings
Date: Sun, 17 Sep 2023 10:08:25 -0700
Message-Id: <20230917170825.26165-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Building with clang and warnings enabled finds several
places where variable was set but not used.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 bridge/vni.c  | 3 +--
 ip/iptuntap.c | 3 ---
 tc/m_pedit.c  | 3 +--
 tc/q_tbf.c    | 8 --------
 4 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/bridge/vni.c b/bridge/vni.c
index 5978e55c79fd..e804cb3f40c3 100644
--- a/bridge/vni.c
+++ b/bridge/vni.c
@@ -49,13 +49,12 @@ static int parse_vni_filter(const char *argv, struct nlmsghdr *n, int reqsize,
 	int group_type = AF_UNSPEC;
 	struct rtattr *nlvlist_e;
 	char *v;
-	int i;
 
 	if (group && is_addrtype_inet(group))
 		group_type = (group->family == AF_INET) ?  VXLAN_VNIFILTER_ENTRY_GROUP :
 						     VXLAN_VNIFILTER_ENTRY_GROUP6;
 
-	for (i = 0; vni; i++) {
+	while (vni != NULL) {
 		__u32 vni_start = 0, vni_end = 0;
 
 		v = strchr(vni, '-');
diff --git a/ip/iptuntap.c b/ip/iptuntap.c
index 552599e9fa5c..dbb07580f68e 100644
--- a/ip/iptuntap.c
+++ b/ip/iptuntap.c
@@ -107,8 +107,6 @@ static int tap_del_ioctl(struct ifreq *ifr)
 static int parse_args(int argc, char **argv,
 		      struct ifreq *ifr, uid_t *uid, gid_t *gid)
 {
-	int count = 0;
-
 	memset(ifr, 0, sizeof(*ifr));
 
 	ifr->ifr_flags |= IFF_NO_PI;
@@ -187,7 +185,6 @@ static int parse_args(int argc, char **argv,
 			if (get_ifname(ifr->ifr_name, *argv))
 				invarg("\"name\" not a valid ifname", *argv);
 		}
-		count++;
 		argc--; argv++;
 	}
 
diff --git a/tc/m_pedit.c b/tc/m_pedit.c
index afdd020b92bc..32f03415d61c 100644
--- a/tc/m_pedit.c
+++ b/tc/m_pedit.c
@@ -627,7 +627,7 @@ static int parse_pedit(struct action_util *a, int *argc_p, char ***argv_p,
 
 	int argc = *argc_p;
 	char **argv = *argv_p;
-	int ok = 0, iok = 0;
+	int ok = 0;
 	struct rtattr *tail;
 
 	while (argc > 0) {
@@ -689,7 +689,6 @@ static int parse_pedit(struct action_util *a, int *argc_p, char ***argv_p,
 			}
 			argc--;
 			argv++;
-			iok++;
 		}
 	}
 
diff --git a/tc/q_tbf.c b/tc/q_tbf.c
index caea6bebd871..f621756d96e6 100644
--- a/tc/q_tbf.c
+++ b/tc/q_tbf.c
@@ -34,7 +34,6 @@ static void explain1(const char *arg, const char *val)
 static int tbf_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 			 struct nlmsghdr *n, const char *dev)
 {
-	int ok = 0;
 	struct tc_tbf_qopt opt = {};
 	__u32 rtab[256];
 	__u32 ptab[256];
@@ -60,7 +59,6 @@ static int tbf_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 				explain1("limit", *argv);
 				return -1;
 			}
-			ok++;
 		} else if (matches(*argv, "latency") == 0) {
 			NEXT_ARG();
 			if (latency) {
@@ -75,7 +73,6 @@ static int tbf_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 				explain1("latency", *argv);
 				return -1;
 			}
-			ok++;
 		} else if (matches(*argv, "burst") == 0 ||
 			strcmp(*argv, "buffer") == 0 ||
 			strcmp(*argv, "maxburst") == 0) {
@@ -90,7 +87,6 @@ static int tbf_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 				explain1(parm_name, *argv);
 				return -1;
 			}
-			ok++;
 		} else if (strcmp(*argv, "mtu") == 0 ||
 			   strcmp(*argv, "minburst") == 0) {
 			const char *parm_name = *argv;
@@ -104,7 +100,6 @@ static int tbf_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 				explain1(parm_name, *argv);
 				return -1;
 			}
-			ok++;
 		} else if (strcmp(*argv, "mpu") == 0) {
 			NEXT_ARG();
 			if (mpu) {
@@ -115,7 +110,6 @@ static int tbf_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 				explain1("mpu", *argv);
 				return -1;
 			}
-			ok++;
 		} else if (strcmp(*argv, "rate") == 0) {
 			NEXT_ARG();
 			if (rate64) {
@@ -131,7 +125,6 @@ static int tbf_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 				explain1("rate", *argv);
 				return -1;
 			}
-			ok++;
 		} else if (matches(*argv, "peakrate") == 0) {
 			NEXT_ARG();
 			if (prate64) {
@@ -147,7 +140,6 @@ static int tbf_parse_opt(struct qdisc_util *qu, int argc, char **argv,
 				explain1("peakrate", *argv);
 				return -1;
 			}
-			ok++;
 		} else if (matches(*argv, "overhead") == 0) {
 			NEXT_ARG();
 			if (overhead) {
-- 
2.39.2


