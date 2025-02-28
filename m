Return-Path: <netdev+bounces-170663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5BBA497E9
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 11:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77AFF7A9E03
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 10:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC202620D3;
	Fri, 28 Feb 2025 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e397iLE9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B614426038D;
	Fri, 28 Feb 2025 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740740093; cv=none; b=EXuRqmdvV6Fk4qzmz25DglSDXCGWkKGxQPzwxf9t2wUcn8ZVd8DLvFnHsF+pCeqQFMF5M1hT7QhDFxbQvebNS2xnf95J+yeYZCMi+abtJUUJwPiIp4fVKCtqSmbIU1AYtwh+nKiSe3pmmacsDIWqBsnzuYsNplL5bGOt7J+N/JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740740093; c=relaxed/simple;
	bh=1LKPPgYL+Ui8po1qEZ/cNXOah2bcGAGnJ9k8NjoQfvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pqjo28bcGrwQ2Cn5odXYs72MLTHu3iJgblQie6UdCZBiaewraIgKVnfpY0wbOHLmtedJsYmQLyEMwkYMR69srx4NISi/p+HsAjvNuJUkf6e/6YkJzAMVUpi8dqG57/6S1CDf3tk7WhNol/u9EquNcGxaqv8/9TqqlAoNZXUpR1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e397iLE9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27CBC4CED6;
	Fri, 28 Feb 2025 10:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740740093;
	bh=1LKPPgYL+Ui8po1qEZ/cNXOah2bcGAGnJ9k8NjoQfvA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e397iLE918DZN/fbAxQ/ZOB8pikoJ6EEPAmCArX9PUM9RUld4Tp55+IG4X+smd49Y
	 WkcbUkNBmZJsmetcGq2Xexry4pBXe5D4kHOYpJUXea2ja/i/BH7yRKG44wy1SYQ97H
	 AYSjz3cFBumRR13/ioDQwFxTT6MHaRBtCHnt5W0NMnqsMcwByaIwx1eN/CCX/FBtH8
	 AwwGBAOrc+qNvGW4115PtT2gN3Y1zfDevXjxx674R5Or0DlLY0oTcnkAByaKWDc8p9
	 FWMwkuCIdqS3+d0yKfgCOpGKyBE9hOB4QwhWLAl/DivgI2Fm9ZsrHf5Jzi0YIaD0Iy
	 mTbYDyhcew2ow==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 28 Feb 2025 11:54:17 +0100
Subject: [PATCH net-next v8 09/15] net: airoha: Rename
 airoha_set_gdm_port_fwd_cfg() in airoha_set_vip_for_gdm_port()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-airoha-en7581-flowtable-offload-v8-9-01dc1653f46e@kernel.org>
References: <20250228-airoha-en7581-flowtable-offload-v8-0-01dc1653f46e@kernel.org>
In-Reply-To: <20250228-airoha-en7581-flowtable-offload-v8-0-01dc1653f46e@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 "Chester A. Unal" <chester.a.unal@arinc9.com>, 
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 upstream@airoha.com
X-Mailer: b4 0.14.2

Rename airoha_set_gdm_port() in airoha_set_vip_for_gdm_port().
Get rid of airoha_set_gdm_ports routine.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 49 +++++++-------------------------
 drivers/net/ethernet/airoha/airoha_eth.h |  8 ------
 2 files changed, 11 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 4e74fd1839919a666065a8a63926abe826b5fa65..8a5f7c080b48c20e7aa00686f29594301bd4b82f 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -105,25 +105,23 @@ static void airoha_set_gdm_port_fwd_cfg(struct airoha_eth *eth, u32 addr,
 		      FIELD_PREP(GDM_UCFQ_MASK, val));
 }
 
-static int airoha_set_gdm_port(struct airoha_eth *eth, int port, bool enable)
+static int airoha_set_vip_for_gdm_port(struct airoha_gdm_port *port,
+				       bool enable)
 {
+	struct airoha_eth *eth = port->qdma->eth;
 	u32 vip_port;
 
-	switch (port) {
-	case XSI_PCIE0_PORT:
+	switch (port->id) {
+	case 3:
+		/* FIXME: handle XSI_PCIE1_PORT */
 		vip_port = XSI_PCIE0_VIP_PORT_MASK;
 		break;
-	case XSI_PCIE1_PORT:
-		vip_port = XSI_PCIE1_VIP_PORT_MASK;
-		break;
-	case XSI_USB_PORT:
-		vip_port = XSI_USB_VIP_PORT_MASK;
-		break;
-	case XSI_ETH_PORT:
+	case 4:
+		/* FIXME: handle XSI_USB_PORT */
 		vip_port = XSI_ETH_VIP_PORT_MASK;
 		break;
 	default:
-		return -EINVAL;
+		return 0;
 	}
 
 	if (enable) {
@@ -137,31 +135,6 @@ static int airoha_set_gdm_port(struct airoha_eth *eth, int port, bool enable)
 	return 0;
 }
 
-static int airoha_set_gdm_ports(struct airoha_eth *eth, bool enable)
-{
-	const int port_list[] = {
-		XSI_PCIE0_PORT,
-		XSI_PCIE1_PORT,
-		XSI_USB_PORT,
-		XSI_ETH_PORT
-	};
-	int i, err;
-
-	for (i = 0; i < ARRAY_SIZE(port_list); i++) {
-		err = airoha_set_gdm_port(eth, port_list[i], enable);
-		if (err)
-			goto error;
-	}
-
-	return 0;
-
-error:
-	for (i--; i >= 0; i--)
-		airoha_set_gdm_port(eth, port_list[i], false);
-
-	return err;
-}
-
 static void airoha_fe_maccr_init(struct airoha_eth *eth)
 {
 	int p;
@@ -1539,7 +1512,7 @@ static int airoha_dev_open(struct net_device *dev)
 	int err;
 
 	netif_tx_start_all_queues(dev);
-	err = airoha_set_gdm_ports(qdma->eth, true);
+	err = airoha_set_vip_for_gdm_port(port, true);
 	if (err)
 		return err;
 
@@ -1565,7 +1538,7 @@ static int airoha_dev_stop(struct net_device *dev)
 	int i, err;
 
 	netif_tx_disable(dev);
-	err = airoha_set_gdm_ports(qdma->eth, false);
+	err = airoha_set_vip_for_gdm_port(port, false);
 	if (err)
 		return err;
 
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 74bdfd9e8d2fb3706f5ec6a4e17fe07fbcb38c3d..44834227a58982d4491f3d8174b9e0bea542f785 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -57,14 +57,6 @@ enum {
 	QDMA_INT_REG_MAX
 };
 
-enum {
-	XSI_PCIE0_PORT,
-	XSI_PCIE1_PORT,
-	XSI_USB_PORT,
-	XSI_AE_PORT,
-	XSI_ETH_PORT,
-};
-
 enum {
 	XSI_PCIE0_VIP_PORT_MASK	= BIT(22),
 	XSI_PCIE1_VIP_PORT_MASK	= BIT(23),

-- 
2.48.1


