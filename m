Return-Path: <netdev+bounces-185346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A010FA99D2E
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 02:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47CCB5A7012
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 00:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703BD2D052;
	Thu, 24 Apr 2025 00:43:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997CC8C0B;
	Thu, 24 Apr 2025 00:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745455430; cv=none; b=VguE8+iR2sSOYpYKroH+q2uwPe4rI4CtCo+zYAgO5EE4RRUToRLzGtiLj7euOcjeSGg2hm3AKdFudRVVrmWq/YlpzJ4CbkFUBfvJiJ3LZQLZU9IgSW0YjnSpk2OiAa88YVpxCsMfIdCzwl3TMdomehg6Q9EFVJLKTMuwq48wU9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745455430; c=relaxed/simple;
	bh=5lr0hOvFVjHbpvGJ32EF8//6WgWpW8Y7H3GFs+lXUho=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bx2RTVUxIgcev48EeukRGyTWsJzc1kr8S6rk70zrdTpwy4qtHutCnjaBUJ6H5IHI8IeouaFNpXPzjk3RHFC+n0Z69Sov3cquw3+vHESTnRGZ9EhuQMD+IZ5iw0gKkE5aQZ79aVcUgGwBJOumJoYCAfccYugIOVIvZ1vbPVl02q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 073311063;
	Wed, 23 Apr 2025 17:43:43 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 812703F59E;
	Wed, 23 Apr 2025 17:43:45 -0700 (PDT)
Date: Thu, 24 Apr 2025 01:42:41 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Yixun Lan <dlan@gentoo.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu
 Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel
 Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 4/5] arm64: dts: allwinner: a527: add EMAC0 to Radxa A5E
 board
Message-ID: <20250424014120.0d66bd85@minigeek.lan>
In-Reply-To: <aa38baed-f528-4650-9e06-e7a76c25ec89@lunn.ch>
References: <20250423-01-sun55i-emac0-v1-0-46ee4c855e0a@gentoo.org>
	<20250423-01-sun55i-emac0-v1-4-46ee4c855e0a@gentoo.org>
	<aa38baed-f528-4650-9e06-e7a76c25ec89@lunn.ch>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 18:58:37 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

Hi,

> > +&emac0 {
> > +	phy-mode = "rgmii";  
> 
> Does the PCB have extra long clock lines in order to provide the
> needed 2ns delay? I guess not, so this should be rgmii-id.

That's a good point, and it probably true.

> 
> > +	phy-handle = <&ext_rgmii_phy>;
> > +
> > +	allwinner,tx-delay-ps = <300>;
> > +	allwinner,rx-delay-ps = <400>;  
> 
> These are rather low delays, since the standard requires 2ns. Anyway,
> once you change phy-mode, you probably don't need these.

Those go on top of the main 2ns delay, I guess to accommodate some skew
between the RX and TX lines, or to account for extra some PCB delay
between clock and data? The vendor BSP kernels/DTs program those board
specific values, so we have been following suit for a while, for the
previous SoCs as well.
I just tried, it also works with some variations of those values, but
setting tx-delay to 0 stops communication.

Cheers,
Andre

