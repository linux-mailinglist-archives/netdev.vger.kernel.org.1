Return-Path: <netdev+bounces-174003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94700A5CF6F
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 20:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D65671721E1
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 19:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51701226CE8;
	Tue, 11 Mar 2025 19:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQVfBiRm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2766F17591;
	Tue, 11 Mar 2025 19:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741721498; cv=none; b=qyfNz0y4/0z12T8EQLdb+upfbob9qfa34jM4XMi7rfsb3+otlMt1F7EpaH81ozFCDx4EYqcCh7cEYb/PeJAwkdUDrArAAjr8zgu2Gi6IxgZ2vD/mL3IScBqU/AZksBPxiDi4Mj/V6kRpUHerOy9WzivGAcJn9eX9NGyXNHsDAys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741721498; c=relaxed/simple;
	bh=9vKWwaB9nvbKVoEN30+SqReCmCUlZ1KxsGwp8d3wTDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/RRnU7R0iF8gCYe0Y2UH20gL9ps/PXiT0DDkqBMDJt7is82eGideg2zmBapf968idglHhAzh+nhe87HqSH/G3k/MgG5r06eSCdANErl24MV02zLqRsMssTiBRB7uGKghfvsJZtx002gdFUgKBD/Ln6pbXX6fdj0v3+vBQLIjGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQVfBiRm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6029BC4CEE9;
	Tue, 11 Mar 2025 19:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741721497;
	bh=9vKWwaB9nvbKVoEN30+SqReCmCUlZ1KxsGwp8d3wTDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bQVfBiRm+tK9ub7XWhRYH1fSA49LyxojZHcoZIEpA2/y4jhfdzeYaHh3wH8Fx9fCS
	 FJO7D9rGCl5jwWWYHY8bJV7Eh+Bck5edTeD4AS6JQh+9tvcGzP8CzNhgM1odt8/Wc9
	 VZTfjWf+Momec4SVf3GjKfFZ+KHuiXUiCFq8SIoAHw0YxoDmleV3dpAmZJw9eMyadV
	 BzRcwnE4de5gCMjGdGVRdjrJ77katc+Lf9ggRuIWdYcjqrNBYioZL9/840QlBDdSe9
	 u6LXsizYPXEVlmxNDWCPJB03oJAXuTY1tNLWRli9pq4rFlo52DRjd9tPOCE1RWdQWn
	 ckSJ29Nhs5sww==
Date: Tue, 11 Mar 2025 14:31:36 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Yao Zi <ziyao@disroot.org>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	David Wu <david.wu@rock-chips.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, netdev@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/5] dt-bindings: net: rockchip-dwmac: Add compatible
 string for RK3528
Message-ID: <174172149414.4181803.16963634632371171945.robh@kernel.org>
References: <20250309232622.1498084-1-jonas@kwiboo.se>
 <20250309232622.1498084-2-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309232622.1498084-2-jonas@kwiboo.se>


On Sun, 09 Mar 2025 23:26:11 +0000, Jonas Karlman wrote:
> Rockchip RK3528 has two Ethernet controllers based on Synopsys DWC
> Ethernet QoS IP.
> 
> Add compatible string for the RK3528 variant.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> Changes in v2:
> - Restrict the minItems: 4 change to rockchip,rk3528-gmac
> 
> The enum will be extended in a future patch, Pending RK3562 and a future
> RK3506 variant also only have 4 clocks.
> 
> Because snps,dwmac-4.20a is already listed in snps,dwmac.yaml adding the
> rockchip,rk3528-gmac compatible did not seem necessary.
> ---
>  .../devicetree/bindings/net/rockchip-dwmac.yaml  | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


