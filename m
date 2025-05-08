Return-Path: <netdev+bounces-188859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2924AAF152
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 04:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D454E22D5
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 02:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10BA1E25FA;
	Thu,  8 May 2025 02:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfsKgZPX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FB4B667;
	Thu,  8 May 2025 02:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746673162; cv=none; b=hplB9WhnNYebE9cLSuS0lgK9ZeWpAdrN1PcyXTNoLjY1pAxnheext0HZNmL54uR1eV2p/jW0a/awne3bCOhLjChkjGC4QSG3ttyZ0h81vxJ+ECTJK87FoBYT7b5Pu4MvQIbiM+RMU7A6EOMBc4QJCdONBdP0e4bsiNW6hETN1bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746673162; c=relaxed/simple;
	bh=/e4RYFCYyvkILeFGLaxdXw5omYO/D+dX1ddHjHEvAdg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nTyO1Aav5Ykj1ktAVu0puVsSfK8UwbtNvvliNMaLJrPwDL7ZmCk8Q8jjB05bYlCMskfNMejCANZVtGaVccxDNAFltg/E0QMSQ5cMkLtb8U3pc4KnW4fRv37uJHhxanIjovYI1wxeZ34SJNQ50K1sRJryd+2g75C9FlN/yvNqkfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfsKgZPX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F60C4CEE2;
	Thu,  8 May 2025 02:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746673162;
	bh=/e4RYFCYyvkILeFGLaxdXw5omYO/D+dX1ddHjHEvAdg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jfsKgZPX3oR/gUTbr2BmAt7cqysmuqg4IvsU6R+qS/EOzzQd2OtH5hS2yl7OSi2f4
	 FqO5foSian6hUBwfbXFWynXawvz+1ZOnGCwGz8GULHM8nG59wGizN2Av3K+KLYxODf
	 7f3vn0GYOekPR5HnOaTEGayiFcFqgxmEgvz3Xq9oiRrkb5FSSMym/kGXkEzDcXh6DN
	 wdyqutiJVAQQRF6hIMnTighNmKPT1AxWMCiTyPxrbxCIpTByTm0l7+AF3nL5SHblnx
	 ccqZFIm4Uc+D/nSg7yT7OS0eie74j7x0nvXlOglU+VYjoM2n27pZajZuTfBESwO0kX
	 IeLFpyCDzYHcg==
Date: Wed, 7 May 2025 19:59:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: Fan Gong <gongfan1@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn
 Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
 <guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
 <shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>, Lee Trager
 <lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>, Suman Ghosh
 <sumang@marvell.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, Joe
 Damato <jdamato@fastly.com>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH net-next v13 1/1] hinic3: module initialization and
 tx/rx logic
Message-ID: <20250507195920.5227ee66@kernel.org>
In-Reply-To: <c20c6e48ac105658204a20a6bfac8398da2e514b.1746519748.git.gur.stavi@huawei.com>
References: <cover.1746519748.git.gur.stavi@huawei.com>
	<c20c6e48ac105658204a20a6bfac8398da2e514b.1746519748.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 May 2025 11:35:28 +0300 Gur Stavi wrote:
> +	page = page_pool_alloc_frag(page_pool, &page_offset, buf_len,
> +				    GFP_ATOMIC |  __GFP_COMP);

No need for __GFP_COMP. page pool will add it if order > 0

> +static struct sk_buff *hinic3_fetch_rx_buffer(struct hinic3_rxq *rxq,
> +					      u32 pkt_len)
> +{
> +	struct net_device *netdev = rxq->netdev;
> +	struct sk_buff *skb;
> +	u32 sge_num;
> +
> +	skb = netdev_alloc_skb_ip_align(netdev, HINIC3_RX_HDR_SIZE);

Looks like this is only called from NAPI so you can use napi_alloc_skb()
it has an object cache so it is measurably faster

