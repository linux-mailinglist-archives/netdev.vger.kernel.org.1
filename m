Return-Path: <netdev+bounces-261490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IORWLPSFoGknkgQAu9opvQ
	(envelope-from <netdev+bounces-261490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:42:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A58E1ACADC
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D177310977C
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADF935A3A4;
	Thu, 26 Feb 2026 16:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OquxiftT"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE976355F52
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 16:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772124130; cv=none; b=huS3Lq1Ce0KTztTlbKNiHBpft8cBkVATGK3+Z/pEoA7HnVMWOMncxbL4x6ir7knQYwB5Wd+XdOGycn0KpuIhj7JO/D4eqc3phy90b8+wNcZeJ34yAiaEajmm2ZpgJt83ZiAh88VWzuTSbZTOXywwjPNybb2PFMuxy2T7x3joyq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772124130; c=relaxed/simple;
	bh=SS2r0x9fJePpa8zmgS9MB4sz3aG3ECRVaSr1UTx4t2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b49ZZ737CO9hydoj/23QH3Q7KtoufZ/hLObHbgDMMPAW4iGaOxPNJuky6PVlzvlXGcPotLQJ/g3jCVhhDXOjdIs9BG9+9ZpxdZ1Kt0feFpShJkZXSniOp+zQRwKzMNeF1pnXAUkkBOOzECH5XH8uZTNqc1VB0lqs+9Mx+exUxU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OquxiftT; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id AC6434E4122F;
	Thu, 26 Feb 2026 16:42:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 801565FDE9;
	Thu, 26 Feb 2026 16:42:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E1051103693FD;
	Thu, 26 Feb 2026 17:42:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772124126; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RCz7ZiFxHupdO6m0tzR5VygQNoN38bElGRsCY7k3JYI=;
	b=OquxiftTQbqzdCxMyWM0e1MQmzcv5cbNzxwlStHDF4PfuhBD45Lj8tlTwo2mgSlGbSgRlU
	S/0JKAr5kyN6Q27Fg5HAY81oC8fNfBQ8nxGRHELjir6v/Jjiwv/dUJ812R52jMsVJMdhK2
	bb5gU3hIyLPteYC9EZevLbd1axE/hpDbNG4Z1Ha6+Ps9ioJFPZUoeiMoc54KwNq6V5Uy+k
	1mYaKfSeNLFGcWtPnS53D82+titThbE1cPUWlcQzVM9wH5afQPCagIFKb3+7iTSUN/uuCv
	ad+UIWBq3ZfsTbqK6orpVd6zd2JcNbH+vWw6YJw95PuPU1vjFJKFAS88G0+/Uw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 26 Feb 2026 17:41:52 +0100
Subject: [PATCH net-next v5 5/9] net: dsa: tag_ksz: Share code for KSZ8795
 and KSZ9893 xmit operations
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-ksz8463-ptp-v5-5-1bc24fb9627d@bootlin.com>
References: <20260226-ksz8463-ptp-v5-0-1bc24fb9627d@bootlin.com>
In-Reply-To: <20260226-ksz8463-ptp-v5-0-1bc24fb9627d@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261490-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim,bootlin.com:email]
X-Rspamd-Queue-Id: 5A58E1ACADC
X-Rspamd-Action: no action

KSZ8795 and KSZ9893 have very similar tag handling in the xmit path,
leading to code duplication.

There are only two differences between the two ksz*_xmit():
- the KSZ8795 doesn't handle priorities between frames
- ksz8795_xmit() directly returns the SKB instead of calling
ksz_defer_xmit(). Yet, ksz_defer_xmit() also returns directly the SKB
if no clone is present inside the SKB. Clones are only created by the KSZ
driver when the PTP feature is enabled. Since KSZ8795 doesn't support
PTP, returning the SKB directly or ksz_defer_xmit() is the same.

The upcoming support for the KSZ8463 also requires a similar xmit().

Move KSZ8795 operations below the definition of ksz_defer_xmit().

Gather the common code from ksz8795_xmit() and ksz9893_xmit() into a new
ksz_common_xmit() function that takes three input arguments:
- do_tstamp to tell whether ksz_xmit_timestamp() should be called
- prio to give the priority tag (if any)
- override_mask to give the location of the override bit (if any)

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 net/dsa/tag_ksz.c | 161 +++++++++++++++++++++++++++---------------------------
 1 file changed, 80 insertions(+), 81 deletions(-)

diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index d2475c3bbb7d227bb42b0368914275b00fb2784a..6ec9bcb324a953d988ef665a177566159e27027f 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -99,68 +99,6 @@ static struct sk_buff *ksz_common_rcv(struct sk_buff *skb,
 	return skb;
 }
 
-/*
- * For Ingress (Host -> KSZ8795), 1 byte is added before FCS.
- * ---------------------------------------------------------------------------
- * DA(6bytes)|SA(6bytes)|....|Data(nbytes)|tag(1byte)|FCS(4bytes)
- * ---------------------------------------------------------------------------
- * tag : each bit represents port (eg, 0x01=port1, 0x02=port2, 0x10=port5)
- *
- * For Egress (KSZ8795 -> Host), 1 byte is added before FCS.
- * ---------------------------------------------------------------------------
- * DA(6bytes)|SA(6bytes)|....|Data(nbytes)|tag0(1byte)|FCS(4bytes)
- * ---------------------------------------------------------------------------
- * tag0 : zero-based value represents port
- *	  (eg, 0x0=port1, 0x2=port3, 0x3=port4)
- */
-
-#define KSZ8795_TAIL_TAG_EG_PORT_M	GENMASK(1, 0)
-#define KSZ8795_TAIL_TAG_OVERRIDE	BIT(6)
-#define KSZ8795_TAIL_TAG_LOOKUP		BIT(7)
-
-static struct sk_buff *ksz8795_xmit(struct sk_buff *skb, struct net_device *dev)
-{
-	struct ethhdr *hdr;
-	u8 *tag;
-
-	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb))
-		return NULL;
-
-	/* Tag encoding */
-	tag = skb_put(skb, KSZ_INGRESS_TAG_LEN);
-	hdr = skb_eth_hdr(skb);
-
-	*tag = dsa_xmit_port_mask(skb, dev);
-	if (is_link_local_ether_addr(hdr->h_dest))
-		*tag |= KSZ8795_TAIL_TAG_OVERRIDE;
-
-	return skb;
-}
-
-static struct sk_buff *ksz8795_rcv(struct sk_buff *skb, struct net_device *dev)
-{
-	u8 *tag;
-
-	if (skb_linearize(skb))
-		return NULL;
-
-	tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
-
-	return ksz_common_rcv(skb, dev, tag[0] & KSZ8795_TAIL_TAG_EG_PORT_M,
-			      KSZ_EGRESS_TAG_LEN);
-}
-
-static const struct dsa_device_ops ksz8795_netdev_ops = {
-	.name	= KSZ8795_NAME,
-	.proto	= DSA_TAG_PROTO_KSZ8795,
-	.xmit	= ksz8795_xmit,
-	.rcv	= ksz8795_rcv,
-	.needed_tailroom = KSZ_INGRESS_TAG_LEN,
-};
-
-DSA_TAG_DRIVER(ksz8795_netdev_ops);
-MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KSZ8795, KSZ8795_NAME);
-
 /*
  * For Ingress (Host -> KSZ9477), 2/6 bytes are added before FCS.
  * ---------------------------------------------------------------------------
@@ -274,6 +212,35 @@ static struct sk_buff *ksz_defer_xmit(struct dsa_port *dp, struct sk_buff *skb)
 	return NULL;
 }
 
+static struct sk_buff *ksz_common_xmit(struct sk_buff *skb,
+				       struct net_device *dev,
+				       bool do_tstamp,
+				       u8 prio,
+				       u8 override_mask)
+{
+	struct dsa_port *dp = dsa_user_to_port(dev);
+	struct ethhdr *hdr;
+	u8 *tag;
+
+	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb))
+		return NULL;
+
+	/* Tag encoding */
+	if (do_tstamp)
+		ksz_xmit_timestamp(dp, skb);
+
+	tag = skb_put(skb, KSZ_INGRESS_TAG_LEN);
+	hdr = skb_eth_hdr(skb);
+
+	*tag = dsa_xmit_port_mask(skb, dev);
+	*tag |= prio;
+
+	if (is_link_local_ether_addr(hdr->h_dest))
+		*tag |= override_mask;
+
+	return ksz_defer_xmit(dp, skb);
+}
+
 static struct sk_buff *ksz9477_xmit(struct sk_buff *skb,
 				    struct net_device *dev)
 {
@@ -339,35 +306,67 @@ static const struct dsa_device_ops ksz9477_netdev_ops = {
 DSA_TAG_DRIVER(ksz9477_netdev_ops);
 MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KSZ9477, KSZ9477_NAME);
 
-#define KSZ9893_TAIL_TAG_PRIO		GENMASK(4, 3)
-#define KSZ9893_TAIL_TAG_OVERRIDE	BIT(5)
-#define KSZ9893_TAIL_TAG_LOOKUP		BIT(6)
+/*
+ * For Ingress (Host -> KSZ8795), 1 byte is added before FCS.
+ * ---------------------------------------------------------------------------
+ * DA(6bytes)|SA(6bytes)|....|Data(nbytes)|tag(1byte)|FCS(4bytes)
+ * ---------------------------------------------------------------------------
+ * tag : each bit represents port (eg, 0x01=port1, 0x02=port2, 0x10=port5)
+ *
+ * For Egress (KSZ8795 -> Host), 1 byte is added before FCS.
+ * ---------------------------------------------------------------------------
+ * DA(6bytes)|SA(6bytes)|....|Data(nbytes)|tag0(1byte)|FCS(4bytes)
+ * ---------------------------------------------------------------------------
+ * tag0 : zero-based value represents port
+ *	  (eg, 0x0=port1, 0x2=port3, 0x3=port4)
+ */
 
-static struct sk_buff *ksz9893_xmit(struct sk_buff *skb,
-				    struct net_device *dev)
+#define KSZ8795_TAIL_TAG_EG_PORT_M	GENMASK(1, 0)
+#define KSZ8795_TAIL_TAG_OVERRIDE	BIT(6)
+#define KSZ8795_TAIL_TAG_LOOKUP		BIT(7)
+
+static struct sk_buff *ksz8795_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	return ksz_common_xmit(skb, dev, false, 0, KSZ8795_TAIL_TAG_OVERRIDE);
+}
+
+static struct sk_buff *ksz8795_rcv(struct sk_buff *skb, struct net_device *dev)
 {
-	u16 queue_mapping = skb_get_queue_mapping(skb);
-	u8 prio = netdev_txq_to_tc(dev, queue_mapping);
-	struct dsa_port *dp = dsa_user_to_port(dev);
-	struct ethhdr *hdr;
 	u8 *tag;
 
-	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb))
+	if (skb_linearize(skb))
 		return NULL;
 
-	/* Tag encoding */
-	ksz_xmit_timestamp(dp, skb);
+	tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
 
-	tag = skb_put(skb, KSZ_INGRESS_TAG_LEN);
-	hdr = skb_eth_hdr(skb);
+	return ksz_common_rcv(skb, dev, tag[0] & KSZ8795_TAIL_TAG_EG_PORT_M,
+			      KSZ_EGRESS_TAG_LEN);
+}
 
-	*tag = dsa_xmit_port_mask(skb, dev);
-	*tag |= FIELD_PREP(KSZ9893_TAIL_TAG_PRIO, prio);
+static const struct dsa_device_ops ksz8795_netdev_ops = {
+	.name	= KSZ8795_NAME,
+	.proto	= DSA_TAG_PROTO_KSZ8795,
+	.xmit	= ksz8795_xmit,
+	.rcv	= ksz8795_rcv,
+	.needed_tailroom = KSZ_INGRESS_TAG_LEN,
+};
 
-	if (is_link_local_ether_addr(hdr->h_dest))
-		*tag |= KSZ9893_TAIL_TAG_OVERRIDE;
+DSA_TAG_DRIVER(ksz8795_netdev_ops);
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KSZ8795, KSZ8795_NAME);
 
-	return ksz_defer_xmit(dp, skb);
+#define KSZ9893_TAIL_TAG_PRIO		GENMASK(4, 3)
+#define KSZ9893_TAIL_TAG_OVERRIDE	BIT(5)
+#define KSZ9893_TAIL_TAG_LOOKUP		BIT(6)
+
+static struct sk_buff *ksz9893_xmit(struct sk_buff *skb,
+				    struct net_device *dev)
+{
+	u16 queue_mapping = skb_get_queue_mapping(skb);
+	u8 prio = netdev_txq_to_tc(dev, queue_mapping);
+
+	return ksz_common_xmit(skb, dev, true,
+			       FIELD_PREP(KSZ9893_TAIL_TAG_PRIO, prio),
+			       KSZ9893_TAIL_TAG_OVERRIDE);
 }
 
 static const struct dsa_device_ops ksz9893_netdev_ops = {

-- 
2.53.0


