Return-Path: <netdev+bounces-296960-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dtz/McXLJ2p32QIAu9opvQ
	(envelope-from <netdev+bounces-296960-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:16:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BA765DA49
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:16:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=R6+nDy4y;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296960-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296960-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D47AF306B3B0
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 08:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A743837AA79;
	Tue,  9 Jun 2026 08:08:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457703E92BD
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 08:08:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992525; cv=none; b=XL/ZBD5YM1oEYIslQDe2anzMVF0wGrJcA8s0nsUhhgHfmZKu7c2HyUVvi9Zf/IwbAEkpORd+a/dxwkwxAG+MUDRFBN50BxXI0tb96RWOqiDAXPmF4+7Ar2mduuVepHAMxDSH7gmeX9Fv6RUHdl3gERvCATfK+RNR1mFhrVk73QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992525; c=relaxed/simple;
	bh=WPC66QcQTp7RabTGeSajil2zH0XU3++znPyLRMZuVkg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CH6EU/3GztvNBDz41lXorBjlIIVXRPrCWDJ1c3wkYoPQeOCE9SZ/71xZnUn6rPr5k1vURfdXAXd+o3Zht1uVpTeKK/y+ER9+U75Nx3grVLoxyBoqkDgw7aMfQVw8EP20NwUX8vQJEFXVHIspwVCZq7bZWyZDHlq8PXRG+T1MKzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R6+nDy4y; arc=none smtp.client-ip=209.85.160.201
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-5177bddf6e0so3091561cf.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 01:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780992523; x=1781597323; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=00R/crQ5EsCO7Flm4IwJknYmSwS4m+tIarJ6AwR1OJk=;
        b=R6+nDy4ykFTp7E8gOSbT18wGcgj4kSvVkojnX+NnbkqLUVJSR7G3EFf5ODQi2DW3aM
         +i/EDSjReqVoaEgN2FnRqFWkuZTskkuF+xMf1863OYOVSL6Ub/XYwVffSPWsreO7DESY
         FCcvA0D7OfnrYVh/CxSLqGTi/Cyl93LYrjxwd3g40Y0nPpG3j1GWUb+h/3czCjB7BoTI
         BaeBkAGGncHbQPccn4xsyY7L1KdYqtY2VWVtwSHl0dSsdZyxbTGRzimt8yjDLXeFv1Z0
         WrtUHyrnMoIloQRiLk8HKJ2sBiydfB4G3A1pBdwZLYQpQXJqVF8G9MnitpF8MjHztamg
         4kjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780992523; x=1781597323;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00R/crQ5EsCO7Flm4IwJknYmSwS4m+tIarJ6AwR1OJk=;
        b=D6x+jKZmgv4rOe4F7P38nCOqCv1NuJdsm/iUklTJU3YUKQnsR+XR6l13Pe1qXnnJwm
         N90iIlWGt8Ypriompn4fjuNDb375j+rJd5TswT7l/Nk4JA4h0vAWmPqn8+ZPjF3zuyjD
         a2t+rmpf5MBypi0C1qawK7CtfEg29ECtiTtB84Fo6WSsoZcEeOj9sRp5IQ/27t8VMf84
         m3s2raSrMJIPWfX9ulj8gCZ1M6sG/PDtZZlul3ZSL8pW5cuObRP7pRzKqCJWmaLnH1y8
         rX4v6tevRw9/DknE0VK/4DgyxDSxHlf/u9+oh5T1acxsPoyCNlUVKraEILcXWLEXL+s6
         595w==
X-Forwarded-Encrypted: i=1; AFNElJ/bZcDB/E+xQY34g2t29dxToqBN+Kt+YEuiYAaEQePHc/YAVnMLgKqqmNsrt4Tki4ygks9uz5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKpB3S2JMtkbqJ9jjA00h8YnDVIa4KMwQmkP7XhRjltrM7jwUT
	A/1alxaUm6zxaCq8/cdjFoc4q6vvT7ASSryuflpp6shTufjwG9gwQoG9H3OU/PaZ7NgWm6xtyMX
	SE6VeksGHELCtlg==
X-Received: from qtbfh11.prod.google.com ([2002:a05:622a:588b:b0:517:89f0:2a75])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4807:b0:516:cd8d:c7fa with SMTP id d75a77b69052e-51798882e6emr197380501cf.39.1780992522810;
 Tue, 09 Jun 2026 01:08:42 -0700 (PDT)
Date: Tue,  9 Jun 2026 08:08:35 +0000
In-Reply-To: <20260609080839.2506801-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609080839.2506801-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609080839.2506801-2-edumazet@google.com>
Subject: [PATCH net-next 1/5] bridge: use atomic ops to read/change p->flags
 in sysfs
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,blackwall.org,vger.kernel.org,gmail.com,google.com];
	TAGGED_FROM(0.00)[bounces-296960-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:razor@blackwall.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22BA765DA49

Change net/bridge/br_sysfs_if.c to use atomic operations
to read/change bits n p->flags.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/bridge/br_sysfs_if.c | 61 ++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 1923c004f0d2b746902f5b6de1bbb72f7f824125..738544901563f570355554f49b2b80cf962f8e71 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -44,40 +44,45 @@ const struct brport_attribute brport_attr_##_name = { 	        \
 	.store	= _store,					\
 };
 
-#define BRPORT_ATTR_FLAG(_name, _mask)				\
+#define BRPORT_ATTR_FLAG(_name, _bitnr)				\
 static ssize_t show_##_name(struct net_bridge_port *p, char *buf) \
 {								\
-	return sysfs_emit(buf, "%d\n", !!(p->flags & _mask));	\
+	return sysfs_emit(buf, "%d\n", test_bit(_bitnr, &p->flags));	\
 }								\
 static int store_##_name(struct net_bridge_port *p, unsigned long v) \
 {								\
-	return store_flag(p, v, _mask);				\
+	return store_flag(p, v, _bitnr);				\
 }								\
 static BRPORT_ATTR(_name, 0644,					\
 		   show_##_name, store_##_name)
 
 static int store_flag(struct net_bridge_port *p, unsigned long v,
-		      unsigned long mask)
+		      unsigned long bitnr)
 {
+	unsigned long oflags, flags = READ_ONCE(p->flags);
 	struct netlink_ext_ack extack = {0};
-	unsigned long flags = p->flags;
 	int err;
 
+
+	oflags = flags;
 	if (v)
-		flags |= mask;
+		__set_bit(bitnr, &flags);
 	else
-		flags &= ~mask;
+		__clear_bit(bitnr, &flags);
 
-	if (flags != p->flags) {
-		err = br_switchdev_set_port_flag(p, flags, mask, &extack);
-		if (err) {
-			netdev_err(p->dev, "%s\n", extack._msg);
-			return err;
-		}
+	if (flags == oflags)
+		return 0;
 
-		p->flags = flags;
-		br_port_flags_change(p, mask);
+	err = br_switchdev_set_port_flag(p, flags, BIT(bitnr), &extack);
+	if (err) {
+		netdev_err(p->dev, "%s\n", extack._msg);
+		return err;
 	}
+	if (v)
+		set_bit(bitnr, &p->flags);
+	else
+		clear_bit(bitnr, &p->flags);
+	br_port_flags_change(p, BIT(bitnr));
 	return 0;
 }
 
@@ -247,17 +252,17 @@ static int store_backup_port(struct net_bridge_port *p, char *buf)
 }
 static BRPORT_ATTR_RAW(backup_port, 0644, show_backup_port, store_backup_port);
 
-BRPORT_ATTR_FLAG(hairpin_mode, BR_HAIRPIN_MODE);
-BRPORT_ATTR_FLAG(bpdu_guard, BR_BPDU_GUARD);
-BRPORT_ATTR_FLAG(root_block, BR_ROOT_BLOCK);
-BRPORT_ATTR_FLAG(learning, BR_LEARNING);
-BRPORT_ATTR_FLAG(unicast_flood, BR_FLOOD);
-BRPORT_ATTR_FLAG(proxyarp, BR_PROXYARP);
-BRPORT_ATTR_FLAG(proxyarp_wifi, BR_PROXYARP_WIFI);
-BRPORT_ATTR_FLAG(multicast_flood, BR_MCAST_FLOOD);
-BRPORT_ATTR_FLAG(broadcast_flood, BR_BCAST_FLOOD);
-BRPORT_ATTR_FLAG(neigh_suppress, BR_NEIGH_SUPPRESS);
-BRPORT_ATTR_FLAG(isolated, BR_ISOLATED);
+BRPORT_ATTR_FLAG(hairpin_mode, BR_HAIRPIN_MODE_BIT);
+BRPORT_ATTR_FLAG(bpdu_guard, BR_BPDU_GUARD_BIT);
+BRPORT_ATTR_FLAG(root_block, BR_ROOT_BLOCK_BIT);
+BRPORT_ATTR_FLAG(learning, BR_LEARNING_BIT);
+BRPORT_ATTR_FLAG(unicast_flood, BR_FLOOD_BIT);
+BRPORT_ATTR_FLAG(proxyarp, BR_PROXYARP_BIT);
+BRPORT_ATTR_FLAG(proxyarp_wifi, BR_PROXYARP_WIFI_BIT);
+BRPORT_ATTR_FLAG(multicast_flood, BR_MCAST_FLOOD_BIT);
+BRPORT_ATTR_FLAG(broadcast_flood, BR_BCAST_FLOOD_BIT);
+BRPORT_ATTR_FLAG(neigh_suppress, BR_NEIGH_SUPPRESS_BIT);
+BRPORT_ATTR_FLAG(isolated, BR_ISOLATED_BIT);
 
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 static ssize_t show_multicast_router(struct net_bridge_port *p, char *buf)
@@ -273,8 +278,8 @@ static int store_multicast_router(struct net_bridge_port *p,
 static BRPORT_ATTR(multicast_router, 0644, show_multicast_router,
 		   store_multicast_router);
 
-BRPORT_ATTR_FLAG(multicast_fast_leave, BR_MULTICAST_FAST_LEAVE);
-BRPORT_ATTR_FLAG(multicast_to_unicast, BR_MULTICAST_TO_UNICAST);
+BRPORT_ATTR_FLAG(multicast_fast_leave, BR_MULTICAST_FAST_LEAVE_BIT);
+BRPORT_ATTR_FLAG(multicast_to_unicast, BR_MULTICAST_TO_UNICAST_BIT);
 #endif
 
 static const struct brport_attribute *brport_attrs[] = {
-- 
2.54.0.1064.gd145956f57-goog


