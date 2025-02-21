Return-Path: <netdev+bounces-168332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23976A3E940
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 01:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BEF83BF738
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 00:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463A72AF1B;
	Fri, 21 Feb 2025 00:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wgl2orus"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1277B2AE99;
	Fri, 21 Feb 2025 00:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740098524; cv=none; b=c7ZqXe+r/Mayj2PCt/CCrixfIqNIEscZcEF3r/6jvZpwM2Rn+7MATAVqzg+Y3t4LuCU19yXMsvxC5A/5aigO9N5recB7YMab3lqE097MfNPSCTRmvxehbpnUq2M2tDvdHEmR5Xhv3O604qX38XmEPN3yu5NN0dsXney0tJJrnTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740098524; c=relaxed/simple;
	bh=kcq2icssB6LIoGsmOFYQXCXzmXJNE/LKNHOLEMUJmG0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g4y5+dc0YPPcDMVZvlIrSeGhb5eECDyu7WqDZ036UB4cAStnWMvHAbi1EsiIogvOb/fsDqD6PBWxbc9WEn2GpqJ+mLkNQJtxxmQQIUXJ6lAFKfpglm0Nzp7DiZtOrBIHBm4pSyTm6bdTmxLBl0bqiI0u64WLBA/jMr1dv70ChVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wgl2orus; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA96C4CEE4;
	Fri, 21 Feb 2025 00:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740098523;
	bh=kcq2icssB6LIoGsmOFYQXCXzmXJNE/LKNHOLEMUJmG0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wgl2orusA60uthPJd7x08Fm/8mJxOd49NH5ZLUptjH9hzhB2rwbbD5kN7is3OfJOd
	 nAmt30IoQ23X6MPmh8ZAdSXDHE6a9/ymnDTZ1XA/BFzrJ1hLnXk8A0C2v3eglAdYRb
	 maQaRxpzV9eo8MlNRExJNIQHH3YM1/YaI68IAN7bxFU6fxprq1xquPhiUQGEnaI11w
	 753enP6GEo7CyrmvatY4V4TOQAUFD9j4biMUgKpE8hxxq5K3VJrXKoqAbmDHnDkkMN
	 CO/nyVVluwDxe+FuwZ9TZrIx/vPX4SWTHhJqF5r/p5lFk6MqxkXSOCsHu9VUk21W01
	 FKZr6ftqHhgPQ==
Date: Thu, 20 Feb 2025 16:42:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Rob Herring
 <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 02/12] net: pse-pd: Add support for
 reporting events
Message-ID: <20250220164201.469fdf6d@kernel.org>
In-Reply-To: <20250218-feature_poe_port_prio-v5-2-3da486e5fd64@bootlin.com>
References: <20250218-feature_poe_port_prio-v5-0-3da486e5fd64@bootlin.com>
	<20250218-feature_poe_port_prio-v5-2-3da486e5fd64@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 17:19:06 +0100 Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Add support for devm_pse_irq_helper() to register PSE interrupts. This aims
> to report events such as over-current or over-temperature conditions
> similarly to how the regulator API handles them but using a specific PSE
> ethtool netlink socket.

I think you should CC HWMON ML on this.
Avoid any surprises.

> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> index 655d8d10fe24..da78c5daf537 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -1526,6 +1526,22 @@ attribute-sets:
>          name: hwtstamp-flags
>          type: nest
>          nested-attributes: bitset
> +  -
> +    name: pse-ntf
> +    attr-cnt-name: __ethtool-a-pse-ntf-cnt
> +    attributes:
> +      -
> +        name: unspec
> +        type: unused
> +        value: 0

Please don't add the unused entries unless your code actually needs
them. YNL will id real ones from 1 anyway.

> +      -
> +        name: header
> +        type: nest
> +        nested-attributes: header
> +      -
> +        name: events
> +        type: nest
> +        nested-attributes: bitset

Do we really need a bitset here? Much more manual work to make a bitset
than just a uint + enum with the bits. enum is much easier to use with
YNL based user space, and it's more self-documenting than a list of bits
buried in the source of the kernel.

>  operations:
>    enum-model: directional
> @@ -2382,3 +2398,13 @@ operations:
>            attributes: *tsconfig
>          reply:
>            attributes: *tsconfig
> +    -
> +      name: pse-ntf
> +      doc: Notification for pse events.

s/pse/PSE/

> +
> +      attribute-set: pse-ntf
> +
> +      event:
> +        attributes:
> +          - header
> +          - events


