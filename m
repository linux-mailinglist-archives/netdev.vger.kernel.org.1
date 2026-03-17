Return-Path: <netdev+bounces-268695-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HZWHpCWuWmhKwIAu9opvQ
	(envelope-from <netdev+bounces-268695-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 18:59:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0469F2B0789
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 18:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35A1031C6CB0
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 17:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF08E3368AE;
	Tue, 17 Mar 2026 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aRAd1tCg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A+tiffoN"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380601ACEDE
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768551; cv=none; b=qrIv7lbs7yeo+9XSZWiosABNq9MAN97Ae7+DBwJnix2h8Lqr92fbNL6AUQDxye6sfaab6/tDhz+OeIisI6grKPDGJTpaAmJgL4SmOGfyONPMGgFIOJQq1bRhtwm/GP4ruwzTZfGeS15Ge5hci9apZnL5OFOJ4DbURpvVeyY/ps0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768551; c=relaxed/simple;
	bh=HJTwP+SnF5u/CWtvu4E/OKgWxZga+EYl+T7NOCC++xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgr8UmpaOzGYqniBBVteZlkzollROqiPV1O2FKUtnDHpqhAUjX3MlydouoqgKrMP3HYAXrTYkGumOpKzGBmdXVOS7Jy88cvK7XDnNMHNyhy2bZdmvaBBBV7COhKSf8Rj6dHQrp8vJJbDkZ9DWzvVwehl1iPklQZ0LhHPGIJ2rLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aRAd1tCg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A+tiffoN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Mar 2026 18:29:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773768548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h5xTRdBHvZnvyS3vBwOWDJwP6EDNArqKmIuDSIIZjLQ=;
	b=aRAd1tCgMMYF1B/aM6imvqq2D5XFQ4xA8gRwMRoFvJe6RNL/2kIys4OwI507KB+FvTOKGA
	+gyqY2UwfpHAkCEa7XmFf3gHCBwvqXNNehFZvFVBaD7JHE/erce8sVcvOxyr78X9KuZ/7S
	sk4SEyLMl5EbJqGDnumXG07syhICaxYyIGXxfA6YJ/bbPbixusRLWvM0xHjkQfLi/9KwJp
	EWXaQCFAvSicwoPQ8iq9lh02dg5oBySmkYHN1hv4t15Pto8QDVrcmJe/mYLPoWAs/OVDHa
	I2ZiDV5GWw4svTQRJgMZTAiefSU9DPDQQvpLAX3sAcm3XiWrZlZdJiDejTSemg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773768548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h5xTRdBHvZnvyS3vBwOWDJwP6EDNArqKmIuDSIIZjLQ=;
	b=A+tiffoNfibtkKUEn3RBJoyMSbqisfttEIWOflVQV74hbwpcWBuYCfCGVa6sx1GW+0wtJP
	ZXfAWPqOzvdZTDBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, "(JC), Jayachandran" <j-rameshbabu@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>, Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>, Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH RFC net-next v2 2/2] af_packet: Add port specific
 handling for HSR
Message-ID: <20260317172906.eG2LxlZ7@linutronix.de>
References: <20260309-hsr_ptp-v2-0-798262aad3a4@linutronix.de>
 <20260309-hsr_ptp-v2-2-798262aad3a4@linutronix.de>
 <willemdebruijn.kernel.3b7b5294c6434@gmail.com>
 <20260310105544.EVXIekwG@linutronix.de>
 <willemdebruijn.kernel.3693c9aa8271@gmail.com>
 <20260312154253.UC-QUPvD@linutronix.de>
 <willemdebruijn.kernel.be379ee17449@gmail.com>
 <20260313092226.SscHp2zQ@linutronix.de>
 <20260313160410.LEhav8Xz@linutronix.de>
 <willemdebruijn.kernel.1fbf050c50d62@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.1fbf050c50d62@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268695-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,ti.com,davemloft.net,lunn.ch,google.com,redhat.com,kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Queue-Id: 0469F2B0789
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-16 16:12:41 [-0400], Willem de Bruijn wrote:
> > The suggested changes to af_packet, that remains a hard no?
> 
> Yes. Packet sockets are largely superseded by XDP and AF_XDP when it
> comes to new functionality. And were never open for such protocol
> specific logic.

ptp4l uses AF_PACKET and while I am not against AF_XDP I am not sure if
it helps. I don't have any protocol stack so extending SOL_PACKET was
the only option left.

> Protocol independent extensions, such as reading skb->mark as part of
> extended auxdata, could be up for debate. But again, we already have
> XDP and AF_XDP which allow passing arbitrary metadata to/from
> userspace. That is preferable over adding new structs to the ABI.

Is this struct xsk_tx_metadata and something similar for RX? If so, I
would require HSR fields for both.
My understanding is that you bind XDP to device+queue. I would require
four sockets (generic+event for both slaves) so this does not work,
right? Also I would need to extend HSR stack so support XDP in a similar
fashion as network driver do?

> If you only want to attach to a single (hsr0) device, I still think
> passing the data inline might work. Either by overriding existing
> fields such as a MAC addr (a hack for sure) or something in the HSR
> header (it as the direction? or by inserting a custom header (or
> trailer) akin to virtio_net_hdr for tun/tap. But custom to your
> workload.

But here you have PACKET_VNET_HDR_SZ to configure virtio_net_hdr. This
is kind of what I ask for with PACKET_HSR_INFO + PACKET_HSR_BIND_PORT
(and I added static branches so nobody has to suffer with CONFIG_HSR
enabled but no HSR enabled socket)..

The diff below would be what means to bypass AF_PACKET entirely and use
eth0/ eth1 to send via SLAVE_A/ B and hsr0 with SO_MARK to send with
system's HSR header but only on one of the two ports.
With HSR-offloading enabled we need to attach the SO_MARK hints also on
eth0/ eth1 devices, too. Otherwise the offloading part will send the
packet on both ports and attach a header (as designed).

Now I have now 8 sockets in userland instead of 4.
I added icssg to show the offloading case:

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 79df641b4fb97..a2e50cae01686 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -909,13 +909,17 @@ enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev
 	 */
 	dst_tag_id = emac->port_id | (q_idx << 8);
 
-	if (prueth->is_hsr_offload_mode &&
-	    (ndev->features & NETIF_F_HW_HSR_DUP))
-		dst_tag_id = PRUETH_UNDIRECTED_PKT_DST_TAG;
+	if (prueth->is_hsr_offload_mode) {
+		bool has_header;
+		bool has_port;
 
-	if (prueth->is_hsr_offload_mode &&
-	    (ndev->features & NETIF_F_HW_HSR_TAG_INS))
-		epib[1] |= PRUETH_UNDIRECTED_PKT_TAG_INS;
+		hsr_skb_get_header_port_mark(skb, &has_header, &has_port);
+		if (ndev->features & NETIF_F_HW_HSR_DUP && !has_port)
+			dst_tag_id = PRUETH_UNDIRECTED_PKT_DST_TAG;
+
+		if (ndev->features & NETIF_F_HW_HSR_TAG_INS && !has_header)
+			epib[1] |= PRUETH_UNDIRECTED_PKT_TAG_INS;
+	}
 
 	cppi5_desc_set_tags_ids(&first_desc->hdr, 0, dst_tag_id);
 	k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &buf_dma);
diff --git a/include/linux/if_hsr.h b/include/linux/if_hsr.h
index d7941fd880329..814b30f65f102 100644
--- a/include/linux/if_hsr.h
+++ b/include/linux/if_hsr.h
@@ -22,6 +22,11 @@ enum hsr_port_type {
 	HSR_PT_PORTS,	/* This must be the last item in the enum */
 };
 
+struct hsr_ptp_cb {
+	u8	ptp;
+	u8	port;
+};
+
 /* HSR Tag.
  * As defined in IEC-62439-3:2010, the HSR tag is really { ethertype = 0x88FB,
  * path, LSDU_size, sequence Nr }. But we let eth_header() create { h_dest,
@@ -43,6 +48,57 @@ extern bool is_hsr_master(struct net_device *dev);
 extern int hsr_get_version(struct net_device *dev, enum hsr_version *ver);
 struct net_device *hsr_get_port_ndev(struct net_device *ndev,
 				     enum hsr_port_type pt);
+
+static inline unsigned int hsr_skb_get_TX_port(struct sk_buff *skb)
+{
+	struct hsr_ptp_cb *cb;
+
+	if (!skb)
+		return 0;
+
+	cb = (struct hsr_ptp_cb*)skb->cb;
+	if (!cb->ptp)
+		return 0;
+	return cb->port;
+}
+
+static inline void hsr_skb_set_TX_port(struct sk_buff *skb,
+				       enum hsr_port_type port)
+{
+	struct hsr_ptp_cb *cb;
+
+	cb = (struct hsr_ptp_cb*)skb->cb;
+	cb->ptp = 1;
+	cb->port = port;
+}
+
+static inline void hsr_skb_non_ptp(struct sk_buff *skb)
+{
+	struct hsr_ptp_cb *cb;
+
+	cb = (struct hsr_ptp_cb*)skb->cb;
+	cb->ptp = 0;
+}
+
+static inline void hsr_skb_get_header_port_mark(struct sk_buff *skb, bool *has_header,
+						bool *has_port)
+{
+	u32 mark = skb->mark;
+	u32 val;
+
+	val = mark & 0b11;
+	if (val == 1 || val == 2)
+		*has_port = true;
+	else
+		*has_port = false;
+
+	val = mark & 0b100;
+	if (val)
+		*has_header = true;
+	else
+		*has_header = false;
+}
+
 #else
 static inline bool is_hsr_master(struct net_device *dev)
 {
@@ -59,6 +115,13 @@ static inline struct net_device *hsr_get_port_ndev(struct net_device *ndev,
 {
 	return ERR_PTR(-EINVAL);
 }
+
+static inline void hsr_skb_get_header_port_mark(struct sk_buff *skb, bool *has_header,
+						bool *has_port)
+{
+	*has_port = false;
+	*has_header = false;
+}
 #endif /* CONFIG_HSR */
 
 #endif /*_LINUX_IF_HSR_H_*/
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 2c43776b7c4fb..e01d3a33ac941 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -229,6 +229,14 @@ static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
 	if (master) {
 		skb->dev = master->dev;
+
+		if (skb->mark == 1)
+			hsr_skb_set_TX_port(skb, HSR_PT_SLAVE_A);
+		else if (skb->mark == 2)
+			hsr_skb_set_TX_port(skb, HSR_PT_SLAVE_B);
+		else
+			hsr_skb_non_ptp(skb);
+
 		skb_reset_mac_header(skb);
 		skb_reset_mac_len(skb);
 		spin_lock_bh(&hsr->seqnr_lock);
@@ -355,6 +363,7 @@ static void send_hsr_supervision_frame(struct hsr_port *port,
 		return;
 	}
 
+	hsr_skb_non_ptp(skb);
 	hsr_forward_skb(skb, port);
 	spin_unlock_bh(&hsr->seqnr_lock);
 	return;
@@ -396,6 +405,7 @@ static void send_prp_supervision_frame(struct hsr_port *master,
 		return;
 	}
 
+	hsr_skb_non_ptp(skb);
 	hsr_forward_skb(skb, master);
 	spin_unlock_bh(&hsr->seqnr_lock);
 }
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index c67c0d35921de..d0d6a8342bb33 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -12,6 +12,7 @@
 #include <linux/skbuff.h>
 #include <linux/etherdevice.h>
 #include <linux/if_vlan.h>
+#include <net/sock.h>
 #include "hsr_main.h"
 #include "hsr_framereg.h"
 
@@ -333,7 +334,10 @@ struct sk_buff *hsr_create_tagged_frame(struct hsr_frame_info *frame,
 		hsr_set_path_id(hsr_ethhdr, port);
 		return skb_clone(frame->skb_hsr, GFP_ATOMIC);
 	} else if (port->dev->features & NETIF_F_HW_HSR_TAG_INS) {
-		return skb_clone(frame->skb_std, GFP_ATOMIC);
+		skb = skb_clone(frame->skb_std, GFP_ATOMIC);
+		if (hsr_skb_get_TX_port(skb))
+			skb_set_owner_w(skb, frame->skb_std->sk);
+		return skb;
 	}
 
 	/* Create the new skb with enough headroom to fit the HSR tag */
@@ -355,6 +359,15 @@ struct sk_buff *hsr_create_tagged_frame(struct hsr_frame_info *frame,
 	memmove(dst, src, movelen);
 	skb_reset_mac_header(skb);
 
+	if (hsr_skb_get_TX_port(skb)) {
+		/* Packets are bound to a port and the sender may expect time
+		 * information.
+		 */
+		skb_shinfo(skb)->tx_flags = skb_shinfo(frame->skb_std)->tx_flags;
+		skb_shinfo(skb)->tskey = skb_shinfo(frame->skb_std)->tskey;
+		skb_set_owner_w(skb, frame->skb_std->sk);
+	}
+
 	/* skb_put_padto free skb on error and hsr_fill_tag returns NULL in
 	 * that case
 	 */
@@ -377,12 +390,23 @@ struct sk_buff *prp_create_tagged_frame(struct hsr_frame_info *frame,
 		}
 		return skb_clone(frame->skb_prp, GFP_ATOMIC);
 	} else if (port->dev->features & NETIF_F_HW_HSR_TAG_INS) {
-		return skb_clone(frame->skb_std, GFP_ATOMIC);
+		skb = skb_clone(frame->skb_std, GFP_ATOMIC);
+		if (hsr_skb_get_TX_port(skb))
+			skb_set_owner_w(skb, frame->skb_std->sk);
+		return skb;
 	}
 
 	skb = skb_copy_expand(frame->skb_std, skb_headroom(frame->skb_std),
 			      skb_tailroom(frame->skb_std) + HSR_HLEN,
 			      GFP_ATOMIC);
+	if (hsr_skb_get_TX_port(skb)) {
+		/* Packets are bound to a port and the sender may expect time
+		 * information.
+		 */
+		skb_shinfo(skb)->tx_flags = skb_shinfo(frame->skb_std)->tx_flags;
+		skb_shinfo(skb)->tskey = skb_shinfo(frame->skb_std)->tskey;
+		skb_set_owner_w(skb, frame->skb_std->sk);
+	}
 	return prp_fill_rct(skb, frame, port);
 }
 
@@ -508,10 +532,13 @@ bool hsr_drop_frame(struct hsr_frame_info *frame, struct hsr_port *port)
  */
 static void hsr_forward_do(struct hsr_frame_info *frame)
 {
+	unsigned int req_tx_port;
 	struct hsr_port *port;
 	struct sk_buff *skb;
 	bool sent = false;
 
+	req_tx_port = hsr_skb_get_TX_port(frame->skb_std);
+
 	hsr_for_each_port(frame->port_rcv->hsr, port) {
 		struct hsr_priv *hsr = port->hsr;
 		/* Don't send frame back the way it came */
@@ -532,6 +559,16 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
 		if ((port->dev->features & NETIF_F_HW_HSR_DUP) && sent)
 			continue;
 
+		/* RX PTP packets have the received port recorded */
+		if (frame->skb_hsr)
+			skb = frame->skb_hsr;
+		else if (frame->skb_prp)
+			skb = frame->skb_prp;
+
+		/* PTP TX packets have an outgoing port specified */
+		if (req_tx_port != HSR_PT_NONE && req_tx_port != port->type)
+			continue;
+
 		/* Don't send frame over port where it has been sent before.
 		 * Also for SAN, this shouldn't be done.
 		 */
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index 464f683e016db..f4879d1ee8ab6 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -44,8 +44,7 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)
 
 	if (hsr_addr_is_self(port->hsr, eth_hdr(skb)->h_source)) {
 		/* Directly kill frames sent by ourselves */
-		kfree_skb(skb);
-		goto finish_consume;
+		goto finish_free_consume;
 	}
 
 	/* For HSR, only tagged frames are expected (unless the device offloads
@@ -70,15 +69,36 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)
 	/* Only the frames received over the interlink port will assign a
 	 * sequence number and require synchronisation vs other sender.
 	 */
+	hsr_skb_non_ptp(skb);
 	if (port->type == HSR_PT_INTERLINK) {
 		spin_lock_bh(&hsr->seqnr_lock);
 		hsr_forward_skb(skb, port);
 		spin_unlock_bh(&hsr->seqnr_lock);
 	} else {
+		struct hsr_ethhdr *hsr_ethhdr;
+
+		/* PTP packets are not supposed to be forwarded via HSR/ PRP
+		 * as-is. The latency introduced by forwarding renders
+		 * the time information useless.
+		 */
+		if ((!hsr->prot_version && protocol == htons(ETH_P_PRP)) ||
+		    protocol == htons(ETH_P_HSR)) {
+			/* HSR */
+			hsr_ethhdr = (struct hsr_ethhdr *)skb_mac_header(skb);
+			if (hsr_ethhdr->hsr_tag.encap_proto == htons(ETH_P_1588))
+				goto finish_free_consume;
+		} else {
+			if (protocol == htons(ETH_P_1588))
+				goto finish_free_consume;
+		}
+
 		hsr_forward_skb(skb, port);
 	}
 
-finish_consume:
+	return RX_HANDLER_CONSUMED;
+
+finish_free_consume:
+	kfree_skb(skb);
 	return RX_HANDLER_CONSUMED;
 
 finish_pass:

Sebastian

