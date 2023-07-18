Return-Path: <netdev+bounces-18739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2E0758750
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 23:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0E91C20E2E
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 21:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D377174FC;
	Tue, 18 Jul 2023 21:37:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F01B15AE3
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 21:37:31 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983AAC0
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 14:37:29 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-cac66969edaso4487389276.3
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 14:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689716249; x=1692308249;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RXDcD9EnNoTmK4yO3hSjUBu26G9MuswmvVZnx9i6Zlc=;
        b=JqmyLsnYMezGWu32utHrbn9BORmGQ6tuwdxXp67j0LCtaqbR/TQ4kmoZuWoCPubXmg
         BHipbea4/XKMaFV46HQMDHRTWbYfcTb4K74guV411lJBk3cXROXKkNwJifiNWSDvKesS
         5nbXVh5ZhYeUbJYg+aHaYkFz/tD34tquS6/EqfvgXtjQojO+4HszTy4/1iZVB7jFhe8s
         OhBSLA6Hr4CVF+Ga9SbfNJDrPHGapIklnCTzGgLznCgDDyxPDLJGgD0VaoFK36tTs6Vj
         51G1FywjRNPui5onyB48PQcODZfCaoW37T/vx6tAdC2XzLa+0raUSChv/2ryaDSOScAg
         +EZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689716249; x=1692308249;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXDcD9EnNoTmK4yO3hSjUBu26G9MuswmvVZnx9i6Zlc=;
        b=Kwo+RosKhoxAK2ZJnguukvJAjXV9pAjL2TIKbwyEBP1AKw2X1/lVWyhvNWy8UkjgDF
         F9svcUqXgDJbNfbh1kEYJHbvrUESO4zJMwMCwQjvqfGIP7f26OG17v6JBZ1yNJzFXW4l
         ZfTZeObvqek/qc3dbe34huboyr/b6j31OkE5cJxWd4S20123LTFmYg0H2+dJLmIEgKm8
         uouzvr5v5UjgqAsbVrS5P/jkXf625w24SSjO8ogtK1Kb2JPCwe9DFGEScfJdZWVUZEru
         VaNy6vHkExLR/yZ+pDrcnzfx5qOBleR40GC58QkJDNeJuyZ94jp5vD4FpAbgFZdRcasF
         rHmQ==
X-Gm-Message-State: ABy/qLaBfJEqA7P0t96kbcGTauEKzT96C8Fjik0imJSN87C2LMGOFqBS
	iTuepYbC1K6SnEelmNqsK/a0Ni7Acg==
X-Google-Smtp-Source: APBJJlH0H1kGPk9coODhr4XjPxCdPi4gPFuj247AgeboTs0yy8JXhjIf3fux6CL1yJ3fa2Ji9XZFs7PEaw==
X-Received: from prohr-desktop.mtv.corp.google.com ([2620:15c:211:200:9b5f:972:3ba7:396d])
 (user=prohr job=sendgmr) by 2002:a05:6902:1005:b0:cb3:c343:19e5 with SMTP id
 w5-20020a056902100500b00cb3c34319e5mr13483ybt.2.1689716248886; Tue, 18 Jul
 2023 14:37:28 -0700 (PDT)
Date: Tue, 18 Jul 2023 14:37:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.455.g037347b96a-goog
Message-ID: <20230718213709.688186-1-prohr@google.com>
Subject: [net-next] net: add sysctl accept_ra_min_rtr_lft
From: Patrick Rohr <prohr@google.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, Patrick Rohr <prohr@google.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This change adds a new sysctl accept_ra_min_rtr_lft to specify the
minimum acceptable router lifetime in an RA. If the received RA router
lifetime is less than the configured value (and not 0), the RA is
ignored.
This is useful for mobile devices, whose battery life can be impacted
by networks that configure RAs with a short lifetime. On such networks,
the device should never gain IPv6 provisioning and should attempt to
drop RAs via hardware offload, if available.

Signed-off-by: Patrick Rohr <prohr@google.com>
Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
---
 Documentation/networking/ip-sysctl.rst |  8 ++++++++
 include/linux/ipv6.h                   |  1 +
 include/uapi/linux/ipv6.h              |  1 +
 net/ipv6/addrconf.c                    | 10 ++++++++++
 net/ipv6/ndisc.c                       | 17 +++++++++++++++--
 5 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/network=
ing/ip-sysctl.rst
index 4a010a7cde7f..f4cc3946d0e3 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2287,6 +2287,14 @@ accept_ra_min_hop_limit - INTEGER
=20
 	Default: 1
=20
+accept_ra_min_rtr_lft - INTEGER
+	Minimum acceptable router lifetime in Router Advertisement.
+
+	RAs with a router lifetime less than this value shall be
+	ignored. RAs with a router lifetime of 0 are unaffected.
+
+	Default: 0
+
 accept_ra_pinfo - BOOLEAN
 	Learn Prefix Information in Router Advertisement.
=20
diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 839247a4f48e..ed3d110c2eb5 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -33,6 +33,7 @@ struct ipv6_devconf {
 	__s32		accept_ra_defrtr;
 	__u32		ra_defrtr_metric;
 	__s32		accept_ra_min_hop_limit;
+	__s32		accept_ra_min_rtr_lft;
 	__s32		accept_ra_pinfo;
 	__s32		ignore_routes_with_linkdown;
 #ifdef CONFIG_IPV6_ROUTER_PREF
diff --git a/include/uapi/linux/ipv6.h b/include/uapi/linux/ipv6.h
index ac56605fe9bc..8b6bcbf6ed4a 100644
--- a/include/uapi/linux/ipv6.h
+++ b/include/uapi/linux/ipv6.h
@@ -198,6 +198,7 @@ enum {
 	DEVCONF_IOAM6_ID_WIDE,
 	DEVCONF_NDISC_EVICT_NOCARRIER,
 	DEVCONF_ACCEPT_UNTRACKED_NA,
+	DEVCONF_ACCEPT_RA_MIN_RTR_LFT,
 	DEVCONF_MAX
 };
=20
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index e5213e598a04..19eb4b3d26ea 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -202,6 +202,7 @@ static struct ipv6_devconf ipv6_devconf __read_mostly =
=3D {
 	.ra_defrtr_metric	=3D IP6_RT_PRIO_USER,
 	.accept_ra_from_local	=3D 0,
 	.accept_ra_min_hop_limit=3D 1,
+	.accept_ra_min_rtr_lft	=3D 0,
 	.accept_ra_pinfo	=3D 1,
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	.accept_ra_rtr_pref	=3D 1,
@@ -262,6 +263,7 @@ static struct ipv6_devconf ipv6_devconf_dflt __read_mos=
tly =3D {
 	.ra_defrtr_metric	=3D IP6_RT_PRIO_USER,
 	.accept_ra_from_local	=3D 0,
 	.accept_ra_min_hop_limit=3D 1,
+	.accept_ra_min_rtr_lft	=3D 0,
 	.accept_ra_pinfo	=3D 1,
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	.accept_ra_rtr_pref	=3D 1,
@@ -5596,6 +5598,7 @@ static inline void ipv6_store_devconf(struct ipv6_dev=
conf *cnf,
 	array[DEVCONF_IOAM6_ID_WIDE] =3D cnf->ioam6_id_wide;
 	array[DEVCONF_NDISC_EVICT_NOCARRIER] =3D cnf->ndisc_evict_nocarrier;
 	array[DEVCONF_ACCEPT_UNTRACKED_NA] =3D cnf->accept_untracked_na;
+	array[DEVCONF_ACCEPT_RA_MIN_RTR_LFT] =3D cnf->accept_ra_min_rtr_lft;
 }
=20
 static inline size_t inet6_ifla6_size(void)
@@ -6789,6 +6792,13 @@ static const struct ctl_table addrconf_sysctl[] =3D =
{
 		.mode		=3D 0644,
 		.proc_handler	=3D proc_dointvec,
 	},
+	{
+		.procname	=3D "accept_ra_min_rtr_lft",
+		.data		=3D &ipv6_devconf.accept_ra_min_rtr_lft,
+		.maxlen		=3D sizeof(int),
+		.mode		=3D 0644,
+		.proc_handler	=3D proc_dointvec,
+	},
 	{
 		.procname	=3D "accept_ra_pinfo",
 		.data		=3D &ipv6_devconf.accept_ra_pinfo,
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 18634ebd20a4..6b7ee8b189c0 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1287,6 +1287,14 @@ static enum skb_drop_reason ndisc_router_discovery(s=
truct sk_buff *skb)
 		goto skip_linkparms;
 	}
=20
+	lifetime =3D ntohs(ra_msg->icmph.icmp6_rt_lifetime);
+	if (lifetime !=3D 0 && lifetime < in6_dev->cnf.accept_ra_min_rtr_lft) {
+		ND_PRINTK(2, info,
+			  "RA: router lifetime (%ds) is too short: %s\n",
+			  lifetime, skb->dev->name);
+		goto skip_linkparms;
+	}
+
 #ifdef CONFIG_IPV6_NDISC_NODETYPE
 	/* skip link-specific parameters from interior routers */
 	if (skb->ndisc_nodetype =3D=3D NDISC_NODETYPE_NODEFAULT) {
@@ -1339,8 +1347,6 @@ static enum skb_drop_reason ndisc_router_discovery(st=
ruct sk_buff *skb)
 		goto skip_defrtr;
 	}
=20
-	lifetime =3D ntohs(ra_msg->icmph.icmp6_rt_lifetime);
-
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	pref =3D ra_msg->icmph.icmp6_router_pref;
 	/* 10b is handled as if it were 00b (medium) */
@@ -1492,6 +1498,13 @@ static enum skb_drop_reason ndisc_router_discovery(s=
truct sk_buff *skb)
 		goto out;
 	}
=20
+	if (lifetime !=3D 0 && lifetime < in6_dev->cnf.accept_ra_min_rtr_lft) {
+		ND_PRINTK(2, info,
+			  "RA: router lifetime (%ds) is too short: %s\n",
+			  lifetime, skb->dev->name);
+		goto out;
+	}
+
 #ifdef CONFIG_IPV6_ROUTE_INFO
 	if (!in6_dev->cnf.accept_ra_from_local &&
 	    ipv6_chk_addr(dev_net(in6_dev->dev), &ipv6_hdr(skb)->saddr,
--=20
2.41.0.455.g037347b96a-goog


