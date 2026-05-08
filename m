Return-Path: <netdev+bounces-285752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IB+Hkq4/Wm4hwAAu9opvQ
	(envelope-from <netdev+bounces-285752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 12:17:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 241F44F4E25
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 12:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 74CF13007B80
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 10:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7693C37F8D3;
	Fri,  8 May 2026 10:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z9tvBqhg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nDNraEjT"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0C137DE90
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 10:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778235463; cv=none; b=XcbOF1eGtu+8u7dktIVO2Qu3L4K+w1YM790D9m426rQHo1QfWg/0udnx7VHmH6cmpmuXXJNHPrICmiY08owBxap7XGkQUOn0Y3w1xIg31/zBRK1pw8krDwfT9TQf74zPFa/DPADtxEqdrPDkqm5Uc+J9i/iGYQF8np5a8EWln60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778235463; c=relaxed/simple;
	bh=Dx6URf/njgnPOGJ4+qD6mChZb/Ob0MFEaIMiPrK0I4A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Mqhe97+w99xCrN/C0HTfGk/n9xQgHi1N2izATT/cA+1t87U64s9m3abiwpuZm+tpeIWSvm17uGOjGQ+evPkHXnqQRYbYSJd6gWCHiPNgbJ0jDmMPqWvhsL5aHXw2eZwYnNHGqa1L3pb8ET6RQ3gXlrMLHTLwo9J5OLEjCBUIR64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z9tvBqhg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nDNraEjT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 8 May 2026 12:17:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778235459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5fxdERfj0yeySjpLLuplcaNC2sEJQaai1MYF8q+UCIY=;
	b=Z9tvBqhgDWOM3ZOaozJCUg9dpho7NDvkx2Q/0qrQxfwTqZT6Yr5omXp0uKIDaOuiKRCjEh
	ogaamt9zeLL7Z912mWdnxeo8wrXBbN56eox23HuMS7PwuiElCtxsLUDOXaXyTDNnOR7qmE
	jiK1CbW5n4+ph3EFM7pZ5fsvaX3BYO+ri/TN1q0j3VkSYCMFUnw+qiI2ahqu7O00ywbeyt
	ygEGHjzkHG3xZzd/eky6xlVJiljvTtmySmJxrJXCn9VEh54sGqbnQLd7Y4poVVKiGMP1R3
	WLHOJDicxVhDBu/AmlkB8aSTkwH8UkEYiDmbkU+XFSDLj50cu4IyDd+Dj5P1nQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778235459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5fxdERfj0yeySjpLLuplcaNC2sEJQaai1MYF8q+UCIY=;
	b=nDNraEjTqlqs+1BANi/N1mW+/QmnoPcdwEpvpA4KieNLZ04lkb7/+/CPr05Cg1PRIp4Aba
	OkS12doydLyZDtCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev@vger.kernel.org
Cc: Jayachandran <j-rameshbabu@ti.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>, Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>, Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next v4] hsr: Allow to send a specific port and with HSR
 header
Message-ID: <20260508-hsr_ptp-v4-1-aa19aa7c6a71@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Change-ID: 20260204-hsr_ptp-1f6380f1d35f
X-Rspamd-Queue-Id: 241F44F4E25
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285752-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ti.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

HSR forwards all packets it received on slave port 1 to slave port 2 and
one of the two copies to the user (master) interface.
In terms of PTP this is not good because the latency introduced by
forwarding makes the timestamp in the PTP packet inaccurate.
The PTP packets should not be forwarded like regular packets.

In order to work with PTP over HSR the following has been done:
- PTP packets which are received are dropped within the HSR stack. That
  means they are not forwarded or injected into the master port. If the
  user requires them, then they need to be obtained directly from the
  SLAVE interface.

- Sending packets. If the ethernet type of the packet is ETH_P_1588 then
  the stack assumes a header of type struct hsr_inline_header. The size
  of this header is the same as ethhdr. As a safeguard, the header
  contains a magic field which matches the position of h_source and it
  needs to match HSR_INLINE_HDR.
  Once this is verified, the header contains the port on which this
  packet needs to be sent and if system's HSR header should be added.
  This information is used with the HSR stack. The packet is then
  pulled passed the custom header so the remaining stack will see the
  actual data.

- HSR HW offloading. The stack passes the skb to the requested port. The
  driver needs to be aware of the mode (HSR/ PRP). In PRP mode, there
  must be no offloading if the ether type is ETH_P_1588. In HSR mode it
  needs to add a HSR header for the ETH_P_1588 ether type but none if it
  is already ETH_P_HSR.

The originally submitted skb is freed and only the (altered) clone is
submitted to the slave interface for sending. Therefore on cloning, the
socket and tx_flags/ tskey are copied so that the PTP timestamp is
forwarded to the socket submitting the skb.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
I am trying to extend linuxptp to support PTP over a HSR network.

This is the kernel side of the changes. In short PTP over HSR sends its
packets to a multicast address and every node needs to forward the PTP
packet (SYNC and FOLLOW-UP for instance) within the HSR ring.
In order to achieve this, the HSR stack must not duplicate and forward
the PTP packets as it would do with other packets. The delay caused by
the duplication and forwarding adds overhead which in turn makes the
timing information within the PTP packet inaccurate.

My current approach is to open the slave devices (eth0/ eth1) from
userland in order to receive the PTP packets. Sending happens from the
hsr0 device. The actual packet can have an optional inline header
prepended of type struct hsr_inline_header. The size of the header is
equivalent to ethhdr. The header has a type (h_proto) at the same
position as ethhdr and expects it to be ETH_P_1588 as this extra meta
information is only relevant for PTP packets. It makes no sense to send
PTP packets via the HSR interface because it gets duplicated and the
timestamp information is lost so this should not break anything. As an
additional safe guard there is a magic value at h_source position. The
value has '0xaf' at the most significant byte which makes the address a
locally administered multicast address.

The header passes two information from userland: On which slave port
the packet has to be sent and does the HSR stack need to prepend a
header or not.
The header is skipped so that the remaining stack sees the actual data
and can send it as requested.

The PRP packets are sent directly via the SLAVE interface. The standard
mandates not add a PRP trailer (PRP, redundancy control trailer) to PTP
packets. There is not really a reason to use hsr interface.

HSR hardware offloading is optional. The driver needs to know if the
operating mode is HSR or PRP. In PRP mode it needs to check the ether
type and for ETH_P_1588 it must not perform any offloading.
In HSR mode, for ether-type ETH_P_1588 there must be no offloading. If
the ether-type is ETH_P_HSR there must be no offloading if the
encapsulated protocol is ETH_P_1588.

This has been tested in a pure software environment and in an HW-assisted
environment where the HW is able to duplicate and duplicate packets
but does not do it for PTP packets.
It has not been tested within an environment where the HW is able to
forward the PTP packet and correctly update the timing information.
---
v3=E2=80=A6v4: https://lore.kernel.org/r/20260429-hsr_ptp-v3-1-afbf8f200f48=
@linutronix.de
- Removed skb extention. The information within HSR is passed via
  struct hsr_frame_info. Driver with HSR-offloading capabilities need to
  know the HSR mode (HSR or PRP) and parse the skb to decide what needs
  to be done (whether to send on both ports and if adding a header is
  needed).

v2=E2=80=A6v3: https://patch.msgid.link/20260309-hsr_ptp-v2-0-798262aad3a4@=
linutronix.de
- Remove af_packet changes entirely.
- Add an internal header to pass additional information for HSR-PTP
  packets.
- Remove PRP, userland will use slave devices directly.
- Drop all received PTP packets. Userland needs to use the slave device
  for RX.

v1=E2=80=A6v2: https://patch.msgid.link/20260204-hsr_ptp-v1-0-b421c69a77da@=
linutronix.de
- Added PRP support
- skb extention is used instead of extending struct skb_shared_info
- in af_packet
  - packet_sendmsg_spkt() is no longer extended
  - jump labels are used to avoid the overhead if there no socket that
    is using this HSR extension.
---
 include/linux/if_hsr.h | 11 +++++++++
 net/hsr/hsr_device.c   | 49 +++++++++++++++++++++++++++----------
 net/hsr/hsr_forward.c  | 65 +++++++++++++++++++++++++++++++++++++++++-----=
----
 net/hsr/hsr_forward.h  |  3 ++-
 net/hsr/hsr_framereg.h |  2 ++
 net/hsr/hsr_slave.c    | 37 +++++++++++++++++++++-------
 6 files changed, 134 insertions(+), 33 deletions(-)

diff --git a/include/linux/if_hsr.h b/include/linux/if_hsr.h
index f4cf2dd36d193..0dda83511804e 100644
--- a/include/linux/if_hsr.h
+++ b/include/linux/if_hsr.h
@@ -3,6 +3,7 @@
 #define _LINUX_IF_HSR_H_
=20
 #include <linux/types.h>
+#include <linux/skbuff.h>
=20
 struct net_device;
=20
@@ -22,6 +23,16 @@ enum hsr_port_type {
 	HSR_PT_PORTS,	/* This must be the last item in the enum */
 };
=20
+#define HSR_INLINE_HDR	0xaf485352
+struct hsr_inline_header {
+	uint8_t tx_port;
+	uint8_t hsr_hdr;
+	uint8_t __pad0[4];
+	uint32_t magic;
+	uint8_t __pad1[2];
+	uint16_t eth_type;
+} __packed;
+
 /* HSR Tag.
  * As defined in IEC-62439-3:2010, the HSR tag is really { ethertype =3D 0=
x88FB,
  * path, LSDU_size, sequence Nr }. But we let eth_header() create { h_dest,
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 5555b71ab19b5..cab4f7c601257 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -223,24 +223,49 @@ static netdev_features_t hsr_fix_features(struct net_=
device *dev,
=20
 static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *de=
v)
 {
+	enum hsr_port_type tx_port =3D HSR_PT_NONE;
 	struct hsr_priv *hsr =3D netdev_priv(dev);
 	struct hsr_port *master;
+	bool has_header =3D false;
=20
 	rcu_read_lock();
 	master =3D hsr_port_get_hsr(hsr, HSR_PT_MASTER);
-	if (master) {
-		skb->dev =3D master->dev;
-		skb_reset_mac_header(skb);
-		skb_reset_mac_len(skb);
-		spin_lock_bh(&hsr->seqnr_lock);
-		hsr_forward_skb(skb, master);
-		spin_unlock_bh(&hsr->seqnr_lock);
-	} else {
-		dev_core_stats_tx_dropped_inc(dev);
-		dev_kfree_skb_any(skb);
+	if (!master)
+		goto drop;
+
+	skb->dev =3D master->dev;
+	if (skb->len > ETH_HLEN * 2) {
+		struct hsr_inline_header *hsr_opt;
+
+		BUILD_BUG_ON(sizeof(struct hsr_inline_header) !=3D sizeof(struct ethhdr)=
);
+		hsr_opt =3D (struct hsr_inline_header *)skb_mac_header(skb);
+		if (hsr_opt->eth_type =3D=3D htons(ETH_P_1588) &&
+		    hsr_opt->magic =3D=3D htonl(HSR_INLINE_HDR)) {
+			has_header =3D hsr_opt->hsr_hdr;
+			tx_port =3D hsr_opt->tx_port;
+			if (tx_port !=3D HSR_PT_SLAVE_A && tx_port !=3D HSR_PT_SLAVE_B)
+				goto drop;
+
+			skb_pull(skb, sizeof(struct hsr_inline_header));
+			if (has_header)
+				skb_set_network_header(skb, ETH_HLEN + HSR_HLEN);
+			else
+				skb_set_network_header(skb, ETH_HLEN);
+		}
 	}
+
+	skb_reset_mac_header(skb);
+	skb_reset_mac_len(skb);
+	spin_lock_bh(&hsr->seqnr_lock);
+	hsr_forward_skb(skb, master, tx_port, has_header);
+	spin_unlock_bh(&hsr->seqnr_lock);
 	rcu_read_unlock();
=20
+	return NETDEV_TX_OK;
+drop:
+	rcu_read_unlock();
+	dev_core_stats_tx_dropped_inc(dev);
+	dev_kfree_skb_any(skb);
 	return NETDEV_TX_OK;
 }
=20
@@ -361,7 +386,7 @@ static void send_hsr_supervision_frame(struct hsr_port =
*port,
 		return;
 	}
=20
-	hsr_forward_skb(skb, port);
+	hsr_forward_skb(skb, port, HSR_PT_NONE, false);
 	spin_unlock_bh(&hsr->seqnr_lock);
 	return;
 }
@@ -402,7 +427,7 @@ static void send_prp_supervision_frame(struct hsr_port =
*master,
 		return;
 	}
=20
-	hsr_forward_skb(skb, master);
+	hsr_forward_skb(skb, master, HSR_PT_NONE, false);
 	spin_unlock_bh(&hsr->seqnr_lock);
 }
=20
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 0aca859c88cbb..7f92314934c98 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -12,6 +12,7 @@
 #include <linux/skbuff.h>
 #include <linux/etherdevice.h>
 #include <linux/if_vlan.h>
+#include <net/sock.h>
 #include "hsr_main.h"
 #include "hsr_framereg.h"
=20
@@ -343,7 +344,10 @@ struct sk_buff *hsr_create_tagged_frame(struct hsr_fra=
me_info *frame,
 		hsr_set_path_id(frame, hsr_ethhdr, port);
 		return skb_clone(frame->skb_hsr, GFP_ATOMIC);
 	} else if (port->dev->features & NETIF_F_HW_HSR_TAG_INS) {
-		return skb_clone(frame->skb_std, GFP_ATOMIC);
+		skb =3D skb_clone(frame->skb_std, GFP_ATOMIC);
+		if (frame->req_tx_port !=3D HSR_PT_NONE)
+			skb_set_owner_w(skb, frame->skb_std->sk);
+		return skb;
 	}
=20
 	/* Create the new skb with enough headroom to fit the HSR tag */
@@ -365,6 +369,15 @@ struct sk_buff *hsr_create_tagged_frame(struct hsr_fra=
me_info *frame,
 	memmove(dst, src, movelen);
 	skb_reset_mac_header(skb);
=20
+	if (frame->req_tx_port !=3D HSR_PT_NONE) {
+		/* Packets are bound to a port and the sender may expect time
+		 * information.
+		 */
+		skb_shinfo(skb)->tx_flags =3D skb_shinfo(frame->skb_std)->tx_flags;
+		skb_shinfo(skb)->tskey =3D skb_shinfo(frame->skb_std)->tskey;
+		skb_set_owner_w(skb, frame->skb_std->sk);
+	}
+
 	/* skb_put_padto free skb on error and hsr_fill_tag returns NULL in
 	 * that case
 	 */
@@ -420,7 +433,7 @@ static void hsr_deliver_master(struct sk_buff *skb, str=
uct net_device *dev,
 static int hsr_xmit(struct sk_buff *skb, struct hsr_port *port,
 		    struct hsr_frame_info *frame)
 {
-	if (frame->port_rcv->type =3D=3D HSR_PT_MASTER) {
+	if (frame->port_rcv->type =3D=3D HSR_PT_MASTER && !frame->has_foreign_hea=
der) {
 		hsr_addr_subst_dest(frame->node_src, skb, port);
=20
 		/* Address substitution (IEC62439-3 pp 26, 50): replace mac
@@ -519,11 +532,12 @@ bool hsr_drop_frame(struct hsr_frame_info *frame, str=
uct hsr_port *port)
 static void hsr_forward_do(struct hsr_frame_info *frame)
 {
 	struct hsr_port *port;
-	struct sk_buff *skb;
 	bool sent =3D false;
=20
 	hsr_for_each_port(frame->port_rcv->hsr, port) {
 		struct hsr_priv *hsr =3D port->hsr;
+		struct sk_buff *skb =3D NULL;
+
 		/* Don't send frame back the way it came */
 		if (port =3D=3D frame->port_rcv)
 			continue;
@@ -542,6 +556,19 @@ static void hsr_forward_do(struct hsr_frame_info *fram=
e)
 		if ((port->dev->features & NETIF_F_HW_HSR_DUP) && sent)
 			continue;
=20
+		/* PTP TX packets have an outgoing port specified */
+		if (frame->req_tx_port !=3D HSR_PT_NONE && frame->req_tx_port !=3D port-=
>type)
+			continue;
+		/* PTP TX packets may already have a HSR header which needs to
+		 * be preserved
+		 */
+		if (frame->has_foreign_header && frame->skb_std) {
+			skb =3D skb_clone(frame->skb_std, GFP_ATOMIC);
+			if (skb)
+				skb_set_owner_w(skb, frame->skb_std->sk);
+			goto inject_into_stack;
+		}
+
 		/* Don't send frame over port where it has been sent before.
 		 * Also for SAN, this shouldn't be done.
 		 */
@@ -569,6 +596,7 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
 		else
 			skb =3D hsr->proto_ops->get_untagged_frame(frame, port);
=20
+inject_into_stack:
 		if (!skb) {
 			frame->port_rcv->dev->stats.rx_dropped++;
 			continue;
@@ -633,6 +661,13 @@ int hsr_fill_frame_info(__be16 proto, struct sk_buff *=
skb,
 	struct hsr_port *port =3D frame->port_rcv;
 	struct hsr_priv *hsr =3D port->hsr;
=20
+	if (frame->has_foreign_header) {
+		frame->skb_std =3D skb;
+
+		WARN_ON_ONCE(port->type !=3D HSR_PT_MASTER);
+		WARN_ON_ONCE(skb->mac_len < sizeof(struct hsr_ethhdr));
+		return 0;
+	}
 	/* HSRv0 supervisory frames double as a tag so treat them as tagged. */
 	if ((!hsr->prot_version && proto =3D=3D htons(ETH_P_PRP)) ||
 	    proto =3D=3D htons(ETH_P_HSR)) {
@@ -674,7 +709,8 @@ int prp_fill_frame_info(__be16 proto, struct sk_buff *s=
kb,
 }
=20
 static int fill_frame_info(struct hsr_frame_info *frame,
-			   struct sk_buff *skb, struct hsr_port *port)
+			   struct sk_buff *skb, struct hsr_port *port,
+			   enum hsr_port_type tx_port, bool has_hsr_header)
 {
 	struct hsr_priv *hsr =3D port->hsr;
 	struct hsr_vlan_ethhdr *vlan_hdr;
@@ -697,10 +733,15 @@ static int fill_frame_info(struct hsr_frame_info *fra=
me,
 	if (port->type =3D=3D HSR_PT_INTERLINK)
 		n_db =3D &hsr->proxy_node_db;
=20
-	frame->node_src =3D hsr_get_node(port, n_db, skb,
-				       frame->is_supervision, port->type);
-	if (!frame->node_src)
-		return -1; /* Unknown node and !is_supervision, or no mem */
+	frame->req_tx_port =3D tx_port;
+	frame->has_foreign_header =3D has_hsr_header;
+
+	if (!frame->has_foreign_header) {
+		frame->node_src =3D hsr_get_node(port, n_db, skb,
+					       frame->is_supervision, port->type);
+		if (!frame->node_src)
+			return -1; /* Unknown node and !is_supervision, or no mem */
+	}
=20
 	ethhdr =3D (struct ethhdr *)skb_mac_header(skb);
 	frame->is_vlan =3D false;
@@ -731,15 +772,17 @@ static int fill_frame_info(struct hsr_frame_info *fra=
me,
 }
=20
 /* Must be called holding rcu read lock (because of the port parameter) */
-void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
+void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port,
+		     enum hsr_port_type tx_port, bool has_hsr_header)
 {
 	struct hsr_frame_info frame;
=20
 	rcu_read_lock();
-	if (fill_frame_info(&frame, skb, port) < 0)
+	if (fill_frame_info(&frame, skb, port, tx_port, has_hsr_header) < 0)
 		goto out_drop;
=20
-	hsr_register_frame_in(frame.node_src, port, frame.sequence_nr);
+	if (!frame.has_foreign_header)
+		hsr_register_frame_in(frame.node_src, port, frame.sequence_nr);
 	hsr_forward_do(&frame);
 	rcu_read_unlock();
 	/* Gets called for ingress frames as well as egress from master port.
diff --git a/net/hsr/hsr_forward.h b/net/hsr/hsr_forward.h
index 206636750b300..e64b0358907a9 100644
--- a/net/hsr/hsr_forward.h
+++ b/net/hsr/hsr_forward.h
@@ -13,7 +13,8 @@
 #include <linux/netdevice.h>
 #include "hsr_main.h"
=20
-void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port);
+void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port,
+		     enum hsr_port_type tx_port, bool has_hsr_header);
 struct sk_buff *prp_create_tagged_frame(struct hsr_frame_info *frame,
 					struct hsr_port *port);
 struct sk_buff *hsr_create_tagged_frame(struct hsr_frame_info *frame,
diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
index c65ecb9257348..7aeb59beb7fd8 100644
--- a/net/hsr/hsr_framereg.h
+++ b/net/hsr/hsr_framereg.h
@@ -27,6 +27,8 @@ struct hsr_frame_info {
 	bool is_local_dest;
 	bool is_local_exclusive;
 	bool is_from_san;
+	bool has_foreign_header;
+	enum hsr_port_type req_tx_port;
 };
=20
 void hsr_del_self_node(struct hsr_priv *hsr);
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index d9af9e65f72f0..7cc0641dbd137 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -44,8 +44,7 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buf=
f **pskb)
=20
 	if (hsr_addr_is_self(port->hsr, eth_hdr(skb)->h_source)) {
 		/* Directly kill frames sent by ourselves */
-		kfree_skb(skb);
-		goto finish_consume;
+		goto finish_free_consume;
 	}
=20
 	/* For HSR, only tagged frames are expected (unless the device offloads
@@ -64,10 +63,8 @@ static rx_handler_result_t hsr_handle_frame(struct sk_bu=
ff **pskb)
 	skb_reset_mac_header(skb);
 	if ((!hsr->prot_version && protocol =3D=3D htons(ETH_P_PRP)) ||
 	    protocol =3D=3D htons(ETH_P_HSR)) {
-		if (!pskb_may_pull(skb, ETH_HLEN + HSR_HLEN)) {
-			kfree_skb(skb);
-			goto finish_consume;
-		}
+		if (!pskb_may_pull(skb, ETH_HLEN + HSR_HLEN))
+			goto finish_free_consume;
=20
 		skb_set_network_header(skb, ETH_HLEN + HSR_HLEN);
 	}
@@ -78,13 +75,35 @@ static rx_handler_result_t hsr_handle_frame(struct sk_b=
uff **pskb)
 	 */
 	if (port->type =3D=3D HSR_PT_INTERLINK) {
 		spin_lock_bh(&hsr->seqnr_lock);
-		hsr_forward_skb(skb, port);
+		hsr_forward_skb(skb, port, HSR_PT_NONE, false);
 		spin_unlock_bh(&hsr->seqnr_lock);
 	} else {
-		hsr_forward_skb(skb, port);
+		struct hsr_ethhdr *hsr_ethhdr;
+
+		/* PTP packets are not supposed to be forwarded via HSR as-is.
+		 * The latency introduced by forwarding renders the time
+		 * information useless. Userland needs to capture the packet on
+		 * the original interface instead of hsr.
+		 */
+		if ((!hsr->prot_version && protocol =3D=3D htons(ETH_P_PRP)) ||
+		    protocol =3D=3D htons(ETH_P_HSR)) {
+			/* HSR */
+			hsr_ethhdr =3D (struct hsr_ethhdr *)skb_mac_header(skb);
+			if (hsr_ethhdr->hsr_tag.encap_proto =3D=3D htons(ETH_P_1588))
+				goto finish_free_consume;
+		} else {
+			/* PRP */
+			if (protocol =3D=3D htons(ETH_P_1588))
+				goto finish_free_consume;
+		}
+
+		hsr_forward_skb(skb, port, HSR_PT_NONE, false);
 	}
=20
-finish_consume:
+	return RX_HANDLER_CONSUMED;
+
+finish_free_consume:
+	kfree_skb(skb);
 	return RX_HANDLER_CONSUMED;
=20
 finish_pass:

---
base-commit: 9e0898f1c0f134c6bad146ca8578f73c3e40ac0a
change-id: 20260204-hsr_ptp-1f6380f1d35f

Best regards,
--=20
Sebastian Andrzej Siewior <bigeasy@linutronix.de>

