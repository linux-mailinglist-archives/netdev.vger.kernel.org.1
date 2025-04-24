Return-Path: <netdev+bounces-185544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 216DBA9ADBB
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 14:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A382C3A5A29
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 12:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0D625DD08;
	Thu, 24 Apr 2025 12:41:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF872143C69;
	Thu, 24 Apr 2025 12:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498471; cv=none; b=koW69w6BpGf/wB0s7p3lw+b4sXpWoVYA0+EbnW2EdUcaD2jz2IDevvZLYm+CljHvy1UahSgrFKe1DJPEgXVl2EMsifTmcyVr45BVqLsuapML/Lb7sm5tnpHjSrp0EQsBT1aSuSt2GPKM58OjA/EcVZdRESqdbsIln4DrdQvF/hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498471; c=relaxed/simple;
	bh=3vzDDu7OwP6S6+fBr+nhlCKhneY3lwT02jKazU0DDI8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=buL3pkm1l2oHhgf5WzxOkI9C6S8kW6j1r/GStkCEFOXdCAb2K3bZ7+CH4oBY4QPu+C+DrGFcqOFs1LWOWQO7rcdiz/M3xxDkJck7gLl6jR7iC250JeI/eOjq/cPYcs4zC4M9HXUPGruhZIEoGMcN+UWQrozfEezGtUv+KNdzIlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 569A51063;
	Thu, 24 Apr 2025 05:41:04 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F21163F59E;
	Thu, 24 Apr 2025 05:41:06 -0700 (PDT)
Date: Thu, 24 Apr 2025 13:41:04 +0100
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
Message-ID: <20250424134104.18031a70@donnerap.manchester.arm.com>
In-Reply-To: <835b58a3-82a0-489e-a80f-dcbdb70f6f8d@lunn.ch>
References: <20250423-01-sun55i-emac0-v1-0-46ee4c855e0a@gentoo.org>
	<20250423-01-sun55i-emac0-v1-4-46ee4c855e0a@gentoo.org>
	<aa38baed-f528-4650-9e06-e7a76c25ec89@lunn.ch>
	<20250424014120.0d66bd85@minigeek.lan>
	<835b58a3-82a0-489e-a80f-dcbdb70f6f8d@lunn.ch>
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

On Thu, 24 Apr 2025 14:16:16 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Thu, Apr 24, 2025 at 01:42:41AM +0100, Andre Przywara wrote:
> > On Wed, 23 Apr 2025 18:58:37 +0200
> > Andrew Lunn <andrew@lunn.ch> wrote:
> > 
> > Hi,
> >   
> > > > +&emac0 {
> > > > +	phy-mode = "rgmii";    
> > > 
> > > Does the PCB have extra long clock lines in order to provide the
> > > needed 2ns delay? I guess not, so this should be rgmii-id.  
> > 
> > That's a good point, and it probably true.
> >   
> > >   
> > > > +	phy-handle = <&ext_rgmii_phy>;
> > > > +
> > > > +	allwinner,tx-delay-ps = <300>;
> > > > +	allwinner,rx-delay-ps = <400>;    
> > > 
> > > These are rather low delays, since the standard requires 2ns. Anyway,
> > > once you change phy-mode, you probably don't need these.  
> > 
> > Those go on top of the main 2ns delay  
> 
> Which 2ns delay? "rgmii" means don't add 2ns delay, the PCB is doing
> it. So if there is a 2ns delay, something is broken by not respecting
> "rgmii".
> 
> > I just tried, it also works with some variations of those values, but
> > setting tx-delay to 0 stops communication.  
> 
> Just to be clear, you tried it with "rgmii-id" and the same <300> and
> <400> values?

Yes, sorry, I wasn't clear: I used rgmii-id, then experimented with those
values. I briefly tried "rgmii", and I couldn't get a lease, so I quite
confident it's rgmii-id, as you said. The vendor DTs just use "rgmii", but
they might hack the delay up another way (and I cannot be asked to look at
that awful code).

Cheers,
Andre

