Return-Path: <netdev+bounces-233025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8F8C0B437
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 22:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0ECB1898AC6
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 21:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2728A2848A7;
	Sun, 26 Oct 2025 21:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdijT+if"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA491E32D7;
	Sun, 26 Oct 2025 21:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761513629; cv=none; b=r3nWj6s9bn/KUWFA7EEPHLB9hkafEy7Z7KrqSUt61qTYrSkzPtIL4y+RQRYK0Gg8fSDT5px+FXQHCIxoL7rIu4gYL1G/DYPeSBLbii8mX8ST1SviUIsEFrWueso0kVzVQEPAYZ+YcuCwp3u5SCyWLj0DAuf3gVPNL8ly+CwvB9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761513629; c=relaxed/simple;
	bh=ZegoPmRGI2ZQ9kZLMvZ4voOFtPZcXtlpwahTpp78m2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ek5WVzJjNkWvLUp/gWKNMUbupAbOQbtPyJvftGhFWTt2QHiQqCJuv2icN/bwQ51Lw2I4AFq91owhs/fiG5MlPoWdx/EjxQtXUPZtlzt45LluvcXm1Umnnxr+SGAaMCXUMHadKafKiGG1LCV6BKYVbLP2hAC+NWD3YEGnHM13nWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdijT+if; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51237C4CEE7;
	Sun, 26 Oct 2025 21:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761513628;
	bh=ZegoPmRGI2ZQ9kZLMvZ4voOFtPZcXtlpwahTpp78m2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UdijT+ifnLPwq5Jv/0zfHFhx78w54at2yVNcnd28hcKTiOQifD5QFXJHaNMOozAqq
	 5EmsavATIhrMtWAnencCoSHIuRmBFeRCgr50+UCZQ+HHfybWEjXyTw4LKGJq8t+bTp
	 ox+QuVf9auCCoas/9uK1xAqaBsbv/sFMqXvewZmBcBKcKrzY2JCRo0aJdDPvH4L7Ob
	 XlUOXsRHE0Vh0Tqp25FU4eYR7ZcVkBuUC/F/Ob0YxRNTLuCn8uX4lK5GU+ZaqufjJx
	 K8vW3v1K6dcm3WHn9XBV8ECHeUXpuXKMDlndZ4AXU1OAjeJqCx7YYy80qr0bJpieyv
	 4XppIBO3tBq/Q==
Date: Sun, 26 Oct 2025 16:20:26 -0500
From: Rob Herring <robh@kernel.org>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/4] dt-bindings: net: mdio: add
 phy-id-read-needs-reset property
Message-ID: <20251026212026.GA2959311-robh@kernel.org>
References: <cover.1760620093.git.buday.csaba@prolan.hu>
 <3a93b87f2bf7ea87c1251d2360e11e710772dd92.1760620093.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a93b87f2bf7ea87c1251d2360e11e710772dd92.1760620093.git.buday.csaba@prolan.hu>

On Fri, Oct 17, 2025 at 06:10:10PM +0200, Buday Csaba wrote:
> Some Ethernet PHYs require a hard reset before accessing their MDIO
> registers. When the ID is not provided by a compatible string,
> reading the PHY ID may fail on such devices.
> 
> This patch introduces a new device tree property called
> `phy-id-read-needs-reset`, which can be used to hard reset the
> PHY before attempting to read its ID via MDIO.

If your phy needs special handling, provide a compatible and use that.

> 
> Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
> ---
> V2 -> V3: unchanged
> V1 -> V2: added this DT binding
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
> +
>    sfp:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
> -- 
> 2.39.5
> 
> 

