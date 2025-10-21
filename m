Return-Path: <netdev+bounces-231388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 29879BF89C5
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 22:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C58094FE85F
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 20:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AE42797B5;
	Tue, 21 Oct 2025 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFlB+Ka5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC72277CBD;
	Tue, 21 Oct 2025 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761077425; cv=none; b=WRj9AtqTVUIY8y9SX642GHrLw93ZckBbYPhKlhSs+zyyPQpMVh2LrCSgMW+dRkEyf/1FT2QpQNMxc5hLYyWCXJ0p4NKSictNlqoSnBwYxtssXKCF+eRtVRWbxmi6LfjLWSnatsyc/pj1wg2Vd21SZqBFAmkMxwXW6AZsOhfQMyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761077425; c=relaxed/simple;
	bh=pgcesUdsb4sOk+nQyeiALpy53Al2dO4CVJReuvh25oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcKXhHyzXvi2APkKga7HkvL5ofoajyKjQjH9v1Fi2kdfmBB6soQ9P2eSmW0eqoKpGSpmO8htN9mt5gnIS2QBZ3xVVf4vTsAiR6sauLufAsqLRjxwlatKlE/mEqlca+oYTxoww9UC64naUATgEcxut9ryxSVDxkKU7w63Shd6pNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFlB+Ka5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1817C4CEF5;
	Tue, 21 Oct 2025 20:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761077424;
	bh=pgcesUdsb4sOk+nQyeiALpy53Al2dO4CVJReuvh25oM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SFlB+Ka53VGE4pbBygrynKZSImqRezXoDmxS8uwAcEFQd1ao/cJxXY//XG5MTO+ZB
	 1zEwXwd2XuT96c6NC20Zhg4QM2/gjo9fFH5jWpTgX8vXlIGHi/as/IKFH8NYr+tvmg
	 ccDbWHQAa/LRifV5e+mxENW7Vn7hSqVJT+fiiwKYprqYV1wXSvtFXQMNr8c4T4/L9F
	 dM0rs7t/IL1mPjyPF38XSQ65h5mG0e2buc+7+YE4Ot16GxHWjCOg5fIAWVEnou4sYA
	 wYNnNhxnkFn7LN0wWcREnrAIEg9FabstmbSczcHAQ68SyTYh1TX8grUYjhBDeTh+4x
	 YuN6/IOnEwgmw==
Date: Tue, 21 Oct 2025 15:10:23 -0500
From: Rob Herring <robh@kernel.org>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: net: mdio: add
 phy-id-read-needs-reset property
Message-ID: <20251021201023.GA741540-robh@kernel.org>
References: <20251015134503.107925-1-buday.csaba@prolan.hu>
 <20251015134503.107925-3-buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015134503.107925-3-buday.csaba@prolan.hu>

On Wed, Oct 15, 2025 at 03:45:02PM +0200, Buday Csaba wrote:
> Some Ethernet PHYs require a hard reset before accessing their MDIO
> registers. When the ID is not provided by a compatible string,
> reading the PHY ID may fail on such devices.
> 
> This patch introduces a new device tree property called
> `phy-id-read-needs-reset`, which can be used to hard reset the
> PHY before attempting to read its ID via MDIO.
> 
> Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
> ---
>  Documentation/devicetree/bindings/net/ethernet-phy.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> index 2ec2d9fda..b570f8038 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> @@ -215,6 +215,14 @@ properties:
>        Delay after the reset was deasserted in microseconds. If
>        this property is missing the delay will be skipped.
>  
> +  phy-id-read-needs-reset:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Some PHYs require a hard reset before accessing MDIO registers.
> +      This workaround allows auto-detection of the PHY ID in such cases.
> +      When the PHY ID is provided with the 'compatible' string, setting
> +      this property has no effect.

If the phy is listed in DT, then it should have a compatible. Therefore, 
you don't need this property.

Rob

