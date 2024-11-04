Return-Path: <netdev+bounces-141574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF1D9BB7E3
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 15:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ADD7B25FC5
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 14:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5361B3921;
	Mon,  4 Nov 2024 14:34:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2319F1B218E;
	Mon,  4 Nov 2024 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730730871; cv=none; b=kn5TVkDzCkkF+EG3/CfhjF6MlYkwKYs0H9I3YCMcAn3GXEI88Wo1a+pxRMT5WOEgSsUmQM5LGMVci2odw0w+nx7cXFu/QkXO8EsNQCxHJojTxmH6xtvO8YVSA8kwdMUhIUrLnakHtOtdIra9esLSoqtlJ5PQPA3RbiMbXLOK06Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730730871; c=relaxed/simple;
	bh=hw9Fmpa6BCCzAz/2ln2Ub3Srz7vuOcdA8qo+52BeNew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ddtBrZJQvNcBgo0gamj9DPUwMkxf5WDrnPoqznyF0aVGbRoV3SGfcIt2gFj6b370IuzFRtkJ7/ympqrQpRogv8Kb9jF7PEKUFxhhE3oIbmNHPPMIfrpcXaRhRXOY3F+4tsnwg/YF/OPmzZFmjGAdVpNiv3KLdGb1sTJ/xBTb88Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Xhv9v0sCKz9sST;
	Mon,  4 Nov 2024 15:34:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RH5f9tRQBcV2; Mon,  4 Nov 2024 15:34:27 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Xhv9t6hz1z9sSS;
	Mon,  4 Nov 2024 15:34:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CD0A68B770;
	Mon,  4 Nov 2024 15:34:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id vJlu8CVG94Eu; Mon,  4 Nov 2024 15:34:26 +0100 (CET)
Received: from [172.25.230.108] (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8DAC98B763;
	Mon,  4 Nov 2024 15:34:26 +0100 (CET)
Message-ID: <81fa5067-88d3-4693-9e42-7072b5430ac8@csgroup.eu>
Date: Mon, 4 Nov 2024 15:34:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: dpaa_eth: add assertions about SGT
 entry offsets in sg_fd_to_skb()
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Breno Leitao <leitao@debian.org>,
 Madalin Bucur <madalin.bucur@nxp.com>, Ioana Ciornei
 <ioana.ciornei@nxp.com>, Radu Bulie <radu-andrei.bulie@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20241029164317.50182-1-vladimir.oltean@nxp.com>
 <20241029164317.50182-3-vladimir.oltean@nxp.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241029164317.50182-3-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 29/10/2024 à 17:43, Vladimir Oltean a écrit :
> Multi-buffer frame descriptors (FDs) point to a buffer holding a
> scatter/gather table (SGT), which is a finite array of fixed-size
> entries, the last of which has qm_sg_entry_is_final(&sgt[i]) == true.
> 
> Each SGT entry points to a buffer holding pieces of the frame.
> DPAARM.pdf explains in the figure called "Internal and External Margins,
> Scatter/Gather Frame Format" that the SGT table is located within its
> buffer at the same offset as the frame data start is located within the
> first packet buffer.
> 
>                                   +------------------------+
>      Scatter/Gather Buffer        |        First Buffer    |   Last Buffer
>        ^ +------------+ ^       +-|---->^ +------------+   +->+------------+
>        | |            | | ICEOF | |     | |            |      |////////////|
>        | +------------+ v       | |     | |            |      |////////////|
>   BSM  | |/ part of //|         | |BSM  | |            |      |////////////|
>        | |/ Internal /|         | |     | |            |      |////////////|
>        | |/ Context //|         | |     | |            |      |// Frame ///|
>        | +------------+         | |     | |            | ...  |/ content //|
>        | |            |         | |     | |            |      |////////////|
>        | |            |         | |     | |            |      |////////////|
>        v +------------+         | |     v +------------+      |////////////|
>          | Scatter/ //| sgt[0]--+ |       |// Frame ///|      |////////////|
>          | Gather List| ...       |       |/ content //|      +------------+ ^
>          |////////////| sgt[N]----+       |////////////|      |            | | BEM
>          |////////////|                   |////////////|      |            | |
>          +------------+                   +------------+      +------------+ v
> 
> BSM = Buffer Start Margin, BEM = Buffer End Margin, both are configured
> by dpaa_eth_init_rx_port() for the RX FMan port relevant here.
> 
> sg_fd_to_skb() runs in the calling context of rx_default_dqrr() -
> the NAPI receive callback - which only expects to receive contiguous
> (qm_fd_contig) or scatter/gather (qm_fd_sg) frame descriptors.
> Everything else is irrelevant codewise.
> 
> The processing done by sg_fd_to_skb() is weird because it does not
> conform to the expectations laid out by the aforementioned figure.
> Namely, it parses the OFFSET field only for SGT entries with i != 0
> (codewise, skb != NULL). In those cases, OFFSET should always be 0.
> Also, it does not parse the OFFSET field for the sgt[0] case, the only
> case where the buffer offset is meaningful in this context. There, it
> uses the fd_off, aka the offset to the Scatter/Gather List in the
> Scatter/Gather Buffer from the figure. By equivalence, they should both
> be equal to the BSM (in turn, equal to priv->rx_headroom).
> 
> This can actually be explained due to the bug which we had in
> qm_sg_entry_get_off() until the previous change:
> 
> - qm_sg_entry_get_off() did not actually _work_ for sgt[0]. It returned
>    zero even with a non-zero offset, so fd_off had to be used as a fill-in.
> 
> - qm_sg_entry_get_off() always returned zero for sgt[i>0], and that
>    resulted in no user-visible bug, because the buffer offset _was
>    supposed_ to be zero for those buffers. So remove it from calculations.
> 
> Add assertions about the OFFSET field in both cases (first or subsequent
> SGT entries) to make it absolutely obvious when something is not well
> handled.
> 
> Similar logic can be seen in the driver for the architecturally similar
> DPAA2, where dpaa2_eth_build_frag_skb() calls dpaa2_sg_get_offset() only
> for i == 0. For the rest, there is even a comment stating the same thing:
> 
> 	 * Data in subsequent SG entries is stored from the
> 	 * beginning of the buffer, so we don't need to add the
> 	 * sg_offset.
> 
> Tested on LS1046A.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>


Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu>


> ---
>   .../net/ethernet/freescale/dpaa/dpaa_eth.c    | 24 ++++++++++++-------
>   1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> index ac06b01fe934..e280013afa63 100644
> --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> @@ -1820,7 +1820,6 @@ static struct sk_buff *sg_fd_to_skb(const struct dpaa_priv *priv,
>   	struct page *page, *head_page;
>   	struct dpaa_bp *dpaa_bp;
>   	void *vaddr, *sg_vaddr;
> -	int frag_off, frag_len;
>   	struct sk_buff *skb;
>   	dma_addr_t sg_addr;
>   	int page_offset;
> @@ -1863,6 +1862,11 @@ static struct sk_buff *sg_fd_to_skb(const struct dpaa_priv *priv,
>   			 * on Tx, if extra headers are added.
>   			 */
>   			WARN_ON(fd_off != priv->rx_headroom);
> +			/* The offset to data start within the buffer holding
> +			 * the SGT should always be equal to the offset to data
> +			 * start within the first buffer holding the frame.
> +			 */
> +			WARN_ON_ONCE(fd_off != qm_sg_entry_get_off(&sgt[i]));
>   			skb_reserve(skb, fd_off);
>   			skb_put(skb, qm_sg_entry_get_len(&sgt[i]));
>   		} else {
> @@ -1876,21 +1880,23 @@ static struct sk_buff *sg_fd_to_skb(const struct dpaa_priv *priv,
>   			page = virt_to_page(sg_vaddr);
>   			head_page = virt_to_head_page(sg_vaddr);
>   
> -			/* Compute offset in (possibly tail) page */
> +			/* Compute offset of sg_vaddr in (possibly tail) page */
>   			page_offset = ((unsigned long)sg_vaddr &
>   					(PAGE_SIZE - 1)) +
>   				(page_address(page) - page_address(head_page));
> -			/* page_offset only refers to the beginning of sgt[i];
> -			 * but the buffer itself may have an internal offset.
> +
> +			/* Non-initial SGT entries should not have a buffer
> +			 * offset.
>   			 */
> -			frag_off = qm_sg_entry_get_off(&sgt[i]) + page_offset;
> -			frag_len = qm_sg_entry_get_len(&sgt[i]);
> +			WARN_ON_ONCE(qm_sg_entry_get_off(&sgt[i]));
> +
>   			/* skb_add_rx_frag() does no checking on the page; if
>   			 * we pass it a tail page, we'll end up with
> -			 * bad page accounting and eventually with segafults.
> +			 * bad page accounting and eventually with segfaults.
>   			 */
> -			skb_add_rx_frag(skb, i - 1, head_page, frag_off,
> -					frag_len, dpaa_bp->size);
> +			skb_add_rx_frag(skb, i - 1, head_page, page_offset,
> +					qm_sg_entry_get_len(&sgt[i]),
> +					dpaa_bp->size);
>   		}
>   
>   		/* Update the pool count for the current {cpu x bpool} */

