Return-Path: <netdev+bounces-250900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A53D397B1
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 17:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AF3D30088BE
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 16:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27861D416C;
	Sun, 18 Jan 2026 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UWARjCTE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4152D515;
	Sun, 18 Jan 2026 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768752109; cv=none; b=f9lMFrsAzEekFuUsPgnRC+B3xwTXAcA6PahgNy6Eygre6JTWNSk+sr9XNiBCrTl2tpkADJrstvVlGsIbegQ3PVWXleIgZrzi4Ea+wpTLFzCKSb94OBfysT4ctAnNfXbAZItB6/Ce2nR8zB2O/kACiVQ1R+wL7rVSjJZFhaITrR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768752109; c=relaxed/simple;
	bh=2tPLVtUcmlNgzcjePqKEikVmIKnrzXJ8VIH0ipbvnQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrvHh187tg74agCx+9YB8vrlt3ldTvnuGXiPehjmZQ3J8Vs58rARhS8WukARULVHlSwY68Fq2NrS/mj0kHTgnQcQ3O8FKhk01SKiP0t+fB2JcEPxSk++oTaZ88ez5QLszk2urtG1o0rhc1Xa614jnapr+8XhYdlNIJeSndci4yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UWARjCTE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vnYChq4ZvENtM2GcteLuTihPDAtrBEYkDAjTfXG0beM=; b=UWARjCTEMhMnxzI07W4B+QF957
	T1TPeU1kk2XUtUdT2yehio5sUVqlvtTZ81PZUJSldlpK1AqSm8Cj/lDu6RYyh35kKrwEhObVYhWX+
	h/W/rmBdw578Qa9VjCO4M+M6ogPQ+5u/x6mS+JU7CmTaH4eXoh3aEEbp4xrAoxXb9gvw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vhVDe-003Min-JD; Sun, 18 Jan 2026 17:01:38 +0100
Date: Sun, 18 Jan 2026 17:01:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Josua Mayer <josua@solid-run.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	Rabeeh Khoury <rabeeh@solid-run.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: sfp: support 25G long-range modules (extended
 compliance code 0x3)
Message-ID: <e04e8bec-a7c5-4e2d-bdd8-fdf79c29deba@lunn.ch>
References: <20260118-sfp-25g-lr-v1-0-2daf48ffae7f@solid-run.com>
 <20260118-sfp-25g-lr-v1-2-2daf48ffae7f@solid-run.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118-sfp-25g-lr-v1-2-2daf48ffae7f@solid-run.com>

On Sun, Jan 18, 2026 at 04:07:38PM +0200, Josua Mayer wrote:
> The extended compliance code value SFF8024_ECC_100GBASE_ER4_25GBASE_ER
> (0x3) means either 4-lane 100G or single lane 25G.

Is there a way to tell them apart?

If it is a QSFP, it means 4-lane 100G? You can however split it into
4x 25GBASE_ER, if the MAC supports port spitting? If it is an SFP, it
must mean 25GBASE_ER because the SFP only supports a single lane?

> Set 25000baseLR_Full mode supported in addition to the already set
> 100000baseLR4_ER4_Full, and handle it in sfp_select_interface.
> 
> This fixes detection of 25G capability for two SFP fiber modules:
> 
> - GigaLight GSS-SPO250-LRT
> - FS SFP-25G23-BX20-I

Are these SFPs or QSFPs?

> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>  drivers/net/phy/sfp-bus.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
> index b945d75966d5..2caa0e0c4ec8 100644
> --- a/drivers/net/phy/sfp-bus.c
> +++ b/drivers/net/phy/sfp-bus.c
> @@ -247,6 +247,7 @@ static void sfp_module_parse_support(struct sfp_bus *bus,
>  	case SFF8024_ECC_100GBASE_LR4_25GBASE_LR:
>  	case SFF8024_ECC_100GBASE_ER4_25GBASE_ER:
>  		phylink_set(modes, 100000baseLR4_ER4_Full);
> +		phylink_set(modes, 25000baseLR_Full);

Given the question above, i'm wondering if it is as simple as this, or
we need to look at the type of SFP?

	Andrew

