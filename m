Return-Path: <netdev+bounces-19086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF517598D4
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 16:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A741C21089
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 14:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4468514A86;
	Wed, 19 Jul 2023 14:52:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3481C1FC1
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:52:40 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8270311B
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 07:52:37 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-573d70da2dcso62740437b3.1
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 07:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689778356; x=1692370356;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PD5uLOzuBRwmNYz+9zKd/DXkxqRGkM3kYlzsyTkhZ1M=;
        b=a0qY5A69q4Tt2/GrlveRkQrVLaE/UVN52SwposTP2vSmJidHRXB/8DurzB88YcQLLv
         9CGgSvG08WdkrpKVXl7u/vEBXzhWCKz1CmvKMK+E5iGR7qJKtW27LZsCIWX69UKRpnER
         CdLvMNLo2D4vrI3IxbUUoYCha7yqgxQXOZ83Bips5rQBg8KqOiMmvgCHLM6aOzKJzDXL
         kTrug9x2r1LLVlqrdiUkVf5O8NnB1sEyt7IeIEOlIbWYmSTZB1UEjh6D0NybsjOBKb9w
         LUa+6CfGDhwBzSCaSmNDtipBFbYDDHwtDv0OaWvwEThW1bLcI5KZZ83CsmLjbumCJvDY
         oJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689778356; x=1692370356;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PD5uLOzuBRwmNYz+9zKd/DXkxqRGkM3kYlzsyTkhZ1M=;
        b=D6WAW3yH//MVXmrLMcSRmdmqG87hJBmCQANUVlMH7f+WrqKlkyY4Q6Ht/Yk5L3hiN3
         9CBGgtWeXY+B7x4rkSpwbp0mN8hPX5dyAlg1EjET5K6vAWF6wo83hABR8BUIMg9f0f52
         ZtM8KzpjIlODICd7IAapuTd5ApbaqqjqSMNgOn0VEtGEyzQ2DVsbooxLHZVruOYiJAZP
         S7wk9pImpx2IcJgk6o93KM5lNhBdvYMse10mFz0/utnDUBj65lQd68VG85MDl9XNQGS3
         jxkDkrgQujBu7/3mkWr02HydeLNBSv4T8NQHMhN1ONYAgK4aDnGSDbV66FjMVkkk0LlI
         hb6w==
X-Gm-Message-State: ABy/qLbMCOCO3VcuqRfpWSkH/soqANT3DOoPFBxNpxioABjiDPWr5mrq
	rz997jOJIVqbNGAdiJyzWJdOD3wZdw==
X-Google-Smtp-Source: APBJJlEk2gG2hnZ3RAdjGUa7OVmY6wBqL4KCOtumZEBpCfVZuofUI0t/VQUVYSyw/i19aty0KTSYMea6tg==
X-Received: from prohr-desktop.mtv.corp.google.com ([2620:15c:211:200:9b5f:972:3ba7:396d])
 (user=prohr job=sendgmr) by 2002:a81:e809:0:b0:583:491b:53d3 with SMTP id
 a9-20020a81e809000000b00583491b53d3mr30283ywm.9.1689778356715; Wed, 19 Jul
 2023 07:52:36 -0700 (PDT)
Date: Wed, 19 Jul 2023 07:52:13 -0700
In-Reply-To: <8ab106ad-d153-4c3e-8b4a-de4826d29da6@kadam.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <8ab106ad-d153-4c3e-8b4a-de4826d29da6@kadam.mountain>
X-Mailer: git-send-email 2.41.0.455.g037347b96a-goog
Message-ID: <20230719145213.888494-1-prohr@google.com>
Subject: [net-next v2] net: add sysctl accept_ra_min_rtr_lft
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
 net/ipv6/ndisc.c                       | 18 ++++++++++++++++--
 5 files changed, 36 insertions(+), 2 deletions(-)

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
index 18634ebd20a4..29ddad1c1a2f 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1280,6 +1280,8 @@ static enum skb_drop_reason ndisc_router_discovery(st=
ruct sk_buff *skb)
 	if (!ndisc_parse_options(skb->dev, opt, optlen, &ndopts))
 		return SKB_DROP_REASON_IPV6_NDISC_BAD_OPTIONS;
=20
+	lifetime =3D ntohs(ra_msg->icmph.icmp6_rt_lifetime);
+
 	if (!ipv6_accept_ra(in6_dev)) {
 		ND_PRINTK(2, info,
 			  "RA: %s, did not accept ra for dev: %s\n",
@@ -1287,6 +1289,13 @@ static enum skb_drop_reason ndisc_router_discovery(s=
truct sk_buff *skb)
 		goto skip_linkparms;
 	}
=20
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
@@ -1339,8 +1348,6 @@ static enum skb_drop_reason ndisc_router_discovery(st=
ruct sk_buff *skb)
 		goto skip_defrtr;
 	}
=20
-	lifetime =3D ntohs(ra_msg->icmph.icmp6_rt_lifetime);
-
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	pref =3D ra_msg->icmph.icmp6_router_pref;
 	/* 10b is handled as if it were 00b (medium) */
@@ -1492,6 +1499,13 @@ static enum skb_drop_reason ndisc_router_discovery(s=
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


