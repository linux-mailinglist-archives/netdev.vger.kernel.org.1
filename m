Return-Path: <netdev+bounces-185992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0145FA9CA1E
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 15:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F63B4A71BF
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 13:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505C025178A;
	Fri, 25 Apr 2025 13:22:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9357C24A074;
	Fri, 25 Apr 2025 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745587377; cv=none; b=UlZL25hRWVWp/YAgvXNVR3bQ3TK0f6crlmZ7KWBpX0gSfV0U6+0RzkfAGc8wCpT4QCws4hqUxOHMcWCN6/g+DW5mGfUzUdocAF2W/BTRimljNwGBCBC9cbRjJ+fwskOCWCVRG/0K2fQBxFPSYvpp16r2YRkCxYAFuTJ3Laqrg6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745587377; c=relaxed/simple;
	bh=+UEqAdABQcBUW46BHo9XWuA/Hw8eE1ZJ7U7m5IB8G9A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bAivs6qLWlREBVngCA2t3sZHpeZmvB/w4ofSoe/Xc6SwqWJLLU2vCqpTUyPxFPaVp9R94TdJbOe52uoi+3aCxKtsP9UC8rte5Y+A5TobJ5t9t5L/UKeSkWDIINRVjISvAQz7Yar/RABlPhvUAibacj/QhiYmHWd2BFS4Itzogx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82A88106F;
	Fri, 25 Apr 2025 06:22:49 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67B103F59E;
	Fri, 25 Apr 2025 06:22:52 -0700 (PDT)
Date: Fri, 25 Apr 2025 14:22:50 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>, Yixun Lan
 <dlan@gentoo.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, Samuel Holland <samuel@sholland.org>, Maxime Ripard
 <mripard@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, clabbe.montjoie@gmail.com
Subject: Re: [PATCH 4/5] arm64: dts: allwinner: a527: add EMAC0 to Radxa A5E
 board
Message-ID: <20250425142250.006a029d@donnerap.manchester.arm.com>
In-Reply-To: <3681181a-0fbb-4979-9a7e-b8fe5c1b7c3c@lunn.ch>
References: <20250423-01-sun55i-emac0-v1-0-46ee4c855e0a@gentoo.org>
	<4ba3e7b8-e680-40fa-b159-5146a16a9415@lunn.ch>
	<20250424150037.0f09a867@donnerap.manchester.arm.com>
	<4643958.LvFx2qVVIh@jernej-laptop>
	<20250424235658.0c662e67@minigeek.lan>
	<3681181a-0fbb-4979-9a7e-b8fe5c1b7c3c@lunn.ch>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 04:01:30 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > Ah, right, I dimly remembered there was some hardware setting, but your
> > mentioning of those strap resistors now tickled my memory!
> > 
> > So according to the Radxa board schematic, RGMII0-RXD0/RXDLY is pulled
> > up to VCCIO via 4.7K, while RGMII0-RXD1/TXDLY is pulled to GND (also via
> > 4K7). According to the Motorcom YT8531 datasheet this means that RX
> > delay is enabled, but TX delay is not.
> > The Avaota board uses the same setup, albeit with an RTL8211F-CG PHY,
> > but its datasheet confirms it uses the same logic.
> > 
> > So does this mean we should say rgmii-rxid, so that the MAC adds the TX
> > delay? Does the stmmac driver actually support this? I couldn't find
> > this part by quickly checking the code.  
> 
> No. It is what the PCB provides which matters. A very small number of
> PCB have extra long clock lines to add the 2ns delay. Those boards
> should use 'rgmii'. All other boards should use rgmii-id, meaning the
> delays need to be provided somewhere else. Typically it is the PHY
> which adds the delays.
> 
> The strapping should not matter, the PHY driver will override that. So
> 'rgmii-id' should result in the PHY doing the basis 2ns in both
> directions. The MAC DT properties then add additional delays, which i
> consider fine tuning. Most systems don't actually need fine tuning,
> but the YT8531 is funky, it often does need it for some reason.

Ah, many thanks for the explanation, that clears that up! I read something
about the MAC adding delays, which confused me, but what you say now makes
sense.

Thanks!
Andre.

