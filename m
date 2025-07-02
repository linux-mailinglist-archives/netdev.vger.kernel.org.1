Return-Path: <netdev+bounces-203345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BEAAF5846
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 15:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0ED4A2109
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D5D2797A4;
	Wed,  2 Jul 2025 13:14:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CED278E7B;
	Wed,  2 Jul 2025 13:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462089; cv=none; b=X3Ny/Ew3nyyQFvA6qPPTlOg/UGT+ynkNPr8L0Q2qDNulh8o5cAO5CKJqI8eBJE21cmofTd1dDDI8LIDhddJZniCJWAgcTN8vAFLSATqijTjRNRbweJxXc9jMWiqPOBJn3qr4HA+dSF+51XCju41FHmV7oqlfAZUb5zMg/znmyfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462089; c=relaxed/simple;
	bh=nXa+otigbDBJM1rZFBFfLd3koHsXm0/i7V1Ux8uVw6w=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMU/6dtnbz4a7wDsxeMq3+MvAL0ga8NgITFlENpLx5gfoLaFy/LzHhBTc0PG7zwebffeYPOvNcIPyAvAxcBPFjEaEiWQadx/F/31NynGFz9iiVCjaOAzCqkRvDZ6PP2HcT7q94cZAWCLsJ+70DBUayqtQxRaobSyFXfKN/En8dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uWxIQ-000000007tO-0pE2;
	Wed, 02 Jul 2025 13:14:42 +0000
Date: Wed, 2 Jul 2025 14:14:39 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Felix Fietkau <nbd@nbd.name>,
	Frank Wunderlich <frank-w@public-files.de>,
	Eric Woudstra <ericwouds@gmail.com>, Elad Yifee <eladwf@gmail.com>,
	Bo-Cun Chen <bc-bocun.chen@mediatek.com>,
	Sky Huang <skylake.huang@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v5 2/3] net: ethernet: mtk_eth_soc: fix kernel-doc
 comment
Message-ID: <748e7de848e45ecdc84fbb78e34e9e13b9aa4329.1751461762.git.daniel@makrotopia.org>
References: <cover.1751461762.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1751461762.git.daniel@makrotopia.org>

Fix and add some missing field descriptions to kernel-doc comment of
struct mtk_eth.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v5: unchanged
v4: unchanged
v3: unchanged
v2: unchanged

 drivers/net/ethernet/mediatek/mtk_eth_soc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 9261c0e13b59..1ad9075a9b69 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -1243,8 +1243,9 @@ struct mtk_soc_data {
 /* struct mtk_eth -	This is the main datasructure for holding the state
  *			of the driver
  * @dev:		The device pointer
- * @dev:		The device pointer used for dma mapping/alloc
+ * @dma_dev:		The device pointer used for dma mapping/alloc
  * @base:		The mapped register i/o base
+ * @sram_base:		The mapped SRAM base
  * @page_lock:		Make sure that register operations are atomic
  * @tx_irq__lock:	Make sure that IRQ register operations are atomic
  * @rx_irq__lock:	Make sure that IRQ register operations are atomic
-- 
2.50.0

