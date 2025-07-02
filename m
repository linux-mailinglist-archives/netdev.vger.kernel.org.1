Return-Path: <netdev+bounces-203114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 881C9AF0887
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 04:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2071C212BC
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 02:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FB21A08A3;
	Wed,  2 Jul 2025 02:38:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286DA18BC3B;
	Wed,  2 Jul 2025 02:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751423893; cv=none; b=U9Z0/dT6pJChELwpdb6WFN0pTKPIdMFHl814PsPxTgv1GvrDjY6H3fJmSsl8r9aQX8p4qt9sYoxX7pRqoYY0qu0cwnV+phljpPfIyfF7s/S8PSTofMz4W/7Q+Ku2Zthxui68QEXSa6x1MnM3I5LnRoeL95j7UAl7J2+yKfTmcOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751423893; c=relaxed/simple;
	bh=b5P0OQ9XHcgt0t3xGFlcHNUeH0PqY6jaf5Zfz7gIa6Y=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBC5sNfupOMe5Qh45H/1yaN8g4HFJEWDv3Hm//n+dGDIcmjnCwHVrekNUYmqXvOHM+tpxJ7E439+h8Pi1Dj6c/A8pCRtM6UKelb41h9P7i9fmV9+D7EiPkhgZVR5k//F9phZ0CuYItbHrcn1btfu8kSjQjwpeYL1Y/mBDV/Xs2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uWnMN-000000005Du-0d2R;
	Wed, 02 Jul 2025 02:38:07 +0000
Date: Wed, 2 Jul 2025 03:38:04 +0100
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
Subject: [PATCH net-next v4 2/3] net: ethernet: mtk_eth_soc: fix kernel-doc
 comment
Message-ID: <748e7de848e45ecdc84fbb78e34e9e13b9aa4329.1751421358.git.daniel@makrotopia.org>
References: <cover.1751421358.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1751421358.git.daniel@makrotopia.org>

Fix and add some missing field descriptions to kernel-doc comment of
struct mtk_eth.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
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

