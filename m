Return-Path: <netdev+bounces-45297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C163A7DC002
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 19:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 384D8B20F50
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 18:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E3518C17;
	Mon, 30 Oct 2023 18:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="XkcSsUGA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B6519445
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 18:42:16 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B722C9
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 11:42:14 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6c115026985so1301217b3a.1
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 11:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1698691333; x=1699296133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKVC0F5femr7EemGiBoSIqgIhj2HlDJ1XhGcjTVbt7c=;
        b=XkcSsUGA0Son9RzX+WR/lu8uPoNORQllihq44rq2PrYiPeBftYBlqvIZFLlMQgCj9q
         v6qEEyWG26s3fxr0zuIQ+QRcuam/i5YghoDAVB9iOMiBeteCHQZIeRPy/MooOLL9/VAl
         4GdzkZPYFgaRbISYCgxfenH9pn7mWF3i5J2dAexxMnECcMMoca4nMnEiRzORHXp4hAsD
         4kesOJdN4SP1V08fkNG4Sxm/Ctoj2PAu1amW40Yf9XcZe20MxIY9GQ6FEXCF6FSJ6opJ
         qjnDjjv7F31PVldK/XyTeim3C8Wx9ZEqJa4NebLQbG8SinirHx/x6fIzyoOIseApg5yA
         ShYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698691333; x=1699296133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKVC0F5femr7EemGiBoSIqgIhj2HlDJ1XhGcjTVbt7c=;
        b=c+MaXAS98L9USzpvGaOnUzZGVec3fAjeO1zimsLof/yO/O2WOtmvgw7iukaNtDbchK
         Occ+oDZKpngFZ+MiI9yQyaSx/2LwfPrwXrb8LTczSaM7JTIzPYCpsbRoyuyCJLolDuoS
         fsTXuG+FDfKcNhMHOJS6CNH2TSJnhcG3fPbg0B17x0g8CslakXO3XckTyW9q3ODEL0q1
         Fu1G3lsZKAD4UDMw4yFxKCNrfgVOq9OTaa2iRvCdNtNhGt0qQmt/X0BJsl673M8gW4Ob
         8yz2+0PPaUqbzKx/DIIrvNE8SOWVLleQR40S4MaidNOdJOGEwCrTmEEeOe/D2SJjUmM5
         hEoQ==
X-Gm-Message-State: AOJu0YwhulAi2HCXj13LkD7zKCd7aQl7Jo/jlLRRwivwEqbyJCY/GfUQ
	OGsaXuiucTvZwEVgNa3XGOv37sBEv1QniTj5yJQ4oZh5dAM=
X-Google-Smtp-Source: AGHT+IHPwKTUHjGsxqJzE/L8P2iSg7ZOE9wss0qc0bRDPtp8kzMveczORIrG2S04/EBNuj71pHvq4Q==
X-Received: by 2002:a05:6a20:4294:b0:14d:d9f8:83f8 with SMTP id o20-20020a056a20429400b0014dd9f883f8mr15003687pzj.1.1698691333258;
        Mon, 30 Oct 2023 11:42:13 -0700 (PDT)
Received: from fedora.. ([38.142.2.14])
        by smtp.gmail.com with ESMTPSA id d5-20020a056a0010c500b006bfb903599esm6206962pfu.139.2023.10.30.11.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 11:42:11 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 iproute2 4/4] tc: remove dsmark qdisc
Date: Mon, 30 Oct 2023 11:39:49 -0700
Message-ID: <20231030184100.30264-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231030184100.30264-1-stephen@networkplumber.org>
References: <20231030184100.30264-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel has removed support for dsmark qdisc in commit
bbe77c14ee61 (net/sched: Retire dsmark qdisc, 2023-02-14)

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 bash-completion/tc          |   6 +-
 man/man8/tc.8               |   4 -
 tc/Makefile                 |   1 -
 tc/q_dsmark.c               | 165 ------------------------------------
 testsuite/tests/tc/dsmark.t |  31 -------
 5 files changed, 1 insertion(+), 206 deletions(-)
 delete mode 100644 tc/q_dsmark.c
 delete mode 100755 testsuite/tests/tc/dsmark.t

diff --git a/bash-completion/tc b/bash-completion/tc
index db5558ab..9f6199c5 100644
--- a/bash-completion/tc
+++ b/bash-completion/tc
@@ -4,7 +4,7 @@
 
 QDISC_KIND=' choke codel bfifo pfifo pfifo_head_drop fq fq_codel gred hhf \
             mqprio multiq netem pfifo_fast pie fq_pie red sfb sfq tbf atm \
-            cbq drr dsmark hfsc htb prio qfq '
+            cbq drr hfsc htb prio qfq '
 FILTER_KIND=' basic bpf cgroup flow flower fw route u32 matchall '
 ACTION_KIND=' gact mirred bpf sample '
 
@@ -362,10 +362,6 @@ _tc_qdisc_options()
             _tc_once_attr 'bandwidth avpkt mpu cell ewma'
             return 0
             ;;
-        dsmark)
-            _tc_once_attr 'indices default_index set_tc_index'
-            return 0
-            ;;
         hfsc)
             _tc_once_attr 'default'
             return 0
diff --git a/man/man8/tc.8 b/man/man8/tc.8
index ae6de397..e5bef911 100644
--- a/man/man8/tc.8
+++ b/man/man8/tc.8
@@ -403,10 +403,6 @@ useful e.g. for using RED qdiscs with different settings for particular
 traffic. There is no default class \-\- if a packet cannot be classified, it is
 dropped.
 .TP
-DSMARK
-Classify packets based on TOS field, change TOS field of packets based on
-classification.
-.TP
 ETS
 The ETS qdisc is a queuing discipline that merges functionality of PRIO and DRR
 qdiscs in one scheduler. ETS makes it easy to configure a set of strict and
diff --git a/tc/Makefile b/tc/Makefile
index ab6ad2f5..b775bbe2 100644
--- a/tc/Makefile
+++ b/tc/Makefile
@@ -26,7 +26,6 @@ TCMODULES += f_bpf.o
 TCMODULES += f_flow.o
 TCMODULES += f_cgroup.o
 TCMODULES += f_flower.o
-TCMODULES += q_dsmark.o
 TCMODULES += q_gred.o
 TCMODULES += q_ingress.o
 TCMODULES += q_hfsc.o
diff --git a/tc/q_dsmark.c b/tc/q_dsmark.c
deleted file mode 100644
index 9adceba5..00000000
--- a/tc/q_dsmark.c
+++ /dev/null
@@ -1,165 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * q_dsmark.c		Differentiated Services field marking.
- *
- * Hacked 1998,1999 by Werner Almesberger, EPFL ICA
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>
-#include <string.h>
-
-#include "utils.h"
-#include "tc_util.h"
-
-
-static void explain(void)
-{
-	fprintf(stderr,"Usage: dsmark indices INDICES [ default_index DEFAULT_INDEX ] [ set_tc_index ]\n");
-}
-
-
-static int dsmark_parse_opt(struct qdisc_util *qu, int argc, char **argv,
-	struct nlmsghdr *n, const char *dev)
-{
-	struct rtattr *tail;
-	__u16 ind;
-	char *end;
-	int dflt, set_tc_index;
-
-	ind = set_tc_index = 0;
-	dflt = -1;
-	while (argc > 0) {
-		if (!strcmp(*argv, "indices")) {
-			NEXT_ARG();
-			ind = strtoul(*argv, &end, 0);
-			if (*end) {
-				explain();
-				return -1;
-			}
-		} else if (!strcmp(*argv,"default_index") || !strcmp(*argv,
-		    "default")) {
-			NEXT_ARG();
-			dflt = strtoul(*argv, &end, 0);
-			if (*end) {
-				explain();
-				return -1;
-			}
-		} else if (!strcmp(*argv,"set_tc_index")) {
-			set_tc_index = 1;
-		} else {
-			explain();
-			return -1;
-		}
-		argc--;
-		argv++;
-	}
-	if (!ind) {
-		explain();
-		return -1;
-	}
-	tail = addattr_nest(n, 1024, TCA_OPTIONS);
-	addattr_l(n, 1024, TCA_DSMARK_INDICES, &ind, sizeof(ind));
-	if (dflt != -1) {
-	    __u16 tmp = dflt;
-
-	    addattr_l(n, 1024, TCA_DSMARK_DEFAULT_INDEX, &tmp, sizeof(tmp));
-	}
-	if (set_tc_index)
-		addattr_l(n, 1024, TCA_DSMARK_SET_TC_INDEX, NULL, 0);
-	addattr_nest_end(n, tail);
-	return 0;
-}
-
-
-static void explain_class(void)
-{
-	fprintf(stderr, "Usage: ... dsmark [ mask MASK ] [ value VALUE ]\n");
-}
-
-
-static int dsmark_parse_class_opt(struct qdisc_util *qu, int argc, char **argv,
-	struct nlmsghdr *n, const char *dev)
-{
-	struct rtattr *tail;
-	__u8 tmp;
-	char *end;
-
-	tail = addattr_nest(n, 1024, TCA_OPTIONS);
-	while (argc > 0) {
-		if (!strcmp(*argv, "mask")) {
-			NEXT_ARG();
-			tmp = strtoul(*argv, &end, 0);
-			if (*end) {
-				explain_class();
-				return -1;
-			}
-			addattr_l(n, 1024, TCA_DSMARK_MASK, &tmp, 1);
-		} else if (!strcmp(*argv,"value")) {
-			NEXT_ARG();
-			tmp = strtoul(*argv, &end, 0);
-			if (*end) {
-				explain_class();
-				return -1;
-			}
-			addattr_l(n, 1024, TCA_DSMARK_VALUE, &tmp, 1);
-		} else {
-			explain_class();
-			return -1;
-		}
-		argc--;
-		argv++;
-	}
-	addattr_nest_end(n, tail);
-	return 0;
-}
-
-
-
-static int dsmark_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
-{
-	struct rtattr *tb[TCA_DSMARK_MAX+1];
-
-	if (!opt) return 0;
-	parse_rtattr(tb, TCA_DSMARK_MAX, RTA_DATA(opt), RTA_PAYLOAD(opt));
-	if (tb[TCA_DSMARK_MASK]) {
-		if (!RTA_PAYLOAD(tb[TCA_DSMARK_MASK]))
-			fprintf(stderr, "dsmark: empty mask\n");
-		else fprintf(f, "mask 0x%02x ",
-			    rta_getattr_u8(tb[TCA_DSMARK_MASK]));
-	}
-	if (tb[TCA_DSMARK_VALUE]) {
-		if (!RTA_PAYLOAD(tb[TCA_DSMARK_VALUE]))
-			fprintf(stderr, "dsmark: empty value\n");
-		else fprintf(f, "value 0x%02x ",
-			    rta_getattr_u8(tb[TCA_DSMARK_VALUE]));
-	}
-	if (tb[TCA_DSMARK_INDICES]) {
-		if (RTA_PAYLOAD(tb[TCA_DSMARK_INDICES]) < sizeof(__u16))
-			fprintf(stderr, "dsmark: indices too short\n");
-		else fprintf(f, "indices 0x%04x ",
-			    rta_getattr_u16(tb[TCA_DSMARK_INDICES]));
-	}
-	if (tb[TCA_DSMARK_DEFAULT_INDEX]) {
-		if (RTA_PAYLOAD(tb[TCA_DSMARK_DEFAULT_INDEX]) < sizeof(__u16))
-			fprintf(stderr, "dsmark: default_index too short\n");
-		else fprintf(f, "default_index 0x%04x ",
-			    rta_getattr_u16(tb[TCA_DSMARK_DEFAULT_INDEX]));
-	}
-	if (tb[TCA_DSMARK_SET_TC_INDEX]) fprintf(f, "set_tc_index ");
-	return 0;
-}
-
-
-struct qdisc_util dsmark_qdisc_util = {
-	.id		= "dsmark",
-	.parse_qopt	= dsmark_parse_opt,
-	.print_qopt	= dsmark_print_opt,
-	.parse_copt	= dsmark_parse_class_opt,
-	.print_copt	= dsmark_print_opt,
-};
diff --git a/testsuite/tests/tc/dsmark.t b/testsuite/tests/tc/dsmark.t
deleted file mode 100755
index 3f1d5ef2..00000000
--- a/testsuite/tests/tc/dsmark.t
+++ /dev/null
@@ -1,31 +0,0 @@
-#!/bin/sh
-# vim: ft=sh
-
-. lib/generic.sh
-
-ts_qdisc_available "dsmark"
-if [ $? -eq 0 ]; then
-	ts_log "dsmark: Unsupported by $TC, skipping"
-	exit 127
-fi
-
-ts_tc "dsmark" "dsmark root qdisc creation" \
-	qdisc add dev $DEV root handle 10:0 \
-	dsmark indices 64 default_index 1 set_tc_index
-
-ts_tc "dsmark" "dsmark class 1 creation" \
-	class change dev $DEV parent 10:0 classid 10:12 \
-	dsmark mask 0xff value 2
-
-ts_tc "dsmark" "dsmark class 2 creation" \
-	class change dev $DEV parent 10:0 classid 10:13 \
-	dsmark mask 0xfc value 4
-
-ts_tc "dsmark" "dsmark dump qdisc" \
-	qdisc list dev $DEV
-
-ts_tc "dsmark" "dsmark dump class" \
-	class list dev $DEV parent 10:0
-
-ts_tc "dsmark" "generic qdisc tree deletion" \
-	qdisc del dev $DEV root
-- 
2.41.0


