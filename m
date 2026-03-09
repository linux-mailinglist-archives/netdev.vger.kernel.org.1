Return-Path: <netdev+bounces-265617-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id K8yrKTDvrmlcKgIAu9opvQ
	(envelope-from <netdev+bounces-265617-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:02:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1495C23C5CF
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6067E304EEA5
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 15:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26DC3DEAC3;
	Mon,  9 Mar 2026 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cK4+famf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wHNmozOQ"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998122765ED
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071602; cv=none; b=Hq9FohjsWt7/IHdU+zzMHO26KqKqtNTygd3mZF5vyVggSA/uKPVbopPRblphp9m1o8FCIIJFfHHnqRDmFpyF9O45rkXP1vnvNc4Yr0Ft9m3mvFOv1JbV8JfAuViF1SgJRau1T0KjOPNw79cvrEmoWn8nI8fCagjutuP8LIWCXXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071602; c=relaxed/simple;
	bh=0moZuIIVKhiNdE8AMancfee0t2wWrTHWZjD+WNsA5rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eG3utdGPprREFQzWRbhGh4g2jX1iinwcha+08alcin3fWpFVxcMFfqovNjAwGAS6+6U6uQERChF+rrESMkm/o033qdX1xE5ETUVYjuyqEZovDnBBzsl5JYs96EoAy/uvftIwj92ReDHIiLbIoLNeW+dIT97aXQvxO3RExPdSscI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cK4+famf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wHNmozOQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773071598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZpKJajSg47trmuiFfdjwj5PtlDnAE9hC08KW1UlgkUc=;
	b=cK4+famfTJx+Yc0UWAAnNNB6rXhUnJrxf2t4Ukgym0/6gqIAWHG0TiYDvSmKm2/++lOmGs
	jjhBTQeG0V4uzCUPV6vNPS4sx0H7kPJ4bk2W5uENAmLC9Nw6R4fyGZZMR2onaiYYVfoMzH
	FCFTy+p0w80fPLuf4YIPMp5ogwAZVH0v1NkCmix9nzhUE+K4m91Nh5UZT+cyEzxRxGzHue
	/Wul1UiN5wyBEVcak9aOzkRw6r3mUxZWbu9g8I4Ysa7z//9ksXSn+37Ym1jM5Z9DuUfJ1P
	xfc2AorrP7zfXMEwq+M0dsxrUE6GurMZ5ToOzl4dVX+yxFkbvBeASakxFFTXvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773071598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZpKJajSg47trmuiFfdjwj5PtlDnAE9hC08KW1UlgkUc=;
	b=wHNmozOQVOonrJWGAKFBdpwl8Oc/ZXEHpUIsd0Y+EqP8n7/9TPH0wqf0EP0X2fgHdSdyhF
	LP04pa50LvCFsEAQ==
To: netdev@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"(JC), Jayachandran" <j-rameshbabu@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>,
	Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>,
	Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH RFC net-next v2 1/2] hsr: Allow to send a specific port and with HSR header
Date: Mon,  9 Mar 2026 16:52:35 +0100
Message-ID: <20260309-hsr_ptp-v2-1-798262aad3a4@linutronix.de>
In-Reply-To: <20260309-hsr_ptp-v2-0-798262aad3a4@linutronix.de>
References: <20260309-hsr_ptp-v2-0-798262aad3a4@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1495C23C5CF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265617-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,ti.com,davemloft.net,lunn.ch,google.com,redhat.com,kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

HSR forwards all packets it received on slave port 1 to slave port 2 and
one of the two copies to the user (master) interface.
In terms of PTP this is not good because the latency introduced by
forwarding makes the timestamp in the PTP packet inaccurate.
The PTP packets should not forwarded like regular packets.

This is addressed by adding a skb extension to received PTP packet
(over a slave interface). Those packets won't be forwarded on the other
port slave port. Instead both copies with the HSR header will be
injected into the master port so userspace can consume it.
For the TX side (received over master port) the same facility is used to
send the packet over the specified slave port and either use the
provided HSR header or generate one by the stack.

The added skb extension is struct hsr_ptp_ext.

Receive (slave ports):
- The 'port' member is set to HSR_PT_SLAVE_A/ HSR_PT_SLAVE_B to denote the
  port which received the packet. The 'header' member is always false.
  This information is only added to PTP packets.
- The received packet is injected into the master port with its HSR
  header. Both copies are injected, duplicates are not removed.

Send (master port):
- The 'port' member is set to HSR_PT_SLAVE_A/ HSR_PT_SLAVE_B to denote
  the port on which the packet has to be sent.
- The 'header' can be set to true to denote that the packet already
  contains a HSR header and the stack must not add the system's header
  to it. Otherwise (if false) the stack will add a HSR header.
  If a header is already provided then some checks/ actions are skipped
  such MAC-assignment or node status update.
- Cloning a TX skb requires to assign socket information and tx_flags/
  tskey to associate the timestamp with the skb.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/if_hsr.h |  81 +++++++++++++++++++++++++++++++++
 include/linux/skbuff.h |   3 ++
 net/core/skbuff.c      |   4 ++
 net/hsr/Kconfig        |   1 +
 net/hsr/hsr_device.c   |   7 +++
 net/hsr/hsr_forward.c  | 118 ++++++++++++++++++++++++++++++++++++++++++++-=
----
 net/hsr/hsr_framereg.h |   1 +
 net/hsr/hsr_slave.c    |  35 ++++++++++++---
 8 files changed, 235 insertions(+), 15 deletions(-)

diff --git a/include/linux/if_hsr.h b/include/linux/if_hsr.h
index f4cf2dd36d193..33fc11f895d3f 100644
--- a/include/linux/if_hsr.h
+++ b/include/linux/if_hsr.h
@@ -22,6 +22,11 @@ enum hsr_port_type {
 	HSR_PT_PORTS,	/* This must be the last item in the enum */
 };
=20
+struct hsr_ptp_ext {
+	u8	port;
+	u8	header;
+};
+
 /* HSR Tag.
  * As defined in IEC-62439-3:2010, the HSR tag is really { ethertype =3D 0=
x88FB,
  * path, LSDU_size, sequence Nr }. But we let eth_header() create { h_dest,
@@ -45,6 +50,60 @@ struct net_device *hsr_get_port_ndev(struct net_device *=
ndev,
 				     enum hsr_port_type pt);
 int hsr_get_port_type(struct net_device *hsr_dev, struct net_device *dev,
 		      enum hsr_port_type *type);
+
+static inline bool hsr_skb_has_header(struct sk_buff *skb)
+{
+	struct hsr_ptp_ext *ptp_ext;
+
+	ptp_ext =3D skb_ext_find(skb, SKB_EXT_HSR);
+	if (!ptp_ext)
+		return false;
+	return ptp_ext->header;
+}
+
+static inline unsigned int hsr_skb_has_port(struct sk_buff *skb)
+{
+	struct hsr_ptp_ext *ptp_ext;
+
+	if (!skb)
+		return 0;
+
+	ptp_ext =3D skb_ext_find(skb, SKB_EXT_HSR);
+	if (!ptp_ext)
+		return 0;
+	return ptp_ext->port;
+}
+
+static inline bool hsr_skb_get_header_port(struct sk_buff *skb, bool *head=
er,
+					   enum hsr_port_type *port_type)
+{
+	struct hsr_ptp_ext *ptp_ext;
+
+	*port_type =3D HSR_PT_NONE;
+	*header =3D false;
+
+	ptp_ext =3D skb_ext_find(skb, SKB_EXT_HSR);
+	if (!ptp_ext)
+		return false;
+
+	*port_type =3D ptp_ext->port;
+	*header =3D ptp_ext->header;
+	return true;
+}
+
+static inline bool hsr_skb_add_header_port(struct sk_buff *skb, bool heade=
r,
+					   enum hsr_port_type port)
+{
+	struct hsr_ptp_ext *ptp_ext;
+
+	ptp_ext =3D skb_ext_add(skb, SKB_EXT_HSR);
+	if (!ptp_ext)
+		return false;
+	ptp_ext->port =3D port;
+	ptp_ext->header =3D header;
+	return true;
+}
+
 #else
 static inline bool is_hsr_master(struct net_device *dev)
 {
@@ -68,6 +127,28 @@ static inline int hsr_get_port_type(struct net_device *=
hsr_dev,
 {
 	return -EINVAL;
 }
+
+static inline bool hsr_skb_has_header(struct sk_buff *skb)
+{
+	return false;
+}
+
+static inline unsigned int hsr_skb_has_port(struct sk_buff *skb)
+{
+	return 0;
+}
+
+static inline bool hsr_skb_get_header_port(struct sk_buff *skb, bool *head=
er,
+					   enum hsr_port_type *port_type)
+{
+	return false;
+}
+
+static inline bool hsr_skb_add_header_port(struct sk_buff *skb, bool heade=
r,
+					   enum hsr_port_type port)
+{
+	return true;
+}
 #endif /* CONFIG_HSR */
=20
 #endif /*_LINUX_IF_HSR_H_*/
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index daa4e4944ce3f..75ddf7f41b8ee 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -5004,6 +5004,9 @@ enum skb_ext_id {
 #endif
 #if IS_ENABLED(CONFIG_CAN)
 	SKB_EXT_CAN,
+#endif
+#if IS_ENABLED(CONFIG_HSR)
+	SKB_EXT_HSR,
 #endif
 	SKB_EXT_NUM, /* must be last */
 };
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 0e217041958a8..d1de7c9d02639 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -60,6 +60,7 @@
 #include <linux/errqueue.h>
 #include <linux/prefetch.h>
 #include <linux/bitfield.h>
+#include <linux/if_hsr.h>
 #include <linux/if_vlan.h>
 #include <linux/mpls.h>
 #include <linux/kcov.h>
@@ -5143,6 +5144,9 @@ static const u8 skb_ext_type_len[] =3D {
 #if IS_ENABLED(CONFIG_CAN)
 	[SKB_EXT_CAN] =3D SKB_EXT_CHUNKSIZEOF(struct can_skb_ext),
 #endif
+#if IS_ENABLED(CONFIG_HSR)
+	[SKB_EXT_HSR] =3D SKB_EXT_CHUNKSIZEOF(struct hsr_ptp_ext),
+#endif
 };
=20
 static __always_inline unsigned int skb_ext_total_length(void)
diff --git a/net/hsr/Kconfig b/net/hsr/Kconfig
index fcacdf4f0ffc3..973f8b03aeb11 100644
--- a/net/hsr/Kconfig
+++ b/net/hsr/Kconfig
@@ -5,6 +5,7 @@
=20
 config HSR
 	tristate "High-availability Seamless Redundancy (HSR & PRP)"
+	select SKB_EXTENSIONS
 	help
 	  This enables IEC 62439 defined High-availability Seamless
 	  Redundancy (HSR) and Parallel Redundancy Protocol (PRP).
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index d1bfc49b5f017..f755f3c85d89d 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -230,6 +230,13 @@ static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, s=
truct net_device *dev)
 	master =3D hsr_port_get_hsr(hsr, HSR_PT_MASTER);
 	if (master) {
 		skb->dev =3D master->dev;
+
+		/* Only HSR (not PRP) skb may include a header. The network
+		 * header is only set to the ethernet header.
+		 */
+		if (hsr_skb_has_header(skb))
+			skb_set_network_header(skb, ETH_HLEN + HSR_HLEN);
+
 		skb_reset_mac_header(skb);
 		skb_reset_mac_len(skb);
 		spin_lock_bh(&hsr->seqnr_lock);
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index aefc9b6936ba0..6fb83a36a44d8 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -12,11 +12,25 @@
 #include <linux/skbuff.h>
 #include <linux/etherdevice.h>
 #include <linux/if_vlan.h>
+#include <net/sock.h>
 #include "hsr_main.h"
 #include "hsr_framereg.h"
=20
 struct hsr_node;
=20
+static void hsr_parse_req_master(struct hsr_frame_info *frame,
+				 unsigned int *port,
+				 bool *header)
+{
+	*port =3D HSR_PT_NONE;
+	*header =3D false;
+
+	if (!frame->skb_std)
+		return;
+
+	hsr_skb_get_header_port(frame->skb_std, header, port);
+}
+
 /* The uses I can see for these HSR supervision frames are:
  * 1) Use the frames that are sent after node initialization ("HSR_TLV.Typ=
e =3D
  *    22") to reset any sequence_nr counters belonging to that node. Usefu=
l if
@@ -343,7 +357,10 @@ struct sk_buff *hsr_create_tagged_frame(struct hsr_fra=
me_info *frame,
 		hsr_set_path_id(frame, hsr_ethhdr, port);
 		return skb_clone(frame->skb_hsr, GFP_ATOMIC);
 	} else if (port->dev->features & NETIF_F_HW_HSR_TAG_INS) {
-		return skb_clone(frame->skb_std, GFP_ATOMIC);
+		skb =3D skb_clone(frame->skb_std, GFP_ATOMIC);
+		if (hsr_skb_has_port(skb))
+			skb_set_owner_w(skb, frame->skb_std->sk);
+		return skb;
 	}
=20
 	/* Create the new skb with enough headroom to fit the HSR tag */
@@ -365,6 +382,15 @@ struct sk_buff *hsr_create_tagged_frame(struct hsr_fra=
me_info *frame,
 	memmove(dst, src, movelen);
 	skb_reset_mac_header(skb);
=20
+	if (hsr_skb_has_port(skb)) {
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
@@ -387,12 +413,23 @@ struct sk_buff *prp_create_tagged_frame(struct hsr_fr=
ame_info *frame,
 		}
 		return skb_clone(frame->skb_prp, GFP_ATOMIC);
 	} else if (port->dev->features & NETIF_F_HW_HSR_TAG_INS) {
-		return skb_clone(frame->skb_std, GFP_ATOMIC);
+		skb =3D skb_clone(frame->skb_std, GFP_ATOMIC);
+		if (hsr_skb_has_port(skb))
+			skb_set_owner_w(skb, frame->skb_std->sk);
+		return skb;
 	}
=20
 	skb =3D skb_copy_expand(frame->skb_std, skb_headroom(frame->skb_std),
 			      skb_tailroom(frame->skb_std) + HSR_HLEN,
 			      GFP_ATOMIC);
+	if (hsr_skb_has_port(skb)) {
+		/* Packets are bound to a port and the sender may expect time
+		 * information.
+		 */
+		skb_shinfo(skb)->tx_flags =3D skb_shinfo(frame->skb_std)->tx_flags;
+		skb_shinfo(skb)->tskey =3D skb_shinfo(frame->skb_std)->tskey;
+		skb_set_owner_w(skb, frame->skb_std->sk);
+	}
 	return prp_fill_rct(skb, frame, port);
 }
=20
@@ -420,7 +457,7 @@ static void hsr_deliver_master(struct sk_buff *skb, str=
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
@@ -518,12 +555,18 @@ bool hsr_drop_frame(struct hsr_frame_info *frame, str=
uct hsr_port *port)
  */
 static void hsr_forward_do(struct hsr_frame_info *frame)
 {
+	unsigned int req_tx_port;
+	bool req_tx_keep_header;
 	struct hsr_port *port;
-	struct sk_buff *skb;
 	bool sent =3D false;
=20
+	hsr_parse_req_master(frame, &req_tx_port, &req_tx_keep_header);
+
 	hsr_for_each_port(frame->port_rcv->hsr, port) {
 		struct hsr_priv *hsr =3D port->hsr;
+		unsigned int skb_rx_port =3D 0;
+		struct sk_buff *skb =3D NULL;
+
 		/* Don't send frame back the way it came */
 		if (port =3D=3D frame->port_rcv)
 			continue;
@@ -542,6 +585,38 @@ static void hsr_forward_do(struct hsr_frame_info *fram=
e)
 		if ((port->dev->features & NETIF_F_HW_HSR_DUP) && sent)
 			continue;
=20
+		/* RX PTP packets have the received port recorded */
+		if (frame->skb_hsr)
+			skb =3D frame->skb_hsr;
+		else if (frame->skb_prp)
+			skb =3D frame->skb_prp;
+
+		skb_rx_port =3D hsr_skb_has_port(skb);
+		if (skb_rx_port) {
+			/* No PTP forwarding */
+			if (port->type !=3D HSR_PT_MASTER)
+				continue;
+
+			skb =3D skb_clone(skb, GFP_ATOMIC);
+			/* Inject the PTP packet into the master interface
+			 * with HSR headers.
+			 */
+			goto inject_into_stack;
+		}
+
+		/* PTP TX packets have an outgoing port specified */
+		if (req_tx_port !=3D HSR_PT_NONE && req_tx_port !=3D port->type)
+			continue;
+		/* PTP TX packets may already have a HSR header which needs to
+		 * be preserved
+		 */
+		if (req_tx_keep_header) {
+			skb =3D skb_clone(frame->skb_std, GFP_ATOMIC);
+			if (skb)
+				skb_set_owner_w(skb, frame->skb_std->sk);
+			goto inject_into_stack;
+		}
+
 		/* Don't send frame over port where it has been sent before.
 		 * Also for SAN, this shouldn't be done.
 		 */
@@ -569,6 +644,7 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
 		else
 			skb =3D hsr->proto_ops->get_untagged_frame(frame, port);
=20
+inject_into_stack:
 		if (!skb) {
 			frame->port_rcv->dev->stats.rx_dropped++;
 			continue;
@@ -633,6 +709,13 @@ int hsr_fill_frame_info(__be16 proto, struct sk_buff *=
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
@@ -658,7 +741,16 @@ int prp_fill_frame_info(__be16 proto, struct sk_buff *=
skb,
 			struct hsr_frame_info *frame)
 {
 	/* Supervision frame */
-	struct prp_rct *rct =3D skb_get_PRP_rct(skb);
+	struct prp_rct *rct;
+
+	if (frame->has_foreign_header) {
+		struct hsr_port *port =3D frame->port_rcv;
+
+		frame->skb_std =3D skb;
+		WARN_ON_ONCE(port->type !=3D HSR_PT_MASTER);
+		return 0;
+	}
+	rct =3D skb_get_PRP_rct(skb);
=20
 	if (rct &&
 	    prp_check_lsdu_size(skb, rct, frame->is_supervision)) {
@@ -697,10 +789,15 @@ static int fill_frame_info(struct hsr_frame_info *fra=
me,
 	if (port->type =3D=3D HSR_PT_INTERLINK)
 		n_db =3D &hsr->proxy_node_db;
=20
-	frame->node_src =3D hsr_get_node(port, n_db, skb,
-				       frame->is_supervision, port->type);
-	if (!frame->node_src)
-		return -1; /* Unknown node and !is_supervision, or no mem */
+	if (hsr_skb_has_header(skb))
+		frame->has_foreign_header =3D true;
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
@@ -739,7 +836,8 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_po=
rt *port)
 	if (fill_frame_info(&frame, skb, port) < 0)
 		goto out_drop;
=20
-	hsr_register_frame_in(frame.node_src, port, frame.sequence_nr);
+	if (!frame.has_foreign_header)
+		hsr_register_frame_in(frame.node_src, port, frame.sequence_nr);
 	hsr_forward_do(&frame);
 	rcu_read_unlock();
 	/* Gets called for ingress frames as well as egress from master port.
diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
index c65ecb9257348..fc0341b158f67 100644
--- a/net/hsr/hsr_framereg.h
+++ b/net/hsr/hsr_framereg.h
@@ -27,6 +27,7 @@ struct hsr_frame_info {
 	bool is_local_dest;
 	bool is_local_exclusive;
 	bool is_from_san;
+	bool has_foreign_header;
 };
=20
 void hsr_del_self_node(struct hsr_priv *hsr);
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index 44f83c8c56a79..cd2092527c780 100644
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
@@ -65,8 +64,7 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buf=
f **pskb)
 	if ((!hsr->prot_version && protocol =3D=3D htons(ETH_P_PRP)) ||
 	    protocol =3D=3D htons(ETH_P_HSR)) {
 		if (!pskb_may_pull(skb, ETH_HLEN + HSR_HLEN)) {
-			kfree_skb(skb);
-			goto finish_consume;
+			goto finish_free_consume;
 		}
=20
 		skb_set_network_header(skb, ETH_HLEN + HSR_HLEN);
@@ -81,10 +79,37 @@ static rx_handler_result_t hsr_handle_frame(struct sk_b=
uff **pskb)
 		hsr_forward_skb(skb, port);
 		spin_unlock_bh(&hsr->seqnr_lock);
 	} else {
+		struct hsr_ethhdr *hsr_ethhdr;
+
+		/* PTP packets are not supposed to be forwarded via HSR/ PRP
+		 * as-is. The latency introduced by forwarding renders
+		 * the time information useless.
+		 * Instead attach the port information on which it was
+		 * received, forward both copies to userland and let it deal
+		 * with it.
+		 */
+		if ((!hsr->prot_version && protocol =3D=3D htons(ETH_P_PRP)) ||
+		    protocol =3D=3D htons(ETH_P_HSR)) {
+			/* HSR */
+			hsr_ethhdr =3D (struct hsr_ethhdr *)skb_mac_header(skb);
+			if (hsr_ethhdr->hsr_tag.encap_proto =3D=3D htons(ETH_P_1588)) {
+				if (!hsr_skb_add_header_port(skb, false, port->type))
+					goto finish_free_consume;
+			}
+		} else {
+			if (protocol =3D=3D htons(ETH_P_1588)) {
+				if (!hsr_skb_add_header_port(skb, false, port->type))
+					goto finish_free_consume;
+			}
+		}
+
 		hsr_forward_skb(skb, port);
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

--=20
2.53.0


