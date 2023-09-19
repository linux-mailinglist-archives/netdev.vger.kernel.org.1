Return-Path: <netdev+bounces-35047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E92A7A6A61
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 20:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33991C20AED
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 18:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C39A3AC13;
	Tue, 19 Sep 2023 18:04:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876E6347B9
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 18:04:17 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FD58F
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 11:04:15 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59c09bcf078so53954887b3.1
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 11:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695146655; x=1695751455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jEgqvZiSH68NpWe0D7XgUQ1V+edtJDC+LxT01O0evxo=;
        b=ejdF7mih8/YAH8Th1kqjgqNWUpi8JwdNTB/eEtbbsOZmzoapgytq8ZtYbP8hYuSAQI
         y9G6cK6LjJMKmhkDusOzO7LS2FJz5dM2luimOajH6f0LxVv7EBzvSuO4uixQCHrcULF5
         6/GmQa+9gCdYmj/BKzk6FUJzt7JVbiCw4Ub6tCVaeTstFRnyKqX1cggFoi4cht4DumIv
         CIp3Sdu+iCRWQCks6b9eO30AJdLBod7eCym4IMqBdydMZ77f5Yi4H02ZEqHvsiFkoadm
         LeWkO3Zyw5/DSQQb9VdSai6vTv3kbBg7Jc5BlETsJAfeIEBWzP/Xk2Ck4WYJemPrLI88
         xC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695146655; x=1695751455;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEgqvZiSH68NpWe0D7XgUQ1V+edtJDC+LxT01O0evxo=;
        b=wjYK8BK3Ja2NXct54nlkPble79E9i8HCsQLdYzIMqmXgRgQKzN5w0of/KpjJjpmjcO
         paPLzi/C1SkFR1O7qYLaXsl7FQckz6LhUNAjLeTKsmSS5hbhgwY3fjwz8C3x6rXOJRpa
         z2rt/hSV9FYOtjw81ZXN9dlPwUOxco1KYsTfIds8cTheL0avVQ5LhwOBisH9eKUr1R7T
         +f1e9rEvP5JaZ9UywakSoOX23R4bCKdX6oSqrX0cwEs4T9CQZfp7bPt40/cl0KJbb+rF
         mcppf6AvJvttjsXTogKnjKDZj9mgyJTDwWBjWXLEkTl1gqFxw7ErognTiSobmGJBAidl
         fG/g==
X-Gm-Message-State: AOJu0YyJw9QXlB5EJUk6UkTmBBZPKx4FYQohatHIqwXy4h61CuhWm/dv
	1aqKCRe5hkDDrsS5GspsqANctkZXdA==
X-Google-Smtp-Source: AGHT+IFcNXmRnswPu6dB3Nz7y+c9ZAPzTby2KWItlOHpI6LJ2wY1E/WxeWhEZTlu+0QjQ/xt23KwKaaybA==
X-Received: from prohr-desktop.mtv.corp.google.com ([2620:15c:211:200:3922:8ca0:e419:5554])
 (user=prohr job=sendgmr) by 2002:a81:4512:0:b0:59b:b8bf:5973 with SMTP id
 s18-20020a814512000000b0059bb8bf5973mr5396ywa.0.1695146654850; Tue, 19 Sep
 2023 11:04:14 -0700 (PDT)
Date: Tue, 19 Sep 2023 11:04:11 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230919180411.754981-1-prohr@google.com>
Subject: [PATCH net-next v3] net: add sysctl to disable rfc4862 5.5.3e
 lifetime handling
From: Patrick Rohr <prohr@google.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, Patrick Rohr <prohr@google.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>, Jen Linkova <furry@google.com>, 
	Jiri Pirko <jiri@resnulli.us>
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
index 5883551b1ee8..59fcc4fee7b7 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -35,6 +35,7 @@ struct ipv6_devconf {
 	__s32		accept_ra_min_hop_limit;
 	__s32		accept_ra_min_lft;
 	__s32		accept_ra_pinfo;
+	__s32		ra_honor_pio_life;
 	__s32		ignore_routes_with_linkdown;
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	__s32		accept_ra_rtr_pref;
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 47d1dd8501b7..edfb450e5893 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -204,6 +204,7 @@ static struct ipv6_devconf ipv6_devconf __read_mostly =
=3D {
 	.accept_ra_min_hop_limit=3D 1,
 	.accept_ra_min_lft	=3D 0,
 	.accept_ra_pinfo	=3D 1,
+	.ra_honor_pio_life	=3D 0,
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	.accept_ra_rtr_pref	=3D 1,
 	.rtr_probe_interval	=3D 60 * HZ,
@@ -265,6 +266,7 @@ static struct ipv6_devconf ipv6_devconf_dflt __read_mos=
tly =3D {
 	.accept_ra_min_hop_limit=3D 1,
 	.accept_ra_min_lft	=3D 0,
 	.accept_ra_pinfo	=3D 1,
+	.ra_honor_pio_life	=3D 0,
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
2.42.0.459.ge4e396fd5e-goog


