Return-Path: <netdev+bounces-272890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id k9N2FLEcyWkDuwUAu9opvQ
	(envelope-from <netdev+bounces-272890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 14:36:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95926351F0B
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 14:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69797302411E
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 12:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AE836214D;
	Sun, 29 Mar 2026 12:32:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39ECF9D9;
	Sun, 29 Mar 2026 12:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774787578; cv=none; b=UfGlPhM6aKEx11lYO+DHidu8331bYxiNy4Rr7OM+99NjNdhBK1nPdL++QDCcQIqAqZDIiQiLoYHVhLfxICixR6L08npmd6KlblqnfaNAczKnNE8iYQFUKXph8SDNIUv3cCu/A5rKPUYEs6yXFFDAnlW6qSZxRMekd7PlpxmWgFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774787578; c=relaxed/simple;
	bh=mdftbmWyKv+KEZRvzk6ehhJTa0juTCj8+XtqTkrNhTY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rY5yTP4ej+hR8rc7q8Iao8U+iuq4rtSm04OGWOYpMEecwbgJfVsENcMKPvI+SG9Lw1MRB30rVupLSuZoIst4NH34+LuchlgoAqZ0kCGtmHjUPE/2WD1tVyeXXRoXs76w2b+V7GLmzgzMNLT6YTRoksmdb+x7KFWLJtn3V9xf2II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id BAACF9200BB; Sun, 29 Mar 2026 14:32:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id B45A09200B3;
	Sun, 29 Mar 2026 13:32:56 +0100 (BST)
Date: Sun, 29 Mar 2026 13:32:56 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] declance: Include the offending address with
 DMA errors
In-Reply-To: <alpine.DEB.2.21.2603291259140.60268@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2603291314560.60268@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2603291259140.60268@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272890-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DMARC_NA(0.00)[orcam.me.uk];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.942];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,angie.orcam.me.uk:mid,orcam.me.uk:email]
X-Rspamd-Queue-Id: 95926351F0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The address latched in the I/O ASIC LANCE DMA Pointer Register uses the 
TURBOchannel bus address encoding and therefore bits 33:29 of location 
referred occupy bits 4:0, bits 28:2 are left-shifted by 3, and bits 1:0 
are hardwired to zero.  In reality no TURBOchannel system exceeds 1GiB 
of RAM though, so the address reported will always fit in 16 hex digits.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/net/ethernet/amd/declance.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

linux-declance-dma-merr-addr.diff
Index: linux-macro/drivers/net/ethernet/amd/declance.c
===================================================================
--- linux-macro.orig/drivers/net/ethernet/amd/declance.c
+++ linux-macro/drivers/net/ethernet/amd/declance.c
@@ -726,8 +726,10 @@ static void lance_tx(struct net_device *
 static irqreturn_t lance_dma_merr_int(int irq, void *dev_id)
 {
 	struct net_device *dev = dev_id;
+	u64 ldp = ioasic_read(IO_REG_LANCE_DMA_P);
 
-	pr_err_ratelimited("%s: DMA error\n", dev->name);
+	pr_err_ratelimited("%s: DMA error at %#010llx\n", dev->name,
+			   (ldp & 0x1f) << 29 | (ldp & 0xffffffe0) >> 3);
 	return IRQ_HANDLED;
 }
 

