Return-Path: <netdev+bounces-272465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKX4KJJExmmgIAUAu9opvQ
	(envelope-from <netdev+bounces-272465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 09:49:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AECE43414AF
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 09:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BBD1F3008455
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924F13D8127;
	Fri, 27 Mar 2026 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="rnwaK1a9"
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68092D3EE5;
	Fri, 27 Mar 2026 08:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774601355; cv=none; b=Dxy/JHboRqo3+OaQrADyOLtJ/AOzGqlanf0nXx06h65bXPuu8NmHpv8wO3yBJl8Vzz0ASe7XTnZwjZEQxEwYLuGql0RKsPDqfJKm0r7ehXrItLMeLKtGeubfIu3lMVDlCirPUKXxHTT5c/6H+Kln/MHl0gbVSo4yeGt8fDxnhsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774601355; c=relaxed/simple;
	bh=AszbKk2UbW/3YlByw22wCgCrsW1o6pJgrdRCwlXFd3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:Cc; b=hkeGw8conn8izw0nSQYghbZR+/2kvdMqP7O8V0vU5Ofsu4Bat8WlUmv1U2yQeptplud8YrvvAeDHOZ/fi/azDX5XodEI99LLc9ZD7diOOTmtxuA5kjU5bk0SptEg1YQhlRw1iSEQOjNXlwowAWAgNCf0nPoY5n+kuWDlE3ZkuoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=rnwaK1a9; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=6560504b2e=ms@dev.tdt.de>)
	id 1w62sN-00GYrU-Hn; Fri, 27 Mar 2026 09:49:07 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1w62sM-002zRG-Ol; Fri, 27 Mar 2026 09:49:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1774601346;
	bh=myEI14OaJ5vlN9nRaS+DEQwHA9TNMsxy8cNQZpWUwc8=;
	h=From:Date:Subject:To:Cc:From;
	b=rnwaK1a94NT1Y4Ih9vi85yyVImKmUnF1ZU+yXg1Nb4SbVBBxMJHefQmZilzlhg1Vl
	 BJgHjIGegqfmwtzX3aLLbu3zhJ7jk6IfZBN51HU7fZ32rXhAFyrYa54TRiL0ulJA/c
	 WdadSANtAsBCdzYYrF1d6iGx3soFEYzxVHXnxbT860wims7oM6sG5/bnMyJRFVLEO3
	 Z8MJn8+manKu6yqalpYEjEmqvXKBy1wKAFH+HGyoAbGAJCgN1skoW3lTIRaTUxp8Y1
	 65S5naBfwx+uVUAkQ7CEeaiDZO4bUZZw38Fv/49iwy6Fcs8SH4H6IgkN5Ts65RR2d7
	 4iZXubjxxThMQ==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 26D1F240040;
	Fri, 27 Mar 2026 09:49:06 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 19281240036;
	Fri, 27 Mar 2026 09:49:06 +0100 (CET)
Received: from [127.0.1.1] (unknown [10.2.3.19])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id E46E3210AC;
	Fri, 27 Mar 2026 09:49:05 +0100 (CET)
From: Martin Schiller <ms@dev.tdt.de>
Date: Fri, 27 Mar 2026 09:49:02 +0100
Subject: [PATCH net v2] net/x25: Fix overflow when accumulating packets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260327-x25_fraglen-v2-1-143911c3f62a@dev.tdt.de>
X-B4-Tracking: v=1; b=H4sIAH1ExmkC/1WNQQrDIBRErxL+ugY12rRd9R4llOD/JkIxRUVSg
 nevSDddvhnmzQGRgqMIt+6AQNlFt/kK8tSBWWe/EHNYGSSXZz5IzXapnzbMy4s8u1gjFUdBiAP
 UxTuQdXuzPcBTgqmGq4tpC5/2kEWrfrLxT5YFE+xqzagFKjtqdUfKfcLUI8FUSvkCLfOgo6wAA
 AA=
X-Change-ID: 20260325-x25_fraglen-8fc240d1edd3
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Yiming Qian <yimingqian591@gmail.com>, linux-x25@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	security@kernel.org, Martin Schiller <ms@dev.tdt.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774601345; l=1712;
 i=ms@dev.tdt.de; s=20260220; h=from:subject:message-id;
 bh=AszbKk2UbW/3YlByw22wCgCrsW1o6pJgrdRCwlXFd3A=;
 b=qOX6IEPtyPoTNmSlCc6CCNmXY5l+QjdKavO7qtzQ5LjkoyQkHd2sluFSAGu/lbR5MOxC5oyCl
 inno2UZB/BkC40gTNo+Y7d0adtR1qK6TKoRrpBbM0oDTLdMnr+LTUhc
X-Developer-Key: i=ms@dev.tdt.de; a=ed25519;
 pk=MAojd7D5IafMnqCYSFC7hY/u/jppX58CLIEhsEsSOYE=
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1774601347-A6786013-7F5441A1/0/0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tdt.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[dev.tdt.de:s=z1-selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tdt.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,dev.tdt.de:dkim,dev.tdt.de:mid];
	DKIM_TRACE(0.00)[dev.tdt.de:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,dev.tdt.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272465-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ms@dev.tdt.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: AECE43414AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a check to ensure that `x25_sock.fraglen` does not overflow.

The `fraglen` also needs to be resetted when purging `fragment_queue` in
`x25_clear_queues()`.

Reported-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
Changes in v2:
- Use USHRT_MAX instead of sizeof(fraglen) nonsense
- Link to v1: https://lore.kernel.org/r/20260327-x25_fraglen-v1-1-9fc751d4f754@dev.tdt.de
---
 net/x25/x25_in.c   | 6 ++++++
 net/x25/x25_subr.c | 1 +
 2 files changed, 7 insertions(+)

diff --git a/net/x25/x25_in.c b/net/x25/x25_in.c
index b981a4828d08c2e6676749a06035910eab01e6cd..cb84c683d249d6078f3673835bb2f80eb487f253 100644
--- a/net/x25/x25_in.c
+++ b/net/x25/x25_in.c
@@ -34,6 +34,12 @@ static int x25_queue_rx_frame(struct sock *sk, struct sk_buff *skb, int more)
 	struct sk_buff *skbo, *skbn = skb;
 	struct x25_sock *x25 = x25_sk(sk);
 
+	/* make sure we don't overflow */
+	if (x25->fraglen + skb->len > USHRT_MAX) {
+		kfree_skb(skb);
+		return 1;
+	}
+
 	if (more) {
 		x25->fraglen += skb->len;
 		skb_queue_tail(&x25->fragment_queue, skb);
diff --git a/net/x25/x25_subr.c b/net/x25/x25_subr.c
index 0285aaa1e93c17233748d38eef6d8b5c6059b67a..159708d9ad20cb2e6db24ead67daf1e9d6258f64 100644
--- a/net/x25/x25_subr.c
+++ b/net/x25/x25_subr.c
@@ -40,6 +40,7 @@ void x25_clear_queues(struct sock *sk)
 	skb_queue_purge(&x25->interrupt_in_queue);
 	skb_queue_purge(&x25->interrupt_out_queue);
 	skb_queue_purge(&x25->fragment_queue);
+	x25->fraglen = 0;
 }
 
 

---
base-commit: 4ae97cae07e15d41e5c0ebabba64c6eefdeb0bbe
change-id: 20260325-x25_fraglen-8fc240d1edd3

Best regards,
-- 
Martin Schiller <ms@dev.tdt.de>


