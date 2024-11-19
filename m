Return-Path: <netdev+bounces-146329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 707FF9D2DF5
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 19:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A561B27D5E
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 18:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439ED1D1E8E;
	Tue, 19 Nov 2024 18:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVokfRuf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C0D1CDFCA;
	Tue, 19 Nov 2024 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732040444; cv=none; b=tAcxx/4Bo24mqvQqpf22wyYj1Ny9RpywIq9AVBjBXhCYdmAgFCJE8oSIIJLE0sq7XjNr7W2eGpYcMZMGqaJFCpaMF0dkpznn3YWH+2OGOVEDGhSFXGVdztFDCsYqjOCNOr+t9JZ82wn8AeDkX93CYso7uQIl5V2ZsZjvSE4fgV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732040444; c=relaxed/simple;
	bh=c+7h9hMMGMohgWVCuK5JjLU4dDG65LxAL3SOLXCksaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q09OVuia36u7d3XlHYo8qvGq+WHdxuLqhc9X30D3g4Xo33AASm2PNckOxwlZpne8bO0Wzqww4VmhSAe0PxhbPUWJ8aZK5dYLSKiO6XO6C7yjjCAtP6STAJDxdXHATh95PsIazZzRrL1pf5V0VUTgqUs1ROWYLfbIH76QEhBFnIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVokfRuf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE00C4CECF;
	Tue, 19 Nov 2024 18:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732040443;
	bh=c+7h9hMMGMohgWVCuK5JjLU4dDG65LxAL3SOLXCksaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GVokfRufVjDiWMFrIV55YKvPnfOCikKXfcvMiewwhF33add4VLpqtW2Vw73JsSO6U
	 lG0gVdZtQPV2hEd++iZVLkGGH2ybiE8tTGlQLa3B0Cf5PXekrVqWM4e3HI3D0ISO8k
	 B5dNVHpg6C5CKEDtmFmKP19CRhwsCx4U4f63Q75/WUejr+WA5MrtUjxzotiK3IYDuR
	 EsaZGNjbNghgBAncGOvTEbS7vB0UtIRAN+LJ952CDPNaoLPxDsdEVgpPnyIs02NbL2
	 yZjidGgpE7dl5XTFe9VPst0RAyKogAIP3Xwp9Z00HQmes+vrFF2X6CyJRuxfTWgL7x
	 iBu44xmlHpqFw==
Date: Tue, 19 Nov 2024 12:20:41 -0600
From: Rob Herring <robh@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	hkallweit1@gmail.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next 2/3] net: mdio: aspeed: Add support for AST2700
Message-ID: <20241119182041.GB1962443-robh@kernel.org>
References: <20241118104735.3741749-1-jacky_chou@aspeedtech.com>
 <20241118104735.3741749-3-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118104735.3741749-3-jacky_chou@aspeedtech.com>

On Mon, Nov 18, 2024 at 06:47:34PM +0800, Jacky Chou wrote:
> The Aspeed 7th generation SoC features three Aspeed MDIO.
> The design of AST2700 MDIO controller is the same as AST2600.
> Therefore, just add AST2700 compatible here.

If they are "the same", you don't need to add the compatible here. You 
still need to add it to the binding, but make ast2600 a fallback 
compatible.

> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  drivers/net/mdio/mdio-aspeed.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-aspeed.c
> index e55be6dc9ae7..4d5a115baf85 100644
> --- a/drivers/net/mdio/mdio-aspeed.c
> +++ b/drivers/net/mdio/mdio-aspeed.c
> @@ -188,6 +188,7 @@ static void aspeed_mdio_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id aspeed_mdio_of_match[] = {
>  	{ .compatible = "aspeed,ast2600-mdio", },
> +	{ .compatible = "aspeed,ast2700-mdio", },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, aspeed_mdio_of_match);
> -- 
> 2.25.1
> 

