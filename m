Return-Path: <netdev+bounces-121625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FC595DC3B
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 08:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4F3C284F8A
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 06:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4640914EC7D;
	Sat, 24 Aug 2024 06:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cr64kY9q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1125F3A8E4;
	Sat, 24 Aug 2024 06:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724481033; cv=none; b=maYNKXaPyPSoC+plChn/lsUBQy+jtaZRuO4o0E+vzCU4y6i4ne6Tc5NYM6pyocVMeFun3Bvml41Htlj3Ml6YIrROp/AUj2DnwWkPE7fUIJjQ3ATANmxoZK6DQxC7TSAq/EeXUaTqEYQHRIRKjV6Dw04fzq2zZx04cZRE8t+P2ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724481033; c=relaxed/simple;
	bh=8ZW0C1G6c5DfMKglNLllIKATSj5OZh1hs2/PFlDai9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7n1Vl+519W8matnbQxNrXecN5odiXvK7WL6OrJyuDKhRIK+8hIiDkyeqVlJnbUx8kS8PuDS3VsG1XHsQQYX656bY08A76T1FxG4Q47vH1y0GUbOVobPt6vqfqJP+8TZAc+Ms81iRFC9ECFX9vTNgOeFK1nGv/OX1JN/wDbIro4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cr64kY9q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7037C32781;
	Sat, 24 Aug 2024 06:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724481032;
	bh=8ZW0C1G6c5DfMKglNLllIKATSj5OZh1hs2/PFlDai9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cr64kY9qomjZQwnaUs3S9tL8cnadlk4bWZdZ3p4xzqRTfzr1gWkH9F2gBgd4bchUk
	 N0KiCn15ghXPcTQIdFJcgcFVv0vELid6xHMoUNuopdiNbUSCGCzGAbqUkCXf/sjBDJ
	 y3VCNa8SaYLmx68RIw7SknV603mFxFdG9FeiuViLvja/1XKnMkti/C+mqaMX05l5fK
	 TOc79q9MfQ41qbfzMDOmD5KarV2lyqC/wLhwxjzdkB8XptCW9g/x1QyM+leg+ghsU9
	 RgzAbPWgmmrpZOUrI0MrlIkpEQvGgChK33NG56O8+CVcJ4SaYzEuWr2+AQ9ajwvllD
	 Ej2rUnU0N4DeA==
Date: Sat, 24 Aug 2024 08:30:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: amitkumar.karwar@nxp.com, neeraj.sanjaykale@nxp.com, 
	marcel@holtmann.org, luiz.dentz@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bsp-development.geo@leica-geosystems.com, customers.leicageo@pengutronix.de
Subject: Re: [PATCH next 1/2] dt-bindings: net: bluetooth: nxp: support
 multiple init baudrates
Message-ID: <6he2msn6oj74isl4l3b2ivegfh6sf5rvqo6cqpcmoqrnvonka4@kesvvmd45l7i>
References: <20240823124239.2263107-1-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240823124239.2263107-1-catalin.popescu@leica-geosystems.com>

On Fri, Aug 23, 2024 at 02:42:38PM +0200, Catalin Popescu wrote:
> Make "fw-init-baudrate" a list of baudrates in order to support chips
> using different baudrates assuming that we could not detect the
> supported baudrate otherwise.
> 
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
> ---
>  .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml  | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> index 37a65badb448..42e3713927de 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> @@ -25,11 +25,12 @@ properties:
>  
>    fw-init-baudrate:
>      $ref: /schemas/types.yaml#/definitions/uint32
> +    maxItems: 8
>      default: 115200
>      description:
> -      Chip baudrate after FW is downloaded and initialized.
> -      This property depends on the module vendor's
> -      configuration.
> +      List of chip baudrates after FW is downloaded and initialized.
> +      The driver goes through the list until it founds a working baudrate.
> +      This property depends on the module vendor's configuration.
>  

You need to test your patch... and update the example and explain why
changing from 1 to 8 items (so ABI break) is okay or needed.

But even without updating the example, you would see errors when testing
DTS, so this was never tested. :/

Best regards,
Krzysztof


