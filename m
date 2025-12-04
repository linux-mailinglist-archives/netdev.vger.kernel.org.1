Return-Path: <netdev+bounces-243604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD75CA46E0
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 17:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD248305578E
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 16:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D9C217F36;
	Thu,  4 Dec 2025 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRdZROds"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A597B2D2397;
	Thu,  4 Dec 2025 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764864798; cv=none; b=b0l1EFfACE3oDat5PW89Yrs1JpfuD6ZWCoaxuoiFLV+AXpo+9qAD5M7ecEfjGCQMW8luNqEjvu7BquccBQSzZqZwjma/SJe5GrLbvfHDF53TY3EpSt6VYqb5PfLrlk6iPGlDbOOxGgs2WRhGScwsq3cCWwb9UO9FMcJIRNVB/oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764864798; c=relaxed/simple;
	bh=BrNx6hRXccMLCbDLWyg8tGP+XIvGp7NdIU9kGAIwDxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/EG/4jq7NSPwppKcqt4u3U/gfjz5Qq3uMEsStco5UYN0Mne5kzu+JrUwHJMUzRmtSjEPiudvsYp+SlazBg+ugrEW6UA3XK14IAPVAzfo0s2RzIGgMB+ZnwuDAYgzVnXs2K/+98eyrVhGxJBerTnldNb4m/QB5QDMi/4IEXqI1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRdZROds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F84C4CEFB;
	Thu,  4 Dec 2025 16:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764864798;
	bh=BrNx6hRXccMLCbDLWyg8tGP+XIvGp7NdIU9kGAIwDxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aRdZROds3f0jvOdMXob8rBlcxJFXp/eb84yof+VXswL63kLYl7AM8zbN15mhmaTRc
	 cioIGfrmSYahuhtxgDP5boH33oev09ETkd9pIyzBzKg0tEf9O6JCPWchmhuyQQRTYp
	 k1fGSMxnnhM+vMqsjRzUGhbvMTpsf26fYO0t8dm7lS3PnyfwieLl9Ou+Sjlo2trHno
	 draZfUk4xJgTBWfJj82BpaPLSaSe3WnX1VdF1RmyTdVE12JDOR46dS2XeKHqjB6UIw
	 g23s1fN8n3xf5iMxRNJX81HFRZaOWh6JxSGBUiNO7Xalkaaw2zvyzSUWKdI6qiEE62
	 VIbWwDYEZU8GQ==
Date: Thu, 4 Dec 2025 10:13:15 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: devicetree@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>, Lee Jones <lee@kernel.org>,
	netdev@vger.kernel.org,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	"David S. Miller" <davem@davemloft.net>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	linux-phy@lists.infradead.org, linux-mediatek@lists.infradead.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Vinod Koul <vkoul@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/9] dt-bindings: net: xpcs: allow properties
 from phy-common-props.yaml
Message-ID: <176486479535.1579612.18279461397755794325.robh@kernel.org>
References: <20251122193341.332324-1-vladimir.oltean@nxp.com>
 <20251122193341.332324-5-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122193341.332324-5-vladimir.oltean@nxp.com>


On Sat, 22 Nov 2025 21:33:36 +0200, Vladimir Oltean wrote:
> Now XPCS device tree nodes can specify properties to configure transmit
> amplitude, receiver polarity inversion, and transmitter polarity
> inversion for different PHY protocols.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


