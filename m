Return-Path: <netdev+bounces-157108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9451EA08F03
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 12:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909CC166A3F
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 11:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3411F2080D2;
	Fri, 10 Jan 2025 11:20:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AC5205AC5
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 11:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508007; cv=none; b=A4bufSLvycXnFhQB0JIMhK9KWDdu6N7bsoZyPBEry0VtrsifCD0VRLS68Bq/sJ6sop5Gk2R1mQ3ttCK+I5Xvf3FRKuT1bhLb1yjN/YzHSy+FEvIOui7oiA+/f5T5DGU1pDUOBOmnbF2GlCrsl9eRBUcFyUfaZ4grWUvctOqsePU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508007; c=relaxed/simple;
	bh=kOST9puL5O0lgZgd9dvofPANW6nURYuXcTcPeRY6+nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TH4juXJ9s34Nii6E45xb0UffCCvT0Rk/Kp03nBlFacrTu0VdugTJPKthtiE9ZK5DXvkMnXoX5sAXJPAb7RCt2DHfjivHB5J8kEBg+b7lf6ytnphW1Imxd3UiOdHM3VAhP4Hnf7j5E9A4pD+xYvYPvSoWWvbnv6MBDiBQCVGRuhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YTzQ66bMjz9sSN;
	Fri, 10 Jan 2025 12:07:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9565rjOLSGr7; Fri, 10 Jan 2025 12:07:26 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YTzQ65Z96z9sSL;
	Fri, 10 Jan 2025 12:07:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id AB26E8B787;
	Fri, 10 Jan 2025 12:07:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id X1yPG8Y30LGd; Fri, 10 Jan 2025 12:07:26 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 31B778B768;
	Fri, 10 Jan 2025 12:07:26 +0100 (CET)
Message-ID: <8b080760-c1c7-4d9d-a17b-3c0115392b36@csgroup.eu>
Date: Fri, 10 Jan 2025 12:07:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] freescale: ucc_geth: Remove set but unused
 variables
To: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20250110-ucc-unused-var-v1-1-4cf02475b21d@kernel.org>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250110-ucc-unused-var-v1-1-4cf02475b21d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 10/01/2025 à 11:18, Simon Horman a écrit :
> Remove set but unused variables. These seem to provide no value.
> So in the spirit of less being more, remove them.

Would be good to identify when those variables became unused.

There is for instance commit 64a99fe596f9 ("ethernet: ucc_geth: remove 
bd_mem_part and all associated code")

...

> 
> Compile tested only.
> No runtime effect intended.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>

As you are playing with that driver, there are also sparse warnings to 
be fixed, getting plenty when building with C=2

> ---
>   drivers/net/ethernet/freescale/ucc_geth.c | 39 +++++++------------------------
>   1 file changed, 8 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
> index 88510f822759..1e3a1cb997c3 100644
> --- a/drivers/net/ethernet/freescale/ucc_geth.c
> +++ b/drivers/net/ethernet/freescale/ucc_geth.c
> @@ -1704,14 +1704,8 @@ static int ugeth_82xx_filtering_clear_addr_in_paddr(struct ucc_geth_private *uge
>   
>   static void ucc_geth_free_rx(struct ucc_geth_private *ugeth)
>   {
> -	struct ucc_geth_info *ug_info;
> -	struct ucc_fast_info *uf_info;
> -	u16 i, j;
>   	u8 __iomem *bd;
> -
> -
> -	ug_info = ugeth->ug_info;
> -	uf_info = &ug_info->uf_info;
> +	u16 i, j;

Why do you need to move this declaration ? Looks like cosmetics. That 
goes beyond the purpose of this patch which is already big enough and 
should be avoided. The same applies several times in this patch.

>   
>   	for (i = 0; i < ucc_geth_rx_queues(ugeth->ug_info); i++) {
>   		if (ugeth->p_rx_bd_ring[i]) {
> @@ -1743,16 +1737,11 @@ static void ucc_geth_free_rx(struct ucc_geth_private *ugeth)
>   
>   static void ucc_geth_free_tx(struct ucc_geth_private *ugeth)
>   {
> -	struct ucc_geth_info *ug_info;
> -	struct ucc_fast_info *uf_info;
> -	u16 i, j;
>   	u8 __iomem *bd;
> +	u16 i, j;
>   
>   	netdev_reset_queue(ugeth->ndev);
>   
> -	ug_info = ugeth->ug_info;
> -	uf_info = &ug_info->uf_info;
> -
>   	for (i = 0; i < ucc_geth_tx_queues(ugeth->ug_info); i++) {
>   		bd = ugeth->p_tx_bd_ring[i];
>   		if (!bd)
> @@ -2036,13 +2025,11 @@ static int ucc_struct_init(struct ucc_geth_private *ugeth)
>   static int ucc_geth_alloc_tx(struct ucc_geth_private *ugeth)
>   {
>   	struct ucc_geth_info *ug_info;
> -	struct ucc_fast_info *uf_info;
> +	u8 __iomem *bd;
>   	int length;
>   	u16 i, j;
> -	u8 __iomem *bd;
>   
>   	ug_info = ugeth->ug_info;
> -	uf_info = &ug_info->uf_info;
>   
>   	/* Allocate Tx bds */
>   	for (j = 0; j < ucc_geth_tx_queues(ug_info); j++) {
> @@ -2098,13 +2085,11 @@ static int ucc_geth_alloc_tx(struct ucc_geth_private *ugeth)
>   static int ucc_geth_alloc_rx(struct ucc_geth_private *ugeth)
>   {
>   	struct ucc_geth_info *ug_info;
> -	struct ucc_fast_info *uf_info;
> +	u8 __iomem *bd;
>   	int length;
>   	u16 i, j;
> -	u8 __iomem *bd;
>   
>   	ug_info = ugeth->ug_info;
> -	uf_info = &ug_info->uf_info;
>   
>   	/* Allocate Rx bds */
>   	for (j = 0; j < ucc_geth_rx_queues(ug_info); j++) {
> @@ -2155,7 +2140,6 @@ static int ucc_geth_alloc_rx(struct ucc_geth_private *ugeth)
>   
>   static int ucc_geth_startup(struct ucc_geth_private *ugeth)
>   {
> -	struct ucc_geth_82xx_address_filtering_pram __iomem *p_82xx_addr_filt;
>   	struct ucc_geth_init_pram __iomem *p_init_enet_pram;
>   	struct ucc_fast_private *uccf;
>   	struct ucc_geth_info *ug_info;
> @@ -2165,8 +2149,8 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
>   	int ret_val = -EINVAL;
>   	u32 remoder = UCC_GETH_REMODER_INIT;
>   	u32 init_enet_pram_offset, cecr_subblock, command;
> -	u32 ifstat, i, j, size, l2qt, l3qt;
>   	u16 temoder = UCC_GETH_TEMODER_INIT;
> +	u32 i, j, size, l2qt, l3qt;
>   	u8 function_code = 0;
>   	u8 __iomem *endOfRing;
>   	u8 numThreadsRxNumerical, numThreadsTxNumerical;
> @@ -2260,7 +2244,7 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
>   	/*                    Set IFSTAT                     */
>   	/* For more details see the hardware spec.           */
>   	/* Read only - resets upon read                      */
> -	ifstat = in_be32(&ug_regs->ifstat);
> +	in_be32(&ug_regs->ifstat);
>   
>   	/*                    Clear UEMPR                    */
>   	/* For more details see the hardware spec.           */
> @@ -2651,10 +2635,6 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
>   		for (j = 0; j < NUM_OF_PADDRS; j++)
>   			ugeth_82xx_filtering_clear_addr_in_paddr(ugeth, (u8) j);
>   
> -		p_82xx_addr_filt =
> -		    (struct ucc_geth_82xx_address_filtering_pram __iomem *) ugeth->
> -		    p_rx_glbl_pram->addressfiltering;
> -
>   		ugeth_82xx_filtering_clear_all_addr_in_hash(ugeth,
>   			ENET_ADDR_TYPE_GROUP);
>   		ugeth_82xx_filtering_clear_all_addr_in_hash(ugeth,
> @@ -2889,9 +2869,8 @@ static int ucc_geth_rx(struct ucc_geth_private *ugeth, u8 rxQ, int rx_work_limit
>   	struct sk_buff *skb;
>   	u8 __iomem *bd;
>   	u16 length, howmany = 0;
> -	u32 bd_status;
> -	u8 *bdBuffer;
>   	struct net_device *dev;
> +	u32 bd_status;
>   
>   	ugeth_vdbg("%s: IN", __func__);
>   
> @@ -2904,7 +2883,7 @@ static int ucc_geth_rx(struct ucc_geth_private *ugeth, u8 rxQ, int rx_work_limit
>   
>   	/* while there are received buffers and BD is full (~R_E) */
>   	while (!((bd_status & (R_E)) || (--rx_work_limit < 0))) {
> -		bdBuffer = (u8 *) in_be32(&((struct qe_bd __iomem *)bd)->buf);
> +		in_be32(&((struct qe_bd __iomem *)bd)->buf);

This line should go completely.

>   		length = (u16) ((bd_status & BD_LENGTH_MASK) - 4);
>   		skb = ugeth->rx_skbuff[rxQ][ugeth->skb_currx[rxQ]];
>   
> @@ -3043,14 +3022,12 @@ static irqreturn_t ucc_geth_irq_handler(int irq, void *info)
>   	struct net_device *dev = info;
>   	struct ucc_geth_private *ugeth = netdev_priv(dev);
>   	struct ucc_fast_private *uccf;
> -	struct ucc_geth_info *ug_info;
>   	register u32 ucce;
>   	register u32 uccm;
>   
>   	ugeth_vdbg("%s: IN", __func__);
>   
>   	uccf = ugeth->uccf;
> -	ug_info = ugeth->ug_info;
>   
>   	/* read and clear events */
>   	ucce = (u32) in_be32(uccf->p_ucce);
> 
> 


