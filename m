Return-Path: <netdev+bounces-106051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B099914780
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 12:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F151F20F63
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 10:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2301369A3;
	Mon, 24 Jun 2024 10:29:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E073BBF2;
	Mon, 24 Jun 2024 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719224969; cv=none; b=l8/uk3HGKgUZIReZccM49WjzrOZ816HLRTB5D4pR9cEWEhZ6ibdYMmHu6e/GlAY9ssaGss8CkUcQ5nC9N/W/XWutF12s2IAyRFPPJykrPjUdIAdtiPNOayviOp7q6CiANdvj+bQo18pD/9w07hV2KUeX7DIrG/Xj0OGXnq8LkoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719224969; c=relaxed/simple;
	bh=ID6uC1394q/rVuz5Y38/BcmRBkkatT0DyixIDFXXCrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GU7HyBAmfLGG/Hucmp8wx8NJZ1MPGVANyH5RO6+HAxJW3EjBDLUt3/G4fQ/QWVFnFYlZBzNLk+8uhPxV3lHlmQhRCrY+Ex4X0iPT8/cYIUXCwOTs4nlIgGB+abcJ3rpOL0bSt1vo3vHbOf7Dh9Z/eJk0opj5MkA1uPrECgExJeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a724b3a32d2so118432566b.2;
        Mon, 24 Jun 2024 03:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719224966; x=1719829766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nyY2ZZiHme00HbBe8pGYRA6yVdo7lRrAai+PoMjkalc=;
        b=JF/bj3UVEIlMKPcPeDV3asOxxpJnGG2rCqzPNBkzhnA5GjJd4LqHhvJyejqrYKVkdA
         1V/NKu2qVC41dKklSzlKwtiSItMc1DJW7/VnFwarvCAn4I0z2CI1rbr/KGJSn7OwfyX0
         xa8emacVyVmm0J5M4cqE1qg0MJ7vgXtp6Qp/KjpFGLxY27f3ou3TkzXtgKeEWasXxLuL
         EBi8u7lbrAl0W6gMUykvqFHYZSyNctQxy78KXRLUSFfSOZWqYE9Wy8SH1ADgPKTFaA5X
         BEDNObeiUvgb3tLrahPqCz8IcBaXwUlK/DDzRnhPjCygu9OztBT+F4ChHWBCVYh9w3Dy
         9GXA==
X-Forwarded-Encrypted: i=1; AJvYcCUV9BxQUA1yGJCjyxKao9EvZZj59bQrSiCLcybcqO9EElE6+IHUPxiF0Z4gBp+4rZRHoPJqs/Uhvo7yOgtVyss/s8Nd6b2/bU6QZukH/m/PvBQeXmmpAeDHRR0QADQdOIkfsEdx
X-Gm-Message-State: AOJu0Yw+fj0dmsUkS+15FiUeS3SBvmiRR7tSaqNQWhCQO1FoAn+cD9Qb
	HOYCcQmpHlGCTD3RqqfWolKzXrWX3TXsHXRx0nWIW+WdstApakEf
X-Google-Smtp-Source: AGHT+IFvaj7d8f/TKbBcTbx/Me9SR9bDVUuO5uBmoAvYJ1+v2T9aT/ellVN4L4y09upWMQDrgA+JeQ==
X-Received: by 2002:a17:907:cb85:b0:a72:46f3:ffc8 with SMTP id a640c23a62f3a-a7246f40067mr281037066b.29.1719224965698;
        Mon, 24 Jun 2024 03:29:25 -0700 (PDT)
Received: from localhost (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a71ddbd3479sm240836966b.189.2024.06.24.03.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 03:29:25 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Sunil Goutham <sgoutham@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: horms@kernel.org,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/CAVIUM THUNDER NETWORK DRIVER),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: thunderx: Unembed netdev structure
Date: Mon, 24 Jun 2024 03:29:18 -0700
Message-ID: <20240624102919.4016797-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Embedding net_device into structures prohibits the usage of flexible
arrays in the net_device structure. For more details, see the discussion
at [1].

Un-embed the net_devices from struct lmac by converting them
into pointers, and allocating them dynamically. Use the leverage
alloc_netdev() to allocate the net_device object at
bgx_lmac_enable().

The free of the device occurs at bgx_lmac_disable().

 Do not free_netdevice() if bgx_lmac_enable() fails after lmac->netdev
is allocated, since bgx_lmac_disable() is called if bgx_lmac_enable()
fails, and lmac->netdev will be freed there (similarly to lmac->dmacs).

Link: https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/ [1]
Signed-off-by: Breno Leitao <leitao@debian.org>
---
PS: Unfortunately due to lack of hardware, this patch is compiled-test
only.

 .../net/ethernet/cavium/thunder/thunder_bgx.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index a317feb8decb..d097d606577b 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -54,7 +54,7 @@ struct lmac {
 	bool			link_up;
 	int			lmacid; /* ID within BGX */
 	int			lmacid_bd; /* ID on board */
-	struct net_device       netdev;
+	struct net_device       *netdev;
 	struct phy_device       *phydev;
 	unsigned int            last_duplex;
 	unsigned int            last_link;
@@ -590,7 +590,7 @@ static void bgx_sgmii_change_link_state(struct lmac *lmac)
 
 static void bgx_lmac_handler(struct net_device *netdev)
 {
-	struct lmac *lmac = container_of(netdev, struct lmac, netdev);
+	struct lmac *lmac = netdev_priv(netdev);
 	struct phy_device *phydev;
 	int link_changed = 0;
 
@@ -1052,12 +1052,18 @@ static int phy_interface_mode(u8 lmac_type)
 
 static int bgx_lmac_enable(struct bgx *bgx, u8 lmacid)
 {
-	struct lmac *lmac;
+	struct lmac *lmac, **priv;
 	u64 cfg;
 
 	lmac = &bgx->lmac[lmacid];
 	lmac->bgx = bgx;
 
+	lmac->netdev = alloc_netdev_dummy(sizeof(struct lmac *));
+	if (!lmac->netdev)
+		return -ENOMEM;
+	priv = netdev_priv(lmac->netdev);
+	*priv = lmac;
+
 	if ((lmac->lmac_type == BGX_MODE_SGMII) ||
 	    (lmac->lmac_type == BGX_MODE_QSGMII) ||
 	    (lmac->lmac_type == BGX_MODE_RGMII)) {
@@ -1116,7 +1122,7 @@ static int bgx_lmac_enable(struct bgx *bgx, u8 lmacid)
 		}
 		lmac->phydev->dev_flags = 0;
 
-		if (phy_connect_direct(&lmac->netdev, lmac->phydev,
+		if (phy_connect_direct(lmac->netdev, lmac->phydev,
 				       bgx_lmac_handler,
 				       phy_interface_mode(lmac->lmac_type)))
 			return -ENODEV;
@@ -1183,6 +1189,7 @@ static void bgx_lmac_disable(struct bgx *bgx, u8 lmacid)
 	    (lmac->lmac_type != BGX_MODE_10G_KR) && lmac->phydev)
 		phy_disconnect(lmac->phydev);
 
+	free_netdev(lmac->netdev);
 	lmac->phydev = NULL;
 }
 
@@ -1414,7 +1421,7 @@ static acpi_status bgx_acpi_register_phy(acpi_handle handle,
 
 	acpi_get_mac_address(dev, adev, bgx->lmac[bgx->acpi_lmac_idx].mac);
 
-	SET_NETDEV_DEV(&bgx->lmac[bgx->acpi_lmac_idx].netdev, dev);
+	SET_NETDEV_DEV(bgx->lmac[bgx->acpi_lmac_idx].netdev, dev);
 
 	bgx->lmac[bgx->acpi_lmac_idx].lmacid = bgx->acpi_lmac_idx;
 	bgx->acpi_lmac_idx++; /* move to next LMAC */
@@ -1483,7 +1490,7 @@ static int bgx_init_of_phy(struct bgx *bgx)
 
 		of_get_mac_address(node, bgx->lmac[lmac].mac);
 
-		SET_NETDEV_DEV(&bgx->lmac[lmac].netdev, &bgx->pdev->dev);
+		SET_NETDEV_DEV(bgx->lmac[lmac].netdev, &bgx->pdev->dev);
 		bgx->lmac[lmac].lmacid = lmac;
 
 		phy_np = of_parse_phandle(node, "phy-handle", 0);
-- 
2.43.0


