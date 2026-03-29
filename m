Return-Path: <netdev+bounces-272963-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCIjOpJqyWnqxwUAu9opvQ
	(envelope-from <netdev+bounces-272963-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:08:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7663538BE
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D2D130164A6
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4569B3859FD;
	Sun, 29 Mar 2026 18:07:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD2040DFD7;
	Sun, 29 Mar 2026 18:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774807664; cv=none; b=eaL5/SpNxl0QcpIjlWZJOfwIgPovGklpRj1SoWhCM9P7/0N2GLTdFiui31ZVsiVpzp88mIhgoQXPFIaUN3CJ4BMp/CscmjxHiz7rDn2RlrdPD6IDncSsnWZr0QbI/pOkQsYlze6V4wP2r0Ghkl1YXnqGzBOkFOA9FwFvsyATyXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774807664; c=relaxed/simple;
	bh=dbPO3jMraffT/PZ8T4+vw7HyjVm0Ny6QQi7W3LF92X0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OrHpRaeQ1+MslWMyaB1NZbnkIY7Un7IyTM05BKdK8i24XNME29zXQmEbeCtNk0nziov2YL2+yrUCrHgDdtX4P+7DpgsfiywGhlStxzXffD3eIJEDt1ajc6qeeBDj9x+pzvYTiqz7JdiVphf15k4qqze3TqXfguH/D2iMajuVBCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id AAC0C92009C; Sun, 29 Mar 2026 20:07:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id A634F92009B;
	Sun, 29 Mar 2026 19:07:41 +0100 (BST)
Date: Sun, 29 Mar 2026 19:07:41 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/2] declance: Include the offending address with
 DMA errors
In-Reply-To: <alpine.DEB.2.21.2603291835550.60268@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2603291839220.60268@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2603291835550.60268@angie.orcam.me.uk>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272963-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DMARC_NA(0.00)[orcam.me.uk];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,orcam.me.uk:email,angie.orcam.me.uk:mid]
X-Rspamd-Queue-Id: 5B7663538BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The address latched in the I/O ASIC LANCE DMA Pointer Register uses the 
TURBOchannel bus address encoding and therefore bits 33:29 of location 
referred occupy bits 4:0, bits 28:2 are left-shifted by 3, and bits 1:0 
are hardwired to zero.  In reality no TURBOchannel system exceeds 1GiB 
of RAM though, so the address reported will always fit in 8 hex digits.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
Changes from v1:

- s/16/8/ in the change description for the printed address width.
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
 

