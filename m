Return-Path: <netdev+bounces-160002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D09A17B41
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 11:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387A71611DD
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 10:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC401B6D14;
	Tue, 21 Jan 2025 10:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+Ffryq/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3940219E0;
	Tue, 21 Jan 2025 10:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737454657; cv=none; b=FhUEBDpuwo6tCNpUUaT5tz7AcKrcmzjCYuWk+1ljGt5NLyjNuu6oNaD0UwCybjjIdwmQXBlBc3Vq3gN3FFyozIasL2rLMbE5Ax8rsV6hgPxAxYWl6cbv6cVt+2sBSrvJXqxBU8h2KHjOU0SIDx0asTpMsQBcckUr0WdZH5UgPIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737454657; c=relaxed/simple;
	bh=6mXqJe6B8alS7DCJy1K/TAUwfPmG26n8CKqlEqTvj9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyuIhA7ct7qknHr+OKpyu4WWHR9npYToZFlMl0N3lcKhco1wRzbXIx7TO6q4OzuKt074sQ9GULgkUOfpZo+B8oPQiix2POawtUoBLAfmiJ4f/m1fbSmKEwUKiB6qubQwdR0J4ItAhnH5ahljgJd3SUUP8nMWA+luC6W9NS6vDfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+Ffryq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F5AC4CEDF;
	Tue, 21 Jan 2025 10:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737454657;
	bh=6mXqJe6B8alS7DCJy1K/TAUwfPmG26n8CKqlEqTvj9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q+Ffryq/DmXIf93TuLspRCgUD/wiZWWnVWDhaulCRcQSyQnP4nXE0bfGgTjwpKsiM
	 W+FbiHoCkF5RhjBUx+AtE/hL+Bpp26kn+yFpNGuAa/yP/muT2dHfNa6UZVQIK9ppHe
	 3eYMCbvFRULwd2KMAe91dv839SKtRnjXxak1T5ay1iZkWEx+1I69yjWN8snmbjuPow
	 E3EcWXPr3RfLGqfa5IkLW/SGoQHFm/+npgJ6yJl+acaCNIsgUklAW+Op78G4gL34DU
	 TSGv/PR0oBeZGxxMR54vzFHzvwr/0C72gre0yer+7o7+xWleWFCpZzG5loJWPD8zlk
	 4NrToOAsR4bXQ==
Date: Tue, 21 Jan 2025 11:17:34 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH net-next v2 1/3] dt-bindings: net: ethernet-phy: add
 property tx-amplitude-100base-tx-gain-milli
Message-ID: <20250121-augmented-coati-of-correction-1f30db@krzk-bin>
References: <20250120-dp83822-tx-swing-v2-0-07c99dc42627@liebherr.com>
 <20250120-dp83822-tx-swing-v2-1-07c99dc42627@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250120-dp83822-tx-swing-v2-1-07c99dc42627@liebherr.com>

On Mon, Jan 20, 2025 at 02:50:21PM +0100, Dimitri Fedrau wrote:
> Add property tx-amplitude-100base-tx-gain-milli in the device tree bindings
> for configuring the tx amplitude of 100BASE-TX PHYs. Modifying it can be
> necessary to compensate losses on the PCB and connector, so the voltages
> measured on the RJ45 pins are conforming.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---
>  Documentation/devicetree/bindings/net/ethernet-phy.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> index 2c71454ae8e362e7032e44712949e12da6826070..ce65413410c2343a3525e746e72b6c6c8bb120d0 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> @@ -232,6 +232,14 @@ properties:
>        PHY's that have configurable TX internal delays. If this property is
>        present then the PHY applies the TX delay.
>  
> +  tx-amplitude-100base-tx-gain-milli:
> +    description: |
> +      Transmit amplitude gain applied (in milli units) for 100BASE-TX. When

milli is unit prefix, not the unit. What is the unit? percentage? basis
point?

> +      omitted, the PHYs default will be left as is. If not present, default to
> +      1000 (no actual gain applied).

Don't repeat constraints in free form text.

Best regards,
Krzysztof


