Return-Path: <netdev+bounces-132161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 721D29909AF
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282A21F2400A
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D181C879F;
	Fri,  4 Oct 2024 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqavDz29"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F314CDEC;
	Fri,  4 Oct 2024 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728060716; cv=none; b=Shx//A+dw2y1NGjXQvFP2kJu/60ee0fp5RTpy2NOVI3a31p4kCV3spp4jyCSzAUvp4/lGR10O5Cu25Gz+BLFmIVvCDfTP+R4MMPdM2jpGXysTAdxnOp9F9Ekz1LqiWTVf1kT/5TMu+AIJmuN0atgtFngi+aMYv3y8tA6K0X7oqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728060716; c=relaxed/simple;
	bh=hZ6aiS5jq6L8gnApAyyG9Gd6HVmPAmAY+ENAgknHgFU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4n4aVRkpufseIJeeD2eHTzHWaqONcDigYUIn7MjqZRaaIdCiPiKsZJBACAiSgumwQQF0TVRYtC/8jXRsn35wJ/IkMAzrdKXfyQkwdX4VBWfhj0flSgnVk86nW3z1SQvrk8htosgFM51hTk+03DC9pRbcN18dUVP8yUXBJaYKkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqavDz29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37292C4CEC6;
	Fri,  4 Oct 2024 16:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728060715;
	bh=hZ6aiS5jq6L8gnApAyyG9Gd6HVmPAmAY+ENAgknHgFU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SqavDz29/wOLnp9C5lDcoDREmnMMjradbwKZVLqLnBB0ZUfe0K3YGjEB5dhH2M3fE
	 BkDUTExePRHvyiIdkFXZa3eAUtHUD/y73pdvcma1gJ00KKPQ9xAn6kHTEHAiaP13Np
	 A/FoxOiG18g1kgHRwSXvq2LYFTaBlvhE3WKaFNdsIIWZjhs83a8wXUWsqlYpcNM4XF
	 fy6OZhCEPusPlpjTkYwepgVVyTjSwVDe/GY5SIUCymZbKL29wcVLGNYej8jehNlQ36
	 LDYEQGXZG6wETRmF3wJytg2wxGlAZ4guDDHF6zP6D+9JNkKqke2lhdbv9gS4D3sxD3
	 wwnz1+SygSxGw==
Date: Fri, 4 Oct 2024 09:51:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Divya.Koppera@microchip.com,
 hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, f.fainelli@gmail.com, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux@armlinux.org.uk, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] dt-bindings: net: ethernet-phy: Add
 timing-role role property for ethernet PHYs
Message-ID: <20241004095154.5810afbf@kernel.org>
In-Reply-To: <19207165-1708-4717-9883-19d914aea5c3@lunn.ch>
References: <20241001073704.1389952-1-o.rempel@pengutronix.de>
	<20241001073704.1389952-2-o.rempel@pengutronix.de>
	<CO1PR11MB47715E80B4261E5BDF86153BE2712@CO1PR11MB4771.namprd11.prod.outlook.com>
	<a11860cc-5804-4a15-9603-624406a29dba@lunn.ch>
	<Zv6XOXveg-dU_t8V@pengutronix.de>
	<19207165-1708-4717-9883-19d914aea5c3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Oct 2024 19:05:58 +0200 Andrew Lunn wrote:
> > 802.3 use "Multiport device" for "preferred master" and "single-port device"
> > for "preferred slave". We decided to use other wording back in the past
> > to avoid confusing and align it with forced master/slave configurations.   
> 
> ethtool is preferred, so it would be more consistent with preferred
> 
> [Shrug]

IIUC we have two weak preferences for "preferred"?
LMK if I misunderstood.
-- 
pw-bot: cr

