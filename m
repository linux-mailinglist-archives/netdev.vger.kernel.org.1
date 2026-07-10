Return-Path: <netdev+bounces-306546-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p2SHNDblUGpI8AIAu9opvQ
	(envelope-from <netdev+bounces-306546-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 14:27:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1DA73AC55
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 14:27:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=YYdPqYkY;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306546-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306546-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A410E30BB281
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 12:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ACC425CEA;
	Fri, 10 Jul 2026 12:18:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE14408014
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 12:18:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783685908; cv=none; b=AJC/N0Rofmu/hr+vZhyADCeDnZWtysyhOSfVouiN854eeQuwqgBrZ6J/r4pbrhuULg3P2N7hLkB0aj5rapJ7x4YR2e2F3jCj7xyFm0kxJCiuyYlRomrF951vxpcbNj8S1OrQeiwQaLDjul95sJtNgzypiqolDU6Wq/cB+XNqr2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783685908; c=relaxed/simple;
	bh=q78CB9M2uMtXfGkbaZE+cV09Z6uxDXn/AiBP991kCj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YMK40gfxM/b+kbKrDYy3C0MJFILiFjNN8YHs1wMrXXWvVzcfXvFtmbHrd7Egd2gEJgAZrduLdeaNNui3SlKqYkxTjMceOQFYvjti6FTOs6tdKxkjM/sGl6NQkBD3+TFHi+EngYwa65joIIh5LH2IYd2iHPqNZxdm3/DQ+9HP5gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYdPqYkY; arc=none smtp.client-ip=209.85.210.177
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84864b41122so458819b3a.2
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 05:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783685905; x=1784290705; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sUmzz+IQE+MMA0FlJ+5hgJKBETJyrM7WGFLJU9wv8RI=;
        b=YYdPqYkY2BZH0gORLOIedJZWg3p6R5u8vNfGZ+JQIr7FfoIRMc56J0FCQ9rt34Df0G
         c2WwG53/10j1sHB2ghCUTkdqvAnxb5YpGfaMJ8nPgrtsF5penEwaac+rLB3QbhwxGmQZ
         OrNpt4iUU6/fu2ipxrIzHeXxdAjAV+/Tmo+eg3w/tyJ06FepQPmlq6G6efYz1yZXrl3X
         Cl667xAyX7UaO5QrSLzSTD+oORHiNUQ1Zy8bLtXkp7E3pW+5fyjpV+6+xmg8y3AYUHoZ
         V8GMgaBOTxFBcJG6yDsharIIa+Clvh3tV1U3j82iTRLzdAI7nVK0GO+MBcR4U4voX6kc
         DyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783685905; x=1784290705;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sUmzz+IQE+MMA0FlJ+5hgJKBETJyrM7WGFLJU9wv8RI=;
        b=ExrKUn6Tfj2E7L5BLXfg250pP8FksCjPrmzJrM2oQZIQ0v7XqufE2wo3XaZV9UpZUf
         IlGMs/HLvzJoH6CPnpUl7OK4M2WPPU+1VGBAVPyVkZHPXVHHyr1Bgty7LzP43sw4zQtd
         2dvL1ArNVyFpt6S5wwBVEsaMnyURlTxRjaVMdU5s+366vcc0IOR1NG7QktH0OtbKqjtc
         YPA+dG2pDbR9NQg/NBDaK3bqyKDTu/Fy995RFuaAPH8kz2L4czi78/WMqXFK+JHq/3Xk
         CPsNfSjJPhclost+y6XMfg2jVOXRXZyrFgyootyrH0JY0RqoncJ4yUvcuqPKkAgGn/5P
         HVHA==
X-Forwarded-Encrypted: i=1; AHgh+Rrbs5wxNiJhGNxTx9SeNB1rw7ROio7j6IQqDnHF2N2KiPFCvSjNLYNB34Of5h0HNXzS27lh+pM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3cEo5hQbecEWvfSaDudQEyG45Df4+dc5z1GgpP/Ed1+2H2a9G
	Z4lewIrQDrGj5rDudC7XYuPEv9OeR0TpHMenRbdrCSm5eXrt/0ezpQy6
X-Gm-Gg: AfdE7ckxTblx7J7B+dY3TIfEMhLhTay5FGm5xeX+6MQpR/W8l6ScUG3J4HxkFpKjgox
	SLn/Qr09tRoEPT3UGwiTvUqReKmnLNkgn8KnZz8lru74n7ujbXAS/DJk1bsqqQju3nWHooUJUPm
	aXXhP57yADOcHj3atfdPSu6UKkABkPoOizG6B64tGrbl3caEHPvGL/FYxvoceFQ9F4lg/yS4X+Z
	ou+iaD63VrqVkdiK6tqxv7MhXiv1EBTURqB2cW8VyqsbbiWYNX1glTQzzLJhxGqkZ/GePAZhASz
	GY49wmsJtjex+RxbX/8IkXe1Whckff1v1en5oM9EsxVnrdlpucpo04uzYdNtQCJHYujF2Xuu+J1
	Xl8mWpNM4qnQ7klGAnNvOuy8Za1/3AtZNxmRnEm0KGTeDkVom8vNfjIs0CRMR/uI6dBJ/iydpKU
	LiNZsaUMjPvVzR/y5txfjyBZE1VD5q/Dborg==
X-Received: by 2002:a05:6a00:4292:b0:847:99a7:c751 with SMTP id d2e1a72fcca58-84842ee30eamr11324293b3a.25.1783685904654;
        Fri, 10 Jul 2026 05:18:24 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8480da8bab0sm8600845b3a.8.2026.07.10.05.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 05:18:23 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Fri, 10 Jul 2026 21:18:19 +0900
Subject: [PATCH RFC iproute2-next 2/2] seg6: add support for the End.MAP
 behavior under seg6mobile encap
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-seg6-mobile-end-map-v1-2-970275f3d80b@gmail.com>
References: <20260710-seg6-mobile-end-map-v1-0-970275f3d80b@gmail.com>
In-Reply-To: <20260710-seg6-mobile-end-map-v1-0-970275f3d80b@gmail.com>
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 Andrea Mayer <andrea@common-net.org>, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9628;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=q78CB9M2uMtXfGkbaZE+cV09Z6uxDXn/AiBP991kCj8=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBqUOMKr/cpssKQMLL438c7lrUneeOdSB0Gtp0g8
 FBvQKYnEoSJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCalDjCgAKCRAq19F1Kl0b
 TUk4D/4vSYpyFX3B6OiCxbpl0cvjwaKzefUFHwCpXgfyrj+m3Z8GLkN9SU4XoC2IvzD+l4vd/bs
 lGRKW8vmLBWIFN29keJZNxXMH5vTnv9j6A4uQ1MVcRQ1b4kNhTV/X3lx4XX/Jv1MV0qs6RcAEV+
 Nl8lmTROb56M7n8ww7bJAkkZrJsvpE84xSFwydaXfa+cpALACY4TUIxZ71/Cj1WEaPf2L36itwy
 SueCIusMSmzThq0GPUr5VVvjf0JcRb9Ag7TcgsZPgK4OPJg7ifKiXNg+HA38/2tVoapEZT2iilM
 zLCLg/oU+/kDHa6Q884MkiEyHP+kOYqxA8KyuMfS9SD4S56u4J4zAtSIQfCQmyELXqkKIs7bTCW
 F1TvqqbnyBver+/SllkMhBM9JAoSnCul0yHig7ym5kJWJFVuGqYdiY0x3JCNDS9jaR71PDakWSL
 hXl3ghRQ7IV34VC4lybxuNB6VlI9RJXS+/BkC+cL4WuVV3p6JvrQghuQ8pz5pZHNn1MHExSOhhz
 zrz0Sm8tfONgC0921Mks4aCjIWYnuPmh/95PSLbsne6NIPk6FhF0977mjV+CnjDiRNGoNsoptWX
 RRcrZjQXGSv7YxrfZONmUxl8PHadxJwOXROdwOCDcPLrLqEm0EdFl/uhBW88xc12r4aQQ3ZulYR
 n/fGsCTB+HASxSQ==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306546-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:andrea.mayer@uniroma2.it,m:andrea@common-net.org,m:yuya.kusakabe@gmail.com,m:yuyakusakabe@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[uniroma2.it,common-net.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,l2encap.red:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A1DA73AC55

Wire up a new "seg6mobile" lightweight tunnel encap type that mirrors
the kernel's LWTUNNEL_ENCAP_SEG6_MOBILE namespace, and add parse and
print support for the first RFC 9433 behavior it carries: End.MAP.

    $ ip -6 route add 2001:db8:f::/64 \
        encap seg6mobile action End.MAP nh6 2001:db8:2::e dev eth0

    $ ip -6 route show 2001:db8:f::/64
    2001:db8:f::/64  encap seg6mobile action End.MAP nh6 2001:db8:2::e dev eth0 metric 1024 pref medium

Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 ip/iproute.c           |   6 +-
 ip/iproute_lwtunnel.c  | 173 +++++++++++++++++++++++++++++++++++++++++++++++++
 man/man8/ip-route.8.in |  24 +++++++
 3 files changed, 201 insertions(+), 2 deletions(-)

diff --git a/ip/iproute.c b/ip/iproute.c
index 5b9e7ac1134a..659ebfa1b113 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -98,8 +98,8 @@ static void usage(void)
 		"TIME := NUMBER[s|ms]\n"
 		"BOOL := [1|0]\n"
 		"FEATURES := ecn\n"
-		"ENCAPTYPE := [ mpls | ip | ip6 | seg6 | seg6local | rpl | ioam6 | xfrm ]\n"
-		"ENCAPHDR := [ MPLSLABEL | SEG6HDR | SEG6LOCAL | IOAM6HDR | XFRMINFO ]\n"
+		"ENCAPTYPE := [ mpls | ip | ip6 | seg6 | seg6local | seg6mobile | rpl | ioam6 | xfrm ]\n"
+		"ENCAPHDR := [ MPLSLABEL | SEG6HDR | SEG6LOCAL | SEG6MOBILE | IOAM6HDR | XFRMINFO ]\n"
 		"SEG6HDR := [ mode SEGMODE ] segs ADDR1,ADDRi,ADDRn [hmac HMACKEYID] [cleanup]\n"
 		"SEGMODE := [ encap | encap.red | inline | l2encap | l2encap.red ]\n"
 		"SEG6LOCAL := action ACTION [ OPTIONS ] [ count ]\n"
@@ -111,6 +111,8 @@ static void usage(void)
 		"            table TABLEID | vrftable TABLEID | endpoint PROGNAME }\n"
 		"FLAVORS := { FLAVOR[,FLAVOR] }\n"
 		"FLAVOR := { psp | usp | usd | next-csid }\n"
+		"SEG6MOBILE := action MOBILE_ACTION nh6 ADDR [ count ]\n"
+		"MOBILE_ACTION := { End.MAP }\n"
 		"IOAM6HDR := trace prealloc type IOAM6_TRACE_TYPE ns IOAM6_NAMESPACE size IOAM6_TRACE_SIZE\n"
 		"XFRMINFO := if_id IF_ID [ link_dev LINK ]\n"
 		"ROUTE_GET_FLAGS := ROUTE_GET_FLAG [ ROUTE_GET_FLAGS ]\n"
diff --git a/ip/iproute_lwtunnel.c b/ip/iproute_lwtunnel.c
index 00b4f7565be6..53df6e2d7610 100644
--- a/ip/iproute_lwtunnel.c
+++ b/ip/iproute_lwtunnel.c
@@ -28,6 +28,7 @@
 #include <linux/rpl_iptunnel.h>
 #include <linux/seg6_hmac.h>
 #include <linux/seg6_local.h>
+#include <linux/seg6_mobile.h>
 #include <linux/if_tunnel.h>
 #include <linux/ioam6.h>
 #include <linux/ioam6_iptunnel.h>
@@ -55,6 +56,8 @@ static const char *format_encap_type(uint16_t type)
 		return "ioam6";
 	case LWTUNNEL_ENCAP_XFRM:
 		return "xfrm";
+	case LWTUNNEL_ENCAP_SEG6_MOBILE:
+		return "seg6mobile";
 	default:
 		return "unknown";
 	}
@@ -95,6 +98,8 @@ static uint16_t read_encap_type(const char *name)
 		return LWTUNNEL_ENCAP_IOAM6;
 	else if (strcmp(name, "xfrm") == 0)
 		return LWTUNNEL_ENCAP_XFRM;
+	else if (strcmp(name, "seg6mobile") == 0)
+		return LWTUNNEL_ENCAP_SEG6_MOBILE;
 	else if (strcmp(name, "help") == 0)
 		encap_type_usage();
 
@@ -578,6 +583,91 @@ static void print_encap_seg6local(FILE *fp, struct rtattr *encap)
 		print_seg6_local_flavors(fp, tb[SEG6_LOCAL_FLAVORS]);
 }
 
+static const char *seg6_mobile_action_names[SEG6_MOBILE_ACTION_MAX + 1] = {
+	[SEG6_MOBILE_ACTION_END_MAP]	= "End.MAP",
+};
+
+static const char *format_seg6_mobile_action(int action)
+{
+	if (action < 0 || action > SEG6_MOBILE_ACTION_MAX)
+		return "<invalid>";
+
+	return seg6_mobile_action_names[action] ?: "<unknown>";
+}
+
+static int read_seg6_mobile_action(const char *name)
+{
+	int i;
+
+	for (i = 0; i < SEG6_MOBILE_ACTION_MAX + 1; i++) {
+		if (!seg6_mobile_action_names[i])
+			continue;
+
+		if (strcmp(seg6_mobile_action_names[i], name) == 0)
+			return i;
+	}
+
+	return SEG6_MOBILE_ACTION_UNSPEC;
+}
+
+static void print_seg6_mobile_counters(FILE *fp, struct rtattr *encap)
+{
+	struct rtattr *tb[SEG6_MOBILE_CNT_MAX + 1];
+	__u64 packets = 0, bytes = 0, errors = 0;
+
+	parse_rtattr_nested(tb, SEG6_MOBILE_CNT_MAX, encap);
+
+	if (tb[SEG6_MOBILE_CNT_PACKETS])
+		packets = rta_getattr_u64(tb[SEG6_MOBILE_CNT_PACKETS]);
+
+	if (tb[SEG6_MOBILE_CNT_BYTES])
+		bytes = rta_getattr_u64(tb[SEG6_MOBILE_CNT_BYTES]);
+
+	if (tb[SEG6_MOBILE_CNT_ERRORS])
+		errors = rta_getattr_u64(tb[SEG6_MOBILE_CNT_ERRORS]);
+
+	if (is_json_context()) {
+		open_json_object("stats64");
+
+		print_u64(PRINT_JSON, "packets", NULL, packets);
+		print_u64(PRINT_JSON, "bytes", NULL, bytes);
+		print_u64(PRINT_JSON, "errors", NULL, errors);
+
+		close_json_object();
+	} else {
+		print_string(PRINT_FP, NULL, "%s ", "packets");
+		print_num(fp, 1, packets);
+
+		print_string(PRINT_FP, NULL, "%s ", "bytes");
+		print_num(fp, 1, bytes);
+
+		print_string(PRINT_FP, NULL, "%s ", "errors");
+		print_num(fp, 1, errors);
+	}
+}
+
+static void print_encap_seg6mobile(FILE *fp, struct rtattr *encap)
+{
+	struct rtattr *tb[SEG6_MOBILE_MAX + 1];
+	int action;
+
+	parse_rtattr_nested(tb, SEG6_MOBILE_MAX, encap);
+
+	if (!tb[SEG6_MOBILE_ACTION])
+		return;
+
+	action = rta_getattr_u32(tb[SEG6_MOBILE_ACTION]);
+	print_string(PRINT_ANY, "action",
+		     "action %s ", format_seg6_mobile_action(action));
+
+	if (tb[SEG6_MOBILE_NH6])
+		print_string(PRINT_ANY, "nh6", "nh6 %s ",
+			     rt_addr_n2a_rta(AF_INET6, tb[SEG6_MOBILE_NH6]));
+
+	if (tb[SEG6_MOBILE_COUNTERS] && show_stats)
+		print_seg6_mobile_counters(fp, tb[SEG6_MOBILE_COUNTERS]);
+}
+
 static void print_encap_mpls(FILE *fp, struct rtattr *encap)
 {
 	struct rtattr *tb[MPLS_IPTUNNEL_MAX+1];
@@ -893,6 +983,9 @@ void lwt_print_encap(FILE *fp, struct rtattr *encap_type,
 	case LWTUNNEL_ENCAP_XFRM:
 		print_encap_xfrm(fp, encap);
 		break;
+	case LWTUNNEL_ENCAP_SEG6_MOBILE:
+		print_encap_seg6mobile(fp, encap);
+		break;
 	}
 	close_json_object();
 }
@@ -1587,6 +1680,83 @@ static int parse_encap_seg6local(struct rtattr *rta, size_t len, int *argcp,
 	return ret;
 }
 
+/* counters are always initialized to zero by the kernel, so no value
+ * is parsed from the command line -- "count" is a bare keyword.
+ */
+static int seg6mobile_fill_counters(struct rtattr *rta, size_t len, int attr)
+{
+	struct rtattr *nest;
+	int ret;
+
+	nest = rta_nest(rta, len, attr);
+
+	ret = rta_addattr64(rta, len, SEG6_MOBILE_CNT_PACKETS, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = rta_addattr64(rta, len, SEG6_MOBILE_CNT_BYTES, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = rta_addattr64(rta, len, SEG6_MOBILE_CNT_ERRORS, 0);
+	if (ret < 0)
+		return ret;
+
+	rta_nest_end(rta, nest);
+	return 0;
+}
+
+static int parse_encap_seg6mobile(struct rtattr *rta, size_t len, int *argcp,
+				  char ***argvp)
+{
+	int action_ok = 0, nh6_ok = 0, counters_ok = 0;
+	char **argv = *argvp;
+	int argc = *argcp;
+	inet_prefix addr;
+	__u32 action = 0;
+	int ret = 0;
+
+	while (argc > 0) {
+		if (strcmp(*argv, "action") == 0) {
+			NEXT_ARG();
+			if (action_ok++)
+				duparg2("action", *argv);
+			action = read_seg6_mobile_action(*argv);
+			if (!action)
+				invarg("\"action\" value is invalid\n", *argv);
+			ret = rta_addattr32(rta, len, SEG6_MOBILE_ACTION,
+					    action);
+		} else if (strcmp(*argv, "nh6") == 0) {
+			NEXT_ARG();
+			if (nh6_ok++)
+				duparg2("nh6", *argv);
+			get_addr(&addr, *argv, AF_INET6);
+			ret = rta_addattr_l(rta, len, SEG6_MOBILE_NH6,
+					    &addr.data, addr.bytelen);
+		} else if (strcmp(*argv, "count") == 0) {
+			if (counters_ok++)
+				duparg2("count", *argv);
+			ret = seg6mobile_fill_counters(rta, len,
+						       SEG6_MOBILE_COUNTERS);
+		} else {
+			break;
+		}
+		if (ret)
+			return ret;
+		argc--; argv++;
+	}
+
+	if (!action) {
+		fprintf(stderr, "Missing action type\n");
+		exit(-1);
+	}
+
+	*argcp = argc + 1;
+	*argvp = argv - 1;
+
+	return ret;
+}
+
 static int parse_encap_mpls(struct rtattr *rta, size_t len,
 			    int *argcp, char ***argvp)
 {
@@ -2326,6 +2496,9 @@ int lwt_parse_encap(struct rtattr *rta, size_t len, int *argcp, char ***argvp,
 	case LWTUNNEL_ENCAP_XFRM:
 		ret = parse_encap_xfrm(rta, len, &argc, &argv);
 		break;
+	case LWTUNNEL_ENCAP_SEG6_MOBILE:
+		ret = parse_encap_seg6mobile(rta, len, &argc, &argv);
+		break;
 	default:
 		fprintf(stderr, "Error: unsupported encap type\n");
 		break;
diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index 9f29fd436f59..396a1dae9118 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -762,6 +762,9 @@ is a string specifying the supported encapsulation type. Namely:
 .BI seg6local
 - local SRv6 segment processing
 .sp
+.BI seg6mobile
+- SRv6 Mobile User Plane processing (RFC 9433)
+.sp
 .BI ioam6
 - encapsulation type IPv6 IOAM
 .sp
@@ -1083,6 +1086,27 @@ flavors. The Locator-Node Function length must be greater than 0 and evenly
 divisible by 8. This attribute can be used only with NEXT-C-SID flavor.
 .in -4
 
+.B seg6mobile
+.in +2
+.IR SEG6_MOBILE_ACTION " [ "
+.IR SEG6_MOBILE_PARAM " ]"
+- SRv6 Mobile User Plane operation (RFC 9433) to perform on matching
+packets. Currently only the End.MAP behavior is supported.
+.in +2
+
+.B End.MAP nh6
+.I ADDRESS
+- Replace the IPv6 destination address with the configured SID
+.RI ( ADDRESS )
+and forward via the IPv6 FIB without consuming the SRH.
+.in -2
+
+.B count
+- Enable per-CPU packet, byte and error counters for this route.
+The aggregated values are printed by
+.RI \(dq ip "\ -s\ route\ show\(dq."
+.in -2
+
 .B ioam6
 .in +2
 .B freq K/N

-- 
2.50.1


