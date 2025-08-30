Return-Path: <netdev+bounces-218449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50159B3C776
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 04:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848AC1C87478
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 02:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9CE2571D8;
	Sat, 30 Aug 2025 02:34:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F7A255F2D;
	Sat, 30 Aug 2025 02:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756521273; cv=none; b=fUvGTT7MN0NwCrEez6fo7ci59z1YeZRJKZ77+/Tds07vcbbGF5f+zEOSR1+kc7FyiIHgXGTek0MhzeG5fzrR2JvPKZa658/3wLc++1crmsHpPHgTp4JEApr5+diymoIIZOmOIGwG8S0oNkaQ92A4oFoGq5wQX48fj1SGeEuh2tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756521273; c=relaxed/simple;
	bh=zZrzbEYXKnp9RaABqFj03QqtBzNpyYiXOKv5g9N5GY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBqgs31hOTYIkO5YgUFYD/oDXaEtwODQu3krW+veJGtqncOZ0eBaAn0lH2jP7ai4ypH0S7EwNPIA3vXp5GXOUXGIyrzCx0Mlp9yLA55eI2R0k8wn1j6OUf4cUnKMzocEMTvXOgk6ciigmxDrTaR208+f3L93f9MtrCZyQTb8CzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1usBQB-000000005x5-1fiO;
	Sat, 30 Aug 2025 02:34:27 +0000
Date: Sat, 30 Aug 2025 03:34:23 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v4 5/6] net: dsa: lantiq_gswip: support standard
 MDIO node name
Message-ID: <5a9a3d659ef0d8b7eca37fb69ec87ff5a3192820.1756520811.git.daniel@makrotopia.org>
References: <cover.1756520811.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756520811.git.daniel@makrotopia.org>


Instead of matching against the child node's compatible string also
support locating the node of the device tree node of the MDIO bus
in the standard way by referencing the node name ("mdio").

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Reviewed-by: Hauke Mehrtens <hauke@hauke-m.de>
---
v4: no changes
v3: no changes
v2: no changes

 drivers/net/dsa/lantiq/lantiq_gswip.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index 4d7c7d933c92..43f83c0736d1 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -286,6 +286,9 @@ static int gswip_mdio(struct gswip_priv *priv)
 	int err = 0;
 
 	mdio_np = of_get_compatible_child(switch_np, "lantiq,xrx200-mdio");
+	if (!mdio_np)
+		mdio_np = of_get_child_by_name(switch_np, "mdio");
+
 	if (!of_device_is_available(mdio_np))
 		goto out_put_node;
 
-- 
2.51.0

