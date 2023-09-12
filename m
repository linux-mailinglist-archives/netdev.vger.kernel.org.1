Return-Path: <netdev+bounces-33247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BEB79D28C
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 15:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C38341C20C03
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 13:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77F8182C7;
	Tue, 12 Sep 2023 13:44:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB28FA952
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 13:44:32 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC0510CE
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 06:44:31 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59b52554914so50035187b3.0
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 06:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694526271; x=1695131071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rueJ3JxHkX3XXlIyOBcnanjjCPXo4cJgvmcjHONI/Yg=;
        b=Ka8c3Tcu09YWxVeKwgN4oBe1akHOMFS2M9NLQWjcB2YmfTdrcxlP6WJ0BR/Uf4kCKq
         woQbGOHnS30ykWycVuQR/5iEHFAwSVQw668RJcm05tJ3eTubqSRZapf6lWTjATcXYQEt
         tZG6GDnz5mksyq2N0QFPq1UL9ycgKgTOGT92D+rCmEnWUmFysb7Zh76xS/1stIvesgve
         6SD30N8oBYnNk7DSOWuEN5/QOM6PWK4XrWTBf+MjPQvH1W32nvAsRquZHgRYBnkmyaxW
         F2IIaqgQPGQq7uLjinunkhLILRXd9FgoXpPD9+ZC53aPUuVJOTZLhwoIlrIko3XpZLHY
         cbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694526271; x=1695131071;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rueJ3JxHkX3XXlIyOBcnanjjCPXo4cJgvmcjHONI/Yg=;
        b=UW5948KmjuzKhjeepAk7ML6xd+jmf2zhcfym/9T7Angc9XVIzwC1AZzqOuy8q5Rjhn
         5qhC2oaVLSvlgbqZG+xVf2UTfdbGlux40c46WiKoZaV3G4aRYSAqVXU48Ci3/0Y+ogWj
         j+9KQ3w9XgNYaJkMx9Bwe/DRSf/fNQpAz6dHF9dsXb11z65nQ47VOrqpVZAqFXeb2Gp9
         tSx+lKGLXKTgc88d0XjqN03fLssChcYYEJeQ0+1HhY5Uc9HcMOsmtyQiLhRPCxNMO05D
         egMfMm8mnB1WkiSyQQYyoZ4Scykvy8FbFzuwQYgNmtdAYuxgs9d/Y4pa9TYxL6BUck0z
         IYBQ==
X-Gm-Message-State: AOJu0YwgrqtwVkLjDZgu8HVdinCacuzqevK3nhZ9vsB5s5km61wufNRF
	f7WS3QPDoncMrFIEkiopt3yZgvjEAQ==
X-Google-Smtp-Source: AGHT+IG5EKFnKPehZ1W1z5VMWPonhf+FfUC65fc1KkhCZbeJoMludCPnwy7sKW6W00637Pj8gOfqAg3evQ==
X-Received: from prohr-desktop.mtv.corp.google.com ([2620:15c:211:200:4162:5280:8f7d:b119])
 (user=prohr job=sendgmr) by 2002:a81:ae66:0:b0:58c:6ddd:d27c with SMTP id
 g38-20020a81ae66000000b0058c6dddd27cmr304743ywk.6.1694526270938; Tue, 12 Sep
 2023 06:44:30 -0700 (PDT)
Date: Tue, 12 Sep 2023 06:44:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912134425.4083337-1-prohr@google.com>
Subject: [PATCH net-next v2] net: add sysctl to disable rfc4862 5.5.3e
 lifetime handling
From: Patrick Rohr <prohr@google.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, Patrick Rohr <prohr@google.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>, Jen Linkova <furry@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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


