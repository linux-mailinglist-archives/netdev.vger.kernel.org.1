Return-Path: <netdev+bounces-137121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C87E9A46B0
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 21:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E78A61F22088
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 19:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A7E18E37A;
	Fri, 18 Oct 2024 19:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1pJU95M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A9F16EB4C;
	Fri, 18 Oct 2024 19:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729278968; cv=none; b=pIEJXAFuArMZ7I+CozKgvaQaCYP01Dv+q8sRmsQsdmVuvZC169B6yUpTG11CaOTcJ1RFObHzBcicVX4yJ1oBcxuNBwAvT+KN/n3PJObA1k2u8uMCS7MmvK/AEfGBUmqQXEda1DLsFHH+NYWcfiwyYTKo72Cv9WbW0cs9DY+9JlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729278968; c=relaxed/simple;
	bh=xYNvEAnbruKmoDP7ruTSaK5ufdaOcVknSAix/ef+r18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gm0NJwWbMPHGwTtX3vBhK3rChWdMOd5OeaCVwrtSqqRRz6s8QgxdxKaJwPrXjayzb/TeM8lhWI94UImLXlEXAcqbY4aVDtkioIZo8LoOV/X5qXHe/eB8aYjtCD3oDDFDUI4fRIOB3FV9vdF6VBpQkjXgIgXEexf8v+OZGoof00I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1pJU95M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AD6C4CEC3;
	Fri, 18 Oct 2024 19:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729278968;
	bh=xYNvEAnbruKmoDP7ruTSaK5ufdaOcVknSAix/ef+r18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y1pJU95MTDQzWNjwBOGBqSBSc88jyOcaXW+B8btrDam5hYaxxwALh1I8mrN4YGae6
	 JZZSZWz4GlaCN8MUEIHo/OuEjdN61Hc4f8aOT4Dap12KKOtHqTUybZeteKpXaPk2ca
	 5snSdEhdbRJEb4jNzlFqJF2IX1uD1Yu/wbl344qlY34u8VGaWA1TuBtrmV+gIzGakM
	 wjM94j2TUNLOxfKOH7yxwe6H3HW+lkeJBzZbWnLKj7iNwf4OSIRC89WH5jFtGH04Qx
	 /+xqRy67uVAr4JTtV6fHlCAo6KJ5mv5c64paVHipX0UHnWLwAg8FHVr1VPybaB5Tl4
	 Y2neu3CE10B6A==
Date: Fri, 18 Oct 2024 20:16:03 +0100
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Furong Xu <0x1207@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v1 4/5] net: stmmac: xgmac: Rename XGMAC_RQ to
 XGMAC_FPRQ
Message-ID: <20241018191603.GA1697@kernel.org>
References: <cover.1728980110.git.0x1207@gmail.com>
 <cover.1728980110.git.0x1207@gmail.com>
 <4557515b4df0ebe7fb8c1fd8b3725386bf77d1a4.1728980110.git.0x1207@gmail.com>
 <4557515b4df0ebe7fb8c1fd8b3725386bf77d1a4.1728980110.git.0x1207@gmail.com>
 <20241017171852.fwomny3wedypybhx@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017171852.fwomny3wedypybhx@skbuf>

On Thu, Oct 17, 2024 at 08:18:52PM +0300, Vladimir Oltean wrote:
> On Tue, Oct 15, 2024 at 05:09:25PM +0800, Furong Xu wrote:
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > index 917796293c26..c66fa6040672 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> > @@ -84,8 +84,8 @@
> >  #define XGMAC_MCBCQEN			BIT(15)
> >  #define XGMAC_MCBCQ			GENMASK(11, 8)
> >  #define XGMAC_MCBCQ_SHIFT		8
> > -#define XGMAC_RQ			GENMASK(7, 4)
> > -#define XGMAC_RQ_SHIFT			4
> > +#define XGMAC_FPRQ			GENMASK(7, 4)
> > +#define XGMAC_FPRQ_SHIFT		4
> 
> If you made use of FIELD_PREP(), you would not need the _SHIFT variant at all
> (though that would be a separate logical change).

+1

> >  #define XGMAC_UPQ			GENMASK(3, 0)
> >  #define XGMAC_UPQ_SHIFT			0
> >  #define XGMAC_RXQ_CTRL2			0x000000a8
> 

