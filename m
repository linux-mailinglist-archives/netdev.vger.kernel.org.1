Return-Path: <netdev+bounces-74238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C76F86093D
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 04:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CD65B23FCC
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 03:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCDAC153;
	Fri, 23 Feb 2024 03:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hU5UE2zC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793ED111A4
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 03:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708657942; cv=none; b=WqYB1GPIPdVS1i5wb8l4tdAqymE+c+B9yxGjlvxsgTemqrYWq2wN/vt1/fzbrP/4QyZAUAgfbPZ24TwVZCnmHWSpoLmlng/vhXoIdUbWolkGEWNn/ytVBlFdmSlnZsrc52Hv8jlvaUWp9hzWvf2056TsccEMy39YrnTIIvWUOUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708657942; c=relaxed/simple;
	bh=TmWPAks3Lb8j9lDLlt3CU6H4Uca9w8HQz3+GS3RrzhI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=joU/gmhlgH+CqC2J13UYq2x00y2vpVCt59KH81P04zGQxbSEcPHiRKJls49z0bg7+pthdw8PZCWy3ME1+h82wBForLI+b0n1A577AWcI1W602MBr0Hxzg5AVl47scTP59vpvf6N/IVJ9Z6qhXib3uZcReIcpqadvI1Q2/5/DkO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hU5UE2zC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC73C433C7;
	Fri, 23 Feb 2024 03:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708657942;
	bh=TmWPAks3Lb8j9lDLlt3CU6H4Uca9w8HQz3+GS3RrzhI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hU5UE2zCtGCP4ejRuEAb2JIITWDiwIe/xLrfD3lnLkPCJiTOocArNTG++VFo6mYJb
	 NpC1QeVhKHikxc3eQmiuPIhGS+R1wYmD8mlSNuG1a1Z6YsT3K0hgizv8j6u67tEXfW
	 a3OQk2b5krZnwU2xDGC0reruuiY5whfddq84I5lUEarqT7mVjzZB5w2a/LinWRf6SI
	 nEzsDPN0bId1FzwqK5EHHdjCAYAnF/bc1qgLCBkSJ1L7u6CN+uZDhX5tc8evCYGjuw
	 cQsm8cvl6cejSUeWSRwgAx4tvasClpDmuiWbsGeZYu+lciKhMjxjLcInjtpzpqfLx3
	 qbhEk8ksQWk1A==
Date: Thu, 22 Feb 2024 19:12:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 davem@davemloft.net, horms@kernel.org, fancer.lancer@gmail.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: stmmac: fix typo in comment
Message-ID: <20240222191220.0507a4de@kernel.org>
In-Reply-To: <20240221103514.968815-1-siyanteng@loongson.cn>
References: <20240221103514.968815-1-siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2024 18:35:14 +0800 Yanteng Si wrote:
> This is just a trivial fix for a typo in a comment, no functional
> changes.
> 
> Fixes: 48863ce5940f ("stmmac: add DMA support for GMAC 4.xx")

Fixes is reserved for functional bugs, let's leave it out
for a typo correction.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
> index 358e7dcb6a9a..9d640ba5c323 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
> @@ -92,7 +92,7 @@
>  #define DMA_TBS_FTOV			BIT(0)
>  #define DMA_TBS_DEF_FTOS		(DMA_TBS_FTOS | DMA_TBS_FTOV)
>  
> -/* Following DMA defines are chanels oriented */
> +/* Following DMA defines are channels oriented */

I'm not a native speaker but I'd spell it "... are channel-oriented"
With a hyphen, channel not channels.

>  #define DMA_CHAN_BASE_ADDR		0x00001100
>  #define DMA_CHAN_BASE_OFFSET		0x80
>  


