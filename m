Return-Path: <netdev+bounces-244496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8998CB8F25
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 15:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 736583058A7B
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 14:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870ED233711;
	Fri, 12 Dec 2025 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btM8wR5/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEB61B0413;
	Fri, 12 Dec 2025 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765548980; cv=none; b=ikgiwbOL8Vbv35IRv/CrJgKOXdc9ia7i4SoDFbTDgD7nGBMb6t0Eb6OUguXbi3wlFZy5ApdMJoEfxpMSKMssj2Yj2oMk4LoRpFnpk8DjM+ro+2jwRCx14vnHKcYhjDtw23DlrFqX3UrSpQQsZGUpOp0wgL7d1asdrpfV2e7VQp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765548980; c=relaxed/simple;
	bh=Ex7q0aDeGBnUWaPy2HZEmJiIpUIejTnT9frXjXjuIrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6pIUGKlTH64a4+EthA3eOhObKy/fStM9+cRtwYoHM5lu+jWD3Zrz/K/JumJbZMrvDe/KCR6k0WmTvEzbGR8sOmlZbq/R6xu13fxTl+41/yrhZxy+3XXPCCbFd3+0sN7sUNZj4AuI3tjrWn+4ZkHZBz1HPnSFSjhLIfwzHcwJyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btM8wR5/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585AFC4CEF1;
	Fri, 12 Dec 2025 14:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765548979;
	bh=Ex7q0aDeGBnUWaPy2HZEmJiIpUIejTnT9frXjXjuIrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=btM8wR5/lNWhb2RSD6iinBgR4tzoLtn3J/0mLPeKa00vnv5WJJCiudMILQvdO9Zvy
	 edV4D6HmR86DPLz4ItyddkkvAFjGUaCtJIlZgqGEh2W+sQFt6KZYCeviPlQcJ7lkbU
	 pEPa8Cwctmng2AFs1BtDjDB3ugHhxFvhqeisLo2jYZs51pcuMKExV7t70NUqNy5p6B
	 DxBWSsMrmFA9dMAYAtTwtwQaW/44Cw8vtLRTU9eQpnTFHGir4KYsrV3YakuvC8nC7I
	 j+yS/+z2EF7OXAgEahrnWI9yDr8MveOOREosqvSrz9pTrK/FfCh34AdPoRqcSxR8qT
	 J5u47RILwLKow==
Date: Fri, 12 Dec 2025 14:16:14 +0000
From: Simon Horman <horms@kernel.org>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, hkallweit1@gmail.com,
	linux@armlinux.org.uk, geert+renesas@glider.be,
	ben.dooks@codethink.co.uk, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	francesco.dolcini@toradex.com, rafael.beims@toradex.com,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH net-next v1 1/3] dt-bindings: net: micrel: Convert to
 YAML schema
Message-ID: <aTwjrqryY23OH_XE@horms.kernel.org>
References: <20251212084657.29239-1-eichest@gmail.com>
 <20251212084657.29239-2-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212084657.29239-2-eichest@gmail.com>

On Fri, Dec 12, 2025 at 09:46:16AM +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> Convert the devicetree bindings for the Micrel PHY to YAML schema. This
> also combines the information from micrel.txt and micrel-ksz90x1.txt
> into a single micrel.yaml file as this PHYs are from the same series.
> Use yaml conditions to differentiate the properties that only apply to
> specific PHY models.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> ---
>  .../bindings/net/micrel-ksz90x1.txt           | 228 --------
>  .../devicetree/bindings/net/micrel.txt        |  57 --
>  .../devicetree/bindings/net/micrel.yaml       | 527 ++++++++++++++++++
>  3 files changed, 527 insertions(+), 285 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
>  delete mode 100644 Documentation/devicetree/bindings/net/micrel.txt
>  create mode 100644 Documentation/devicetree/bindings/net/micrel.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/micrel-ksz90x1.txt b/Documentation/devicetree/bindings/net/micrel-ksz90x1.txt

...

> -  Optional properties:
> -
> -    Maximum value of 1860, default value 900:
> -
> -      - rxc-skew-ps : Skew control of RX clock pad
> -      - txc-skew-ps : Skew control of TX clock pad
> -
> -    Maximum value of 900, default value 420:
> -
> -      - rxdv-skew-ps : Skew control of RX CTL pad
> -      - txen-skew-ps : Skew control of TX CTL pad
> -      - rxd0-skew-ps : Skew control of RX data 0 pad
> -      - rxd1-skew-ps : Skew control of RX data 1 pad
> -      - rxd2-skew-ps : Skew control of RX data 2 pad
> -      - rxd3-skew-ps : Skew control of RX data 3 pad
> -      - txd0-skew-ps : Skew control of TX data 0 pad
> -      - txd1-skew-ps : Skew control of TX data 1 pad
> -      - txd2-skew-ps : Skew control of TX data 2 pad
> -      - txd3-skew-ps : Skew control of TX data 3 pad
> -
> -    - micrel,force-master:
> -        Boolean, force phy to master mode. Only set this option if the phy
> -        reference clock provided at CLK125_NDO pin is used as MAC reference
> -        clock because the clock jitter in slave mode is too high (errata#2).
> -        Attention: The link partner must be configurable as slave otherwise
> -        no link will be established.

Hi Stefan,

Sorry if this is off the mark, but Claude Code with
https://github.com/masoncl/review-prompts/ flags
that micrel,force-master is not included in the new .yaml
schema and yet it is used in the driver (and I would add,
several dts/dtsi files).

https://netdev-ai.bots.linux.dev/ai-review.html?id=2390d104-ff56-43f2-ba06-9650e8e5343b

...

