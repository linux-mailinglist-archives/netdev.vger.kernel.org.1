Return-Path: <netdev+bounces-36176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DE07AE0EE
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 23:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 850871F24C22
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 21:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC6224203;
	Mon, 25 Sep 2023 21:47:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976811170A
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 21:47:21 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D228A2
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 14:47:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d852a6749baso11467850276.0
        for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 14:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695678439; x=1696283239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9kSoxE55K8Ugx6woIwUGCOWl36cKcykhW9tXJWOEJpY=;
        b=jAK6iQrpDwkSPC1srF4xlv2Q4FNMiy9JHNC806rqH0JG2WwOvOmMU+o8+UebEOeaQv
         foCxA66BonFs0VynfbcgQYLWzbzm2f1X33kz2i1cah1iP4R5ghN+0luiweDTkVVO3RS4
         SZcKrpucbDKxCSvbUiMH1xTpT3qkmihE5vjfFmTZy95BPHIYcNlIV0YUoUc2S0D8ij6+
         9emSzuoF50UWJbFR6L64okSLmeISkcImpHSXp1H4WNrIKkp9hqE1CFhCVrpHpFWnK45e
         f2hyt4AuyDiIP/1WKUyxxegFSfHKTClPme90z+GTYDFXD4f27D6S9mw2d9lJoHpnSnJj
         mBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695678439; x=1696283239;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kSoxE55K8Ugx6woIwUGCOWl36cKcykhW9tXJWOEJpY=;
        b=MKGiZr1nrNKAewxzd+/LjpzQtokRwsBS9cZdBBEOAi3YUyo/sTCRvh2ojDcdatKRBI
         iwjw2clkFvb1E69h6qQpDZQEyWa7NKUzmU9/aJGtjFY1KjL5O2FwA329e2jETBSuJJeJ
         5lDi70iGqhFVRu1MfFV5wI8AA4NX9C0u7yr2anxvLlyACSndIqfFa4c6428hHtnp0JGA
         EevcUapD+i3MG7fUVX7l9vTvDor2RLAoBEmKfmU/4wRrlsWxGVlBX/06aVbJoRkXFQCY
         LOKhVnAecg+hHxBoXHuHQX2wLQqMgq/CXdSL0QyduHDhHGA08AjdJVmrUJB6fI3NWhHb
         LTNw==
X-Gm-Message-State: AOJu0YyGgdALN1L3TmbPFa/9qaHi3P06wV1QdWSY+yOCs6a2ssHSngpT
	SDZlYqIExblX5jh5byDdvwhZF8dPNQ==
X-Google-Smtp-Source: AGHT+IGNxUAnQaY4xj1Tr5Semp31UI5iqGF+Jr7BeejUHDMX14O9gNNIjXkgC/0ea1JjkcmXc+ifKphnwg==
X-Received: from prohr-desktop.mtv.corp.google.com ([2620:15c:211:200:146d:2aa0:7ed1:bbb8])
 (user=prohr job=sendgmr) by 2002:a05:6902:1105:b0:d81:6637:b5b2 with SMTP id
 o5-20020a056902110500b00d816637b5b2mr89965ybu.0.1695678439382; Mon, 25 Sep
 2023 14:47:19 -0700 (PDT)
Date: Mon, 25 Sep 2023 14:47:11 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230925214711.959704-1-prohr@google.com>
Subject: [PATCH net-next v4] net: add sysctl to disable rfc4862 5.5.3e
 lifetime handling
From: Patrick Rohr <prohr@google.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, Patrick Rohr <prohr@google.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>, Jen Linkova <furry@google.com>, 
	Jiri Pirko <jiri@resnulli.us>, David Ahern <dsahern@kernel.org>
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
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: David Ahern <dsahern@kernel.org>
Signed-off-by: Patrick Rohr <prohr@google.com>
---
 Documentation/networking/ip-sysctl.rst | 11 ++++++++
 include/linux/ipv6.h                   |  1 +
 net/ipv6/addrconf.c                    | 38 +++++++++++++++++---------
 3 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/network=
ing/ip-sysctl.rst
index a66054d0763a..45d700e04dba 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2304,6 +2304,17 @@ accept_ra_pinfo - BOOLEAN
 		- enabled if accept_ra is enabled.
 		- disabled if accept_ra is disabled.
=20
+ra_honor_pio_life - BOOLEAN
+	Whether to use RFC4862 Section 5.5.3e to determine the valid
+	lifetime of an address matching a prefix sent in a Router
+	Advertisement Prefix Information Option.
+
+	- If enabled, the PIO valid lifetime will always be honored.
+	- If disabled, RFC4862 section 5.5.3e is used to determine
+	  the valid lifetime of the address.
+
+	Default: 0 (disabled)
+
 accept_ra_rt_info_min_plen - INTEGER
 	Minimum prefix length of Route Information in RA.
=20
diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 5883551b1ee8..8f3b61f953c4 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -82,6 +82,7 @@ struct ipv6_devconf {
 	__u32		ioam6_id_wide;
 	__u8		ioam6_enabled;
 	__u8		ndisc_evict_nocarrier;
+	__u8		ra_honor_pio_life;
=20
 	struct ctl_table_header *sysctl_header;
 };
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 47d1dd8501b7..980d0f65b745 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -236,6 +236,7 @@ static struct ipv6_devconf ipv6_devconf __read_mostly =
=3D {
 	.ioam6_id               =3D IOAM6_DEFAULT_IF_ID,
 	.ioam6_id_wide		=3D IOAM6_DEFAULT_IF_ID_WIDE,
 	.ndisc_evict_nocarrier	=3D 1,
+	.ra_honor_pio_life	=3D 0,
 };
=20
 static struct ipv6_devconf ipv6_devconf_dflt __read_mostly =3D {
@@ -297,6 +298,7 @@ static struct ipv6_devconf ipv6_devconf_dflt __read_mos=
tly =3D {
 	.ioam6_id               =3D IOAM6_DEFAULT_IF_ID,
 	.ioam6_id_wide		=3D IOAM6_DEFAULT_IF_ID_WIDE,
 	.ndisc_evict_nocarrier	=3D 1,
+	.ra_honor_pio_life	=3D 0,
 };
=20
 /* Check if link is ready: is it up and is a valid qdisc available */
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
+		if (update_lft && !in6_dev->cnf.ra_honor_pio_life) {
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
+		.procname	=3D "ra_honor_pio_life",
+		.data		=3D &ipv6_devconf.ra_honor_pio_life,
+		.maxlen		=3D sizeof(u8),
+		.mode		=3D 0644,
+		.proc_handler	=3D proc_dou8vec_minmax,
+		.extra1		=3D SYSCTL_ZERO,
+		.extra2		=3D SYSCTL_ONE,
+	},
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	{
 		.procname	=3D "accept_ra_rtr_pref",
--=20
2.42.0.515.g380fc7ccd1-goog


