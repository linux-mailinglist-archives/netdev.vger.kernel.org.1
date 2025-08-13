Return-Path: <netdev+bounces-213132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E630BB23D55
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 02:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3469F1AA4B19
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 00:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC6928682;
	Wed, 13 Aug 2025 00:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEXwTYsM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7854C2C0F92;
	Wed, 13 Aug 2025 00:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755046138; cv=none; b=UsM766XxPWR2eN1fsHO3aTwaHEFe6fYA/6ZWkQM6habpv70Ymzmjqzv+rEGpWN/02qxSnR671xNwKS8nsfahys3Q6rUPxtCPrH+3EZXN8pPXoRFl+Xax9RiIEVc78uQGnJll1SDebbX/7Ocl0j/iJyeGH/AGtmjk9pih9ywfQIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755046138; c=relaxed/simple;
	bh=5ySabijytcLvAH8ERVSO35jFHmP0C94vF4wVqdhfde8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XK9LBaHy/YZCiZqlEzwao0gEbp6QEhMD4IzQ0GvweqJrEsFJQglMP4AFi6c+Nx7I279tQZZQ7acyPHd4aA1tdC9f6YXfIzZ0Snz0h1UQEpUep1FwEUxzmzoODIFyKBkoP9Yfq/b/RFBQxBf5xkZFdNOoYYM5sDXdfk/Meousj00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEXwTYsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D3BC4CEF0;
	Wed, 13 Aug 2025 00:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755046138;
	bh=5ySabijytcLvAH8ERVSO35jFHmP0C94vF4wVqdhfde8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UEXwTYsMAAkO3PtYUlygaAHXIwGrutask0lqWR7MuSyf8nfPCpKjV6TAub/3pgpQk
	 tj47k2Y8AWXh4Gg8JU9eHWlrxsuz2hoR6DnWoraFfn14KhbrMKTgb5DfQtTepV7aUE
	 XysxZ5P4XATsGzSuwCxYVj/PyCNlcejBiSBDl4jq0da59p0o6RIQlhTjh24vGQTsJS
	 pldCOHEm3JyivFCdXMhUSU8kktR1HaFKKFuG33riYsirB5wsKbFhTBTrxo/AsItHY8
	 /zBQB3FDznxfysRfFkvl0o9aRRHCNdNBkua/mWSzOV6XWJdAFhyP331R9GLMaTv3iK
	 6GHI/3t8CAqzw==
Date: Wed, 13 Aug 2025 08:31:45 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: stmmac: add support for dwmac 5.20
Message-ID: <aJvc8S5CUfWH4MfO@xhacker>
References: <20250705090931.14358-1-jszhang@kernel.org>
 <b4091f34-8901-4a30-937a-a9aac35310b7@lunn.ch>
 <aGl3jiAjCiXMF_FK@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aGl3jiAjCiXMF_FK@shell.armlinux.org.uk>

On Sat, Jul 05, 2025 at 08:05:50PM +0100, Russell King (Oracle) wrote:
> On Sat, Jul 05, 2025 at 05:51:11PM +0200, Andrew Lunn wrote:
> > On Sat, Jul 05, 2025 at 05:09:30PM +0800, Jisheng Zhang wrote:
> > > The dwmac 5.20 IP can be found on some synaptics SoCs. Add a
> > > compatibility flag for it.
> > 
> > Is a compatible flag enough to make it actually work?

Yep, it's enough, we are using dwmac-generic.c for DT based platforms

> 
> Also, shouldn't there be a binding doc update?

The binding doc is already upstreamed by the following commit:
13f9351180aa ("dt-bindings: net: snps,dwmac: Add dwmac-5.20 version")

Hi Russell, Andrew,

Kindly let me know if I still need to do more to let this CL merged.

Thanks in advance

> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

