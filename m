Return-Path: <netdev+bounces-233290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11343C10EBC
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 20:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BAC675080CE
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 19:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A63326D45;
	Mon, 27 Oct 2025 19:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fg5tvawN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BD91E47CA;
	Mon, 27 Oct 2025 19:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761592636; cv=none; b=FsRtVbA7NJlbSV51i+uWwSo0X5ejmd1ZxCmvxD/+ipwhEYkaRDWcFAc4/UZ/ph4D+NIjk29KzqdPNhCtiHygXUuudz+luDVawZMhrsvp1XIXl4m5sDFsRgE1/7YAeOeW9neRtJ28nzgBaDYCz9jnulA7sXUpUxylnui8IPjF47A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761592636; c=relaxed/simple;
	bh=mmWNVH8Z0wkoOiWVvjxfBmmdO0OIAoLLR/+tC4OGlGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXeSl79RodJ5kcAstsQ+ru4zDedR4570Ydiu83LjnnUkpoioFEqgxY3G7qcbev/A2U+LExbGXFuetkknCwvueCb28OfWKeYGG3Ecf8DRj6Iu+sNuk2g1uqmxtLFkqvycblhrJAz9K9kp1pt08h5ezTzT597wAPdGexD+FxMTD8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fg5tvawN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833DEC4CEF1;
	Mon, 27 Oct 2025 19:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761592635;
	bh=mmWNVH8Z0wkoOiWVvjxfBmmdO0OIAoLLR/+tC4OGlGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fg5tvawNQQxKOnGSc2B355zaBy1wf+dUNWGGaKWpOfFCsBx1AYXKLA5NrP0zB5WUB
	 p00fp06Q4LoCtStQwnKmyFGQ2WqTqmQqYcKvxAVFtb72Cavt5zLXq30rX1DPFIZkzP
	 ISwdQgADdznR1/S5ZJPqRYdzrEO1wRTTS96pqYTBY5YpN1O83nJoqyX45Ooxc2XXO2
	 +5NmQrKOSxsu9OCCfW45dQ05DQFExtyfLD1gkoPht6ICeK7WAoGBElpiO0aU4kwP2h
	 F0vuo9hTw6nX92Pw8z82P6MhtDPnX9L9zEseLoGlv6bdgm8Z72D2vsS5WdBTjQ5R91
	 kjQhAlGxWseRw==
Date: Mon, 27 Oct 2025 14:17:14 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, UNGLinuxDriver@microchip.com,
	Daniel Machon <daniel.machon@microchip.com>,
	Robert Marko <robert.marko@sartura.hr>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Lars Povlsen <lars.povlsen@microchip.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH net v2] dt-bindings: net: sparx5: Narrow properly LAN969x
 register space windows
Message-ID: <176159263113.1438645.11402990432058741672.robh@kernel.org>
References: <20251026101741.20507-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026101741.20507-2-krzysztof.kozlowski@linaro.org>


On Sun, 26 Oct 2025 11:17:42 +0100, Krzysztof Kozlowski wrote:
> Commit 267bca002c50 ("dt-bindings: net: sparx5: correct LAN969x register
> space windows") said that LAN969x has exactly two address spaces ("reg"
> property) but implemented it as 2 or more.  Narrow the constraint to
> properly express that only two items are allowed, which also matches
> Linux driver.
> 
> Fixes: 267bca002c50 ("dt-bindings: net: sparx5: correct LAN969x register space windows")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> No in-kernel DTS using it.
> 
> Changes in v2:
> 1. Fix typo in commit msg.
> ---
>  .../devicetree/bindings/net/microchip,sparx5-switch.yaml      | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


