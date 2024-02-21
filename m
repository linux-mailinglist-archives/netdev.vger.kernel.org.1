Return-Path: <netdev+bounces-73519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A2E85CE02
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 03:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88DE71F25E6F
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 02:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D62F9FD;
	Wed, 21 Feb 2024 02:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iVwLl1Ne"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94A2101D0
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708482466; cv=none; b=oB54nnZrDBzrgQKG33wc4aVJCc+lew8Z1Rx3ilJguJz/SNG9IBWML3vXUWwQ25H0jdRUfxnVyJSek74zCAX9zEf2mFeiU0LaXzkX/s+K+cKGFZK3Rt91gU1zCbo9bMZgcgz+fpZ24ijApTH0Cbn3FBUGTZUHBwGsNiyPjdJZn4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708482466; c=relaxed/simple;
	bh=Pqg9Mv92hJ7yZFO2hSHk6kSpr4kikz7KArdDWpbm4RM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=DTfOC+q95sxDQVuL/NkbPiidU6qAb0s9CAI9fVVuNZ7PIaCaNKbfNhgAas02WloOFSMfeVj6leJv6nwDpGhA5Sq/p+FMBumNT+r+Q8M6tEj3nwW47TR6Rtk+VySxZp76aIIA/jaBmSloW/LeehIANDI7nxZNHD7cfmSa1L/cAu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iVwLl1Ne; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=26KsupRJS3yPz543M+TTmeXSYTUPw/j8BAfAHViALS8=; b=iVwLl1NekeMdUbMaaLbzOD58/H
	tTJ9dshtU7jGWyEfn4eTJEmoR/3NkxWrSQEfs5Ib8a+rhHkSQiHtGzqtNUhIvlRPAbODXQE6b6V6L
	0XvuUBHzkaqMrZhjYwMIVWL6xtTEmcvT4HGTIh/df4/2VhgAWu1YvQxhdWQmr3xktb9c1WxGJY6Jr
	WJyjcWZU26IBvHpVotqPgc6d++qgF5RCpeq4Fc5juznCB80lXvRNIwyoFLGhrMtCKFVLVfa7pPz9d
	pRThFTzdCEjDtyH6bb4hZyL387CGWUT90/6kFHd7GaFBw/x6RoHgtb33lQVTNRRQypAHJiwyqxAIq
	98lqvaXA==;
Received: from 124x35x135x198.ap124.ftth.ucom.ne.jp ([124.35.135.198] helo=[192.168.2.109])
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rccKf-0000000HAaK-13SU;
	Wed, 21 Feb 2024 02:27:37 +0000
Message-ID: <52f5f716-adec-48bf-aa68-76078190c56f@infradead.org>
Date: Wed, 21 Feb 2024 11:27:29 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH v6 net] ps3/gelic: Fix SKB allocation
To: sambat goson <sombat3960@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Commit 3ce4f9c3fbb3 ("net/ps3_gelic_net: Add gelic_descr structures") of
6.8-rc1 had a copy-and-paste error where the pointer that holds the
allocated SKB (struct gelic_descr.skb)  was set to NULL after the SKB was
allocated. This resulted in a kernel panic when the SKB pointer was
accessed.

This fix moves the initialization of the gelic_descr to before the SKB
is allocated.

Reported-by: sambat goson <sombat3960@gmail.com>
Fixes: 3ce4f9c3fbb3 ("net/ps3_gelic_net: Add gelic_descr structures")
Signed-off-by: Geoff Levand <geoff@infradead.org>

diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
index d5b75af163d3..c1b0d35c8d05 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
@@ -384,18 +384,18 @@ static int gelic_descr_prepare_rx(struct gelic_card *card,
 	if (gelic_descr_get_status(descr) !=  GELIC_DESCR_DMA_NOT_IN_USE)
 		dev_info(ctodev(card), "%s: ERROR status\n", __func__);
 
-	descr->skb = netdev_alloc_skb(*card->netdev, rx_skb_size);
-	if (!descr->skb) {
-		descr->hw_regs.payload.dev_addr = 0; /* tell DMAC don't touch memory */
-		return -ENOMEM;
-	}
 	descr->hw_regs.dmac_cmd_status = 0;
 	descr->hw_regs.result_size = 0;
 	descr->hw_regs.valid_size = 0;
 	descr->hw_regs.data_error = 0;
 	descr->hw_regs.payload.dev_addr = 0;
 	descr->hw_regs.payload.size = 0;
-	descr->skb = NULL;
+
+	descr->skb = netdev_alloc_skb(*card->netdev, rx_skb_size);
+	if (!descr->skb) {
+		descr->hw_regs.payload.dev_addr = 0; /* tell DMAC don't touch memory */
+		return -ENOMEM;
+	}
 
 	offset = ((unsigned long)descr->skb->data) &
 		(GELIC_NET_RXBUF_ALIGN - 1);

