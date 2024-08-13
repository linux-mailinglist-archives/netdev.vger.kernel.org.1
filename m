Return-Path: <netdev+bounces-117990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E999502FE
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 12:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ABF41F21BFE
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 10:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2854419B3C3;
	Tue, 13 Aug 2024 10:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsCSw3y3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D7C19ADB9;
	Tue, 13 Aug 2024 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546330; cv=none; b=mBGW8wQyM8fePxBJlA/haH84NBmQET0STasTDShlHNEcI3c+v+adTIldvQjtUJWSfjqPUX1YTve62F7qb+ASy9cQ97MBGotbPwVMJNOrxU8xVXUXSVdEAFxTViQRqFMiCsb4cIaIRtZ5ckfk2eNok/iy3PRWgYTA8qRhAZmJVqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546330; c=relaxed/simple;
	bh=19P1yH4b64Ikkc4SmfeEMqvZKraUG3cSFt25H0eCWL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZ1h+w+9rO01wjweN3fRdbNRWlqIqC1FmvaYyLuJ5OmZ9/LFuIrrrzytW89srEXY+bVDEyz7CRRQIOn8sFHEtweChKdnWFI/nYRC3tlUuMXsjEtI6UYGzpnKxaVQB3700fW8UMVINeSno9H+czGAoaL4jvOzulu3QGxncRkncAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsCSw3y3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24046C4AF09;
	Tue, 13 Aug 2024 10:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723546329;
	bh=19P1yH4b64Ikkc4SmfeEMqvZKraUG3cSFt25H0eCWL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NsCSw3y3lVYRZKrIkJAurcwjEwJSjcecqGPWp2dm2IyZN1NA8s9ETcCsa3elW34GA
	 S7ZKO6PAswIa/CJAylNNNsG2Ot/+sQ75+YkEgELJm6pdd4pQ6fmZ7oJESAo6xcdR2+
	 rnQOJhiez6xtHLtBYvLOzbTklMUJE13wyztuVtGvwvU6zf1NhNYb57ks3rEMs+Awic
	 KnsaA4Rztvw7XJ3ltUD0Bu9j6YCeinuqRXkrZ5z3AAPdhbaNaQ9/kBe8Zyzij8m2VO
	 ScgJX7kclPQnBrkaNP00aqOMUdHPwVMbEMJbDOLdsSYaq8gTI2oxKYBLGP80VVXwyp
	 aKTBRZwAI58/Q==
Date: Tue, 13 Aug 2024 11:52:04 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org, o.rempel@pengutronix.de
Subject: Re: [PATCH net-next 2/3] net: ag71xx: use devm for
 of_mdiobus_register
Message-ID: <20240813105204.GB5183@kernel.org>
References: <20240812190700.14270-1-rosenp@gmail.com>
 <20240812190700.14270-3-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812190700.14270-3-rosenp@gmail.com>

On Mon, Aug 12, 2024 at 12:06:52PM -0700, Rosen Penev wrote:
> Allows removing ag71xx_mdio_remove.
> 
> Removed local mii_bus variable and assign struct members directly.
> Easier to reason about.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/atheros/ag71xx.c | 39 ++++++++-------------------
>  1 file changed, 11 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
> index c22ebd3c1f46..1bc882fc1388 100644
> --- a/drivers/net/ethernet/atheros/ag71xx.c
> +++ b/drivers/net/ethernet/atheros/ag71xx.c
> @@ -684,12 +684,10 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
>  {
>  	struct device *dev = &ag->pdev->dev;
>  	struct net_device *ndev = ag->ndev;
> -	static struct mii_bus *mii_bus;
>  	struct device_node *np, *mnp;
>  	int err;
>  
>  	np = dev->of_node;
> -	ag->mii_bus = NULL;
>  
>  	ag->clk_mdio = devm_clk_get_enabled(dev, "mdio");
>  	if (IS_ERR(ag->clk_mdio)) {
> @@ -703,7 +701,7 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
>  		return err;
>  	}
>  
> -	mii_bus = devm_mdiobus_alloc(dev);
> +	ag->mii_bus = devm_mdiobus_alloc(dev);
>  	if (!mii_bus)

Above mii_bus is removed, but here it is used.

>  		return -ENOMEM;
>  

...

