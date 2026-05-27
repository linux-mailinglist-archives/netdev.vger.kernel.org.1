Return-Path: <netdev+bounces-292347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +My6G4wKF2pB2AcAu9opvQ
	(envelope-from <netdev+bounces-292347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:15:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF32D5E6AB8
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F7B83048548
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF82428849;
	Wed, 27 May 2026 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iEYPki9d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C2LhLrXv"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5B0428487
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 15:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894643; cv=none; b=ohlyVyqqoCKkC/N/k33PL16EcsCZHh6o7JbOAAMnN2mE6FGpd8EvH1BPPMIFXNzzrTDHWDwgaQnFbsN9+A1O7m8fZVP45Cob6nCcIi6Q3AmYxtKoJYH45abPFTNvHsDx1U8xqR4CE5Ogx6yvRx7NsOZob2J2icvVVrg5rhy8lV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894643; c=relaxed/simple;
	bh=KmgGr+ylasiqJgCeOxWMVsRM5qQH4MNxPEZKXo8YyHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9UlDRA8fKq0J5CnFYTK/SuERtYIcYitRq1aKYCvwBefv3tRBiPk6kqBMrJM9z5EXpsE1h6+uPICSKGABqnxBW+gSly23EI3PSQNqfw8OZrPGBKe/Mn8XmpptJK6O4+1k7uZPI1JCPZthJBb94UH3k1a7YGnu5EXAya+nJqxMTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iEYPki9d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C2LhLrXv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779894629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=44rL90hQC6iBOkSormC9pHFc+LBmbAvJDgeKiapsfmI=;
	b=iEYPki9dhuUMlqNyShGNpWMerBg5gl00vTFxe9mcVyuERWIjh7pK+EJNlsBOAxoHdqcRPu
	Ng1PCDSG08Cocp9sgNEKrNdQluunC35YcCHypwbrgBDXnQVgLrRPPXVmZSXJ6U3h++sl73
	oyUKt2flcJA/tFP1c6ZnahavFC83w7kNsVe0D5kFvzUwbtZ8L+c2fWgn7xoT4PSRnlaBLY
	z3ykN5qLmX3Nedhfh5HjlVU3qRn8tFHVYgv3tnhzh9OwA/9GDfZbZ7MYT9J/S5tbqPqMM7
	q9p8z85d4kWRWApr/+ItdyuT8ghB7pCfFdxCtUSJ54mADPUDGGNmYRHS5SGOrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779894629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=44rL90hQC6iBOkSormC9pHFc+LBmbAvJDgeKiapsfmI=;
	b=C2LhLrXvttE84E6O6BXuNqQze58ydwBKI2eytv+YDL5y7frXnZDJP4RWicdlBiVY05ka/9
	I9icNLMv1xyDS2Bg==
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
Subject: [PATCH net-next v5 4/8] hsr: Drop received PTP packets
Date: Wed, 27 May 2026 17:08:54 +0200
Message-ID: <20260527-hsr_ptp-v5-4-158a7633eac0@linutronix.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292347-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,linutronix.de:mid,linutronix.de:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BF32D5E6AB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Receiving PTP packets via the HSR interface does not make sense. The HSR
stack will forward one copy to the user and ignore the duplicate from
the other port. The PTP stack is however interested in both copies since
they will have different content (due to different processing times
within the HSR ring) and different timestamp information which is not
forwarded at all.

Forwarding a PTP packet by the HSR stack is undesired because the
forwarding takes time, it is not accounted in the packet and this makes
the outgoing PTP packet inaccurate and therefore useless.

Drop all received PTP packets. For the PRP configuration it is the
ether type, for HSR configuration it is the encapsulated protocol, that
is checked. A PTP stack that is doing PTP over a HSR network needs to
retrieve the PTP packet on the original slave interface where it was
received.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/hsr/hsr_slave.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index 0f2cedaffa347..7cc0641dbd137 100644
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
 		hsr_forward_skb(skb, port, HSR_PT_NONE, false);
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
 		hsr_forward_skb(skb, port, HSR_PT_NONE, false);
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


