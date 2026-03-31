Return-Path: <netdev+bounces-273502-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLiyAgh9y2mLIQYAu9opvQ
	(envelope-from <netdev+bounces-273502-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 09:51:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B248636581F
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 09:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 250F4306C869
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797D43CEB87;
	Tue, 31 Mar 2026 07:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="QfWikLGY"
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D413CCFA9;
	Tue, 31 Mar 2026 07:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943028; cv=none; b=mIAVA3MUTShjB4EiRmkPXhEBayFBs3PLY0wDF/Ff8ZjQzx8+k7V+tRhtsYsOqeHwYSSVG6rgLpjnkNVzsu3Ht+EgUF0HgjmDlSKiIpHnlT+7BEr3/Z7p3CGex0jsdCUbGnTc8Lx/2ZItkCvJxUIVyJsz0/ry2ph5J0XGOUGEoPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943028; c=relaxed/simple;
	bh=OdWsXOSpKx2KIVeAFa5xlYv3FnOYDsT/6PebGCuKocA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:Cc; b=kvfqPIJhi48hkzzno6VSTvdtPL2rovDjiUN+6h160/ZGhNbwxy94VeqIFOyWAsQEZyyADna386WAP2dT4/47He857F6+jLijesBk0lnl9vX+fyDIJIenjl/HOpHTXHDQuwuo6G8o1cW/bjfIGO+gFuLgydAF+NESF5iXcsbkdBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=QfWikLGY; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=656447fc3f=ms@dev.tdt.de>)
	id 1w7Tl6-00FWkB-62; Tue, 31 Mar 2026 09:43:32 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1w7Tl4-006L8s-V4; Tue, 31 Mar 2026 09:43:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1774943010;
	bh=RoA2ct3WGvm4MFq2PE1vvrax7TpOpLDv7PngWSXsJPI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QfWikLGYlZjty08nrUgN0MWu8fyHfsBw950JpsJFArDkr3ZFVXVQ6fzH76fazc3YV
	 QcH3+op8j0xiVK+eLkiFm/L3X6c58ipcrgL4TSIxnNVqA1zKaOGjX2FXyQcl5fq8Si
	 blLyKkA5JLiBXn3TI+NM6888/Q8rewa1qZmjpfd9U230B0lGhc4gDftAcZcz4TbrHt
	 gPcdC9u0Kr4rM8FmtvazwPnibxKgwBRzA8a2c+oPHW31XRmyyZCNofx29lwMUikiLQ
	 y+/in/SN4QQgW6suar8ZPZyJlF/Lxrs77y8GQVne0qPE9SFIwJ7XgBYZF8mAWjPfuy
	 ee/njllylUzfg==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 62A0D240042;
	Tue, 31 Mar 2026 09:43:30 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 4A744240040;
	Tue, 31 Mar 2026 09:43:30 +0200 (CEST)
Received: from [127.0.1.1] (unknown [10.2.3.19])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 2FE8821989;
	Tue, 31 Mar 2026 09:43:30 +0200 (CEST)
From: Martin Schiller <ms@dev.tdt.de>
Date: Tue, 31 Mar 2026 09:43:17 +0200
Subject: [PATCH net v4 1/2] net/x25: Fix potential double free of skb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260331-x25_fraglen-v4-1-3e69f18464b4@dev.tdt.de>
References: <20260331-x25_fraglen-v4-0-3e69f18464b4@dev.tdt.de>
In-Reply-To: <20260331-x25_fraglen-v4-0-3e69f18464b4@dev.tdt.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Yiming Qian <yimingqian591@gmail.com>, linux-x25@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	security@kernel.org, Martin Schiller <ms@dev.tdt.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774943009; l=1460;
 i=ms@dev.tdt.de; s=20260220; h=from:subject:message-id;
 bh=OdWsXOSpKx2KIVeAFa5xlYv3FnOYDsT/6PebGCuKocA=;
 b=e51TX5V2EIvzzl0DONlvncVMtdme6hep7B3EFNgU2CRWaZyCC/OM1WniHet2gNgW/Blw8tV2J
 +XP26y0Nmn7BQv50uI5nEO5dSLEaVE/osiPCfmEmtJY+7eHF8y8v15w
X-Developer-Key: i=ms@dev.tdt.de; a=ed25519;
 pk=MAojd7D5IafMnqCYSFC7hY/u/jppX58CLIEhsEsSOYE=
X-purgate-type: clean
X-purgate-ID: 151534::1774943011-43C75BD0-9040426B/0/0
X-purgate: clean
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tdt.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[dev.tdt.de:s=z1-selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dev.tdt.de:dkim,dev.tdt.de:mid,tdt.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[dev.tdt.de:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,dev.tdt.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273502-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ms@dev.tdt.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: B248636581F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When alloc_skb fails in x25_queue_rx_frame it calls kfree_skb(skb) at
line 48 and returns 1 (error).
This error propagates back through the call chain:

x25_queue_rx_frame returns 1
    |
    v
x25_state3_machine receives the return value 1 and takes the else
branch at line 278, setting queued=0 and returning 0
    |
    v
x25_process_rx_frame returns queued=0
    |
    v
x25_backlog_rcv at line 452 sees queued=0 and calls kfree_skb(skb)
again

This would free the same skb twice. Looking at x25_backlog_rcv:

net/x25/x25_in.c:x25_backlog_rcv() {
    ...
    queued = x25_process_rx_frame(sk, skb);
    ...
    if (!queued)
        kfree_skb(skb);
}

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 net/x25/x25_in.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/x25/x25_in.c b/net/x25/x25_in.c
index b981a4828d08c2e6676749a06035910eab01e6cd..0dbc73efab1cbd4d98fa77d7a72a2b665203511b 100644
--- a/net/x25/x25_in.c
+++ b/net/x25/x25_in.c
@@ -44,10 +44,9 @@ static int x25_queue_rx_frame(struct sock *sk, struct sk_buff *skb, int more)
 	if (x25->fraglen > 0) {	/* End of fragment */
 		int len = x25->fraglen + skb->len;
 
-		if ((skbn = alloc_skb(len, GFP_ATOMIC)) == NULL){
-			kfree_skb(skb);
+		skbn = alloc_skb(len, GFP_ATOMIC);
+		if (!skbn)
 			return 1;
-		}
 
 		skb_queue_tail(&x25->fragment_queue, skb);
 

-- 
2.47.3


