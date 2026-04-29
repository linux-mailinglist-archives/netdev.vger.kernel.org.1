Return-Path: <netdev+bounces-282406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GZbEhIQ8mmPngEAu9opvQ
	(envelope-from <netdev+bounces-282406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 16:05:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7865F4954DE
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 16:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A8660300FEF8
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2798A3F789A;
	Wed, 29 Apr 2026 14:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aODQHHvQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mVc3ZFuR"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B595933F58E
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471270; cv=none; b=acwQQ+oZ2lQUueQTqgOmrGyB6yy91Ro+fha5ci0FonxMCAq8X1drOU7bX9AWPsDvOaRADxxCIKCZrasc/+/akoGq9nOHXwol4ajYAuv8kIpAtcidFNNuoqS19SiQTb5Cwv6akJsn5SfGaiohonfwpVRz2rHunT1bB0Fy4sMHe3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471270; c=relaxed/simple;
	bh=Tm5G/lo1oE8bqSotlhwVupBL4cH0RnDa6Xoi1wnW0/A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XWRKqzOVUV28BaOQtEWEfrqHTMJFIbKAzZMcFD1nXL297L2C9NyUORj/OUB5PJZbMMw04tYg7U0/qLcIMo/ws8LKYRhOGOG+xbtMKhfpyxzHwBxkFlDoceym0ugaTn/5VByYv5lZ5skZ/MknDahtg2gcTmvgdBSdRyfjvG9ndbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aODQHHvQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mVc3ZFuR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Apr 2026 16:01:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777471265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=coOKlP239TMLJk8EM9aK8P++hTKxjYFyMPsW7gmJVco=;
	b=aODQHHvQ/T/1uQCy46yELnBrQntCzjaNoIGEsoT9TFYPbYlWIEG6bK7xknn5F8qM9ztEOL
	6qbvZMi9bkF7YtzXmjCqBwpHtwGVdd4q8QcO4wynZ0jyiLcb/my6hRZdLtOwSa3IPkEzhI
	aNgvVfEoa/P3n2YP1s9p7sL9DGT+5kiX0JhztzPr2WAPBowHILBVEdjBZvqz2aWjyDiOfp
	pipIm8BOLk2hAMUu/oap8SG271V7CLxTW0p5ncIDgZqjlA7vI77Ic1pf5mIi1iS4m4i08+
	fNQTZAvQw4e7Qjii9cxAYu87hYmzfp7iyJ41+VUENoxQSEvNX459xY5G9APi6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777471265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=coOKlP239TMLJk8EM9aK8P++hTKxjYFyMPsW7gmJVco=;
	b=mVc3ZFuRJ/opvmMm3o9QrgsxUgkNeQ3jWMyA0/FsCd8OHRedYEYF4wsmf9HBI5quAa2/Pq
	hZsGfISh2G7KrzDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Chintan Vankar <c-vankar@ti.com>,
	Danish Anwar <danishanwar@ti.com>, Daolin Qiu <d-qiu@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>, Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RFC net-next v3] hsr: Allow to send a specific port and with
 HSR header
Message-ID: <20260429-hsr_ptp-v3-1-afbf8f200f48@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-B4-Tracking: v=1; b=H4sIAF8B8mkC/2WOywrCMBBFf6VkbSSP2lpXguAHuBWR2EztgKY1S
 UOl9N8NURB0ebnn3JmJOLAIjmyyiVgI6LAzMchFRupWmStQ1DETwUTBBMtp6+y59z3lTSHXrOF
 arhoS6d5Cg2NaOpLDfpcZ8NTA6Mnp3Vp4DHHef5CLckDr7n5Hv8lCueTU1jyxLTrf2Wd6KfAE/
 10PnDJ6yQWvi0qVpVbbG5rB287guNSQdoL4upJVX1dEt6zWohBKaanyX3ee5xeRIryHGAEAAA= =
X-Change-ID: 20260204-hsr_ptp-1f6380f1d35f
X-Rspamd-Queue-Id: 7865F4954DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,ti.com,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,linutronix.de];
	TAGGED_FROM(0.00)[bounces-282406-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_SOME(0.00)[]

HSR forwards all packets it received on slave port 1 to slave port 2 and
one of the two copies to the user (master) interface.
In terms of PTP this is not good because the latency introduced by
forwarding makes the timestamp in the PTP packet inaccurate.
The PTP packets should not forwarded like regular packets.

In order to work with PTP over HSR the following has been done:
- PTP packets which are received are dropped within the HSR stack. That
  means they are not forwarded or injected into the master port. If the
  user requires them, then they need to be obtained directly from the
  SLAVE interface.

- Sending packets. If the ethernet type of the packet is ETH_P_1588 then
  the stack assumes a header of type struct hsr_inline_header. The size
  of this header is as ethhdr. As a safeguard, the header contains a
  magic field which matches the position of h_source and it needs to
  match HSR_INLINE_HDR.
  Once this is verified, the header contains the port on which this
  packet needs to be sent and if system's HSR header should be added.
  This information is used with the HSR stack and also attached to skb
  as a skb-extension. The packet is then pulled passed the custom header
  so the remaining stack will see the actual data.
  The skb-extension is needed so that an ethernet driver, with
  HSR-offload capabilities, knows that it must not add HSR-header (unless
  requested) and send the packet on both ports.

The originally submitted skb is freed and only the (altered) clone is
submitted to the slave interface for sending. Therefore on cloning, the
socket and tx_flags/ tskey are copied so that the PTP timestamp is
forwarded to the submitting socket.

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
This information is then added to a skb-extension, the header is skipped
so that the remaining stack sees the actual data and then send it as
requested.

The PRP packets are sent directly via the SLAVE interface. The standard
mandates not add a PRP trailer (PRP, redundancy control trailer) to PTP
packets. There not really a reason to use hsr interface.

HSR hardware offloading is optional. If the skb has a HSR skb-extension
then based on the provided information it decides if it is required to
add a HSR-header or send it as-is.
If the extension is not present and the ethernet type is PTP then it
assumes a PRP network and the packet is sent as-is on the requested
port.

This has been tested in a pure software environment and in an HW-assisted
environment where the HW is able to duplicate and duplicate packets
but does not do it for PTP packets.
It has not been tested within an environment where the HW is able to
forward the PTP packet and correctly update the timing information.
---
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
 include/linux/if_hsr.h | 87 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 include/linux/skbuff.h |  3 ++
 net/core/skbuff.c      |  4 +++
 net/hsr/Kconfig        |  1 +
 net/hsr/hsr_device.c   | 51 +++++++++++++++++++++++------
 net/hsr/hsr_forward.c  | 74 +++++++++++++++++++++++++++++++++++++-----
 net/hsr/hsr_framereg.h |  1 +
 net/hsr/hsr_slave.c    | 33 +++++++++++++++----
 8 files changed, 229 insertions(+), 25 deletions(-)

diff --git a/include/linux/if_hsr.h b/include/linux/if_hsr.h
index f4cf2dd36d193..220f6e5d7b24c 100644
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
@@ -22,6 +23,21 @@ enum hsr_port_type {
 	HSR_PT_PORTS,	/* This must be the last item in the enum */
 };
=20
+struct hsr_ptp_ext {
+	u8	port;
+	u8	header;
+};
+
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
@@ -45,6 +61,60 @@ struct net_device *hsr_get_port_ndev(struct net_device *=
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
@@ -68,6 +138,23 @@ static inline int hsr_get_port_type(struct net_device *=
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
 #endif /* CONFIG_HSR */
=20
 #endif /*_LINUX_IF_HSR_H_*/
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2bcf78a4de7b9..17918eecaf6cf 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -5030,6 +5030,9 @@ enum skb_ext_id {
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
index 7dad68e3b5186..fa0780c4b7d1b 100644
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
@@ -5116,6 +5117,9 @@ static const u8 skb_ext_type_len[] =3D {
 #if IS_ENABLED(CONFIG_CAN)
 	[SKB_EXT_CAN] =3D SKB_EXT_CHUNKSIZEOF(struct can_skb_ext),
 #endif
+#if IS_ENABLED(CONFIG_HSR)
+	[SKB_EXT_HSR] =3D SKB_EXT_CHUNKSIZEOF(struct hsr_ptp_ext),
+#endif
 };
=20
 static __always_inline __no_profile unsigned int skb_ext_total_length(void)
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
index 5555b71ab19b5..ac39b2347aa0f 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -228,20 +228,51 @@ static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, =
struct net_device *dev)
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
+			enum hsr_port_type tx_port;
+			bool has_header;
+
+			has_header =3D hsr_opt->hsr_hdr;
+			tx_port =3D hsr_opt->tx_port;
+			if (tx_port !=3D HSR_PT_SLAVE_A && tx_port !=3D HSR_PT_SLAVE_B)
+				goto drop;
+
+			if (!hsr_skb_add_header_port(skb, has_header, tx_port))
+				goto drop;
+
+			skb_pull(skb, ETH_HLEN);
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
+	hsr_forward_skb(skb, master);
+	spin_unlock_bh(&hsr->seqnr_lock);
+
 	rcu_read_unlock();
=20
 	return NETDEV_TX_OK;
+
+drop:
+	dev_core_stats_tx_dropped_inc(dev);
+	dev_kfree_skb_any(skb);
+	rcu_read_unlock();
+	return NETDEV_TX_OK;
 }
=20
 static const struct header_ops hsr_header_ops =3D {
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 0aca859c88cbb..3345eb26cd98e 100644
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
@@ -420,7 +446,7 @@ static void hsr_deliver_master(struct sk_buff *skb, str=
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
@@ -518,12 +544,17 @@ bool hsr_drop_frame(struct hsr_frame_info *frame, str=
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
+		struct sk_buff *skb =3D NULL;
+
 		/* Don't send frame back the way it came */
 		if (port =3D=3D frame->port_rcv)
 			continue;
@@ -542,6 +573,19 @@ static void hsr_forward_do(struct hsr_frame_info *fram=
e)
 		if ((port->dev->features & NETIF_F_HW_HSR_DUP) && sent)
 			continue;
=20
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
@@ -569,6 +613,7 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
 		else
 			skb =3D hsr->proto_ops->get_untagged_frame(frame, port);
=20
+inject_into_stack:
 		if (!skb) {
 			frame->port_rcv->dev->stats.rx_dropped++;
 			continue;
@@ -633,6 +678,13 @@ int hsr_fill_frame_info(__be16 proto, struct sk_buff *=
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
@@ -697,10 +749,15 @@ static int fill_frame_info(struct hsr_frame_info *fra=
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
@@ -739,7 +796,8 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_po=
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
index d9af9e65f72f0..00aa8d848e2a9 100644
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
@@ -81,10 +78,32 @@ static rx_handler_result_t hsr_handle_frame(struct sk_b=
uff **pskb)
 		hsr_forward_skb(skb, port);
 		spin_unlock_bh(&hsr->seqnr_lock);
 	} else {
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

---
base-commit: 5e9b7d093f3f77cb0af4409559e3d139babfb443
change-id: 20260204-hsr_ptp-1f6380f1d35f

Best regards,
--=20
Sebastian Andrzej Siewior <bigeasy@linutronix.de>


