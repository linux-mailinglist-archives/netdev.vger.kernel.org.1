Return-Path: <netdev+bounces-231402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2907BF8CAD
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 22:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6717A19A5D3B
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 20:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2575D283CB5;
	Tue, 21 Oct 2025 20:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uy0GgF99"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9240274666;
	Tue, 21 Oct 2025 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079848; cv=none; b=JkGRew9SKqQpRS7+UA0YQN9PQOkt9h30/DzPBuMZ8DvYAy8g6m5XTsl/nHqI2DP8fdgfwWShL4ejuq0I1pH35Fp3JNlT2tEdAyLHDRrBseowww8KkDwerrKUsRk31Blg+47vwz0mLeKsB4DznEwV05FJPAXnB/upCbB5qgjTZS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079848; c=relaxed/simple;
	bh=dxE7+bbsxi5QIGwvY2JoID7QprUOO5jJg+PQtEckxAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fazwJsaxlMYyP/41bOTjoI5XDUGveNgkwTy80S96M8CESDEaERFUvrP+Zs085cQF7AYODaRvCb6mYH2X527/PIcEF05kodenp8A8fvSLoVI6ILqj3ugvKFfTj1rxecOMNFRahGrrFcizlR/YX8C2koAzXNWbIWXQ67duUeFgKug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uy0GgF99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B8FC4CEF1;
	Tue, 21 Oct 2025 20:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761079846;
	bh=dxE7+bbsxi5QIGwvY2JoID7QprUOO5jJg+PQtEckxAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uy0GgF99hy3KCeJN56y/YReAHPTHDdo3bYZCUcnjYlnj7KtCj4/p8T0W52k6tN+gW
	 4WEK+rld2szHliBsx60NKzLDdVVlffoKhQTsoubQsfGNA2C5od1W0eSOAr2w+t4SHY
	 MSlKgYlZNLMXIz8Xrgls3/Ty5PVfZ233FyyhnjelHmwYAQZvFptO2+65VwjIGx2yUl
	 nMaY94srD3+pJSb2LsEisEaFQeBmwz5jiT14fWwwUeg47sEwOBm4SE5TiMK0Rli2Go
	 NmxrXrqvn6NNK56wAuaRkcs1buc0I4W5kz7IPkjLDbtREzgkjpp7ysklNU+dGI9OEz
	 G4uqP1XdVuVXg==
Date: Tue, 21 Oct 2025 15:50:44 -0500
From: Rob Herring <robh@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, Frank.Li@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 3/8] dt-bindings: net: ethernet-controller:
 remove the enum values of speed
Message-ID: <20251021205044.GA776699-robh@kernel.org>
References: <20251016102020.3218579-1-wei.fang@nxp.com>
 <20251016102020.3218579-4-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016102020.3218579-4-wei.fang@nxp.com>

On Thu, Oct 16, 2025 at 06:20:14PM +0800, Wei Fang wrote:
> Some fixed-link devices have uncommon link speeds. For example, the CPU
> port of NXP NETC switch is connected to an ENETC (Ethernet Controller),
> they are fully integrated into the NETC IP and connected through the
> 'pseudo link'. The link speed varies depending on the NETC version. For
> example, the speed of NETC v4.3 is 2680 Mbps, other versions may be 8
> Gbps or 12.5 Gbps or other speeds. There is no need and pointless to add
> these values to ethernet-controller.yaml. Therefore, remove these enum
> values so that when performing dtbs_check, no warnings are reported for
> the uncommon values.

Every binding that used this was relying on these constraints. So you've 
got to move them into the individual bindings. I'd leave a minimum and 
maximum here.

> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> index 1bafd687dcb1..7fa02d58c208 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> @@ -177,7 +177,6 @@ properties:
>              description:
>                Link speed.
>              $ref: /schemas/types.yaml#/definitions/uint32
> -            enum: [10, 100, 1000, 2500, 5000, 10000]
>  
>            full-duplex:
>              $ref: /schemas/types.yaml#/definitions/flag
> -- 
> 2.34.1
> 

