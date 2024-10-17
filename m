Return-Path: <netdev+bounces-136578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 008F69A2298
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 14:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA39C1F20F6C
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 12:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0531DDC12;
	Thu, 17 Oct 2024 12:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xaamtl8K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559EE770E2;
	Thu, 17 Oct 2024 12:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729168819; cv=none; b=Stjelxy7rbWr/yHLvvnlOlqOv9wyX+vjfaGEj15eT2jJOqPvkwKxQC+ZFoFcdfBidtlD3m9OrNROYpuiRtu2CH8QkgRRPDmx7IHnAIqrgBJBhUcuct8kIwNuZbBVER/SgUzs0H3/kTDGHV0Fy12qN4WV4Y4LvVf5w01upkstaCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729168819; c=relaxed/simple;
	bh=LtW4cH6RJ/U6LGh2Snc/2Z+gjm0u80RPvBaReDRovUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c85yHil0PJWdvFsdaza9Hw49sMe2Y1NKWZND+3Bkh4MNWV4gv95ynQbNKMuhOoyAhlJBk2hnWj7d2Bv2PPBeqBaxd1uQoXQ9F7U8txNc48WNJutNIFo29KhHuywIuh/twwVgqXyyoMDyxlKU3maGWhJNgGkJBWkDlhJDUlgpbQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xaamtl8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B334C4CEC3;
	Thu, 17 Oct 2024 12:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729168819;
	bh=LtW4cH6RJ/U6LGh2Snc/2Z+gjm0u80RPvBaReDRovUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xaamtl8KRjOjP51N2cKoVPsK0zRx6djNcjncvqtnwYUuBwRg5DdXYfa8W+Vk/8f7C
	 neGj0fgMMYaoVghCbsrKFk85x1JteUEEDY/rIc6fFlO/bqOmHJ5dOUIjk59rwwh0m/
	 pCinou1Vryco6ewHX/t3XzeXKY/eBar1Tzj6mrg7LPtTA/CxeumsQBwakZ9oQL7LPD
	 D6ZnJHhKPJ9DVuCrHRKhG+glrHA9dzrtNYBOuMsrfB8TN8SB7G+Mhn4xaFajrU4AoK
	 m4Qyjh3SKXAwu0xMc9GdmnJRROn+3UlTgxToIUFtpZ4JuCvj6fQazVKjVS1ONrr7CA
	 TALJ8a5mR8lBQ==
Date: Thu, 17 Oct 2024 13:40:14 +0100
From: Simon Horman <horms@kernel.org>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v1 4/5] net: stmmac: xgmac: Rename XGMAC_RQ to
 XGMAC_FPRQ
Message-ID: <20241017124014.GJ1697@kernel.org>
References: <cover.1728980110.git.0x1207@gmail.com>
 <4557515b4df0ebe7fb8c1fd8b3725386bf77d1a4.1728980110.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4557515b4df0ebe7fb8c1fd8b3725386bf77d1a4.1728980110.git.0x1207@gmail.com>

On Tue, Oct 15, 2024 at 05:09:25PM +0800, Furong Xu wrote:
> Synopsys XGMAC Databook defines MAC_RxQ_Ctrl1 register:
> RQ: Frame Preemption Residue Queue
> 
> XGMAC_FPRQ is more readable and more consistent with GMAC4.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


