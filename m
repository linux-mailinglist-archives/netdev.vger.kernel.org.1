Return-Path: <netdev+bounces-163194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 959A1A298C9
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 293173A9DC2
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 18:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986EE1FDE39;
	Wed,  5 Feb 2025 18:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaYOLG/M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCDB1FDA66;
	Wed,  5 Feb 2025 18:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738779745; cv=none; b=jYeRqcJVchLvp7prJr43dI3c6c7mBwdDqlQGVnDdwAYXfFevLhp4SKC1zKN1rplF5pOTc9gWb/NglfIU97GFMK6Plq9F0RqwNsiEbztXdefBqDt4/CBX5zwAHLDp8TWXCxwFmxjUDKE476QEieBUanaemgXZrXA+iBwScj28NYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738779745; c=relaxed/simple;
	bh=4Qk8X7qpIVCbN/KBSqhoxxEZY1Ovomp+1fX44eKyUmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dpc/5E8Uepr77UshG0sijTe5sCEqzOYBseFvt1cM/WtLmVqNxwsrJccreLa2JxrHdEYzoEPokfQxb6bzXGieDF6hsQYMU/EPfuiO+jkgKAEgCoNO7zJm1m5PC66Gp/+vlGt6tmkbj+ECwGiSJwq52vVwsiJEc/I6M1tZq2zLP0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaYOLG/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1EBC4CED1;
	Wed,  5 Feb 2025 18:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738779744;
	bh=4Qk8X7qpIVCbN/KBSqhoxxEZY1Ovomp+1fX44eKyUmk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DaYOLG/MV4STzERM8xg+mcrZxf/nAxiqYkKWawOIQry9TYbXSp5Z65otLz0JLLc6e
	 kqUDJHuVpO+LTt3QIp+akH6Rc2skVCsyYaiSiQ4XA+dh5hACYDRBi2xgIEsqtETFz1
	 WmzolBEYO5dF0PtWwfu7NKiJvDk3k8EOhxEvDD1mXcFZqMJi+ZCoJqsH3rdoKBA80H
	 Xh6FM4y0vVKCeufy41SsKhe3FYaiV/3t7WYXo+1WyGRJ5UQGKDroJO9WNJohBbZ5SY
	 VF5mXnfwZYbOvTxs/k4P9ABrBwhisWVGlThWOTuyf5l6imGzvdN8k96pmvSRAFwnDs
	 /7SU9UQGRCAYg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 05 Feb 2025 19:21:27 +0100
Subject: [PATCH net-next 08/13] net: airoha: Rename
 airoha_set_gdm_port_fwd_cfg() in airoha_set_vip_for_gdm_port()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-airoha-en7581-flowtable-offload-v1-8-d362cfa97b01@kernel.org>
References: <20250205-airoha-en7581-flowtable-offload-v1-0-d362cfa97b01@kernel.org>
In-Reply-To: <20250205-airoha-en7581-flowtable-offload-v1-0-d362cfa97b01@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
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


