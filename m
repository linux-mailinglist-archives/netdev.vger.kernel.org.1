Return-Path: <netdev+bounces-100499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4728B8FAEAD
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 11:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 092CD288DDB
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 09:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C091448D3;
	Tue,  4 Jun 2024 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="ZBRykCbg"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB251143C44
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493038; cv=none; b=iiVRsCzeH/HTDCnL7ydQ40cMP4kgA7+Dri/vKPf4fuuCGdhZQkZnefeJdpbIy6//o1SjOIux2v7DUPs6ycIaevJ2WIcAfai6BfDQexqTDjyZ1jEwtSLhoPCUqJY7FOvhVYEwU1mFAlVUYYjXKV5P1WznjnZbmbxljsu29H9VheE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493038; c=relaxed/simple;
	bh=+KW5iEKJEFh1bmDgJ94fjsL21q4MrNzZihOmTRlkSek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=onUXXGaETC8b89PFQs77Vspe9C+sO2uyJhful6/T4JD8pL79kIj19y49/0NKV0KQa8mYrzKuG8W5q+ACgj+gHhl399kGlcrdGtMff2HryAOWCAFi9a3P5dPRb7+RtSqOvnBLFerlAPcsUE+iaybXRivZA4junL/vuMAGvIfSfeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=ZBRykCbg; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E0F4B9C59D4;
	Tue,  4 Jun 2024 05:23:49 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 6CIwNDbzIX7u; Tue,  4 Jun 2024 05:23:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 37B859C58AE;
	Tue,  4 Jun 2024 05:23:49 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 37B859C58AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1717493029; bh=+uotw6VjqpLc57rZDJ2OavLRq9Ew2QDzQUICpP/lpmg=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=ZBRykCbgzWkgfTKbaErqW6pFODJ6W5VnWjc7EUbeclbJRXHPxR7wK/SjLLaDXepsV
	 ITpCAWZpDqXf2NXxNocpBpjqMheUltVKA/akcwhocBVSIB1G/oKMml2KvwHF7ybYgS
	 wd4oaArs8Zy/v5HTSJxqFABoyVwuFzvKiigsv9n41SWY3xhWOoIbC6tOEB3AYdMdpe
	 crK4gMEsD4d1fCEHuj7dW+1xgSJpw+dasE8gnmAoT40ktt+7+oXwnm2zNvzQm9fZKm
	 8aMkZpfxSNFZqn9i1+KxOH+Jaw6icCXY/JLQpNhDRIaFsCtxDixl5Lk8GU0e0jpAsU
	 lgpyEyp7JXHQQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 3o376i6n4XaN; Tue,  4 Jun 2024 05:23:49 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 0066D9C58EF;
	Tue,  4 Jun 2024 05:23:47 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	horms@kernel.org,
	Tristram.Ha@microchip.com,
	Arun.Ramadoss@microchip.com,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Subject: [PATCH net v5 3/4] net: dsa: microchip: use collision based back pressure mode
Date: Tue,  4 Jun 2024 09:23:04 +0000
Message-Id: <20240604092304.314636-4-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Errata DS80000758 states that carrier sense back pressure mode can cause
link down issues in 100BASE-TX half duplex mode. The datasheet also
recommends to always use the collision based back pressure mode.

Fixes: b987e98e50ab ("dsa: add DSA switch driver for Microchip KSZ9477")
Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirf=
airelinux.com>
---
v5:
 - define SW_BACK_PRESSURE_COLLISION
v4: https://lore.kernel.org/all/20240531142430.678198-5-enguerrand.de-rib=
aucourt@savoirfairelinux.com/
 - rebase on net/main
 - add Fixes tag
v3: https://lore.kernel.org/all/20240530102436.226189-5-enguerrand.de-rib=
aucourt@savoirfairelinux.com/
---
 drivers/net/dsa/microchip/ksz9477.c     | 4 ++++
 drivers/net/dsa/microchip/ksz9477_reg.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microc=
hip/ksz9477.c
index f8ad7833f5d9..c2878dd0ad7e 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1299,6 +1299,10 @@ int ksz9477_setup(struct dsa_switch *ds)
 	/* Enable REG_SW_MTU__2 reg by setting SW_JUMBO_PACKET */
 	ksz_cfg(dev, REG_SW_MAC_CTRL_1, SW_JUMBO_PACKET, true);
=20
+	/* Use collision based back pressure mode. */
+	ksz_cfg(dev, REG_SW_MAC_CTRL_1, SW_BACK_PRESSURE,
+		SW_BACK_PRESSURE_COLLISION);
+
 	/* Now we can configure default MTU value */
 	ret =3D regmap_update_bits(ksz_regmap_16(dev), REG_SW_MTU__2, REG_SW_MT=
U_MASK,
 				 VLAN_ETH_FRAME_LEN + ETH_FCS_LEN);
diff --git a/drivers/net/dsa/microchip/ksz9477_reg.h b/drivers/net/dsa/mi=
crochip/ksz9477_reg.h
index f3a205ee483f..fb124be8edd3 100644
--- a/drivers/net/dsa/microchip/ksz9477_reg.h
+++ b/drivers/net/dsa/microchip/ksz9477_reg.h
@@ -247,6 +247,7 @@
 #define REG_SW_MAC_CTRL_1		0x0331
=20
 #define SW_BACK_PRESSURE		BIT(5)
+#define SW_BACK_PRESSURE_COLLISION	0
 #define FAIR_FLOW_CTRL			BIT(4)
 #define NO_EXC_COLLISION_DROP		BIT(3)
 #define SW_JUMBO_PACKET			BIT(2)
--=20
2.34.1


