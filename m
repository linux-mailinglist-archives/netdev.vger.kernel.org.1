Return-Path: <netdev+bounces-31630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AD778F1D2
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 19:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EBB61C20AF6
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 17:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCED18C2D;
	Thu, 31 Aug 2023 17:23:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011DB11CB6
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 17:23:37 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BD81B2
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 10:23:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7b9eb73dcdso883269276.0
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 10:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693502615; x=1694107415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rueJ3JxHkX3XXlIyOBcnanjjCPXo4cJgvmcjHONI/Yg=;
        b=26UhVG48g2Xwd5QfeduZ9ZWCy2iZY4N+w+2C3HthyqNnBEVd+9oUyVlp0NS7dxeURe
         7QZU/OMqlwAYVCrIrxRy1+ILChhTjhG0l522pI2AHck9tcyLtdi4aQAhoOYVHMgs6oVH
         7iGL9Sd+0I7zZCUvxnyF4HjtjbILEDwuBpeh0fBPZhzXjo+Bf/mTNfRj537ffeabS+KI
         GRPo//RxVztDiXQcjjFy4F8ypsdxBPI+h6l4qCZ6J/t8YUyp1NSuRwbM/TM/kXDrjYaO
         0jgPRFJxHEvmnVdwvrZVcYSU2As4ZsMBkzRKbGuJsRuJtNVaW4BNNOtADPrQE/U2g5r6
         1Odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693502615; x=1694107415;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rueJ3JxHkX3XXlIyOBcnanjjCPXo4cJgvmcjHONI/Yg=;
        b=ZJm1MyrOw1nXmtR3YFxhGIb6Uh2mHMGsTgeZCigp6nPtHQkskONjfsh2UtzrWbLWbP
         b9C/XyIdeGk80jTjmNCOPw4iaF/P+WC4k2ksDZhWj4K5fyupSZA6AYUYLbCWv8Ewl6YX
         zUpSZ0f+w0ywKUem3nHh8PNUipCf0ivmrlJwBhPH7s/izc5DhQMkSAmxndhwUUqhHkOw
         5xEPnS3TRXzckpsG2FRWogoPTIVHdlPDdXhs21AV9MvBgpzpq+kFhi+16NzlBWPPo47V
         E9pVKOz2iyprNQZc8dRvtDkUmXvGMlT/jg+/vGURTRWBbzlwk8P2O811h5rh1+7T7g12
         9Azw==
X-Gm-Message-State: AOJu0YwDinZ9c39BjE9d1XslniFYM/UqnO+XnJp7L3/5pd45HEYH193v
	sH72AklCzRDrCk4pYWFGai1JkhWX5g==
X-Google-Smtp-Source: AGHT+IFuUQrS3F7jzaP5F9EaRSbhStFbpHLWKurl83lVUU2K8nl1lWBAK/TGtDfRTYuFA6fn1e+mGOAaog==
X-Received: from prohr-desktop.mtv.corp.google.com ([2620:15c:211:200:e4e2:e0b2:e2f6:d8d0])
 (user=prohr job=sendgmr) by 2002:a25:d80a:0:b0:d08:ea77:52d4 with SMTP id
 p10-20020a25d80a000000b00d08ea7752d4mr7657ybg.12.1693502615698; Thu, 31 Aug
 2023 10:23:35 -0700 (PDT)
Date: Thu, 31 Aug 2023 10:23:21 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230831172322.668507-1-prohr@google.com>
Subject: [PATCH net-next] net: add sysctl to disable rfc4862 5.5.3e lifetime handling
From: Patrick Rohr <prohr@google.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, Patrick Rohr <prohr@google.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>, Jen Linkova <furry@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This change adds a sysctl to opt-out of RFC4862 section 5.5.3e's valid
lifetime derivation mechanism.

RFC4862 section 5.5.3e prescribes that the valid lifetime in a Router
Advertisement PIO shall be ignored if it less than 2 hours and to reset
the lifetime of the corresponding address to 2 hours. An in-progress
6man draft (see draft-ietf-6man-slaac-renum-07 section 4.2) is currently
looking to remove this mechanism. While this draft has not been moving
particularly quickly for other reasons, there is widespread consensus on
section 4.2 which updates RFC4862 section 5.5.3e.

Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: Jen Linkova <furry@google.com>
Signed-off-by: Patrick Rohr <prohr@google.com>
---
 Documentation/networking/ip-sysctl.rst | 11 ++++++++
 include/linux/ipv6.h                   |  1 +
 net/ipv6/addrconf.c                    | 38 +++++++++++++++++---------
 3 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/network=
ing/ip-sysctl.rst
index a66054d0763a..7f21877e3f78 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2304,6 +2304,17 @@ accept_ra_pinfo - BOOLEAN
 		- enabled if accept_ra is enabled.
 		- disabled if accept_ra is disabled.
=20
+ra_pinfo_rfc4862_5_5_3e - BOOLEAN
+	Use RFC4862 Section 5.5.3e to determine the valid lifetime of
+	an address matching a prefix sent in a Router Advertisement
+	Prefix Information Option.
+
+	- If enabled, RFC4862 section 5.5.3e is used to determine
+	  the valid lifetime of the address.
+	- If disabled, the PIO valid lifetime will always be honored.
+
+	Default: 1
+
 accept_ra_rt_info_min_plen - INTEGER
 	Minimum prefix length of Route Information in RA.
=20
diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 5883551b1ee8..f90cf8835ed4 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -35,6 +35,7 @@ struct ipv6_devconf {
 	__s32		accept_ra_min_hop_limit;
 	__s32		accept_ra_min_lft;
 	__s32		accept_ra_pinfo;
+	__s32		ra_pinfo_rfc4862_5_5_3e;
 	__s32		ignore_routes_with_linkdown;
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	__s32		accept_ra_rtr_pref;
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 47d1dd8501b7..1ac23a37e8eb 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -204,6 +204,7 @@ static struct ipv6_devconf ipv6_devconf __read_mostly =
=3D {
 	.accept_ra_min_hop_limit=3D 1,
 	.accept_ra_min_lft	=3D 0,
 	.accept_ra_pinfo	=3D 1,
+	.ra_pinfo_rfc4862_5_5_3e =3D 1,
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	.accept_ra_rtr_pref	=3D 1,
 	.rtr_probe_interval	=3D 60 * HZ,
@@ -265,6 +266,7 @@ static struct ipv6_devconf ipv6_devconf_dflt __read_mos=
tly =3D {
 	.accept_ra_min_hop_limit=3D 1,
 	.accept_ra_min_lft	=3D 0,
 	.accept_ra_pinfo	=3D 1,
+	.ra_pinfo_rfc4862_5_5_3e =3D 1,
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	.accept_ra_rtr_pref	=3D 1,
 	.rtr_probe_interval	=3D 60 * HZ,
@@ -2657,22 +2659,23 @@ int addrconf_prefix_rcv_add_addr(struct net *net, s=
truct net_device *dev,
 			stored_lft =3D ifp->valid_lft - (now - ifp->tstamp) / HZ;
 		else
 			stored_lft =3D 0;
-		if (!create && stored_lft) {
+
+		/* RFC4862 Section 5.5.3e:
+		 * "Note that the preferred lifetime of the
+		 *  corresponding address is always reset to
+		 *  the Preferred Lifetime in the received
+		 *  Prefix Information option, regardless of
+		 *  whether the valid lifetime is also reset or
+		 *  ignored."
+		 *
+		 * So we should always update prefered_lft here.
+		 */
+		update_lft =3D !create && stored_lft;
+
+		if (update_lft && in6_dev->cnf.ra_pinfo_rfc4862_5_5_3e) {
 			const u32 minimum_lft =3D min_t(u32,
 				stored_lft, MIN_VALID_LIFETIME);
 			valid_lft =3D max(valid_lft, minimum_lft);
-
-			/* RFC4862 Section 5.5.3e:
-			 * "Note that the preferred lifetime of the
-			 *  corresponding address is always reset to
-			 *  the Preferred Lifetime in the received
-			 *  Prefix Information option, regardless of
-			 *  whether the valid lifetime is also reset or
-			 *  ignored."
-			 *
-			 * So we should always update prefered_lft here.
-			 */
-			update_lft =3D 1;
 		}
=20
 		if (update_lft) {
@@ -6846,6 +6849,15 @@ static const struct ctl_table addrconf_sysctl[] =3D =
{
 		.mode		=3D 0644,
 		.proc_handler	=3D proc_dointvec,
 	},
+	{
+		.procname	=3D "ra_pinfo_rfc4862_5_5_3e",
+		.data		=3D &ipv6_devconf.ra_pinfo_rfc4862_5_5_3e,
+		.maxlen		=3D sizeof(int),
+		.mode		=3D 0644,
+		.proc_handler	=3D proc_dointvec_minmax,
+		.extra1		=3D SYSCTL_ZERO,
+		.extra2		=3D SYSCTL_ONE,
+	},
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	{
 		.procname	=3D "accept_ra_rtr_pref",
--=20
2.42.0.283.g2d96d420d3-goog


