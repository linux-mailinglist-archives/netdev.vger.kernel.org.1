Return-Path: <netdev+bounces-72856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E043C859F5A
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 10:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07232B207DC
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 09:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2986D22618;
	Mon, 19 Feb 2024 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ivIsmRnB"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F18222309
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334000; cv=none; b=JKzxQ/Nzewpcm4LmPo1NOh08Ls4EQ38rjGYH+fRIRgc8U65a8JEKGrmhIFrHSeDrCP32NkrSO83Z8LDykx09WSBx7nXB23n7DAedVyyod5MIcmndCJhsrjcVYq+mCuQGjS5Yd5rFR2OzK1KvBvSal49ecw5kfkxdlf2bbq4xC2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334000; c=relaxed/simple;
	bh=xWaJJdjFnRhGZ3VNMuuZG7Ba+N/FWNKVU/aiYLc4ytU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=aROsU8JUWzfunMHTuNW7uC5vqspkEjCzxNdjk90ZeJB+G0TwvJVUeD+vCJgLTYZgkf7uJxhHpCbl4rf+0vuboc5rkCC93oq+rR501RUOyjIyMNcbeQwCbHOej1x9nuoicTAC86EZccx77DMvTnBFVKDa6FBk9g5FblWvEkqUBwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ivIsmRnB; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=EwNgFjPiuDAGKQ51zDamn2zjxGqORtiKSFgMAae48L8=; b=ivIsmRnBuxWsVASOfg3lgiLDwU
	6c0JyMCJWqkxfcrokxl/dwZ04GevfrxlBZN6EWUjXQBJFc/Xqj6QJg/kJ8DjsGpnVjBsr+tN3SCoi
	tXlK+wGbUlo+84D8xiVNaI+W1pDD+deMjjlehDzFd8zMDxc6DrR2+YFqIS0/HvWebL+b2KSQDVmUY
	A5AhubOaa55C9qdFBPmdwZ+wQvNV8PpVnKk9M2QW9kaDcWyjTlZvOTPvXEdxpqqKrxocpck/5ZgdK
	JNMEot7KKYs+tTp8CPT2ThvtLGyH1Dw7MDLNQEPNHk6YmdFGh5iaJdDUpHGh+RaKgMY6CRuDbGpwl
	rTwmttLw==;
Received: from 124x35x135x198.ap124.ftth.ucom.ne.jp ([124.35.135.198] helo=[192.168.2.109])
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rbzhv-00000001BNc-13Nd;
	Mon, 19 Feb 2024 09:13:09 +0000
Message-ID: <2f2b4550-8c66-4300-85b5-b9143cc7d918@infradead.org>
Date: Mon, 19 Feb 2024 18:12:57 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH v5 net] ps3/gelic: Fix SKB allocation
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
index d5b75af163d3..28116891d2ce 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
@@ -384,11 +384,6 @@ static int gelic_descr_prepare_rx(struct gelic_card *card,
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
@@ -397,6 +392,12 @@ static int gelic_descr_prepare_rx(struct gelic_card *card,
 	descr->hw_regs.payload.size = 0;
 	descr->skb = NULL;
 
+	descr->skb = netdev_alloc_skb(*card->netdev, rx_skb_size);
+	if (!descr->skb) {
+		descr->hw_regs.payload.dev_addr = 0; /* tell DMAC don't touch memory */
+		return -ENOMEM;
+	}
+
 	offset = ((unsigned long)descr->skb->data) &
 		(GELIC_NET_RXBUF_ALIGN - 1);
 	if (offset)

