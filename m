Return-Path: <netdev+bounces-101066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA958FD1D9
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 17:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DC651F2757D
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 15:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D426B481B3;
	Wed,  5 Jun 2024 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaLvBuJ0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B0D19D891;
	Wed,  5 Jun 2024 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717602075; cv=none; b=h1veebhe2ioHlBi75InhRQw0sgV4F7LsNoLD6rcTKiNDUvxumCddahENnNEyZXpopE5VygOPTxdMU3ov3iNKqRf/64SEeVUpeEdjw5ckVynbqnBDNTCisuDFY4fDzDAvaGRpthJv8DyIBSPzAxZvD5+SHeCbnl9Mzw7QLdsjpT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717602075; c=relaxed/simple;
	bh=+5xjWbK4wagRPFFLOdl1Jb03kxWLjGziaouuSjpqiBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J57Bir2+evWKyIhtktUl0Se+Oh6fBGhP7DJoxUPkbwjpVyIO5aCbhc0lBCSfl9Y9sGOJSJT6GDZiQrQOZbrXxvG6RHa/j8SIfu56LqLYueV0OUukOjNmF8/qqryLFkrR5Cu/JbEkOhF7UaetSmAxesTJV6JIjo2NeYV2eZ9eNEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaLvBuJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56CAC3277B;
	Wed,  5 Jun 2024 15:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717602075;
	bh=+5xjWbK4wagRPFFLOdl1Jb03kxWLjGziaouuSjpqiBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TaLvBuJ0YemhiNjgKHdEbhunt+/E95Gn7MIOhYOcWyHEjWYQ2/vN/UBcYT28RgeJf
	 U5dz/vJmj6r3N3jvt68BW7JzjeiFoKGy8uOBeOBYuZbxo1KTxQbLtmdQMjr/qeFM2T
	 KVeK9TM/YvEA8ynKgH0H/dIcqTR9KmrLBt8vO6IJ4tkrvy+rdxEG/bP+1Ki4tjZRGV
	 rwOi8qgI20KWJS7drePpxZARAnwgDP+HzWUI1QAgIANKdHM8RRpPgIOBlzQ8Q1azGr
	 IRzc4mjk3x9+zVFCKqxTR6K30HzBc7LO8ix3z+1srY45iF+pkx0DGziY1cXidKRaWn
	 CkHnKbG6I3x8A==
Date: Wed, 5 Jun 2024 09:41:12 -0600
From: Rob Herring <robh@kernel.org>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux@armlinux.org.uk,
	vadim.fedorenko@linux.dev, andrew@lunn.ch, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	git@amd.com
Subject: Re: [PATCH net-next v3 4/4] dt-bindings: net: cdns,macb: Deprecate
 magic-packet property
Message-ID: <20240605154112.GA3197137-robh@kernel.org>
References: <20240605102457.4050539-1-vineeth.karumanchi@amd.com>
 <20240605102457.4050539-5-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605102457.4050539-5-vineeth.karumanchi@amd.com>

On Wed, Jun 05, 2024 at 03:54:57PM +0530, Vineeth Karumanchi wrote:
> WOL modes such as magic-packet should be an OS policy.
> By default, advertise supported modes and use ethtool to activate
> the required mode.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> ---
>  Documentation/devicetree/bindings/net/cdns,macb.yaml | 1 +
>  1 file changed, 1 insertion(+)

You forgot Krzysztof's ack.

> 
> diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> index 2c71e2cf3a2f..3c30dd23cd4e 100644
> --- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
> +++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> @@ -146,6 +146,7 @@ patternProperties:
>  
>        magic-packet:
>          type: boolean
> +        deprecated: true
>          description:
>            Indicates that the hardware supports waking up via magic packet.
>  
> -- 
> 2.34.1
> 

