Return-Path: <netdev+bounces-214825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BEBB2B645
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 03:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B73E7627E2B
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 01:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66A11F8AD3;
	Tue, 19 Aug 2025 01:34:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BCC1F2BAB;
	Tue, 19 Aug 2025 01:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567283; cv=none; b=KzItZwK2RZbWb1UfY/zagR4NrRMB106ZDBPZuii1RTlhZ9nD+clHbLKOugcH4QNc/h5gi8bFAZM9Z+kAZdea/Wnjgy0283SROFTTMSq0BKmdS75TNiyviafXg7fxR0RcefK0BYVEeUQiDoLXEbHpfII2Kg2ot2QsyPELhfiDTto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567283; c=relaxed/simple;
	bh=NZ2uih3Daqd2zHOAIDtO6KGNj/knslJGewKEAmZ0/30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvjPH666yaJFAnJtVq/rOQqKpjZNPOJzpXLUWPditHZjIuuvETKA/yhRaIem64GZqXrminUgNHVMG+6Ml/KAEWkituy60wfuZ5dYvGXzKicQIhU0uUgULVohNBq7YH52u6M1DxAQ+tKi8Hoc1/O4MNX+M/ifCQP1Na24+bcbD6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uoBFF-000000000CZ-0Jdk;
	Tue, 19 Aug 2025 01:34:37 +0000
Date: Tue, 19 Aug 2025 02:34:33 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
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
Subject: [PATCH net-next v2 7/8] net: dsa: lantiq_gswip: store switch API
 version in priv
Message-ID: <56f6b06e22b3b6dbfb45ef04a43bac13a8cb02e5.1755564606.git.daniel@makrotopia.org>
References: <cover.1755564606.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755564606.git.daniel@makrotopia.org>

Store the switch API version in struct gswip_priv (in host endian) to
prepare supporting newer features such as 4096 VLANs and per-port
configurable learning.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: store version as u16 in host byte order

 drivers/net/dsa/lantiq_gswip.c | 3 +++
 drivers/net/dsa/lantiq_gswip.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index d42e7625fe44..751ac9d6e49b 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -28,6 +28,7 @@
 #include "lantiq_gswip.h"
 #include "lantiq_pce.h"
 
+#include <linux/byteorder/generic.h>
 #include <linux/delay.h>
 #include <linux/etherdevice.h>
 #include <linux/firmware.h>
@@ -1936,6 +1937,8 @@ static int gswip_probe(struct platform_device *pdev)
 					     "gphy fw probe failed\n");
 	}
 
+	priv->version = le16_to_cpu(version);
+
 	/* bring up the mdio bus */
 	err = gswip_mdio(priv);
 	if (err) {
diff --git a/drivers/net/dsa/lantiq_gswip.h b/drivers/net/dsa/lantiq_gswip.h
index d4603bba7e7c..5a0ac7a538d9 100644
--- a/drivers/net/dsa/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq_gswip.h
@@ -259,6 +259,7 @@ struct gswip_priv {
 	struct gswip_gphy_fw *gphy_fw;
 	u32 port_vlan_filter;
 	struct mutex pce_table_lock;
+	u16 version;
 };
 
 #endif /* __LANTIQ_GSWIP_H */
-- 
2.50.1

