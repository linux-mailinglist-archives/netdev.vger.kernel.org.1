Return-Path: <netdev+bounces-204290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71C5AF9ED1
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 09:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 461AF5685D0
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 07:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257DB258CC0;
	Sat,  5 Jul 2025 07:37:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8FD20B1E8;
	Sat,  5 Jul 2025 07:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751701054; cv=none; b=lCmmX0XdCo8HFrWFw03hpGYsJ5g1JhjVyx/V7DnkztOC0m3An49KTEbp7qgUYZK3MO9q/Z+nRj3n2L8INI+nEQLplDHU+qIk3SRqV93tuXuhfeVo6DbyzXSr383g0gtyAZHsf8m5fznmu4WZWBbatdOnpW0QeEvcyF5x7hTTIdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751701054; c=relaxed/simple;
	bh=RSEN/2TWL3Q95UPQ30ZbVUKp/ioML++whRQBV7x0Oxg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CT+G4GeN0ndqbUeXn/6F/W3cLrX8PR+A/dq/k6NBZODVJ2lYEuP5QVxgGYezs/flg+UlUCNKaDYVq6/Ln/uq2nETh/uRaKlkKZ27XBq9DR4+M5wOpu4hWmphv8MHbG6/gE44Pz8hGxYOFRyTvaGZKiovjGdwJHbnVkiN6AhA+xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01A61153B;
	Sat,  5 Jul 2025 00:37:17 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 785EA3F6A8;
	Sat,  5 Jul 2025 00:37:28 -0700 (PDT)
Date: Sat, 5 Jul 2025 08:36:00 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH net 0/2] allwinner: a523: Rename emac0 to gmac0
Message-ID: <20250705083600.2916bf0c@minigeek.lan>
In-Reply-To: <20250628054438.2864220-1-wens@kernel.org>
References: <20250628054438.2864220-1-wens@kernel.org>
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

On Sat, 28 Jun 2025 13:44:36 +0800
Chen-Yu Tsai <wens@kernel.org> wrote:

Hi,

> From: Chen-Yu Tsai <wens@csie.org>
> 
> Hi folks,
> 
> This small series aims to align the name of the first ethernet
> controller found on the Allwinner A523 SoC family with the name
> found in the datasheets. It renames the compatible string and
> any other references from "emac0" to "gmac0".

To be honest I am not a big fan of those cosmetic renames when it
touches DT files. It seems to not break compatibility in this case,
since we don't use the specific compatible string, but leaves a bitter
taste anyway. Also I pick DT patches out of -rc releases for U-Boot,
and did so internally already, so it's not without churns.

So is this really necessary, and what is the purpose of this patch?
I am fine with using GMAC for the GMAC200 part in the SoC, but the A64,
H6, H616, A133 all use the same IP - as the fallback compatible proves -
and they call it all EMAC.

That's not a NAK, but just wanted to bring this up.

Cheers,
Andre. 

> When support of the hardware was introduced, the name chosen was
> "EMAC", which followed previous generations. However the datasheets
> use the name "GMAC" instead, likely because there is another "GMAC"
> based on a newer DWMAC IP.
> 
> The first patch fixes the compatible string entry in the device tree
> binding.
> 
> The second patch fixes all references in the existing device trees.
> 
> Since this was introduced in v6.16-rc1, I hope to land this for v6.16
> as well.
> 
> There's a small conflict in patch one around the patch context with 
> 
>     dt-bindings: net: sun8i-emac: Add A100 EMAC compatible
> 
> that just landed in net-next today. I will leave this patch to the net
> mainainers to merge to avoid making a bigger mess. Once that is landed
> I will merge the second patch through the sunxi tree.
> 
> 
> Thanks
> ChenYu
> 
> 
> Chen-Yu Tsai (2):
>   dt-bindings: net: sun8i-emac: Rename A523 EMAC0 to GMAC0
>   arm64: dts: allwinner: a523: Rename emac0 to gmac0
> 
>  .../devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml  | 2 +-
>  arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi              | 6 +++---
>  arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts     | 4 ++--
>  arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts     | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 


