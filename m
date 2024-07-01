Return-Path: <netdev+bounces-108215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B1C91E693
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 19:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF821F234EB
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 17:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADCC16E87D;
	Mon,  1 Jul 2024 17:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfDLNjx6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2A9126F1E;
	Mon,  1 Jul 2024 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719854618; cv=none; b=AXLbnvlE4i8WzgmasfvyQIqjR87GFRnxLOKKXDz516bjmZguT2SqT7C4PDluzBPqw90U4gS4U64LKXZMRcT38AfKDQptZZXXcr3Pu9QeeQ/Phgy4ZzHZcDS0ftlPZ8afjvzFZPImYU9GkgSUa+TvdvUtq9WdHw6kJjBAxohzm2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719854618; c=relaxed/simple;
	bh=OHZLx8pPNgesHGu9A+Up6rEjvpM2KHacrpLcYCQi8Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PH9Ll/aTNlW7aMqcAoNrKW3XAIV7pMFZ/LAhDYOMiSW7Qmm90IPFFQ5kUCQ3J6sq6ZmuQyPUgEeUL+srv7MDbtfVt5U8aAvVrQB9mNM/z183EN0yYxt0xffG7xYXP2qxn4r+qhHopQeTIupXySmlF3buJ7zFSxYfqdrOpBlEOwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfDLNjx6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB83C116B1;
	Mon,  1 Jul 2024 17:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719854618;
	bh=OHZLx8pPNgesHGu9A+Up6rEjvpM2KHacrpLcYCQi8Fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NfDLNjx6l2FtHqQy31axlYyHzNMshF+YdnpeoGQ1iZSH2kPIee82B9MbSxGe/WB2d
	 JvCFcOA6kcB6lD10YLjhVAMOvKtzvYUxpYbPE/zV7yuJeTwKtodWsmUIVd6ZYtLTgd
	 q8RB8EVy6xne5GL8wBkhmKqDi19qmS3lOAQFqc1CFK14X/0tdl6+3JB0crdZQRv3Jo
	 0Nrzntqydg287dp/JcgYoN8TnYsLEhYa4lroXwNsKPNVxoLHlVlBicSYMylwFfE66X
	 k7qSNr7qIxECUaIE7dOpYG4q6K+MHc9T/YW6IPrYkntNDJrH3+C6vD6mVAB4Vxj3xl
	 2pgvT7v8QIq4g==
Date: Mon, 1 Jul 2024 11:23:37 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next] dt-bindings: net: dwmac: Validate PBL for all
 IP-cores
Message-ID: <171985461601.140520.15616660629845565811.robh@kernel.org>
References: <20240628154515.8783-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628154515.8783-1-fancer.lancer@gmail.com>


On Fri, 28 Jun 2024 18:45:12 +0300, Serge Semin wrote:
> Indeed the maximum DMA burst length can be programmed not only for DW
> xGMACs, Allwinner EMACs and Spear SoC GMAC, but in accordance with
> [1, 2, 3] for Generic DW *MAC IP-cores. Moreover the STMMAC driver parses
> the property and then apply the configuration for all supported DW MAC
> devices. All of that makes the property being available for all IP-cores
> the bindings supports. Let's make sure the PBL-related properties are
> validated for all of them by the common DW *MAC DT schema.
> 
> [1] DesignWare Cores Ethernet MAC Universal Databook, Revision 3.73a,
>     October 2013, p.378.
> 
> [2] DesignWare Cores Ethernet Quality-of-Service Databook, Revision 5.10a,
>     December 2017, p.1223.
> 
> [3] DesignWare Cores XGMAC - 10G Ethernet MAC Databook, Revision 2.11a,
>     September 2015, p.469-473.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> 
> ---
> 
> The discussion where we agreed to submit this change:
> Link: https://lore.kernel.org/netdev/20240625215442.190557-2-robh@kernel.org
> 
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml   | 80 ++++++-------------
>  1 file changed, 26 insertions(+), 54 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


