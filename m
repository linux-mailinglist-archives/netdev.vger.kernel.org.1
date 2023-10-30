Return-Path: <netdev+bounces-45295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62397DC000
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 19:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04B1281615
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 18:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48067182CA;
	Mon, 30 Oct 2023 18:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="eC/3p7GM"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AF518C01
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 18:42:14 +0000 (UTC)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D22B7
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 11:42:11 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5b856d73a12so3776326a12.1
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 11:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1698691331; x=1699296131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HY4O8Ksj0e99T2CWyVjhlp44ZNflyZdjrDp0uAXuIc=;
        b=eC/3p7GM2MrzCYWrXzT3+ncwQYyQ5I1OgmaVTGl7/cdbmfVPIzkNLbKdLvXfharJ4C
         5d7gK/bJ9ViuKvurIFszHMzWeWXDkkPtRTozp40eOI0AfvNSfTbJtYunoPJrP9OterEi
         CaDlwaM9zdFu5R3/FyWug4v8V75sMheF0LUjL4BSbYBB/ehxfsqwAgWRTPHcXEfwzwig
         LnGUa9/WweT3p78YFUnKi+MAxMw7lA/04JH5ABL5ORE4DC9M+BYnevnJbNBHgAIQKoA8
         FDJjAvDWJeotDxIwvmjqtf8Z30rM3qjp6qymRiIeQWqgjxlhd/5Ak4x3Ssm6YpD5OPqj
         ObOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698691331; x=1699296131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HY4O8Ksj0e99T2CWyVjhlp44ZNflyZdjrDp0uAXuIc=;
        b=Wb9i3Ho7PAhXj8+/p8oPiuncl/QknM7NE0eGgqEWnFH147W+5BNZvntdoC/LC11MLN
         uMiJWFCiGGVZRSO2OEFxqr+7wXXrfEdQcWBvLP+GGnZpQlg/O4uAqdtAD1CYkRltE3ii
         op++9rqDEC9L7+ONveNyMUrwwSywcb9juoTIwyLC5sCs+r3Y8wBCGNB1YSkBjM7UcZKv
         fC7XwwbVRQBfiAGPad1pTcGTMYUeL2f8bpDAueqP63xVXeASKS5/krKrEKtC9TDpIRW1
         yuOOV4iVmh6hMyHfUD66m31kBqRPrqV1Quf/z7P2qp14dLLiWaifuu96f2EN81QSBQfi
         cA3g==
X-Gm-Message-State: AOJu0YxKbbyKlqLdocPY8ZvXCqwVgumT/A8iek5IhLxIzt26K4RkM6jx
	LkW7oGk098+upoAzXsKRcgHyZUl9phXH5MYRetFOXUcvsok=
X-Google-Smtp-Source: AGHT+IFWAFZ1wamIEglb1/XYNYwU3mihfXhY61APOW1nI9eoKNwjYZwjIsFcZFk4AwKxS0c0eWIT6A==
X-Received: by 2002:a05:6a20:7f92:b0:157:64e4:4260 with SMTP id d18-20020a056a207f9200b0015764e44260mr17203714pzj.9.1698691330836;
        Mon, 30 Oct 2023 11:42:10 -0700 (PDT)
Received: from fedora.. ([38.142.2.14])
        by smtp.gmail.com with ESMTPSA id d5-20020a056a0010c500b006bfb903599esm6206962pfu.139.2023.10.30.11.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 11:42:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 iproute2 3/4] tc: remove tcindex classifier
Date: Mon, 30 Oct 2023 11:39:48 -0700
Message-ID: <20231030184100.30264-4-stephen@networkplumber.org>
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

Support for tcindex classifier was removed by upstream commit
8c710f75256b (net/sched: Retire tcindex classifier, 2023-02-14)

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 bash-completion/tc    |   7 +-
 man/man8/tc-tcindex.8 |  58 -------------
 man/man8/tc.8         |   7 +-
 tc/Makefile           |   1 -
 tc/f_tcindex.c        | 185 ------------------------------------------
 5 files changed, 2 insertions(+), 256 deletions(-)
 delete mode 100644 man/man8/tc-tcindex.8
 delete mode 100644 tc/f_tcindex.c

diff --git a/bash-completion/tc b/bash-completion/tc
index 6af3b799..db5558ab 100644
--- a/bash-completion/tc
+++ b/bash-completion/tc
@@ -5,7 +5,7 @@
 QDISC_KIND=' choke codel bfifo pfifo pfifo_head_drop fq fq_codel gred hhf \
             mqprio multiq netem pfifo_fast pie fq_pie red sfb sfq tbf atm \
             cbq drr dsmark hfsc htb prio qfq '
-FILTER_KIND=' basic bpf cgroup flow flower fw route tcindex u32 matchall '
+FILTER_KIND=' basic bpf cgroup flow flower fw route u32 matchall '
 ACTION_KIND=' gact mirred bpf sample '
 
 # Takes a list of words in argument; each one of them is added to COMPREPLY if
@@ -476,11 +476,6 @@ _tc_filter_options()
             _tc_once_attr 'to classid action'
             return 0
             ;;
-        tcindex)
-            _tc_once_attr 'hash mask shift classid action'
-            _tc_one_of_list 'pass_on fall_through'
-            return 0
-            ;;
         u32)
             _tc_once_attr 'match link classid action offset ht hashkey sample'
             COMPREPLY+=( $( compgen -W 'ip ip6 udp tcp icmp u8 u16 u32 mark \
diff --git a/man/man8/tc-tcindex.8 b/man/man8/tc-tcindex.8
deleted file mode 100644
index ccf2c5e8..00000000
--- a/man/man8/tc-tcindex.8
+++ /dev/null
@@ -1,58 +0,0 @@
-.TH "Traffic control index filter" 8 "21 Oct 2015" "iproute2" "Linux"
-
-.SH NAME
-tcindex \- traffic control index filter
-.SH SYNOPSIS
-.in +8
-.ti -8
-.BR tc " " filter " ... " tcindex " [ " hash
-.IR SIZE " ] [ "
-.B mask
-.IR MASK " ] [ "
-.B shift
-.IR SHIFT " ] [ "
-.BR pass_on " | " fall_through " ] [ " classid
-.IR CLASSID " ] [ "
-.B action
-.BR ACTION_SPEC " ]"
-.SH DESCRIPTION
-This filter allows one to match packets based on their
-.B tcindex
-field value, i.e. the combination of the DSCP and ECN fields as present in IPv4
-and IPv6 headers.
-.SH OPTIONS
-.TP
-.BI action " ACTION_SPEC"
-Apply an action from the generic actions framework on matching packets.
-.TP
-.BI classid " CLASSID"
-Push matching packets into the class identified by
-.IR CLASSID .
-.TP
-.BI hash " SIZE"
-Hash table size in entries to use. Defaults to 64.
-.TP
-.BI mask " MASK"
-An optional bitmask to binary
-.BR AND " to the packet's " tcindex
-field before use.
-.TP
-.BI shift " SHIFT"
-The number of bits to right-shift a packet's
-.B tcindex
-value before use. If a
-.B mask
-has been set, masking is done before shifting.
-.TP
-.B pass_on
-If this flag is set, failure to find a class for the resulting ID will make the
-filter fail and lead to the next filter being consulted.
-.TP
-.B fall_through
-This is the opposite of
-.B pass_on
-and the default. The filter will classify the packet even if there is no class
-present for the resulting class ID.
-
-.SH SEE ALSO
-.BR tc (8)
diff --git a/man/man8/tc.8 b/man/man8/tc.8
index 59cc7b17..ae6de397 100644
--- a/man/man8/tc.8
+++ b/man/man8/tc.8
@@ -241,10 +241,6 @@ Filter packets based on routing table. See
 .BR tc-route (8)
 for details.
 .TP
-tcindex
-Filter packets based on traffic control index. See
-.BR tc-tcindex (8).
-.TP
 u32
 Generic filtering on arbitrary packet data, assisted by syntax to abstract common operations. See
 .BR tc-u32 (8)
@@ -892,8 +888,7 @@ was written by Alexey N. Kuznetsov and added in Linux 2.2.
 .BR tc-sfq (8),
 .BR tc-stab (8),
 .BR tc-tbf (8),
-.BR tc-tcindex (8),
-.BR tc-u32 (8),
+.BR tc-u32 (8)
 .br
 .RB "User documentation at " http://lartc.org/ ", but please direct bugreports and patches to: " <netdev@vger.kernel.org>
 
diff --git a/tc/Makefile b/tc/Makefile
index 82e61125..ab6ad2f5 100644
--- a/tc/Makefile
+++ b/tc/Makefile
@@ -28,7 +28,6 @@ TCMODULES += f_cgroup.o
 TCMODULES += f_flower.o
 TCMODULES += q_dsmark.o
 TCMODULES += q_gred.o
-TCMODULES += f_tcindex.o
 TCMODULES += q_ingress.o
 TCMODULES += q_hfsc.o
 TCMODULES += q_htb.o
diff --git a/tc/f_tcindex.c b/tc/f_tcindex.c
deleted file mode 100644
index ae4cbf11..00000000
--- a/tc/f_tcindex.c
+++ /dev/null
@@ -1,185 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * f_tcindex.c		Traffic control index filter
- *
- * Written 1998,1999 by Werner Almesberger
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
-#include <netinet/in.h>
-
-#include "utils.h"
-#include "tc_util.h"
-
-static void explain(void)
-{
-	fprintf(stderr,
-		" Usage: ... tcindex	[ hash SIZE ] [ mask MASK ] [ shift SHIFT ]\n"
-		"			[ pass_on | fall_through ]\n"
-		"			[ classid CLASSID ] [ action ACTION_SPEC ]\n");
-}
-
-static int tcindex_parse_opt(struct filter_util *qu, char *handle, int argc,
-			     char **argv, struct nlmsghdr *n)
-{
-	struct tcmsg *t = NLMSG_DATA(n);
-	struct rtattr *tail;
-	char *end;
-
-	if (handle) {
-		t->tcm_handle = strtoul(handle, &end, 0);
-		if (*end) {
-			fprintf(stderr, "Illegal filter ID\n");
-			return -1;
-		}
-	}
-	if (!argc) return 0;
-	tail = addattr_nest(n, 4096, TCA_OPTIONS);
-	while (argc) {
-		if (!strcmp(*argv, "hash")) {
-			int hash;
-
-			NEXT_ARG();
-			hash = strtoul(*argv, &end, 0);
-			if (*end || !hash || hash > 0x10000) {
-				explain();
-				return -1;
-			}
-			addattr_l(n, 4096, TCA_TCINDEX_HASH, &hash,
-				  sizeof(hash));
-		} else if (!strcmp(*argv,"mask")) {
-			__u16 mask;
-
-			NEXT_ARG();
-			mask = strtoul(*argv, &end, 0);
-			if (*end) {
-				explain();
-				return -1;
-			}
-			addattr_l(n, 4096, TCA_TCINDEX_MASK, &mask,
-				  sizeof(mask));
-		} else if (!strcmp(*argv,"shift")) {
-			int shift;
-
-			NEXT_ARG();
-			shift = strtoul(*argv, &end, 0);
-			if (*end) {
-				explain();
-				return -1;
-			}
-			addattr_l(n, 4096, TCA_TCINDEX_SHIFT, &shift,
-			    sizeof(shift));
-		} else if (!strcmp(*argv,"fall_through")) {
-			int value = 1;
-
-			addattr_l(n, 4096, TCA_TCINDEX_FALL_THROUGH, &value,
-			    sizeof(value));
-		} else if (!strcmp(*argv,"pass_on")) {
-			int value = 0;
-
-			addattr_l(n, 4096, TCA_TCINDEX_FALL_THROUGH, &value,
-			    sizeof(value));
-		} else if (!strcmp(*argv,"classid")) {
-			__u32 handle;
-
-			NEXT_ARG();
-			if (get_tc_classid(&handle, *argv)) {
-				fprintf(stderr, "Illegal \"classid\"\n");
-				return -1;
-			}
-			addattr_l(n, 4096, TCA_TCINDEX_CLASSID, &handle, 4);
-		} else if (!strcmp(*argv,"police")) {
-			NEXT_ARG();
-			if (parse_police(&argc, &argv, TCA_TCINDEX_POLICE, n)) {
-				fprintf(stderr, "Illegal \"police\"\n");
-				return -1;
-			}
-			continue;
-		} else if (!strcmp(*argv,"action")) {
-			NEXT_ARG();
-			if (parse_action(&argc, &argv, TCA_TCINDEX_ACT, n)) {
-				fprintf(stderr, "Illegal \"action\"\n");
-				return -1;
-			}
-			continue;
-		} else {
-			explain();
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
-static int tcindex_print_opt(struct filter_util *qu, FILE *f,
-			     struct rtattr *opt, __u32 handle)
-{
-	struct rtattr *tb[TCA_TCINDEX_MAX+1];
-
-	if (opt == NULL)
-		return 0;
-
-	parse_rtattr_nested(tb, TCA_TCINDEX_MAX, opt);
-
-	if (handle != ~0) fprintf(f, "handle 0x%04x ", handle);
-	if (tb[TCA_TCINDEX_HASH]) {
-		__u16 hash;
-
-		if (RTA_PAYLOAD(tb[TCA_TCINDEX_HASH]) < sizeof(hash))
-			return -1;
-		hash = rta_getattr_u16(tb[TCA_TCINDEX_HASH]);
-		fprintf(f, "hash %d ", hash);
-	}
-	if (tb[TCA_TCINDEX_MASK]) {
-		__u16 mask;
-
-		if (RTA_PAYLOAD(tb[TCA_TCINDEX_MASK]) < sizeof(mask))
-			return -1;
-		mask = rta_getattr_u16(tb[TCA_TCINDEX_MASK]);
-		fprintf(f, "mask 0x%04x ", mask);
-	}
-	if (tb[TCA_TCINDEX_SHIFT]) {
-		int shift;
-
-		if (RTA_PAYLOAD(tb[TCA_TCINDEX_SHIFT]) < sizeof(shift))
-			return -1;
-		shift = rta_getattr_u32(tb[TCA_TCINDEX_SHIFT]);
-		fprintf(f, "shift %d ", shift);
-	}
-	if (tb[TCA_TCINDEX_FALL_THROUGH]) {
-		int fall_through;
-
-		if (RTA_PAYLOAD(tb[TCA_TCINDEX_FALL_THROUGH]) <
-		    sizeof(fall_through))
-			return -1;
-		fall_through = rta_getattr_u32(tb[TCA_TCINDEX_FALL_THROUGH]);
-		fprintf(f, fall_through ? "fall_through " : "pass_on ");
-	}
-	if (tb[TCA_TCINDEX_CLASSID]) {
-		SPRINT_BUF(b1);
-		fprintf(f, "classid %s ", sprint_tc_classid(*(__u32 *)
-		    RTA_DATA(tb[TCA_TCINDEX_CLASSID]), b1));
-	}
-	if (tb[TCA_TCINDEX_POLICE]) {
-		fprintf(f, "\n");
-		tc_print_police(f, tb[TCA_TCINDEX_POLICE]);
-	}
-	if (tb[TCA_TCINDEX_ACT]) {
-		fprintf(f, "\n");
-		tc_print_action(f, tb[TCA_TCINDEX_ACT], 0);
-	}
-	return 0;
-}
-
-struct filter_util tcindex_filter_util = {
-	.id = "tcindex",
-	.parse_fopt = tcindex_parse_opt,
-	.print_fopt = tcindex_print_opt,
-};
-- 
2.41.0


