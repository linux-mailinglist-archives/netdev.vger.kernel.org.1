Return-Path: <netdev+bounces-180411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EEBA813F6
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 19:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF03C468341
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C631B23F273;
	Tue,  8 Apr 2025 17:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6gm00BS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B8123E23F;
	Tue,  8 Apr 2025 17:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744134469; cv=none; b=LXy3M0d+fQ3UeC4P3VvSmMHUyCLImM9L3pEi3p97YYlCoqceJJYHw+jxXxEHHF/4L0FjBKZlkQ0d0SFdKpVfAjDxm8s2awvyLCXK3Goa6hftRZMSw5Db1vJ7Y1764trPBVMRBe7Gp+GyK5rMpvZ4hZ+Dh9qYvaUuODm+EnHkdrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744134469; c=relaxed/simple;
	bh=R0H4qB2DWVusKSacLmBvQoYOkD35Q2qxSrY8UFIpCvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mb4bzVQWdIrl7QAQSlgtHm8JitZvCktd+1jTnAzzsuCBvPvdB7Sire5AzNM3vvFDR1BiF+CVT1UTyaeyUsabZNwxJ/jnX31LcBpGtoKpwyj7aMBuCcJ2eZ+we7dlxv9FgSz3PTLpRjGDzUZOxP85o+9QtA/xDkZyKoVldYqpR/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6gm00BS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13BFC4CEE5;
	Tue,  8 Apr 2025 17:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744134469;
	bh=R0H4qB2DWVusKSacLmBvQoYOkD35Q2qxSrY8UFIpCvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g6gm00BSrUC9a67VqfO6wzWEjAiHCtHL+S0ONbWlZMdtU1RGAA1v7JyzyXBXm7oSF
	 KWVxyk524MPRmVUAXoOjqyy4XmLat4bzEnXeICTAI7M/iXAG/DfNTO5TZZKyaz4YsX
	 Bo3rtDRoRI1SfJkbJ4gFnuNg4WKEKp1x7kJcK4QbPLDo5ycUvUouZonsO/zCJvwPpZ
	 ldDNwn1Tb4+9MCZVY8ms0z8w+ON0h4iyZ/frlBQjdm7lWsEf1EGE16myKTLJthgtqJ
	 T7L+/DmJH52x5aDEygZvRGYbYNULH/VQ3VuFk71ev3vNdUzfF/xwpP5V77GJG3c5NX
	 l+GMF4NLDc27g==
Date: Tue, 8 Apr 2025 12:47:47 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sean Wang <sean.wang@mediatek.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, upstream@airoha.com,
	linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-mediatek@lists.infradead.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, devicetree@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>
Subject: Re: [net-next PATCH v14 03/16] dt-bindings: net: dsa: Document
 support for Airoha AN8855 DSA Switch
Message-ID: <174413446086.2421916.12520938934401150643.robh@kernel.org>
References: <20250408095139.51659-1-ansuelsmth@gmail.com>
 <20250408095139.51659-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408095139.51659-4-ansuelsmth@gmail.com>


On Tue, 08 Apr 2025 11:51:10 +0200, Christian Marangi wrote:
> Document support for Airoha AN8855 5-port Gigabit Switch.
> 
> It does expose the 5 Internal PHYs on the MDIO bus and each port
> can access the Switch register space by configurting the PHY page.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../net/dsa/airoha,an8855-switch.yaml         | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>




