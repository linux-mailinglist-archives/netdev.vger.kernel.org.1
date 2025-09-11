Return-Path: <netdev+bounces-222113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB49B53273
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 14:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DEFA165186
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 12:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DE1321F40;
	Thu, 11 Sep 2025 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="InVXk5tU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BEB31D362;
	Thu, 11 Sep 2025 12:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757594323; cv=none; b=tP+8iu9aO+qJC250SJHFWMXaWH+ItI7VOpqiPMAIwaf7+Yb3CTecr47ZtxeHYzkaHiBts4J1ZZ6OLuqKRALS2p3GB8vQzakPOjVznh2n5PnU5rms32m18D7g84kD76FnQrZSJuLAsacCp0S95UqTIgosw7M8MUhzdANuuVcaDQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757594323; c=relaxed/simple;
	bh=3hbK9wf2+mxCowDDtmc5Ops79VGnUo1EqG4EIVO6VFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbcXh1506DpziVPa54VCbv54juFZNeX32myGSh2//UTNuwwoRs7d7Ms+UWU+GgSfgCKGoDigqeYsuY3C4IVqAwPhUYtY1pgafCzRk8rwop0HaDEbOtXbtf5FcryvnmVbbiEqwa5p4R5BhUfRofnCFcWaewuKz3lr5iIQnJARFUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=InVXk5tU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Uez8W5u/gbkeD8LK5BeMMMrUWwpOmn67Ekut9N1X2AY=; b=InVXk5tUMol00XxMVVnl/6yzM+
	h+7kLVi6/C8v+326tvaYONoPE86kKtqpzbQvFncjVfuBY4j6VD83r53GV/3uejNBCAn6738Vmh0Mn
	FigGoq77bYScFtze/coslyp3C1pBjMLDBqRKszZ+tfthYJtzP3FRmYsPKSvI1MvoIEA0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uwgZL-0084p5-TM; Thu, 11 Sep 2025 14:38:31 +0200
Date: Thu, 11 Sep 2025 14:38:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: phy: micrel: Update Kconfig help text
Message-ID: <74a34c78-fed8-4438-9a9e-027d4a4762a7@lunn.ch>
References: <20250911-micrel-kconfig-v2-1-e8f295059050@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-micrel-kconfig-v2-1-e8f295059050@pengutronix.de>

On Thu, Sep 11, 2025 at 10:29:03AM +0200, Jonas Rebmann wrote:
> This driver by now supports 17 different Microchip (formerly known as
> Micrel) chips: KSZ9021, KSZ9031, KSZ9131, KSZ8001, KS8737, KSZ8021,
> KSZ8031, KSZ8041, KSZ8051, KSZ8061, KSZ8081, KSZ8873MLL, KSZ886X,
> KSZ9477, LAN8814, LAN8804 and LAN8841.
> 
> Support for the VSC8201 was removed in commit 51f932c4870f ("micrel phy
> driver - updated(1)")
> 
> Update the help text to reflect that, list families instead of models to
> ease future maintenance.
> 
> Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
> ---
> Changes in v2:
> - Don't capitalize "micrel" in commit message (Thanks, Jakub)
> - Name chip families with the common xxx-placeholders (Thanks, Jakub)
> - Be a bit more specific as to which families
> - Link to v1: https://lore.kernel.org/r/20250909-micrel-kconfig-v1-1-22d04bb90052@pengutronix.de
> ---
>  drivers/net/phy/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index a7fb1d7cae94..e543eef36d98 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -298,7 +298,7 @@ config MICREL_PHY
>  	depends on PTP_1588_CLOCK_OPTIONAL
>  	select PHY_PACKAGE
>  	help
> -	  Supports the KSZ9021, VSC8201, KS8001 PHYs.
> +	  Supports the KSZ8xxx, KSZ9xxx, and LAN88xx families of Micrel/Microchip PHYs.

Much better, thanks.

> Best regards,
> --  
> Jonas Rebmann <jre@pengutronix.de>

It is a bit unusual to see a signature, git send-email, or b4 send
would not do that. But patch(1) should be able to figure this out.

For future reference, the Subject line should have the tree inside the
[].

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


