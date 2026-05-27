Return-Path: <netdev+bounces-292343-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PzPBj8KF2pB2AcAu9opvQ
	(envelope-from <netdev+bounces-292343-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:14:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 459D45E6A65
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 584F43028B67
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B298D429818;
	Wed, 27 May 2026 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f4QTad8S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I0Z1RFP4"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFDC426ED8
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894635; cv=none; b=PSEfb34jfznCKQAFjwR/kTljpuJNkQqNav6dvz4L/ln10TjOatBBXM1W+Hx0AHgL+FES8ibcEAOfqOqxDwMrHOQ9fTBP+8tnMic1aRVCAYhdS1fh5FqAt64VHRKe3U69KVNq0CfkzEb7AGf6bV51eEDYM1sRsfph5//esT1dn50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894635; c=relaxed/simple;
	bh=qQwZLBw8jba0LuomOLPK5w+3632BJit0b43qvO6t2AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TztsLQh6VPw/Rvx3zZrWiWoZP/OnMp3NULGCHL0VWu8gl3SwDZ2g44E+h12ZV8D/BuzyQJR+BTeQMxAzA81JlSGtj5IrgOXHHo79NLFOFjuG9qW0E3lU8Was/NN4949f3A7LvEO1rAkjV0gDk0u7SKjIXKY2adE4jrquVPqOmRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f4QTad8S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I0Z1RFP4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779894628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gY6SL1eUjNWGyf9hrC/dwsAtV5NTHT51VSCrTZugbpU=;
	b=f4QTad8SQAwS0aDGEyk7AKElGgb4291KZgBEkFF3zxg7EqwR/rvyqXfenqjrbm5RKSWV2y
	ej97mdynWn9o34gNANBKpE6N9+62LmA0AYBWZgEbga1K1Ji/dWS1+EGsn++Q9/qD7mGXWr
	I5rsQF8swwkFzA4T0YAiJZF9Tx706XNKApQSmkiFipELy+2FwZUuPExeQKzew5eayySIVS
	O2PmE0P0A0JhXXQaEq1e7JTptDoUpzjBjSY0dfuONPnlNZljNExJsamAxTOhC8k64i3xYm
	NS1ZYkelWkYCTHcqgkJb6c90Lj3EchZqxoBemXJCjGuIsmV3VQ/yryCO/9bEUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779894628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gY6SL1eUjNWGyf9hrC/dwsAtV5NTHT51VSCrTZugbpU=;
	b=I0Z1RFP4kdAoGxKt0ue+AO2CJVT3BUx9Vghm+RAV+ChA0QlWsriGoYi+ZYkFqx3XTEuOOI
	wc3LqqDXp/nStMAw==
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
Subject: [PATCH net-next v5 1/8] hsr: Add header_ops::parse_protocol
Date: Wed, 27 May 2026 17:08:51 +0200
Message-ID: <20260527-hsr_ptp-v5-1-158a7633eac0@linutronix.de>
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
	TAGGED_FROM(0.00)[bounces-292343-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linutronix.de:email,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: 459D45E6A65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

af_packet uses dev_parse_header_protocol() to assign skb::protocol.
The hsr stack does not assign a callback so the field is assigned to 0.

The header used by the hsr stack corresponds to the ethernet header for
the "first" part so the protocol member is at the same position.

Use eth_header_parse_protocol() for the hsr_header_ops's parse_protocol
callback.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/hsr/hsr_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 5555b71ab19b5..a999ddccc46c5 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -247,6 +247,7 @@ static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, st=
ruct net_device *dev)
 static const struct header_ops hsr_header_ops =3D {
 	.create	 =3D eth_header,
 	.parse	 =3D eth_header_parse,
+	.parse_protocol =3D eth_header_parse_protocol,
 };
=20
 static struct sk_buff *hsr_init_skb(struct hsr_port *master, int extra)

--=20
2.53.0


