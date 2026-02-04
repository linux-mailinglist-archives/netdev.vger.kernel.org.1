Return-Path: <netdev+bounces-256677-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF+0OIssg2kxigMAu9opvQ
	(envelope-from <netdev+bounces-256677-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 12:24:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CD2E50AE
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 12:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA38B300830F
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 11:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C112D3E9F79;
	Wed,  4 Feb 2026 11:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EECeKL+h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RVu9htc2"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D40B3E9F71
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 11:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770204295; cv=none; b=T1YIUEl6k6OkaT9NNdUsYuqMRWCVDfgylaSADHhpcQ7vEU6W7nwqAwpeMl7lcUm6Jr55SfQFXGzzyaSbpWAzDag4Ln9w4fTTd/MkYu9A7p46WeoWE/IwOQhz/KNHVHxBVng9YgkB3Cf7RF1YBCO8uZbtp6lMeGq0YFidUDFTLMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770204295; c=relaxed/simple;
	bh=yMVWgT9Xj35qGlt3W5m03jQAhLFGdn+0lppfjWvwK88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TG+3t1LvWGjZFdGyQTna88K4uPC6klaYBb16DlOifiQc+C8vqzxASjyNMA+nabgPMNVm3ppbodI+qy0Ytm26Bo3A8vRXKNPjWnf1qCSXIAjf4s1Hdh75lRLUv2feEhuDRD2wQXPDfcFJUbeD9xUv78/8isUasaUYWMYrGvcRiDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EECeKL+h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RVu9htc2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770204293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rZwxwE9C2FkMuoaWZLLtUh4y2X4LZZy2X8HuMmjPyEw=;
	b=EECeKL+hqeDkDguwACxj4Y5EKKSEUvwOHd0KJd3deZ3AeQm4Vmu91hPp9Pw9Z4xwGyFW8k
	GW4OMpiFjgTupy0xlRUM/y2KDKh/DbGxwUOqgZy/c/45T+trNg+jzUVo/8KNnXFgCAiCws
	kzaFDOyiHJuNhQXVFovL6ilVPaN5LCiHA+GE2XJNYH181aAW1mB3Hgmi/3h3y1E9MqXTjg
	HBM+wrVmaByD2Sf54w10OcBSbW6SyebSNO4ZAongarwIp2UG8Mwk++RVh7L2nUvRMt9j2V
	A/YSqypatkRAUp8iY/5ZgiAOQbJbxWdHnz5tuSHEZ2AfCeQv6xtJ16FqiYO6lA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770204293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rZwxwE9C2FkMuoaWZLLtUh4y2X4LZZy2X8HuMmjPyEw=;
	b=RVu9htc2OJtYy6ck8+pNllD5wymrEyc1tuMuUOZrR+QgEyJ27xkj5baOroVXg1dhBMJsbQ
	ZsgKpMaXRwxJhrDQ==
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RFC net-next 1/2] hsr: Allow to send a specific port and with HSR header
Date: Wed,  4 Feb 2026 12:24:03 +0100
Message-ID: <20260204-hsr_ptp-v1-1-b421c69a77da@linutronix.de>
In-Reply-To: <20260204-hsr_ptp-v1-0-b421c69a77da@linutronix.de>
References: <20260204-hsr_ptp-v1-0-b421c69a77da@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,linutronix.de];
	TAGGED_FROM(0.00)[bounces-256677-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 86CD2E50AE
X-Rspamd-Action: no action

HSR forwards all packets it received on slave port A to slave port B and
one of the possible two copies to the user (master) interface.
In terms of PTP this is not good because the latency introduced by
forwarding makes the timestamp in the PTP packet inaccurate.

Introduce a hsr_ptp field to struct skb_shared_info which can be used to
store HSR specific information for sending and receiving skbs.

Receive (slave ports):
- HSR_PT_SLAVE_A/ HSR_PT_SLAVE_B to denote the port which received the
  packet. This information is only added to PTP packets.

Send (master port):
- HSR_PT_SLAVE_A/ HSR_PT_SLAVE_B to denote the port on which the packet
  has to be sent.
- HSR_SKB_INCLUDES_HEADER to denote that the packet already contains a
  HSR header and the stack must not add the system's header to it.

HSR_SKB_INCLUDES_HEADER is used to allow forwarding a PTP packet and
preserving the HSR header by the sender.
Cloning skbs requires to preserve the socket information so that a PTP
timestamp can be associated with the socket.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/if_hsr.h |   2 +
 include/linux/skbuff.h |   1 +
 net/hsr/hsr_device.c   |   7 +++
 net/hsr/hsr_forward.c  | 114 +++++++++++++++++++++++++++++++++++++++++++++=
+---
 net/hsr/hsr_slave.c    |  16 +++++++
 5 files changed, 133 insertions(+), 7 deletions(-)

diff --git a/include/linux/if_hsr.h b/include/linux/if_hsr.h
index f4cf2dd36d193..1463ddbc8cddf 100644
--- a/include/linux/if_hsr.h
+++ b/include/linux/if_hsr.h
@@ -22,6 +22,8 @@ enum hsr_port_type {
 	HSR_PT_PORTS,	/* This must be the last item in the enum */
 };
=20
+#define HSR_SKB_INCLUDES_HEADER		(1 << 4)
+
 /* HSR Tag.
  * As defined in IEC-62439-3:2010, the HSR tag is really { ethertype =3D 0=
x88FB,
  * path, LSDU_size, sequence Nr }. But we let eth_header() create { h_dest,
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 86737076101d4..52c847e490ee8 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -605,6 +605,7 @@ struct skb_shared_info {
 	};
 	unsigned int	gso_type;
 	u32		tskey;
+	u32		hsr_ptp;
=20
 	/*
 	 * Warning : all fields before dataref are cleared in __alloc_skb()
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index d1bfc49b5f017..a06ef7c88792c 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -230,6 +230,13 @@ static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, s=
truct net_device *dev)
 	master =3D hsr_port_get_hsr(hsr, HSR_PT_MASTER);
 	if (master) {
 		skb->dev =3D master->dev;
+
+		/* skb includes HSR header but the network header is only set to
+		 * the ethernet header.
+		 */
+		if (skb_shinfo(skb)->hsr_ptp & HSR_SKB_INCLUDES_HEADER)
+			skb_set_network_header(skb, ETH_HLEN + HSR_HLEN);
+
 		skb_reset_mac_header(skb);
 		skb_reset_mac_len(skb);
 		spin_lock_bh(&hsr->seqnr_lock);
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index aefc9b6936ba0..c4040e61bd914 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -17,6 +17,16 @@
=20
 struct hsr_node;
=20
+static unsigned int hsr_get_ptp_flags(struct sk_buff *skb)
+{
+	return skb_shinfo(skb)->hsr_ptp;
+}
+
+static unsigned int hsr_keep_header(struct sk_buff *skb)
+{
+	return (hsr_get_ptp_flags(skb) & 0xf0) =3D=3D HSR_SKB_INCLUDES_HEADER;
+}
+
 /* The uses I can see for these HSR supervision frames are:
  * 1) Use the frames that are sent after node initialization ("HSR_TLV.Typ=
e =3D
  *    22") to reset any sequence_nr counters belonging to that node. Usefu=
l if
@@ -343,7 +353,10 @@ struct sk_buff *hsr_create_tagged_frame(struct hsr_fra=
me_info *frame,
 		hsr_set_path_id(frame, hsr_ethhdr, port);
 		return skb_clone(frame->skb_hsr, GFP_ATOMIC);
 	} else if (port->dev->features & NETIF_F_HW_HSR_TAG_INS) {
-		return skb_clone(frame->skb_std, GFP_ATOMIC);
+		skb =3D skb_clone(frame->skb_std, GFP_ATOMIC);
+		if (skb_shinfo(frame->skb_std)->hsr_ptp && skb)
+			skb->sk =3D frame->skb_std->sk;
+		return skb;
 	}
=20
 	/* Create the new skb with enough headroom to fit the HSR tag */
@@ -365,6 +378,16 @@ struct sk_buff *hsr_create_tagged_frame(struct hsr_fra=
me_info *frame,
 	memmove(dst, src, movelen);
 	skb_reset_mac_header(skb);
=20
+	if (skb_shinfo(frame->skb_std)->hsr_ptp) {
+		/* Packets are bound to a port and the sender may expect time
+		 * information.
+		 */
+		skb_shinfo(skb)->hsr_ptp =3D skb_shinfo(frame->skb_std)->hsr_ptp;
+		skb_shinfo(skb)->tx_flags =3D skb_shinfo(frame->skb_std)->tx_flags;
+		skb_shinfo(skb)->tskey =3D skb_shinfo(frame->skb_std)->tskey;
+		skb->sk =3D frame->skb_std->sk;
+	}
+
 	/* skb_put_padto free skb on error and hsr_fill_tag returns NULL in
 	 * that case
 	 */
@@ -420,7 +443,7 @@ static void hsr_deliver_master(struct sk_buff *skb, str=
uct net_device *dev,
 static int hsr_xmit(struct sk_buff *skb, struct hsr_port *port,
 		    struct hsr_frame_info *frame)
 {
-	if (frame->port_rcv->type =3D=3D HSR_PT_MASTER) {
+	if (frame->port_rcv->type =3D=3D HSR_PT_MASTER && !hsr_keep_header(skb)) {
 		hsr_addr_subst_dest(frame->node_src, skb, port);
=20
 		/* Address substitution (IEC62439-3 pp 26, 50): replace mac
@@ -504,6 +527,32 @@ bool hsr_drop_frame(struct hsr_frame_info *frame, stru=
ct hsr_port *port)
 	return false;
 }
=20
+static void hsr_parse_req_master(struct hsr_frame_info *frame,
+				 unsigned int *req_port,
+				 bool *req_keep_header)
+{
+	struct skb_shared_info *si;
+	unsigned int val;
+
+	*req_port =3D HSR_PT_NONE;
+	*req_keep_header =3D false;
+
+	if (!frame->skb_std)
+		return;
+
+	si =3D skb_shinfo(frame->skb_std);
+	if (!si->hsr_ptp)
+		return;
+
+	val =3D si->hsr_ptp & 0xf;
+	if (val =3D=3D HSR_PT_SLAVE_A || val =3D=3D HSR_PT_SLAVE_B)
+		*req_port =3D val;
+
+	val =3D si->hsr_ptp & 0xf0;
+	if (val =3D=3D HSR_SKB_INCLUDES_HEADER)
+		*req_keep_header =3D true;
+}
+
 /* Forward the frame through all devices except:
  * - Back through the receiving device
  * - If it's a HSR frame: through a device where it has passed before
@@ -521,6 +570,10 @@ static void hsr_forward_do(struct hsr_frame_info *fram=
e)
 	struct hsr_port *port;
 	struct sk_buff *skb;
 	bool sent =3D false;
+	unsigned int req_port;
+	bool req_keep_header;
+
+	hsr_parse_req_master(frame, &req_port, &req_keep_header);
=20
 	hsr_for_each_port(frame->port_rcv->hsr, port) {
 		struct hsr_priv *hsr =3D port->hsr;
@@ -542,6 +595,42 @@ static void hsr_forward_do(struct hsr_frame_info *fram=
e)
 		if ((port->dev->features & NETIF_F_HW_HSR_DUP) && sent)
 			continue;
=20
+		{
+			struct skb_shared_info *si =3D NULL;
+
+			if (frame->skb_hsr)
+				si =3D skb_shinfo(frame->skb_hsr);
+
+			/* Received over a slave interface */
+			if (si && si->hsr_ptp) {
+				/* No PTP forwarding */
+				if (port->type =3D=3D HSR_PT_SLAVE_A ||
+				    port->type =3D=3D HSR_PT_SLAVE_B)
+					continue;
+
+				if (port->type !=3D HSR_PT_MASTER)
+					continue;
+
+				skb =3D skb_clone(frame->skb_hsr, GFP_ATOMIC);
+				/* Inject the PTP frame into the master
+				 * interface including HSR headers.
+				 */
+				goto inject_into_stack;
+			}
+
+			/* Outgoing port has been specified */
+			if ((req_port !=3D HSR_PT_NONE) && (req_port !=3D port->type))
+				continue;
+			if (req_keep_header) {
+				skb =3D skb_clone(frame->skb_std, GFP_ATOMIC);
+				/* Send the frame on the specific port without
+				 * addign HSR headers.
+				 */
+				if (skb)
+					skb->sk =3D frame->skb_std->sk;
+				goto inject_into_stack;
+			}
+		}
 		/* Don't send frame over port where it has been sent before.
 		 * Also for SAN, this shouldn't be done.
 		 */
@@ -569,6 +658,7 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
 		else
 			skb =3D hsr->proto_ops->get_untagged_frame(frame, port);
=20
+inject_into_stack:
 		if (!skb) {
 			frame->port_rcv->dev->stats.rx_dropped++;
 			continue;
@@ -633,6 +723,13 @@ int hsr_fill_frame_info(__be16 proto, struct sk_buff *=
skb,
 	struct hsr_port *port =3D frame->port_rcv;
 	struct hsr_priv *hsr =3D port->hsr;
=20
+	if (hsr_keep_header(skb)) {
+		frame->skb_std =3D skb;
+
+		WARN_ON_ONCE(port->type !=3D HSR_PT_MASTER);
+		WARN_ON_ONCE(skb->mac_len < sizeof(struct hsr_ethhdr));
+		return 0;
+	}
 	/* HSRv0 supervisory frames double as a tag so treat them as tagged. */
 	if ((!hsr->prot_version && proto =3D=3D htons(ETH_P_PRP)) ||
 	    proto =3D=3D htons(ETH_P_HSR)) {
@@ -697,10 +794,12 @@ static int fill_frame_info(struct hsr_frame_info *fra=
me,
 	if (port->type =3D=3D HSR_PT_INTERLINK)
 		n_db =3D &hsr->proxy_node_db;
=20
-	frame->node_src =3D hsr_get_node(port, n_db, skb,
-				       frame->is_supervision, port->type);
-	if (!frame->node_src)
-		return -1; /* Unknown node and !is_supervision, or no mem */
+	if (!hsr_keep_header(skb)) {
+		frame->node_src =3D hsr_get_node(port, n_db, skb,
+					       frame->is_supervision, port->type);
+		if (!frame->node_src)
+			return -1; /* Unknown node and !is_supervision, or no mem */
+	}
=20
 	ethhdr =3D (struct ethhdr *)skb_mac_header(skb);
 	frame->is_vlan =3D false;
@@ -739,7 +838,8 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_po=
rt *port)
 	if (fill_frame_info(&frame, skb, port) < 0)
 		goto out_drop;
=20
-	hsr_register_frame_in(frame.node_src, port, frame.sequence_nr);
+	if (!hsr_keep_header(skb))
+		hsr_register_frame_in(frame.node_src, port, frame.sequence_nr);
 	hsr_forward_do(&frame);
 	rcu_read_unlock();
 	/* Gets called for ingress frames as well as egress from master port.
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index afe06ba00ea44..8329d01eee287 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -81,6 +81,22 @@ static rx_handler_result_t hsr_handle_frame(struct sk_bu=
ff **pskb)
 		hsr_forward_skb(skb, port);
 		spin_unlock_bh(&hsr->seqnr_lock);
 	} else {
+		struct hsr_ethhdr *hsr_ethhdr;
+		struct skb_shared_info *si;
+
+		hsr_ethhdr =3D (struct hsr_ethhdr *)skb_mac_header(skb);
+		if (hsr_ethhdr->hsr_tag.encap_proto =3D=3D htons(ETH_P_1588)) {
+			/* PTP packages are not supposed to be forwarded via HSR
+			 * as-is. The latency introduced by forwarding renders
+			 * the time information useless.
+			 * Instead attach the port information on which it was
+			 * received, forward both copies to userland only and
+			 * let it deal with it.
+			 */
+			si =3D skb_shinfo(skb);
+			si->hsr_ptp =3D port->type;
+		}
+
 		hsr_forward_skb(skb, port);
 	}
=20

--=20
2.51.0

