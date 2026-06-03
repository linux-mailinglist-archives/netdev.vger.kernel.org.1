Return-Path: <netdev+bounces-294561-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Dgx0MpTEH2q3pgAAu9opvQ
	(envelope-from <netdev+bounces-294561-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:07:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFB0634862
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:07:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TA1FpFrO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294561-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294561-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 372A431064AD
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 06:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDA23FB07A;
	Wed,  3 Jun 2026 06:01:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D543FAE14;
	Wed,  3 Jun 2026 06:01:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780466477; cv=none; b=Oc0b1nGHpS3Jrj2bhmQrCpGG9EuggS3U/mvxGtvEwQJyoxt672c9+s9VbtsF0WckcOdDhVZIPlIhbeGOfJ5ekDXljSIfpfW1JjZ+USiGNl9ssfq8KcfhgDZw8FLA54M6cqygyBm3swcAiDByQ3OE979K3PRaPnBGfBB6O/zkhsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780466477; c=relaxed/simple;
	bh=mCf4vt1gRQWzhRGZmGE6HPjmqKyqXkNYs9U1etyGipI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u98REKqvPPDqJNn8eKcp3UiSVM5M/D884X3O0EEHl/nhf634BdPx9mCwXoL9WjwMRrfguFTkZi2cxA5mgMxTet640jIljgpxGBu5Y9hW9q74vvxRZME1en9k0lcKAFI4NVrdkP45vB2aMb509L4x408d2fYSVjASv4UmGr9awdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TA1FpFrO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1D91F00898;
	Wed,  3 Jun 2026 06:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780466473;
	bh=R6BwajFpcPNJcJIDEceoxcP5TFARTBGtkGncJlAqer4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TA1FpFrO2rLnFBxhIV/YSGCmBTzjeR0/5CkuslbrarMpuLdMLIR9GOKdNe9400YQv
	 k3sFito/JLNr8e9T1W6PJaY+ASS8L5Gs2Ze1e+VeYgtJ3roC6Cebq9faVkkcYjPBCX
	 1m5oUKnLoqY53c1Bt/SYmcAUwLhgdygM/pCO1yj2DiWONbPj5VunLpc3tzwghJyjTu
	 Od13NQ31hf4MYd36T3XTrAxKoV6RZNYdzOgFDy4Yen0R6JC5muUqS617/J0wF7iutD
	 iFnI6dUYTNXlb/hyp9JqL7i0nkQiCocw9oNgrZxfKMhl/4bp9XBCTT9VGx5EkoRVRE
	 icsmLC3ejci4g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 03 Jun 2026 08:00:19 +0200
Subject: [PATCH net-next v9 5/6] net: airoha: Introduce WAN device flag
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-airoha-eth-multi-serdes-v9-5-5d476bc2f426@kernel.org>
References: <20260603-airoha-eth-multi-serdes-v9-0-5d476bc2f426@kernel.org>
In-Reply-To: <20260603-airoha-eth-multi-serdes-v9-0-5d476bc2f426@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 Benjamin Larsson <benjamin.larsson@genexis.eu>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Xuegang Lu <xuegang.lu@airoha.com>
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294561-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:lorenzo@kernel.org,m:ansuelsmth@gmail.com,m:benjamin.larsson@genexis.eu,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:xuegang.lu@airoha.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,airoha.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7BFB0634862

Introduce WAN flag to specify if a given device is used to transmit/receive
WAN or LAN traffic. Current codebase supports specifying LAN/WAN device
configuration in ndo_init() callback during device bootstrap.
In order to consider setups where LAN configuration is used even for
GDM3/GDM4 devices, check airoha_is_lan_gdm_dev() to select pse_port in
airoha_ppe_foe_entry_prepare().
Please note after this patch, it will be possible to specify multiple LAN
devices but just a single WAN one. Please note this change is not visible
to the user since airoha_eth driver currently supports just the internal
phy available via the MT7530 DSA switch and there are no WAN interfaces
officially supported since PCS/external phy is not merged mainline yet
(it will be posted with following patches).

Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 73 ++++++++++++++++++++++++++------
 drivers/net/ethernet/airoha/airoha_eth.h | 13 +++---
 drivers/net/ethernet/airoha/airoha_ppe.c |  2 +-
 3 files changed, 66 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 44b77a5cc4c5..64ee526da241 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1899,36 +1899,81 @@ static int airoha_enable_gdm2_loopback(struct airoha_gdm_dev *dev)
 	return 0;
 }
 
-static int airoha_dev_init(struct net_device *netdev)
+static struct airoha_gdm_dev *
+airoha_get_wan_gdm_dev(struct airoha_eth *eth)
 {
-	struct airoha_gdm_dev *dev = netdev_priv(netdev);
-	struct airoha_gdm_port *port = dev->port;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
+		struct airoha_gdm_port *port = eth->ports[i];
+		int j;
+
+		if (!port)
+			continue;
+
+		for (j = 0; j < ARRAY_SIZE(port->devs); j++) {
+			struct airoha_gdm_dev *dev = port->devs[j];
+
+			if (dev && !airoha_is_lan_gdm_dev(dev))
+				return dev;
+		}
+	}
+
+	return NULL;
+}
+
+static void airoha_dev_set_qdma(struct airoha_gdm_dev *dev)
+{
+	struct net_device *netdev = netdev_from_priv(dev);
 	struct airoha_eth *eth = dev->eth;
 	int ppe_id;
 
 	/* QDMA0 is used for lan ports while QDMA1 is used for WAN ports */
 	dev->qdma = &eth->qdma[!airoha_is_lan_gdm_dev(dev)];
 	netdev->irq = dev->qdma->irq_banks[0].irq;
-	airoha_set_macaddr(dev, netdev->dev_addr);
+
+	ppe_id = !airoha_is_lan_gdm_dev(dev) && airoha_ppe_is_enabled(eth, 1);
+	airoha_ppe_set_cpu_port(dev, ppe_id, airoha_get_fe_port(dev));
+}
+
+static int airoha_dev_init(struct net_device *netdev)
+{
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_gdm_port *port = dev->port;
 
 	switch (port->id) {
 	case AIROHA_GDM3_IDX:
-	case AIROHA_GDM4_IDX:
-		/* If GDM2 is active we can't enable loopback */
-		if (!eth->ports[1]) {
-			int err;
+	case AIROHA_GDM4_IDX: {
+		struct airoha_eth *eth = dev->eth;
 
-			err = airoha_enable_gdm2_loopback(dev);
-			if (err)
-				return err;
-		}
+		/* GDM2 supports a single net_device */
+		if (eth->ports[1] && eth->ports[1]->devs[0])
+			break;
+
+		if (airoha_get_wan_gdm_dev(eth))
+			break;
+
+		fallthrough;
+	}
+	case AIROHA_GDM2_IDX:
+		/* GDM2 is always used as wan */
+		dev->flags |= AIROHA_PRIV_F_WAN;
 		break;
 	default:
 		break;
 	}
 
-	ppe_id = !airoha_is_lan_gdm_dev(dev) && airoha_ppe_is_enabled(eth, 1);
-	airoha_ppe_set_cpu_port(dev, ppe_id, airoha_get_fe_port(dev));
+	airoha_dev_set_qdma(dev);
+	airoha_set_macaddr(dev, netdev->dev_addr);
+
+	if (!airoha_is_lan_gdm_dev(dev) &&
+	    (port->id == AIROHA_GDM3_IDX || port->id == AIROHA_GDM4_IDX)) {
+		int err;
+
+		err = airoha_enable_gdm2_loopback(dev);
+		if (err)
+			return err;
+	}
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 666e9246e70e..3e8262f583a7 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -538,6 +538,10 @@ struct airoha_qdma {
 	DECLARE_BITMAP(qos_channel_map, AIROHA_NUM_QOS_CHANNELS);
 };
 
+enum airoha_priv_flags {
+	AIROHA_PRIV_F_WAN = BIT(0),
+};
+
 struct airoha_gdm_dev {
 	struct airoha_gdm_port *port;
 	struct airoha_qdma *qdma;
@@ -548,6 +552,7 @@ struct airoha_gdm_dev {
 	u64 cpu_tx_packets;
 	u64 fwd_tx_packets;
 
+	u32 flags;
 	int nbq;
 };
 
@@ -654,13 +659,7 @@ static inline u16 airoha_qdma_get_txq(struct airoha_qdma *qdma, u16 qid)
 
 static inline bool airoha_is_lan_gdm_dev(struct airoha_gdm_dev *dev)
 {
-	struct airoha_gdm_port *port = dev->port;
-
-	/* GDM1 port on EN7581 SoC is connected to the lan dsa switch.
-	 * GDM{2,3,4} can be used as wan port connected to an external
-	 * phy module.
-	 */
-	return port->id == 1;
+	return !(dev->flags & AIROHA_PRIV_F_WAN);
 }
 
 static inline bool airoha_is_7581(struct airoha_eth *eth)
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 96abf451fdac..f54622904733 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -355,7 +355,7 @@ static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
 				return -EINVAL;
 
 			port = dev->port;
-			if (dsa_port >= 0 || eth->ports[1])
+			if (dsa_port >= 0 || airoha_is_lan_gdm_dev(dev))
 				pse_port = port->id == 4 ? FE_PSE_PORT_GDM4
 							 : port->id;
 			else

-- 
2.54.0


