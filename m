Return-Path: <netdev+bounces-253367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AeyI7Ald2kUcwEAu9opvQ
	(envelope-from <netdev+bounces-253367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 09:28:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C7C856F8
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 09:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 352F73019117
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 08:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCB7311C09;
	Mon, 26 Jan 2026 08:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="sPYF2eEQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E10312819
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769416074; cv=none; b=R8yqp+Cj8ejUEsDjSszFI94qRkHW3oxNMX3xtGo8+sWGl+8Mos1CxNc8dE7Z9rxHEABfOOtWyYlh8FwdzxaeAZIq/YXK0qI6cMBVwVQiezzIgStSASufEjID+ZPAl9m8CZtLHHprB33yZA6FFFRR89Z/R8FfiCM9b3ltuELbNyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769416074; c=relaxed/simple;
	bh=NXBqTeRrMdmbv9KNJEvENd/g8zIiTw3uvoCmEedoIqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pKhbFovktRFTRXisGxuEPOMzJG/JCtp26/kLdWh+h086ga2AuwQDm75HTryIFjxJDochhq/F4yhE6Ff4+ZU7pHSMF1IPKg/VecCaFDKIromzPMqSj8KHpkZzMO+2JHtOkMfwgg+U8MceT1je+WEhvZvvKOSUj9LYstQOAduko0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=sPYF2eEQ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BB59F4E42298;
	Mon, 26 Jan 2026 08:27:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 91AAE60717;
	Mon, 26 Jan 2026 08:27:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1C4F5119A8643;
	Mon, 26 Jan 2026 09:27:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769416066; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mAdxSZE83xUC1VcdJ9laK4kQl5LwI5jSzJL0hyvTGo8=;
	b=sPYF2eEQftLv9YGwAeJneSuibjdKA6zJYhmcxIc3Hi4DOH1wOBIjtM/qQVOrlvVR0ueRY8
	u7HYdLKzvsWMS6aBmXE2NweFknErz9NUiM3UMB8HpnFFVXA+h6SVirBWz/5gCmN3uXzZG3
	BUUkxkEDjZtJtG3VUYDvr3/r7pNipasn9bhChLVC7UheZSe5cWwlVA6SFagae71B4REn7K
	YhiYX5SxMqtixlJLtffbb0DNK1DRDtus2UcGhy8HzqVJYHpvdYu3KYN37KEfE/Qz2wcRr7
	LPbi7lcQsEJUzx4AtGONzsKe4zR7Sp+HmymHHwfFs+zNj9SJclscasyJLMy5XQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Mon, 26 Jan 2026 09:27:33 +0100
Subject: [PATCH net-next v3 5/8] net: dsa: microchip: Add KSZ8463 tail tag
 handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-ksz8463-ptp-v3-5-9f092aeb8492@bootlin.com>
References: <20260126-ksz8463-ptp-v3-0-9f092aeb8492@bootlin.com>
In-Reply-To: <20260126-ksz8463-ptp-v3-0-9f092aeb8492@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253367-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Queue-Id: 38C7C856F8
X-Rspamd-Action: no action

KSZ8463 uses the KSZ9893 DSA TAG driver. However, the KSZ8463 doesn't
use the tail tag to convey timestamps to the host as KSZ9893 does. It
uses the reserved fields in the PTP header instead.

Add a KSZ8463-specifig DSA_TAG driver to handle KSZ8463 timestamps.
There is no information in the tail tag to distinguish PTP packets from
others so use the ptp_classify_raw() helper to find the PTP packets and
extract the timestamp from their PTP headers.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c |  5 ++-
 include/net/dsa.h                      |  2 +
 net/dsa/tag_ksz.c                      | 70 ++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 224be307b3417bf30d62da5c94efc6714d914dc6..5141343d2f40bbd380c0b52f6919b842fb71a8fd 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3580,8 +3580,10 @@ static enum dsa_tag_protocol ksz_get_tag_protocol(struct dsa_switch *ds,
 	if (ksz_is_ksz87xx(dev) || ksz_is_8895_family(dev))
 		proto = DSA_TAG_PROTO_KSZ8795;
 
+	if (dev->chip_id == KSZ8463_CHIP_ID)
+		proto = DSA_TAG_PROTO_KSZ8463;
+
 	if (dev->chip_id == KSZ88X3_CHIP_ID ||
-	    dev->chip_id == KSZ8463_CHIP_ID ||
 	    dev->chip_id == KSZ8563_CHIP_ID ||
 	    dev->chip_id == KSZ9893_CHIP_ID ||
 	    dev->chip_id == KSZ9563_CHIP_ID)
@@ -3611,6 +3613,7 @@ static int ksz_connect_tag_protocol(struct dsa_switch *ds,
 		return 0;
 	case DSA_TAG_PROTO_KSZ9893:
 	case DSA_TAG_PROTO_KSZ9477:
+	case DSA_TAG_PROTO_KSZ8463:
 	case DSA_TAG_PROTO_LAN937X:
 		tagger_data = ksz_tagger_data(ds);
 		tagger_data->xmit_work_fn = ksz_port_deferred_xmit;
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 6b2b5ed64ea4cee6ab59c9e6eaab30f07f82816a..5b5fed6e6f9171f5875d61c1395758065ac5808a 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -57,6 +57,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_BRCM_LEGACY_FCS_VALUE	29
 #define DSA_TAG_PROTO_YT921X_VALUE		30
 #define DSA_TAG_PROTO_MXL_GSW1XX_VALUE		31
+#define DSA_TAG_PROTO_KSZ8463_VALUE		32
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -91,6 +92,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_VSC73XX_8021Q	= DSA_TAG_PROTO_VSC73XX_8021Q_VALUE,
 	DSA_TAG_PROTO_YT921X		= DSA_TAG_PROTO_YT921X_VALUE,
 	DSA_TAG_PROTO_MXL_GSW1XX	= DSA_TAG_PROTO_MXL_GSW1XX_VALUE,
+	DSA_TAG_PROTO_KSZ8463		= DSA_TAG_PROTO_KSZ8463_VALUE,
 };
 
 struct dsa_switch;
diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index 9170a0148cc43b4213ec4bd8e81d338589671f23..f6590549908e016ca224501e6bc296c9c5feafb3 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -16,6 +16,7 @@
 #define KSZ9477_NAME "ksz9477"
 #define KSZ9893_NAME "ksz9893"
 #define LAN937X_NAME "lan937x"
+#define KSZ8463_NAME "ksz8463"
 
 /* Typically only one byte is used for tail tag. */
 #define KSZ_PTP_TAG_LEN			4
@@ -383,6 +384,74 @@ static const struct dsa_device_ops ksz9893_netdev_ops = {
 DSA_TAG_DRIVER(ksz9893_netdev_ops);
 MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KSZ9893, KSZ9893_NAME);
 
+#define KSZ8463_TAIL_TAG_PRIO		GENMASK(4, 3)
+#define KSZ8463_TAIL_TAG_EG_PORT_M	GENMASK(2, 0)
+
+static struct sk_buff *ksz8463_xmit(struct sk_buff *skb,
+				    struct net_device *dev)
+{
+	u16 queue_mapping = skb_get_queue_mapping(skb);
+	u8 prio = netdev_txq_to_tc(dev, queue_mapping);
+	struct dsa_port *dp = dsa_user_to_port(dev);
+	u8 *tag;
+
+	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb))
+		return NULL;
+
+	tag = skb_put(skb, KSZ_INGRESS_TAG_LEN);
+
+	*tag = BIT(dp->index);
+	*tag |= FIELD_PREP(KSZ8463_TAIL_TAG_PRIO, prio);
+
+	return ksz_defer_xmit(dp, skb);
+}
+
+static struct sk_buff *ksz8463_rcv(struct sk_buff *skb, struct net_device *dev)
+{
+	unsigned int len = KSZ_EGRESS_TAG_LEN;
+	struct ptp_header *ptp_hdr;
+	unsigned int ptp_class;
+	unsigned int port;
+	ktime_t tstamp;
+	u8 *tag;
+
+	if (skb_linearize(skb))
+		return NULL;
+
+	/* Tag decoding */
+	tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
+	port = tag[0] & KSZ8463_TAIL_TAG_EG_PORT_M;
+
+	__skb_push(skb, ETH_HLEN);
+	ptp_class = ptp_classify_raw(skb);
+	__skb_pull(skb, ETH_HLEN);
+	if (ptp_class == PTP_CLASS_NONE)
+		goto common_rcv;
+
+	ptp_hdr = ptp_parse_header(skb, ptp_class);
+	if (ptp_hdr) {
+		tstamp = ksz_decode_tstamp(get_unaligned_be32(&ptp_hdr->reserved2));
+		KSZ_SKB_CB(skb)->tstamp = tstamp;
+		ptp_hdr->reserved2 = 0;
+	}
+
+common_rcv:
+	return ksz_common_rcv(skb, dev, port, len);
+}
+
+static const struct dsa_device_ops ksz8463_netdev_ops = {
+	.name	= KSZ8463_NAME,
+	.proto	= DSA_TAG_PROTO_KSZ8463,
+	.xmit	= ksz8463_xmit,
+	.rcv	= ksz8463_rcv,
+	.connect = ksz_connect,
+	.disconnect = ksz_disconnect,
+	.needed_tailroom = KSZ_INGRESS_TAG_LEN,
+};
+
+DSA_TAG_DRIVER(ksz8463_netdev_ops);
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KSZ8463, KSZ8463_NAME);
+
 /* For xmit, 2/6 bytes are added before FCS.
  * ---------------------------------------------------------------------------
  * DA(6bytes)|SA(6bytes)|....|Data(nbytes)|ts(4bytes)|tag0(1byte)|tag1(1byte)|
@@ -457,6 +526,7 @@ static struct dsa_tag_driver *dsa_tag_driver_array[] = {
 	&DSA_TAG_DRIVER_NAME(ksz9477_netdev_ops),
 	&DSA_TAG_DRIVER_NAME(ksz9893_netdev_ops),
 	&DSA_TAG_DRIVER_NAME(lan937x_netdev_ops),
+	&DSA_TAG_DRIVER_NAME(ksz8463_netdev_ops),
 };
 
 module_dsa_tag_drivers(dsa_tag_driver_array);

-- 
2.52.0


