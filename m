Return-Path: <netdev+bounces-119311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3435955229
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 22:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7CD1F22168
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 20:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359A21C68A8;
	Fri, 16 Aug 2024 20:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kw1iIC2z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E301C68A3;
	Fri, 16 Aug 2024 20:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723841936; cv=none; b=iSAoaEfkXbs5L4vOS5MlMMVDd6koGKXUpnRjOOhjSlK/550tLbuKpvTgfyTpiXF2hyLH6XpWrJjKFR0FVoi02s52rUxFuj5sDTw6QHCFPAdjl6EJvDOgHiJYbw9OeecYts3SFNXqWzvTamOocutwnZQj3EAnsvvf3hGTOfMPXsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723841936; c=relaxed/simple;
	bh=d/gXKV+rzSeF81+qiKEmv3B6KI33JDPBB1EQCC/niTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwKDu4sOcjFF7nRaTDwBUr6mKkspJcMAB/q7zYPI4IHU1DT536SXatn+OQksv8KrC5thKSgw+yNUjUBt4Y4GXsFwZlcOLFiakstBOUIrH3vcl5QrnZZA4aHAdgvRrtMPktNFCsZ4iY9eC+dDIaX0tZEdA2tJ/ddcb9Zv45670gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kw1iIC2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457AEC32782;
	Fri, 16 Aug 2024 20:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723841935;
	bh=d/gXKV+rzSeF81+qiKEmv3B6KI33JDPBB1EQCC/niTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kw1iIC2zcVH425XaIRUmdpEBpaUSjqCwZYku3c7DZ5vF1vOdaC+XZAnCgtle39qlk
	 /Ci2/W9Jx60laZCU4o5S9mVXxj5U1Asy7xZbMio8ay2z/QPfLmMQ1Bionk4fkF1cOt
	 d3HPfhxnl/98Y9sFOHR4CCpXPegQHg0lLIRBrBLnAnfzuCk+6rkzVD5Wt3YrXjl98k
	 zgSpJrwoWz/xl1WbpAYJIfp3Oqz1NsIZKOHWIgAG0IO2uL6WAZhoxsygt9mYOZm8Ra
	 yLJa3llWeTZLioq72YQi0Cnx3LftF6/Ck3p0/VIMzjxtdzGCffdO21fLydL+lwL6fH
	 4OyK8mud/e4og==
Date: Fri, 16 Aug 2024 14:58:54 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	devicetree@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Conor Dooley <conor+dt@kernel.org>,
	imx@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v4 1/1] dt-bindings: net: mdio: change nodename match
 pattern
Message-ID: <172384193319.2153392.2293896904577787066.robh@kernel.org>
References: <20240815163408.4184705-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815163408.4184705-1-Frank.Li@nxp.com>


On Thu, 15 Aug 2024 12:34:07 -0400, Frank Li wrote:
> Change mdio.yaml nodename match pattern to
> 	'^mdio(-(bus|external))?(@.+|-([0-9]+))$'
> 
> Fix mdio.yaml wrong parser mdio controller's address instead phy's address
> when mdio-mux exista.
> 
> For example:
> mdio-mux-emi1@54 {
> 	compatible = "mdio-mux-mmioreg", "mdio-mux";
> 
>         mdio@20 {
> 		reg = <0x20>;
> 		       ^^^ This is mdio controller register
> 
> 		ethernet-phy@2 {
> 			reg = <0x2>;
>                               ^^^ This phy's address
> 		};
> 	};
> };
> 
> Only phy's address is limited to 31 because MDIO bus definition.
> 
> But CHECK_DTBS report below warning:
> 
> arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: mdio-mux-emi1@54:
> 	mdio@20:reg:0:0: 32 is greater than the maximum of 31
> 
> The reason is that "mdio-mux-emi1@54" match "nodename: '^mdio(@.*)?'" in
> mdio.yaml.
> 
> Change to '^mdio(-(bus|external))?(@.+|-([0-9]+))?$' to avoid wrong match
> mdio mux controller's node.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v3 to v4
> - add ? in end of pattern to allow mdio{}. not touch mdio-gpio.yaml.
> 
> Change from v2 to v3
> - update mdio-gpio.yaml node name mdio to mdio-0 to fix dt_binding_check
> error foud by rob's bot.
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mdio-gpio.example.dtb: mdio: $nodename:0: 'mdio' does not match '^mdio(-(bus|external))?(@.+|-([0-9]+))$'
> 	from schema $id: http://devicetree.org/schemas/net/mdio-gpio.yaml#
> 
> Change from v1 to v2
> - use rob's suggest to fix node name pattern.
> ---
>  Documentation/devicetree/bindings/net/mdio.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


