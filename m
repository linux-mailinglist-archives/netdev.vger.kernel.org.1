Return-Path: <netdev+bounces-292344-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOCyCkMKF2pB2AcAu9opvQ
	(envelope-from <netdev+bounces-292344-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:14:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0562C5E6A6C
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47AA6302A2CC
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6F2426EA6;
	Wed, 27 May 2026 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WklaOyB3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xUekpcqU"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBE44279F6
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894638; cv=none; b=TfBOhPPWPukTiVlkDVxRDHn0yFXfqJNmNx0WRU3uUTDS8w82F4qAD1NQmrl6SmSl9wI0mVPKlh4UfpBecW6qKiumHEUxbsDhnzgiblWW36/q7IDgx2OKb72STwrewf4DzVxTr1nlXy/EQHrN42EnbWDZmpTdv2kxWF3o+QbF4T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894638; c=relaxed/simple;
	bh=zSDQAYbLlEI8MBbQklhzuns9NlNjqT7hw55i2xLycd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RWki7Mur2GiNMlKLSLbF7Ub+dYIGoNCAYJdSpG/36CWbMB9lT1ZcKcZAugYYhJzczv3exkF+idSV5aEqgEU2SRGaLghejKia7gYkbmWIptLjc1WWCaFyb2A4T56e4OP7D56D8z287eVOjsSJRshuR7/xoum5ddmj/RAExNg13W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WklaOyB3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xUekpcqU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779894629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TaXgzEMe4MBgsegVkpm579UoaSuHps8rM9aNMwkf090=;
	b=WklaOyB3c0AYio08JCkgfesnGaup4t8myeZoap+T0beoGaN/8l0J2K2RUcij3yvHjB+Wq6
	4gUtW/nd2rnajlQd2UJyoUzvBkYn+fLxcoi8w39VwpyMelo4iUVAZ0GhVQPmJGLlDGqKxz
	7Kymy6kPrbbf5l1fWpO0aNGNQwSIhFCyIZ+LQRRMCAaUAf67xca0NkOV3OPyLt3Rl6sd/l
	cd25NvysQOBHGWCme3ku/a72T7i77kpGufEDbe3QmPYc8Nkz8wMoZAOeMBt0DxkIa1vt+o
	3aQr+y/4jMPAMNQIfBc7URkmHkauyHTVHn9cCw0syMzCDvJyyLq3KeYl7vc8eA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779894629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TaXgzEMe4MBgsegVkpm579UoaSuHps8rM9aNMwkf090=;
	b=xUekpcqUFBmtpLoeJdbIjNYGD8Z6Zd9WbxIXwopx5OvWKDWXRUcvGenudfCWP/CDosxKM8
	lCSWMhPeqvQL/SDQ==
To: netdev@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>,
	Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next v5 3/8] hsr: Add a magic header for sending PTP packets
Date: Wed, 27 May 2026 17:08:53 +0200
Message-ID: <20260527-hsr_ptp-v5-3-158a7633eac0@linutronix.de>
In-Reply-To: <20260527-hsr_ptp-v5-0-158a7633eac0@linutronix.de>
References: <20260527-hsr_ptp-v5-0-158a7633eac0@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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
	TAGGED_FROM(0.00)[bounces-292344-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,lunn.ch,ti.com,davemloft.net,google.com,redhat.com,kernel.org,gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linutronix.de:email,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: 0562C5E6A6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sending PTP packets (ETH_P_1588) via the HSR stack is pointless in its
current shape because the requested PTP timestamp is not routed to the
sender. It also needs to be distinguished on which port the message
should be sent and whether or not a HSR header should be attached.

To pass this information, a custom header (struct hsr_inline_header) is
introduced. This header is expected if the ether type is ETH_P_1588. To
avoid any wrong usage, there is a magic field to ensure it really is the
header.

The inline header is just prepended containing the port and header
parameter. After the header, a regular packet follows. It is ensured that
the inline header and the following ethernet or HSR header is linear
and can be accessed.

The two retrieved parameters are passed to hsr_forward_skb() and will be
used later.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/if_hsr.h | 11 +++++++++
 net/hsr/hsr_device.c   | 61 ++++++++++++++++++++++++++++++++++++++++------=
----
 net/hsr/hsr_forward.c  |  3 ++-
 net/hsr/hsr_forward.h  |  3 ++-
 net/hsr/hsr_slave.c    |  4 ++--
 5 files changed, 66 insertions(+), 16 deletions(-)

diff --git a/include/linux/if_hsr.h b/include/linux/if_hsr.h
index f4cf2dd36d193..1db1bd0fa181d 100644
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
+	__be32 magic;
+	uint8_t __pad1[2];
+	__be16 eth_type;
+} __packed;
+
 /* HSR Tag.
  * As defined in IEC-62439-3:2010, the HSR tag is really { ethertype =3D 0=
x88FB,
  * path, LSDU_size, sequence Nr }. But we let eth_header() create { h_dest,
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index a999ddccc46c5..797e2cf391998 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -223,24 +223,61 @@ static netdev_features_t hsr_fix_features(struct net_=
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
+	if (skb->protocol =3D=3D htons(ETH_P_1588)) {
+		struct hsr_inline_header *hsr_opt;
+		unsigned int hdr_len;
+
+		BUILD_BUG_ON(sizeof(struct hsr_inline_header) !=3D sizeof(struct ethhdr)=
);
+
+		/* need to access the magic header */
+		if (!pskb_may_pull(skb, sizeof(struct hsr_inline_header)))
+			goto drop;
+
+		hsr_opt =3D (struct hsr_inline_header *)skb_mac_header(skb);
+		if (hsr_opt->magic =3D=3D htonl(HSR_INLINE_HDR)) {
+			struct ethhdr *eth_hdr;
+
+			has_header =3D hsr_opt->hsr_hdr;
+			tx_port =3D hsr_opt->tx_port;
+			if (tx_port !=3D HSR_PT_SLAVE_A && tx_port !=3D HSR_PT_SLAVE_B)
+				goto drop;
+
+			eth_hdr =3D skb_pull(skb, sizeof(struct hsr_inline_header));
+			if (has_header)
+				hdr_len =3D ETH_HLEN + HSR_HLEN;
+			else
+				hdr_len =3D ETH_HLEN;
+			skb_set_network_header(skb, hdr_len);
+			/* Ensure the header can be accessed */
+			if (!pskb_may_pull(skb, hdr_len))
+				goto drop;
+			skb->protocol =3D eth_hdr->h_proto;
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
@@ -362,7 +399,7 @@ static void send_hsr_supervision_frame(struct hsr_port =
*port,
 		return;
 	}
=20
-	hsr_forward_skb(skb, port);
+	hsr_forward_skb(skb, port, HSR_PT_NONE, false);
 	spin_unlock_bh(&hsr->seqnr_lock);
 	return;
 }
@@ -403,7 +440,7 @@ static void send_prp_supervision_frame(struct hsr_port =
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
index 632355a6e5faf..699b0619cf469 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -742,7 +742,8 @@ static int fill_frame_info(struct hsr_frame_info *frame,
 }
=20
 /* Must be called holding rcu read lock (because of the port parameter) */
-void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
+void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port,
+		     enum hsr_port_type tx_port, bool has_hsr_header)
 {
 	struct hsr_frame_info frame;
=20
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
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index d9af9e65f72f0..0f2cedaffa347 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -78,10 +78,10 @@ static rx_handler_result_t hsr_handle_frame(struct sk_b=
uff **pskb)
 	 */
 	if (port->type =3D=3D HSR_PT_INTERLINK) {
 		spin_lock_bh(&hsr->seqnr_lock);
-		hsr_forward_skb(skb, port);
+		hsr_forward_skb(skb, port, HSR_PT_NONE, false);
 		spin_unlock_bh(&hsr->seqnr_lock);
 	} else {
-		hsr_forward_skb(skb, port);
+		hsr_forward_skb(skb, port, HSR_PT_NONE, false);
 	}
=20
 finish_consume:

--=20
2.53.0


