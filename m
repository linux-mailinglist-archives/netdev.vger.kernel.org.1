Return-Path: <netdev+bounces-21662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5D0764259
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 01:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3E1D1C21342
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E088A940;
	Wed, 26 Jul 2023 23:07:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEE81BEE4
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 23:07:36 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E49272A
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 16:07:34 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d052f58b7deso237501276.2
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 16:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690412854; x=1691017654;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W0mq6p9ERAh9KOULcmCjxmhnbV0tAeCG5WIuUCSe80A=;
        b=bbpRFMbGmr2UwTuLkznNiooTXEnrrexv5G7TFKzMaa9qalKUMNt3+vGTZ2rMMHqIQR
         kyaM55ANzFth2mO2x/SgCPoktrT4vuwRCDjqIoMTxJEeap37l9xFagDvvh5g5AvG40yC
         VspJMGVZQH4EufToNIoG5DIwzBBlVmStB8XdNrOYaLQ6f2zjN7BDK3qOf5pO+jKCEWQL
         ZGh08+lmbldQJjLDaAbhAvsX2LEBJWxWkl7LTYZTj7zTjqNZvT4QSc8DBr2sDyTnDW0L
         ocIrseYMrrlN5Pd0t+tg6dIIACwd4waNfmVi1p+0cJ/oHEdmohIHTOvB3TxpEU5dx1LG
         A2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690412854; x=1691017654;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0mq6p9ERAh9KOULcmCjxmhnbV0tAeCG5WIuUCSe80A=;
        b=AxUtZgUsWkk3FzrC/AZmwzI518B1N3c7VWEQA3ONeHueg66N7pT7QlH3F8dD/Uylqp
         dSbIsKLM1tvM8xRCJ43OvDSSUR2OtMBUAYCKliu9UFpWlgiLlWqAMRYe074SFUauM/QN
         ofSksb3GrU7AMU4VEg/4zTbnSR4SmXPnvuMp1lyby42i76vMNPnxcqTWB3XN39bMBndr
         DPgVDn1pVJmyX/3McJe7OsDjkMS63rUH9XMlVfWhA2TTm8a9CdtFrVFPErxBfNHaHFpm
         GTqCAyFGK044eZohiA+iE80VtM4D71XZKOF5+FI0xp53ZjzlgtcXPuKpOu/eIjOw42Kj
         xkXw==
X-Gm-Message-State: ABy/qLZR2bcdTzw17NAtr+a+0NvBMCLyNRLx199k6O3tFmxLSuJ2U1z+
	joH8lXa/oBSN2olVH+ndfcPiAMXicQ==
X-Google-Smtp-Source: APBJJlEBhehJXqUhoJUx/TsD/JbXc1e/+F82kZoTckUUBuckwXjEutOTR1cG+n/yBUvtkrimxU0xq9HxyQ==
X-Received: from prohr-desktop.mtv.corp.google.com ([2620:15c:211:200:5e5d:827a:19e1:949])
 (user=prohr job=sendgmr) by 2002:a25:734f:0:b0:d05:38ba:b616 with SMTP id
 o76-20020a25734f000000b00d0538bab616mr18485ybc.6.1690412854136; Wed, 26 Jul
 2023 16:07:34 -0700 (PDT)
Date: Wed, 26 Jul 2023 16:07:01 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230726230701.919212-1-prohr@google.com>
Subject: [net-next v2] net: change accept_ra_min_rtr_lft to affect all RA lifetimes
From: Patrick Rohr <prohr@google.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, Patrick Rohr <prohr@google.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

accept_ra_min_rtr_lft only considered the lifetime of the default route
and discarded entire RAs accordingly.

This change renames accept_ra_min_rtr_lft to accept_ra_min_lft, and
applies the value to individual RA sections; in particular, router
lifetime, PIO preferred lifetime, and RIO lifetime. If any of those
lifetimes are lower than the configured value, the specific RA section
is ignored.

In order for the sysctl to be useful to Android, it should really apply
to all lifetimes in the RA, since that is what determines the minimum
frequency at which RAs must be processed by the kernel. Android uses
hardware offloads to drop RAs for a fraction of the minimum of all
lifetimes present in the RA (some networks have very frequent RAs (5s)
with high lifetimes (2h)). Despite this, we have encountered networks
that set the router lifetime to 30s which results in very frequent CPU
wakeups. Instead of disabling IPv6 (and dropping IPv6 ethertype in the
WiFi firmware) entirely on such networks, it seems better to ignore the
misconfigured routers while still processing RAs from other IPv6 routers
on the same network (i.e. to support IoT applications).

The previous implementation dropped the entire RA based on router
lifetime. This turned out to be hard to expand to the other lifetimes
present in the RA in a consistent manner; dropping the entire RA based
on RIO/PIO lifetimes would essentially require parsing the whole thing
twice.

Fixes: 1671bcfd76fd ("net: add sysctl accept_ra_min_rtr_lft")
Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: David Ahern <dsahern@kernel.org>
Signed-off-by: Patrick Rohr <prohr@google.com>
---
 Documentation/networking/ip-sysctl.rst |  8 ++++----
 include/linux/ipv6.h                   |  2 +-
 include/uapi/linux/ipv6.h              |  2 +-
 net/ipv6/addrconf.c                    | 14 ++++++++-----
 net/ipv6/ndisc.c                       | 27 +++++++++++---------------
 5 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/network=
ing/ip-sysctl.rst
index 37603ad6126b..a66054d0763a 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2288,11 +2288,11 @@ accept_ra_min_hop_limit - INTEGER
=20
 	Default: 1
=20
-accept_ra_min_rtr_lft - INTEGER
-	Minimum acceptable router lifetime in Router Advertisement.
+accept_ra_min_lft - INTEGER
+	Minimum acceptable lifetime value in Router Advertisement.
=20
-	RAs with a router lifetime less than this value shall be
-	ignored. RAs with a router lifetime of 0 are unaffected.
+	RA sections with a lifetime less than this value shall be
+	ignored. Zero lifetimes stay unaffected.
=20
 	Default: 0
=20
diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 0295b47c10a3..5883551b1ee8 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -33,7 +33,7 @@ struct ipv6_devconf {
 	__s32		accept_ra_defrtr;
 	__u32		ra_defrtr_metric;
 	__s32		accept_ra_min_hop_limit;
-	__s32		accept_ra_min_rtr_lft;
+	__s32		accept_ra_min_lft;
 	__s32		accept_ra_pinfo;
 	__s32		ignore_routes_with_linkdown;
 #ifdef CONFIG_IPV6_ROUTER_PREF
diff --git a/include/uapi/linux/ipv6.h b/include/uapi/linux/ipv6.h
index 8b6bcbf6ed4a..cf592d7b630f 100644
--- a/include/uapi/linux/ipv6.h
+++ b/include/uapi/linux/ipv6.h
@@ -198,7 +198,7 @@ enum {
 	DEVCONF_IOAM6_ID_WIDE,
 	DEVCONF_NDISC_EVICT_NOCARRIER,
 	DEVCONF_ACCEPT_UNTRACKED_NA,
-	DEVCONF_ACCEPT_RA_MIN_RTR_LFT,
+	DEVCONF_ACCEPT_RA_MIN_LFT,
 	DEVCONF_MAX
 };
=20
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 19eb4b3d26ea..7f7d2b677711 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -202,7 +202,7 @@ static struct ipv6_devconf ipv6_devconf __read_mostly =
=3D {
 	.ra_defrtr_metric	=3D IP6_RT_PRIO_USER,
 	.accept_ra_from_local	=3D 0,
 	.accept_ra_min_hop_limit=3D 1,
-	.accept_ra_min_rtr_lft	=3D 0,
+	.accept_ra_min_lft	=3D 0,
 	.accept_ra_pinfo	=3D 1,
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	.accept_ra_rtr_pref	=3D 1,
@@ -263,7 +263,7 @@ static struct ipv6_devconf ipv6_devconf_dflt __read_mos=
tly =3D {
 	.ra_defrtr_metric	=3D IP6_RT_PRIO_USER,
 	.accept_ra_from_local	=3D 0,
 	.accept_ra_min_hop_limit=3D 1,
-	.accept_ra_min_rtr_lft	=3D 0,
+	.accept_ra_min_lft	=3D 0,
 	.accept_ra_pinfo	=3D 1,
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	.accept_ra_rtr_pref	=3D 1,
@@ -2727,6 +2727,10 @@ void addrconf_prefix_rcv(struct net_device *dev, u8 =
*opt, int len, bool sllao)
 		return;
 	}
=20
+	if (valid_lft !=3D 0 && valid_lft < in6_dev->cnf.accept_ra_min_lft) {
+		return;
+	}
+
 	/*
 	 *	Two things going on here:
 	 *	1) Add routes for on-link prefixes
@@ -5598,7 +5602,7 @@ static inline void ipv6_store_devconf(struct ipv6_dev=
conf *cnf,
 	array[DEVCONF_IOAM6_ID_WIDE] =3D cnf->ioam6_id_wide;
 	array[DEVCONF_NDISC_EVICT_NOCARRIER] =3D cnf->ndisc_evict_nocarrier;
 	array[DEVCONF_ACCEPT_UNTRACKED_NA] =3D cnf->accept_untracked_na;
-	array[DEVCONF_ACCEPT_RA_MIN_RTR_LFT] =3D cnf->accept_ra_min_rtr_lft;
+	array[DEVCONF_ACCEPT_RA_MIN_LFT] =3D cnf->accept_ra_min_lft;
 }
=20
 static inline size_t inet6_ifla6_size(void)
@@ -6793,8 +6797,8 @@ static const struct ctl_table addrconf_sysctl[] =3D {
 		.proc_handler	=3D proc_dointvec,
 	},
 	{
-		.procname	=3D "accept_ra_min_rtr_lft",
-		.data		=3D &ipv6_devconf.accept_ra_min_rtr_lft,
+		.procname	=3D "accept_ra_min_lft",
+		.data		=3D &ipv6_devconf.accept_ra_min_lft,
 		.maxlen		=3D sizeof(int),
 		.mode		=3D 0644,
 		.proc_handler	=3D proc_dointvec,
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 29ddad1c1a2f..eeb60888187f 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1280,8 +1280,6 @@ static enum skb_drop_reason ndisc_router_discovery(st=
ruct sk_buff *skb)
 	if (!ndisc_parse_options(skb->dev, opt, optlen, &ndopts))
 		return SKB_DROP_REASON_IPV6_NDISC_BAD_OPTIONS;
=20
-	lifetime =3D ntohs(ra_msg->icmph.icmp6_rt_lifetime);
-
 	if (!ipv6_accept_ra(in6_dev)) {
 		ND_PRINTK(2, info,
 			  "RA: %s, did not accept ra for dev: %s\n",
@@ -1289,13 +1287,6 @@ static enum skb_drop_reason ndisc_router_discovery(s=
truct sk_buff *skb)
 		goto skip_linkparms;
 	}
=20
-	if (lifetime !=3D 0 && lifetime < in6_dev->cnf.accept_ra_min_rtr_lft) {
-		ND_PRINTK(2, info,
-			  "RA: router lifetime (%ds) is too short: %s\n",
-			  lifetime, skb->dev->name);
-		goto skip_linkparms;
-	}
-
 #ifdef CONFIG_IPV6_NDISC_NODETYPE
 	/* skip link-specific parameters from interior routers */
 	if (skb->ndisc_nodetype =3D=3D NDISC_NODETYPE_NODEFAULT) {
@@ -1336,6 +1327,14 @@ static enum skb_drop_reason ndisc_router_discovery(s=
truct sk_buff *skb)
 		goto skip_defrtr;
 	}
=20
+	lifetime =3D ntohs(ra_msg->icmph.icmp6_rt_lifetime);
+	if (lifetime !=3D 0 && lifetime < in6_dev->cnf.accept_ra_min_lft) {
+		ND_PRINTK(2, info,
+			  "RA: router lifetime (%ds) is too short: %s\n",
+			  lifetime, skb->dev->name);
+		goto skip_defrtr;
+	}
+
 	/* Do not accept RA with source-addr found on local machine unless
 	 * accept_ra_from_local is set to true.
 	 */
@@ -1499,13 +1498,6 @@ static enum skb_drop_reason ndisc_router_discovery(s=
truct sk_buff *skb)
 		goto out;
 	}
=20
-	if (lifetime !=3D 0 && lifetime < in6_dev->cnf.accept_ra_min_rtr_lft) {
-		ND_PRINTK(2, info,
-			  "RA: router lifetime (%ds) is too short: %s\n",
-			  lifetime, skb->dev->name);
-		goto out;
-	}
-
 #ifdef CONFIG_IPV6_ROUTE_INFO
 	if (!in6_dev->cnf.accept_ra_from_local &&
 	    ipv6_chk_addr(dev_net(in6_dev->dev), &ipv6_hdr(skb)->saddr,
@@ -1530,6 +1522,9 @@ static enum skb_drop_reason ndisc_router_discovery(st=
ruct sk_buff *skb)
 			if (ri->prefix_len =3D=3D 0 &&
 			    !in6_dev->cnf.accept_ra_defrtr)
 				continue;
+			if (ri->lifetime !=3D 0 &&
+			    ntohl(ri->lifetime) < in6_dev->cnf.accept_ra_min_lft)
+				continue;
 			if (ri->prefix_len < in6_dev->cnf.accept_ra_rt_info_min_plen)
 				continue;
 			if (ri->prefix_len > in6_dev->cnf.accept_ra_rt_info_max_plen)
--=20
2.41.0.487.g6d72f3e995-goog


