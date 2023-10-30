Return-Path: <netdev+bounces-45296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 044D77DC001
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 19:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4D321C20B74
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 18:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDBE1945A;
	Mon, 30 Oct 2023 18:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="06F+JwtA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323A918E11
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 18:42:15 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85362D3
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 11:42:10 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso3414459b3a.1
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 11:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1698691330; x=1699296130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjRImtNY1i+2haaDVnCCKfz7/zU8Y2De+UDzLFXCOO4=;
        b=06F+JwtA3ZoDMCtqI5mJzl7TrIf2G/yUzdIoDhpK6o+FcR0WsujmBdrSlV/zKHcFnS
         riejnyPmw0zKzwfP3CSPXcyzVYTgiQB3ENIIraajdmkW35BhZgN1BQhtOk3xmMnKbpOD
         W48mSuZrZtXi+tgY3N6OVhlK4ccURaiOTqZ0bAWrhfQPvGFgDOziQJygdOs0/8qnbteV
         +6NXYySWd4Y/uAXsXDOwk2ZcMEmtftDAKkQynVXYhbEMaj31Eir98AHoC2+9CUhdlaUS
         L1G8/pD6qhQe1jtUR+tHsjQ67V72H5y2oRcEBYQkAdfiiXD4CB3WNjwnqq0zJ1QxYsBF
         4IJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698691330; x=1699296130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjRImtNY1i+2haaDVnCCKfz7/zU8Y2De+UDzLFXCOO4=;
        b=wHrmsRQ8toYLG7XE5/d+CC+2CtRqDDdmAQd6m/wP1OcR0Ticb9Mvb9WA313BygzU3f
         9v3JNsynhpL7rtn8sBKg9PZiuqhNV3Mgo8UqRYI9Z+i5Y0RuqVJjoveb4XYrQMpZViHv
         mn8Hc6R5xpwkEN2mOT9GunhBHW5rr4r2FKN7b0OZfHfFT0CNc0JoFTFQzwVKezWCCecv
         mD53ma/EdRnUjU1d+GRQ2+4ociJu89fhd9JqnbQlwlaq3FRHW7osRdNXwz8IFQ4XC7d1
         t5AhhguWHIGZRkfXTnminuzN+tTxiPqbjxXTelh0++Vscpeq3Y7GgsnPObToW4Y+lwjN
         1z8w==
X-Gm-Message-State: AOJu0YwLU1X6InRXzaIP3C8N8N5Nq2YRRXUhY3Z3kSHJOZLQcbe65sso
	mFwyz0GC8IeOCFoQ30eOV0OGV6m5qfSoyqf3w31ZQlyz7bY=
X-Google-Smtp-Source: AGHT+IFewBbS0QpeU3xKWvU5ao6QOfmuQsawH7DTqWAeYzPImGrJS3hGid9yB5e5YCpVgBND+sagmg==
X-Received: by 2002:a05:6a00:1d98:b0:68f:cbd3:5b01 with SMTP id z24-20020a056a001d9800b0068fcbd35b01mr550351pfw.13.1698691329487;
        Mon, 30 Oct 2023 11:42:09 -0700 (PDT)
Received: from fedora.. ([38.142.2.14])
        by smtp.gmail.com with ESMTPSA id d5-20020a056a0010c500b006bfb903599esm6206962pfu.139.2023.10.30.11.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 11:42:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 iproute2 2/4] tc: remove support for RSVP classifier
Date: Mon, 30 Oct 2023 11:39:47 -0700
Message-ID: <20231030184100.30264-3-stephen@networkplumber.org>
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

The RSVP classifier was removed in 6.3 kernel by upstream commit
265b4da82dbf (net/sched: Retire rsvp classifier, 2023-02-14)

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 bash-completion/tc |  13 +-
 man/man8/tc.8      |   3 -
 tc/Makefile        |   1 -
 tc/f_rsvp.c        | 417 ---------------------------------------------
 tc/tc_filter.c     |   2 +-
 5 files changed, 2 insertions(+), 434 deletions(-)
 delete mode 100644 tc/f_rsvp.c

diff --git a/bash-completion/tc b/bash-completion/tc
index 8352cc94..6af3b799 100644
--- a/bash-completion/tc
+++ b/bash-completion/tc
@@ -5,7 +5,7 @@
 QDISC_KIND=' choke codel bfifo pfifo pfifo_head_drop fq fq_codel gred hhf \
             mqprio multiq netem pfifo_fast pie fq_pie red sfb sfq tbf atm \
             cbq drr dsmark hfsc htb prio qfq '
-FILTER_KIND=' basic bpf cgroup flow flower fw route rsvp tcindex u32 matchall '
+FILTER_KIND=' basic bpf cgroup flow flower fw route tcindex u32 matchall '
 ACTION_KIND=' gact mirred bpf sample '
 
 # Takes a list of words in argument; each one of them is added to COMPREPLY if
@@ -476,17 +476,6 @@ _tc_filter_options()
             _tc_once_attr 'to classid action'
             return 0
             ;;
-        rsvp)
-            _tc_once_attr 'ipproto session sender classid action tunnelid \
-                tunnel flowlabel spi/ah spi/esp u8 u16 u32'
-            [[ ${words[${#words[@]}-3]} == tunnel ]] && \
-                    COMPREPLY+=( $( compgen -W 'skip' -- "$cur" ) )
-            [[ ${words[${#words[@]}-3]} =~ u(8|16|32) ]] && \
-                    COMPREPLY+=( $( compgen -W 'mask' -- "$cur" ) )
-            [[ ${words[${#words[@]}-3]} == mask ]] && \
-                    COMPREPLY+=( $( compgen -W 'at' -- "$cur" ) )
-            return 0
-            ;;
         tcindex)
             _tc_once_attr 'hash mask shift classid action'
             _tc_one_of_list 'pass_on fall_through'
diff --git a/man/man8/tc.8 b/man/man8/tc.8
index 8f730dda..59cc7b17 100644
--- a/man/man8/tc.8
+++ b/man/man8/tc.8
@@ -241,9 +241,6 @@ Filter packets based on routing table. See
 .BR tc-route (8)
 for details.
 .TP
-rsvp
-Match Resource Reservation Protocol (RSVP) packets.
-.TP
 tcindex
 Filter packets based on traffic control index. See
 .BR tc-tcindex (8).
diff --git a/tc/Makefile b/tc/Makefile
index 95ba3b5d..82e61125 100644
--- a/tc/Makefile
+++ b/tc/Makefile
@@ -18,7 +18,6 @@ TCMODULES += q_multiq.o
 TCMODULES += q_netem.o
 TCMODULES += q_choke.o
 TCMODULES += q_sfb.o
-TCMODULES += f_rsvp.o
 TCMODULES += f_u32.o
 TCMODULES += f_route.o
 TCMODULES += f_fw.o
diff --git a/tc/f_rsvp.c b/tc/f_rsvp.c
deleted file mode 100644
index 84187d62..00000000
--- a/tc/f_rsvp.c
+++ /dev/null
@@ -1,417 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * q_rsvp.c		RSVP filter.
- *
- * Authors:	Alexey Kuznetsov, <kuznet@ms2.inr.ac.ru>
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
-#include "rt_names.h"
-#include "utils.h"
-#include "tc_util.h"
-
-static void explain(void)
-{
-	fprintf(stderr,
-		"Usage:	... rsvp ipproto PROTOCOL session DST[/PORT | GPI ]\n"
-		"		[ sender SRC[/PORT | GPI ] ]\n"
-		"		[ classid CLASSID ] [ action ACTION_SPEC ]\n"
-		"		[ tunnelid ID ] [ tunnel ID skip NUMBER ]\n"
-		"Where:	GPI := { flowlabel NUMBER | spi/ah SPI | spi/esp SPI |\n"
-		"		u{8|16|32} NUMBER mask MASK at OFFSET}\n"
-		"	ACTION_SPEC := ... look at individual actions\n"
-		"	FILTERID := X:Y\n"
-		"\nNOTE: CLASSID is parsed as hexadecimal input.\n");
-}
-
-static int get_addr_and_pi(int *argc_p, char ***argv_p, inet_prefix *addr,
-		    struct tc_rsvp_pinfo *pinfo, int dir, int family)
-{
-	int argc = *argc_p;
-	char **argv = *argv_p;
-	char *p = strchr(*argv, '/');
-	struct tc_rsvp_gpi *pi = dir ? &pinfo->dpi : &pinfo->spi;
-
-	if (p) {
-		__u16 tmp;
-
-		if (get_u16(&tmp, p+1, 0))
-			return -1;
-
-		if (dir == 0) {
-			/* Source port: u16 at offset 0 */
-			pi->key = htonl(((__u32)tmp)<<16);
-			pi->mask = htonl(0xFFFF0000);
-		} else {
-			/* Destination port: u16 at offset 2 */
-			pi->key = htonl(((__u32)tmp));
-			pi->mask = htonl(0x0000FFFF);
-		}
-		pi->offset = 0;
-		*p = 0;
-	}
-	if (get_addr_1(addr, *argv, family))
-		return -1;
-	if (p)
-		*p = '/';
-
-	argc--; argv++;
-
-	if (pi->mask || argc <= 0)
-		goto done;
-
-	if (strcmp(*argv, "spi/ah") == 0 ||
-	    strcmp(*argv, "gpi/ah") == 0) {
-		__u32 gpi;
-
-		NEXT_ARG();
-		if (get_u32(&gpi, *argv, 0))
-			return -1;
-		pi->mask = htonl(0xFFFFFFFF);
-		pi->key = htonl(gpi);
-		pi->offset = 4;
-		if (pinfo->protocol == 0)
-			pinfo->protocol = IPPROTO_AH;
-		argc--; argv++;
-	} else if (strcmp(*argv, "spi/esp") == 0 ||
-		   strcmp(*argv, "gpi/esp") == 0) {
-		__u32 gpi;
-
-		NEXT_ARG();
-		if (get_u32(&gpi, *argv, 0))
-			return -1;
-		pi->mask = htonl(0xFFFFFFFF);
-		pi->key = htonl(gpi);
-		pi->offset = 0;
-		if (pinfo->protocol == 0)
-			pinfo->protocol = IPPROTO_ESP;
-		argc--; argv++;
-	} else if (strcmp(*argv, "flowlabel") == 0) {
-		__u32 flabel;
-
-		NEXT_ARG();
-		if (get_u32(&flabel, *argv, 0))
-			return -1;
-		if (family != AF_INET6)
-			return -1;
-		pi->mask = htonl(0x000FFFFF);
-		pi->key = htonl(flabel) & pi->mask;
-		pi->offset = -40;
-		argc--; argv++;
-	} else if (strcmp(*argv, "u32") == 0 ||
-		   strcmp(*argv, "u16") == 0 ||
-		   strcmp(*argv, "u8") == 0) {
-		int sz = 1;
-		__u32 tmp;
-		__u32 mask = 0xff;
-
-		if (strcmp(*argv, "u32") == 0) {
-			sz = 4;
-			mask = 0xffff;
-		} else if (strcmp(*argv, "u16") == 0) {
-			mask = 0xffffffff;
-			sz = 2;
-		}
-		NEXT_ARG();
-		if (get_u32(&tmp, *argv, 0))
-			return -1;
-		argc--; argv++;
-		if (strcmp(*argv, "mask") == 0) {
-			NEXT_ARG();
-			if (get_u32(&mask, *argv, 16))
-				return -1;
-			argc--; argv++;
-		}
-		if (strcmp(*argv, "at") == 0) {
-			NEXT_ARG();
-			if (get_integer(&pi->offset, *argv, 0))
-				return -1;
-			argc--; argv++;
-		}
-		if (sz == 1) {
-			if ((pi->offset & 3) == 0) {
-				mask <<= 24;
-				tmp <<= 24;
-			} else if ((pi->offset & 3) == 1) {
-				mask <<= 16;
-				tmp <<= 16;
-			} else if ((pi->offset & 3) == 3) {
-				mask <<= 8;
-				tmp <<= 8;
-			}
-		} else if (sz == 2) {
-			if ((pi->offset & 3) == 0) {
-				mask <<= 16;
-				tmp <<= 16;
-			}
-		}
-		pi->offset &= ~3;
-		pi->mask = htonl(mask);
-		pi->key = htonl(tmp) & pi->mask;
-	}
-
-done:
-	*argc_p = argc;
-	*argv_p = argv;
-	return 0;
-}
-
-
-static int rsvp_parse_opt(struct filter_util *qu, char *handle, int argc,
-			  char **argv, struct nlmsghdr *n)
-{
-	int family = strcmp(qu->id, "rsvp") == 0 ? AF_INET : AF_INET6;
-	struct tc_rsvp_pinfo pinfo = {};
-	struct tcmsg *t = NLMSG_DATA(n);
-	int pinfo_ok = 0;
-	struct rtattr *tail;
-
-	if (handle) {
-		if (get_u32(&t->tcm_handle, handle, 0)) {
-			fprintf(stderr, "Illegal \"handle\"\n");
-			return -1;
-		}
-	}
-
-	if (argc == 0)
-		return 0;
-
-	tail = addattr_nest(n, 4096, TCA_OPTIONS);
-
-	while (argc > 0) {
-		if (matches(*argv, "session") == 0) {
-			inet_prefix addr;
-
-			NEXT_ARG();
-			if (get_addr_and_pi(&argc, &argv, &addr, &pinfo, 1, family)) {
-				fprintf(stderr, "Illegal \"session\"\n");
-				return -1;
-			}
-			addattr_l(n, 4096, TCA_RSVP_DST, &addr.data, addr.bytelen);
-			if (pinfo.dpi.mask || pinfo.protocol)
-				pinfo_ok++;
-			continue;
-		} else if (matches(*argv, "sender") == 0 ||
-			   matches(*argv, "flowspec") == 0) {
-			inet_prefix addr;
-
-			NEXT_ARG();
-			if (get_addr_and_pi(&argc, &argv, &addr, &pinfo, 0, family)) {
-				fprintf(stderr, "Illegal \"sender\"\n");
-				return -1;
-			}
-			addattr_l(n, 4096, TCA_RSVP_SRC, &addr.data, addr.bytelen);
-			if (pinfo.spi.mask || pinfo.protocol)
-				pinfo_ok++;
-			continue;
-		} else if (matches("ipproto", *argv) == 0) {
-			int num;
-
-			NEXT_ARG();
-			num = inet_proto_a2n(*argv);
-			if (num < 0) {
-				fprintf(stderr, "Illegal \"ipproto\"\n");
-				return -1;
-			}
-			pinfo.protocol = num;
-			pinfo_ok++;
-		} else if (matches(*argv, "classid") == 0 ||
-			   strcmp(*argv, "flowid") == 0) {
-			unsigned int classid;
-
-			NEXT_ARG();
-			if (get_tc_classid(&classid, *argv)) {
-				fprintf(stderr, "Illegal \"classid\"\n");
-				return -1;
-			}
-			addattr_l(n, 4096, TCA_RSVP_CLASSID, &classid, 4);
-		} else if (strcmp(*argv, "tunnelid") == 0) {
-			unsigned int tid;
-
-			NEXT_ARG();
-			if (get_unsigned(&tid, *argv, 0)) {
-				fprintf(stderr, "Illegal \"tunnelid\"\n");
-				return -1;
-			}
-			pinfo.tunnelid = tid;
-			pinfo_ok++;
-		} else if (strcmp(*argv, "tunnel") == 0) {
-			unsigned int tid;
-
-			NEXT_ARG();
-			if (get_unsigned(&tid, *argv, 0)) {
-				fprintf(stderr, "Illegal \"tunnel\"\n");
-				return -1;
-			}
-			addattr_l(n, 4096, TCA_RSVP_CLASSID, &tid, 4);
-			NEXT_ARG();
-			if (strcmp(*argv, "skip") == 0) {
-				NEXT_ARG();
-			}
-			if (get_unsigned(&tid, *argv, 0)) {
-				fprintf(stderr, "Illegal \"skip\"\n");
-				return -1;
-			}
-			pinfo.tunnelhdr = tid;
-			pinfo_ok++;
-		} else if (matches(*argv, "action") == 0) {
-			NEXT_ARG();
-			if (parse_action(&argc, &argv, TCA_RSVP_ACT, n)) {
-				fprintf(stderr, "Illegal \"action\"\n");
-				return -1;
-			}
-			continue;
-		} else if (matches(*argv, "police") == 0) {
-			NEXT_ARG();
-			if (parse_police(&argc, &argv, TCA_RSVP_POLICE, n)) {
-				fprintf(stderr, "Illegal \"police\"\n");
-				return -1;
-			}
-			continue;
-		} else if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
-		} else {
-			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
-			return -1;
-		}
-		argc--; argv++;
-	}
-
-	if (pinfo_ok)
-		addattr_l(n, 4096, TCA_RSVP_PINFO, &pinfo, sizeof(pinfo));
-	addattr_nest_end(n, tail);
-	return 0;
-}
-
-static char *sprint_spi(struct tc_rsvp_gpi *pi, int dir, char *buf)
-{
-	if (pi->offset == 0) {
-		if (dir && pi->mask == htonl(0xFFFF)) {
-			snprintf(buf, SPRINT_BSIZE-1, "/%d", htonl(pi->key));
-			return buf;
-		}
-		if (!dir && pi->mask == htonl(0xFFFF0000)) {
-			snprintf(buf, SPRINT_BSIZE-1, "/%d", htonl(pi->key)>>16);
-			return buf;
-		}
-		if (pi->mask == htonl(0xFFFFFFFF)) {
-			snprintf(buf, SPRINT_BSIZE-1, " spi/esp 0x%08x", htonl(pi->key));
-			return buf;
-		}
-	} else if (pi->offset == 4 && pi->mask == htonl(0xFFFFFFFF)) {
-		snprintf(buf, SPRINT_BSIZE-1, " spi/ah 0x%08x", htonl(pi->key));
-		return buf;
-	} else if (pi->offset == -40 && pi->mask == htonl(0x000FFFFF)) {
-		snprintf(buf, SPRINT_BSIZE-1, " flowlabel 0x%05x", htonl(pi->key));
-		return buf;
-	}
-	snprintf(buf, SPRINT_BSIZE-1, " u32 0x%08x mask %08x at %d",
-		 htonl(pi->key), htonl(pi->mask), pi->offset);
-	return buf;
-}
-
-static int rsvp_print_opt(struct filter_util *qu, FILE *f, struct rtattr *opt, __u32 handle)
-{
-	int family = strcmp(qu->id, "rsvp") == 0 ? AF_INET : AF_INET6;
-	struct rtattr *tb[TCA_RSVP_MAX+1];
-	struct tc_rsvp_pinfo *pinfo = NULL;
-
-	if (opt == NULL)
-		return 0;
-
-	parse_rtattr_nested(tb, TCA_RSVP_MAX, opt);
-
-	if (handle)
-		fprintf(f, "fh 0x%08x ", handle);
-
-	if (tb[TCA_RSVP_PINFO]) {
-		if (RTA_PAYLOAD(tb[TCA_RSVP_PINFO])  < sizeof(*pinfo))
-			return -1;
-
-		pinfo = RTA_DATA(tb[TCA_RSVP_PINFO]);
-	}
-
-	if (tb[TCA_RSVP_CLASSID]) {
-		SPRINT_BUF(b1);
-		if (!pinfo || pinfo->tunnelhdr == 0)
-			fprintf(f, "flowid %s ", sprint_tc_classid(rta_getattr_u32(tb[TCA_RSVP_CLASSID]), b1));
-		else
-			fprintf(f, "tunnel %d skip %d ", rta_getattr_u32(tb[TCA_RSVP_CLASSID]), pinfo->tunnelhdr);
-	} else if (pinfo && pinfo->tunnelhdr)
-		fprintf(f, "tunnel [BAD] skip %d ", pinfo->tunnelhdr);
-
-	if (tb[TCA_RSVP_DST]) {
-		char buf[128];
-
-		fprintf(f, "session ");
-		if (inet_ntop(family, RTA_DATA(tb[TCA_RSVP_DST]), buf, sizeof(buf)) == 0)
-			fprintf(f, " [INVALID DADDR] ");
-		else
-			fprintf(f, "%s", buf);
-		if (pinfo && pinfo->dpi.mask) {
-			SPRINT_BUF(b2);
-			fprintf(f, "%s ", sprint_spi(&pinfo->dpi, 1, b2));
-		} else
-			fprintf(f, " ");
-	} else {
-		if (pinfo && pinfo->dpi.mask) {
-			SPRINT_BUF(b2);
-			fprintf(f, "session [NONE]%s ", sprint_spi(&pinfo->dpi, 1, b2));
-		} else
-			fprintf(f, "session NONE ");
-	}
-
-	if (pinfo && pinfo->protocol) {
-		SPRINT_BUF(b1);
-		fprintf(f, "ipproto %s ", inet_proto_n2a(pinfo->protocol, b1, sizeof(b1)));
-	}
-	if (pinfo && pinfo->tunnelid)
-		fprintf(f, "tunnelid %d ", pinfo->tunnelid);
-	if (tb[TCA_RSVP_SRC]) {
-		char buf[128];
-
-		fprintf(f, "sender ");
-		if (inet_ntop(family, RTA_DATA(tb[TCA_RSVP_SRC]), buf, sizeof(buf)) == 0) {
-			fprintf(f, "[BAD]");
-		} else {
-			fprintf(f, " %s", buf);
-		}
-		if (pinfo && pinfo->spi.mask) {
-			SPRINT_BUF(b2);
-			fprintf(f, "%s ", sprint_spi(&pinfo->spi, 0, b2));
-		} else
-			fprintf(f, " ");
-	} else if (pinfo && pinfo->spi.mask) {
-		SPRINT_BUF(b2);
-		fprintf(f, "sender [NONE]%s ", sprint_spi(&pinfo->spi, 0, b2));
-	}
-
-	if (tb[TCA_RSVP_ACT]) {
-		tc_print_action(f, tb[TCA_RSVP_ACT], 0);
-	}
-	if (tb[TCA_RSVP_POLICE])
-		tc_print_police(f, tb[TCA_RSVP_POLICE]);
-	return 0;
-}
-
-struct filter_util rsvp_filter_util = {
-	.id = "rsvp",
-	.parse_fopt = rsvp_parse_opt,
-	.print_fopt = rsvp_print_opt,
-};
-
-struct filter_util rsvp6_filter_util = {
-	.id = "rsvp6",
-	.parse_fopt = rsvp_parse_opt,
-	.print_fopt = rsvp_print_opt,
-};
diff --git a/tc/tc_filter.c b/tc/tc_filter.c
index d28b1859..eb45c588 100644
--- a/tc/tc_filter.c
+++ b/tc/tc_filter.c
@@ -35,7 +35,7 @@ static void usage(void)
 		"       tc filter show [ dev STRING ] [ root | ingress | egress | parent CLASSID ]\n"
 		"       tc filter show [ block BLOCK_INDEX ]\n"
 		"Where:\n"
-		"FILTER_TYPE := { rsvp | u32 | bpf | fw | route | etc. }\n"
+		"FILTER_TYPE := { u32 | bpf | fw | route | etc. }\n"
 		"FILTERID := ... format depends on classifier, see there\n"
 		"OPTIONS := ... try tc filter add <desired FILTER_KIND> help\n");
 }
-- 
2.41.0


