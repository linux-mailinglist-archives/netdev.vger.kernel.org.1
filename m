Return-Path: <netdev+bounces-174986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A577A61CBD
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 21:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D776319C21F0
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 20:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579D61A23B7;
	Fri, 14 Mar 2025 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o338TSpD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3431819F436
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 20:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741984311; cv=none; b=ivm3yaWczOI3ODEoUF9m36G3VheE1xeEhXT5nDiQWqpWo5Ag1Szo8EQhiLaDn/Ipizof/zrWyXn93+Sg53PKy5ufZtsqOSTUcER40CFgMMuMepr9FXxuztngxHNhE1aC9ACHvHoIRilZ+q3BxR4TkNAnW3wCtkxjH0y2aAKDVMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741984311; c=relaxed/simple;
	bh=2QK4E9ynapxckPwxo8W/JTy4OvOXsGI29ZK/3e/YNY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PEzGDzyfa10whgRHuKb52rKdsuqm8lrBJhBLFDRqCNxAVQgUEeESqIkhAsj8KGhAaNh4AEFehiSf+GGLh87Z9nYj0KhxmBZRO0iN+QNyfG6GfFSAasClMUk21EoKCj12n8S2Lj41nH/gbAfQbDjf9MCS0oi6famY4K/cyBTB03Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o338TSpD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3274C4CEE3;
	Fri, 14 Mar 2025 20:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741984310;
	bh=2QK4E9ynapxckPwxo8W/JTy4OvOXsGI29ZK/3e/YNY8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o338TSpDAE5T9ccL/O2z4CMfuNtvnI2cvj4YLYVX2XiSAPSoNXgwjMwUFBLR7SN+n
	 TZmar8vWeGE9pEhYQj9Hi0Q88hJZysWC93CBoE75YjmRraee+IdjzHkRfwJpXdIQTW
	 a7prJDPFDR2fs2ZxegP0TctSW04RXCd8xS964GiAGx2t7z6SQW50cvAXn3Psm0k6Yj
	 3JBEpKWDOsKo9cHawEaduQ0DOQUnDwdjdC78HosFC8JbeNIQwKUpGJpJ2KTwx1Unct
	 eXn+sXbuYl+hZX/uQeeIn6PIV9ih25h9xAitoA7UoF2BUV0ivO4DN6vUNY6j6MtvKn
	 L8qJKEmEelP9g==
Message-ID: <a497632b-3754-42f2-9b7b-1821fee0c136@kernel.org>
Date: Fri, 14 Mar 2025 22:31:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] net: ti: icssg-prueth: Add XDP support
To: Dan Carpenter <dan.carpenter@linaro.org>,
 "Malladi, Meghana" <m-malladi@ti.com>
Cc: netdev@vger.kernel.org
References: <70d8dd76-0c76-42fc-8611-9884937c82f5@stanley.mountain>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <70d8dd76-0c76-42fc-8611-9884937c82f5@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+Meghana,

On 14/03/2025 12:50, Dan Carpenter wrote:
> Hello Roger Quadros,
> 
> Commit 62aa3246f462 ("net: ti: icssg-prueth: Add XDP support") from
> Mar 5, 2025 (linux-next), leads to the following Smatch static
> checker warning:
> 
> 	drivers/net/ethernet/ti/icssg/icssg_common.c:635 emac_xmit_xdp_frame()
> 	error: we previously assumed 'first_desc' could be null (see line 584)
> 
> drivers/net/ethernet/ti/icssg/icssg_common.c
>    563  u32 emac_xmit_xdp_frame(struct prueth_emac *emac,
>    564                          struct xdp_frame *xdpf,
>    565                          struct page *page,
>    566                          unsigned int q_idx)
>    567  {
>    568          struct cppi5_host_desc_t *first_desc;
>    569          struct net_device *ndev = emac->ndev;
>    570          struct prueth_tx_chn *tx_chn;
>    571          dma_addr_t desc_dma, buf_dma;
>    572          struct prueth_swdata *swdata;
>    573          u32 *epib;
>    574          int ret;
>    575  
>    576          if (q_idx >= PRUETH_MAX_TX_QUEUES) {
>    577                  netdev_err(ndev, "xdp tx: invalid q_id %d\n", q_idx);
>    578                  return ICSSG_XDP_CONSUMED;      /* drop */
> 
> Do we need to free something on this path?
> 
>    579          }
>    580  
>    581          tx_chn = &emac->tx_chns[q_idx];
>    582  
>    583          first_desc = k3_cppi_desc_pool_alloc(tx_chn->desc_pool);
>    584          if (!first_desc) {
>    585                  netdev_dbg(ndev, "xdp tx: failed to allocate descriptor\n");
>    586                  goto drop_free_descs;   /* drop */
>                         ^^^^^^^^^^^^^^^^^^^^
> This will dereference first_desc and crash.
> 
>    587          }
>    588  
>    589          if (page) { /* already DMA mapped by page_pool */
>    590                  buf_dma = page_pool_get_dma_addr(page);
>    591                  buf_dma += xdpf->headroom + sizeof(struct xdp_frame);
>    592          } else { /* Map the linear buffer */
>    593                  buf_dma = dma_map_single(tx_chn->dma_dev, xdpf->data, xdpf->len, DMA_TO_DEVICE);
>    594                  if (dma_mapping_error(tx_chn->dma_dev, buf_dma)) {
>    595                          netdev_err(ndev, "xdp tx: failed to map data buffer\n");
>    596                          goto drop_free_descs;   /* drop */
>    597                  }
>    598          }
>    599  
>    600          cppi5_hdesc_init(first_desc, CPPI5_INFO0_HDESC_EPIB_PRESENT,
>    601                           PRUETH_NAV_PS_DATA_SIZE);
>    602          cppi5_hdesc_set_pkttype(first_desc, 0);
>    603          epib = first_desc->epib;
>    604          epib[0] = 0;
>    605          epib[1] = 0;
>    606  
>    607          /* set dst tag to indicate internal qid at the firmware which is at
>    608           * bit8..bit15. bit0..bit7 indicates port num for directed
>    609           * packets in case of switch mode operation
>    610           */
>    611          cppi5_desc_set_tags_ids(&first_desc->hdr, 0, (emac->port_id | (q_idx << 8)));
>    612          k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &buf_dma);
>    613          cppi5_hdesc_attach_buf(first_desc, buf_dma, xdpf->len, buf_dma, xdpf->len);
>    614          swdata = cppi5_hdesc_get_swdata(first_desc);
>    615          if (page) {
>    616                  swdata->type = PRUETH_SWDATA_PAGE;
>    617                  swdata->data.page = page;
>    618          } else {
>    619                  swdata->type = PRUETH_SWDATA_XDPF;
>    620                  swdata->data.xdpf = xdpf;
>    621          }
>    622  
>    623          cppi5_hdesc_set_pktlen(first_desc, xdpf->len);
>    624          desc_dma = k3_cppi_desc_pool_virt2dma(tx_chn->desc_pool, first_desc);
>    625  
>    626          ret = k3_udma_glue_push_tx_chn(tx_chn->tx_chn, first_desc, desc_dma);
>    627          if (ret) {
>    628                  netdev_err(ndev, "xdp tx: push failed: %d\n", ret);
>    629                  goto drop_free_descs;
>    630          }
>    631  
>    632          return ICSSG_XDP_TX;
>    633  
>    634  drop_free_descs:
>    635          prueth_xmit_free(tx_chn, first_desc);
>    636          return ICSSG_XDP_CONSUMED;
>    637  }
> 
> 
> regards,
> dan carpenter

-- 
cheers,
-roger


