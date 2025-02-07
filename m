Return-Path: <netdev+bounces-164083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D644A2C8CE
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 17:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 820AA7A4E38
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 16:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BEB192D7C;
	Fri,  7 Feb 2025 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLY+/YPu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECA418EFED;
	Fri,  7 Feb 2025 16:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738945631; cv=none; b=oCSTBbNjQgP0T6Q4ReD+eir4nyN6b5+n72Wo2W9dFfXgk3O8cBw4TB/8IZcpxNiDiA+VnObnpPbjNTD1cFGG/u0taUU1VTKaZSIeLcfeYp1LkyihFvvHrq3WZbU2fXGIdpSP14Tfu6TOixckKnpgBjjbZCm/kSFrLQonQTaqxWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738945631; c=relaxed/simple;
	bh=4Qk8X7qpIVCbN/KBSqhoxxEZY1Ovomp+1fX44eKyUmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G22iON+aQ9C09bvCBdrGN8JC+LLF1YdZWJ1BGtmHLY1mfHdGpXlIE0t4oj1Rfb+QQ9TRBdgLTJwJLV79fioxTaA9xiuayTu4dgKW6HQtHOvtrUFNZVMr8+I13b8t7TDC8TfVqtCjZIHZTTs/N6sh+Hv/NMWNqJFyn/bTAYWxh+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLY+/YPu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FAAC4CED1;
	Fri,  7 Feb 2025 16:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738945630;
	bh=4Qk8X7qpIVCbN/KBSqhoxxEZY1Ovomp+1fX44eKyUmk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CLY+/YPu+e8E6LOxIrIQWdtzysanVhH+MsFYa2mt5qgUjr/bv0qNGwnvOYOEeGd7p
	 ywKSjVPna8eW2qPI6TL6OwP3vX1x5TKvLZzcOvKPhzyWGwCSsKP4p9XOCSvaD4YfZR
	 Mry1PFhNHKxYOyyew3OUcOVEG82qP6j6rLg14nnvus8ExPWr77pBwCBx4Uhq3r/k7Q
	 zFCJKf06N4FPcspWM9LeOEJoeiF/YXXMT1l20hb2w0KrT/vRuI3gyDvc3woMMcsSN7
	 +KLqYSTVbUF94nMB5Ln7/vFALMxCe79StoauFXqRTQ+y/Ww2fFO3EWWREvTKlgKI2J
	 aoTTpTcEZjb2w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 07 Feb 2025 17:26:24 +0100
Subject: [PATCH net-next v2 09/15] net: airoha: Rename
 airoha_set_gdm_port_fwd_cfg() in airoha_set_vip_for_gdm_port()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-airoha-en7581-flowtable-offload-v2-9-3a2239692a67@kernel.org>
References: <20250207-airoha-en7581-flowtable-offload-v2-0-3a2239692a67@kernel.org>
In-Reply-To: <20250207-airoha-en7581-flowtable-offload-v2-0-3a2239692a67@kernel.org>
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
index db75a9b1d5766bfaaa92312d625c395e19c88368..52be276039eff7772b3c604cf7db5d456ec155ab 100644
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


