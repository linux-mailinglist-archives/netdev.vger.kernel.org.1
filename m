Return-Path: <netdev+bounces-243598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 581E0CA459B
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 16:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CB0403007AA7
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 15:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B922EC558;
	Thu,  4 Dec 2025 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pg0bWHfT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DDA2EC559;
	Thu,  4 Dec 2025 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764863543; cv=none; b=R5pSTzhxk0M12EftxhcI2h5ihVrpBcJnDqRQbCxX66aZBM5t4ejGbefsNn4Bwyvc2EKrD+Yv2ntfC2IO1EH0a3leheAYzicQN5AB1I5VnwLFz6kmlNhEihLxTlzzcXbZeKaFyEtKWoa9jUOqWK8+OMkidgE1oU9CVIRWT8BrnvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764863543; c=relaxed/simple;
	bh=gx0KCllM9ErS+DGIJRYM6/W4bjQJj3kqWBhKLjr1UiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVjZZKptpiqlveb/uisXlCxV1tLgbPalQUL52/alBx2HtK7VwnaUZmQR0jV+m6c0UjS5fLkepLgTe+VNhOIlCRixI3UOZK/5m5Ggamp5RDr1mqQgzBUidpIzPDBKIabnmM/T473nKhgVvO4J1qF2QwFKBVM9CLBrNY9expo8ZEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pg0bWHfT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CC3C116B1;
	Thu,  4 Dec 2025 15:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764863543;
	bh=gx0KCllM9ErS+DGIJRYM6/W4bjQJj3kqWBhKLjr1UiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pg0bWHfT+vnpAFNxfwug+IPFq3ujzrQQrYpfkTaS3FonIi5FMu78d2lTK/UKD7QcW
	 ToRRj1eimPm5gCrHIg/crnJnFJLSoxWi+xFof3gDd61UALe+SdpaSva/wmsNHuj2NA
	 gogMqrb90UOV1WVz0UgkFd5GK7LTBlRbdm7dF97mJzTAPKmPbWwBOVBNWO2GLSYMe5
	 4Hv/UoAoNt2IP55W5uSQWQz1w71o6R+YsYvhDkGcQTG3Z2v0/KHQxxM2IHDOgOXFRt
	 cHNVS9DrtbBXmR03dXTIoab+ImcJIpyzNDIcMh5ak72Ce6BswZgf0FjAK1aZZSCsPK
	 5Ynr68VeIVy+A==
Date: Thu, 4 Dec 2025 09:52:19 -0600
From: Rob Herring <robh@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH net-next 2/9] dt-bindings: phy-common-props: create a
 reusable "protocol-names" definition
Message-ID: <20251204155219.GA1533839-robh@kernel.org>
References: <20251122193341.332324-1-vladimir.oltean@nxp.com>
 <20251122193341.332324-3-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251122193341.332324-3-vladimir.oltean@nxp.com>

On Sat, Nov 22, 2025 at 09:33:34PM +0200, Vladimir Oltean wrote:
> Other properties also need to be defined per protocol than just
> tx-p2p-microvolt-names. Create a common definition to avoid copying a 55
> line property.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  .../bindings/phy/phy-common-props.yaml        | 34 +++++++++++--------
>  1 file changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-common-props.yaml b/Documentation/devicetree/bindings/phy/phy-common-props.yaml
> index 255205ac09cd..775f4dfe3cc3 100644
> --- a/Documentation/devicetree/bindings/phy/phy-common-props.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-common-props.yaml
> @@ -13,22 +13,12 @@ description:
>  maintainers:
>    - Marek Behún <kabel@kernel.org>
>  
> -properties:
> -  tx-p2p-microvolt:
> +$defs:
> +  protocol-names:
>      description:
> -      Transmit amplitude voltages in microvolts, peak-to-peak. If this property
> -      contains multiple values for various PHY modes, the
> -      'tx-p2p-microvolt-names' property must be provided and contain
> -      corresponding mode names.
> -
> -  tx-p2p-microvolt-names:
> -    description: |
> -      Names of the modes corresponding to voltages in the 'tx-p2p-microvolt'
> -      property. Required only if multiple voltages are provided.
> -
> -      If a value of 'default' is provided, the system should use it for any PHY
> -      mode that is otherwise not defined here. If 'default' is not provided, the
> -      system should use manufacturer default value.
> +      Names of the PHY modes. If a value of 'default' is provided, the system
> +      should use it for any PHY mode that is otherwise not defined here. If
> +      'default' is not provided, the system should use manufacturer default value.
>      minItems: 1
>      maxItems: 16
>      items:
> @@ -89,6 +79,20 @@ properties:
>          - mipi-dphy-univ
>          - mipi-dphy-v2.5-univ
>  
> +properties:
> +  tx-p2p-microvolt:
> +    description:
> +      Transmit amplitude voltages in microvolts, peak-to-peak. If this property
> +      contains multiple values for various PHY modes, the
> +      'tx-p2p-microvolt-names' property must be provided and contain
> +      corresponding mode names.
> +
> +  tx-p2p-microvolt-names:
> +    description:
> +      Names of the modes corresponding to voltages in the 'tx-p2p-microvolt'
> +      property. Required only if multiple voltages are provided.
> +    $ref: "#/$defs/protocol-names"

The default for .*-names is the entries don't have to be unique. That's 
for the exception, but unfortunately everyone else has to define the 
type (type.yaml#/definitons/string).

Each user needs to define the names of the entries which will enforce 
the length. So defining the length 1-16 here doesn't do much. So I think 
you can drop that and then the $defs is not needed either.

Rob

