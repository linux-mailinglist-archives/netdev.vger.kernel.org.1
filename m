Return-Path: <netdev+bounces-148279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614749E0FC0
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 01:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B5BE281FB6
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 00:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0F52500D1;
	Tue,  3 Dec 2024 00:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4NCaqBH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D807EDE;
	Tue,  3 Dec 2024 00:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733185992; cv=none; b=NpqEfJyZqrkChVwc3lPzCHz08WwLDFyLe99SH1gZNuZciBwYrJZJy8u7zDI7w0Y2sPaWANGkBhuPlKoAPFb/Rf78d9Tv8pCjXCtqmk1d2IRbzLig+zZdpL9GSMhudEZ+EkRqQNtZF9Aodxixo3CaBhnBPtbShpU5FodIUOBtwA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733185992; c=relaxed/simple;
	bh=P+cKs927/DzHr7RXmSOFRn/pT0qYBrswblnynVURMiU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKV+BElRm0iaNfLMVH4cXmd0jEIVZzanAnhgd5P4FwSj9mdD9ylnTp/R07mQopKkAxwnUnDjp3VvCBn2AYY6A5KH3T4QaLGjbKRqBg5vXh30OTGmGne1SR5ApjxkrZMMpLwu7OGFH239Ec0iPwe9poes4W7xhrXnja+kI/NJW6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4NCaqBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0433C4CED1;
	Tue,  3 Dec 2024 00:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733185991;
	bh=P+cKs927/DzHr7RXmSOFRn/pT0qYBrswblnynVURMiU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e4NCaqBHn0r9TX+saVe2U42+z147y9cdC8ZqLiVtF1Yo2vKYdm5706b8l6NhTT0lG
	 aCoFRkZo/8LOiRyNpfGg6d2MLfgnzpXSle4VVoH0Uh08Rw2aWjJGEpj+9y9Nh8Dgxh
	 R91ouvGM5u6ylzIkH+YDw6+8qokCxXCn5q9quqtsB/O2Gg5IO/F+Qur+1QBIxpWday
	 QCqmAkoTzyzV3KD3Ts+V0yjuNt1/Ey1sMSQfpSGL4PF5nSNRuL+YLJWo9RDJ6PlzFi
	 tRwGY7Ie+ybLDWjFlRwYe3vOQehxOKL4h/1nEh6w728JU7cPazg3zrEvo77/Iy7BUQ
	 LRKjnQriXpnaA==
Date: Mon, 2 Dec 2024 16:33:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Furong Xu <0x1207@gmail.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com, Suraj Jaiswal
 <quic_jsuraj@quicinc.com>, Thierry Reding <treding@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH net v1] net: stmmac: TSO: Fix unbalanced DMA map/unmap
 for non-paged SKB data
Message-ID: <20241202163309.05603e96@kernel.org>
In-Reply-To: <20241128144501.0000619b@gmail.com>
References: <20241021061023.2162701-1-0x1207@gmail.com>
	<d8112193-0386-4e14-b516-37c2d838171a@nvidia.com>
	<20241128144501.0000619b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Nov 2024 14:45:01 +0800 Furong Xu wrote:
> > Let me know if you need any more information.
> 
> [  149.986210] dwc-eth-dwmac 2490000.ethernet eth0: Tx DMA map failed
> and
> [  245.571688] dwc-eth-dwmac 2490000.ethernet eth0: Tx DMA map failed
> [  245.575349] dwc-eth-dwmac 2490000.ethernet eth0: Tx DMA map failed
> are reported by stmmac_xmit() obviously, but not stmmac_tso_xmit().
> 
> And these crashes are caused by "Tx DMA map failed", as you can see that
> current driver code does not handle this kind of failure so well. It is clear
> that we need to figure out why Tx DMA map failed.
> 
> This patch corrects the sequence and timing of DMA unmap by waiting all
> DMA transmit descriptors to be closed by DMA engine for one DMA map in
> stmmac_tso_xmit(), it never leaks DMA addresses and never introduces
> other side effect.
> 
> "Tx DMA map failed" is a weird failure, and I cannot reproduce this failure
> on my device with DWMAC CORE 5.10a(Synopsys ID: 0x51) and DWXGMAC CORE 3.20a.

Let me repeat Jon's question - is there any info or test you need from
Jon to make progress with a fix?

If Jon's board worked before and doesn't work with this patch we will
need *a* fix, if no fix is provided our only choice is revert.

