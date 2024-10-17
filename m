Return-Path: <netdev+bounces-136570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D469A2238
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 14:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF81288D5B
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 12:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A961DD9AB;
	Thu, 17 Oct 2024 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktuCV2Cg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5A91DD88F;
	Thu, 17 Oct 2024 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729168182; cv=none; b=S3MzcnHSPbMGib6QsMltPKFaoft4ZoYCTqlaHMooXG2eZvvzXSQfcaooc1nbUWK2SIDW9+QyJrJvB0KwHHNT3+4+hM9fh7lqSY7ATL7OtXtBIKqrEF82RXW9FQKMk1jV9I7ENnSJrO033+Z4ta3QT9XsX84VJ88cX+boAqtU//Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729168182; c=relaxed/simple;
	bh=yd5Il7nYS8RK836o00Q0x0vsIfnv7ERNERDNUicu15c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kF8rY5IqElwQhCmEFKCTZ66VP5748InuN0dcWxZsMZtqejyR88crSb5+I5n221ekqSWrlv83p8XnABG2nIa3GUYeKFDa4fx4JMFtvmr01BxeP5XqtHKHo3uK1g/2TINDqq5KmjGTAAEfu3fmj4eW4ehbZJadzs2UTEY2YwOcRrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktuCV2Cg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E50C4CEC5;
	Thu, 17 Oct 2024 12:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729168180;
	bh=yd5Il7nYS8RK836o00Q0x0vsIfnv7ERNERDNUicu15c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ktuCV2Cgw0lV7EeBTGRZ3xOzke+9u/4WWh6TslyhJJMNwrCvw5axWh/HQdIn/LO+o
	 gXVDPwJhQ12qwzNdmnWPoAxMOsAT3fcoEAAdOuZ+9DvmYbQy7zXZ29+TQFBislgAzr
	 8rdcC+nAxfpgKDz8ezw+rIFEFCnWfAwDmIry68FoZPstEhuSPQkkWe6HigQHCFhY2Q
	 9IlU8ja64MPGj8A8Q1EalGdG4AhEW2v3IT/SoV/di1IQmLPQjGn8HnxocagWVgv8Eo
	 3JutdfkML1Z/msj/4Fi590I6q4q/KrT3WHm3Spy3SbAhzYxdUkIMRuNjwiRy3zMLX0
	 iDN1kL1H8BxJQ==
Date: Thu, 17 Oct 2024 13:29:36 +0100
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
Subject: Re: [PATCH net-next v1 5/5] net: stmmac: xgmac: Complete FPE support
Message-ID: <20241017122936.GF1697@kernel.org>
References: <cover.1728980110.git.0x1207@gmail.com>
 <7b244a9d6550bd856298150fb4c083ca95b41f38.1728980110.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b244a9d6550bd856298150fb4c083ca95b41f38.1728980110.git.0x1207@gmail.com>

On Tue, Oct 15, 2024 at 05:09:26PM +0800, Furong Xu wrote:
> FPE implementation for DWMAC4 and DWXGMAC differs only for:
> 1) Offset address of MAC_FPE_CTRL_STS and MTL_FPE_CTRL_STS
> 2) FPRQ(Frame Preemption Residue Queue) field in MAC_RxQ_Ctrl1
> 
> Refactor stmmac_fpe_ops callback functions to avoid code duplication
> between gmac4 and xgmac.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>

Hi Furong Xu,

I think it would be best to split this patch so that the refactor of dwmac4
code is in one patch, and adding xgmac code is in another.

...

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> index 6060a1d702c6..80f12b6e84e6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> @@ -160,41 +160,54 @@ void stmmac_fpe_apply(struct stmmac_priv *priv)
>  	}
>  }
>  
> -static void dwmac5_fpe_configure(void __iomem *ioaddr,
> -				 struct stmmac_fpe_cfg *cfg,
> -				 u32 num_txq, u32 num_rxq,
> -				 bool tx_enable, bool pmac_enable)
> +static void common_fpe_configure(void __iomem *ioaddr,
> +				 struct stmmac_fpe_cfg *cfg, u32 rxq,
> +				 bool tx_enable, bool pmac_enable,
> +				 u32 rxq_addr, u32 fprq_mask, u32 fprq_shift,
> +				 u32 mac_fpe_addr, u32 int_en_addr,
> +				 u32 int_en_bit)

This function now has a lot of parameters. Could we consider another way?
One idea I had was that describes the addresses for different chips.

...

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index 75ad2da1a37f..6a79e6a111ed 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -1290,8 +1290,8 @@ const struct stmmac_tc_ops dwxgmac_tc_ops = {
>  	.setup_cls_u32 = tc_setup_cls_u32,
>  	.setup_cbs = tc_setup_cbs,
>  	.setup_cls = tc_setup_cls,
> -	.setup_taprio = tc_setup_taprio_without_fpe,
> +	.setup_taprio = tc_setup_taprio,
>  	.setup_etf = tc_setup_etf,
>  	.query_caps = tc_query_caps,
> -	.setup_mqprio = tc_setup_mqprio_unimplemented,
> +	.setup_mqprio = tc_setup_dwmac510_mqprio,
>  };

It is not clear to me how this hunk relates to the rest of the patch.

