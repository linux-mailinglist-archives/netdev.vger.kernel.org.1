Return-Path: <netdev+bounces-146301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EE39D2BD8
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 17:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21A1FB2D033
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 16:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251EC1D1305;
	Tue, 19 Nov 2024 16:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vCBFAFK9"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F012C1CCECE;
	Tue, 19 Nov 2024 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034548; cv=none; b=JzDOVaUYTC3vQHCoS11cNSpEn3sDei0ZZJ+C8cOAEJhrnd1hvgX8XuRX0TuiEO28yWhpfsMCdgdeqpMtlkH06KbPRGWh3J3YSlaAmkfHd20YJBRO02iBOiAkS1XoYYmg65/eoosfHt4Z4mHsyB4trI20S9Q3/YIVUJAm+FWpCpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034548; c=relaxed/simple;
	bh=dyK6iQY4mG9VcCDxZWnkVliPw/bcSwDsWwuf4vJ6BnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YEhQluCi3xvbxqjYCrZXy11HOdpA9NYC4j+RRMX81s98vKlIW5OI8KBrU764YWMPWpc572BxbFMxOPjhdQOH1Cy0s8FmqbdoI8vQxIN8L0c3NkZquVowOHZ+G9G0qsU7dayN7KNGDgcWU7wOrwr3Uczr5FqdDxasbEyRUYB1mi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vCBFAFK9; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6d2cdd37-f2d7-4537-a7e7-8e525c4378dd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732034541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7l0JgKEgxnC8jk86kuocY0fjlpXe94Bsa3OSgU7iB+E=;
	b=vCBFAFK9N11a8pykhD5s/Z3QIsimgWs+/LGk8r7ZPpr+OSIAmH4uK3sEuADOXoE5VWI2th
	4ZCb11WmXmg39Cr5sJg+Zk+uFyBb4Rjop9ilizf5KbFtiyVZg/SFq6m0m7P1k2t5kWHdgQ
	4vpM1ofFiZOYdzTR3Ftm2pPdKS/7VrE=
Date: Tue, 19 Nov 2024 11:42:15 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/2] net: axienet: Add support for AXI 2.5G MAC
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Suraj Gupta <suraj.gupta2@amd.com>,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
 radhey.shyam.pandey@amd.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 git@amd.com, harini.katakam@amd.com
References: <20241118081822.19383-1-suraj.gupta2@amd.com>
 <20241118081822.19383-3-suraj.gupta2@amd.com>
 <ZztjvkxbCiLER-PJ@shell.armlinux.org.uk>
 <657764fd-68a1-4826-b832-3bda91a0c13b@linux.dev>
 <9d26a588-d9ac-43c5-bedc-22cb1f0923dd@lunn.ch>
 <72ded972-cd16-4124-84af-8d8ddad049f0@linux.dev>
 <ZzyzhCVBgXtQ_Aop@shell.armlinux.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <ZzyzhCVBgXtQ_Aop@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/19/24 10:49, Russell King (Oracle) wrote:
> On Tue, Nov 19, 2024 at 10:26:52AM -0500, Sean Anderson wrote:
>> On 11/18/24 20:35, Andrew Lunn wrote:
>> > On Mon, Nov 18, 2024 at 11:00:22AM -0500, Sean Anderson wrote:
>> >> On 11/18/24 10:56, Russell King (Oracle) wrote:
>> >> > On Mon, Nov 18, 2024 at 01:48:22PM +0530, Suraj Gupta wrote:
>> >> >> Add AXI 2.5G MAC support, which is an incremental speed upgrade
>> >> >> of AXI 1G MAC and supports 2.5G speed only. "max-speed" DT property
>> >> >> is used in driver to distinguish 1G and 2.5G MACs of AXI 1G/2.5G IP.
>> >> >> If max-speed property is missing, 1G is assumed to support backward
>> >> >> compatibility.
>> >> >> 
>> >> >> Co-developed-by: Harini Katakam <harini.katakam@amd.com>
>> >> >> Signed-off-by: Harini Katakam <harini.katakam@amd.com>
>> >> >> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
>> >> >> ---
>> >> > 
>> >> > ...
>> >> > 
>> >> >> -	lp->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
>> >> >> -		MAC_10FD | MAC_100FD | MAC_1000FD;
>> >> >> +	lp->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
>> >> >> +
>> >> >> +	/* Set MAC capabilities based on MAC type */
>> >> >> +	if (lp->max_speed == SPEED_1000)
>> >> >> +		lp->phylink_config.mac_capabilities |= MAC_10FD | MAC_100FD | MAC_1000FD;
>> >> >> +	else
>> >> >> +		lp->phylink_config.mac_capabilities |= MAC_2500FD;
>> >> > 
>> >> > The MAC can only operate at (10M, 100M, 1G) _or_ 2.5G ?
>> >> 
>> >> It's a PCS limitation. It either does (1000Base-X and/or SGMII) OR
>> >> (2500Base-X). The MAC itself doesn't have this limitation AFAIK.
>> > 
>> > 
>> > And can the PCS change between these modes? It is pretty typical to
>> > use SGMII for 10/100/1G and then swap to 2500BaseX for 2.5G.
>> 
>> Not AFAIK. There's only a bit for switching between 1000Base-X and
>> SGMII. 2500Base-X is selected at synthesis time, and AIUI the serdes
>> settings are different.
> 
> Okay. First it was a PCS limitation. Then it was a MAC limitation. Now
> it's a synthesis limitation.
> 
> I'm coming to the conclusion that those I'm communicating with don't
> actually know, and are just throwing random thoughts out there.
> 
> Please do the research, and come back to me with a real and complete
> answer, not some hand-wavey "it's a limitation of X, no it's a
> limitation of Y, no it's a limitation of Z" which looks like no one
> really knows the correct answer.
> 
> Just because the PCS doesn't have a bit that selects 2500base-X is
> meaningless. 2500base-X is generally implemented by upclocking
> 1000base-X by 2.5x. Marvell does this at their Serdes, there is
> no configuration at the MAC/PCS for 2.5G speeds.
> 
> The same is true of 10GBASE-R vs 5GBASE-R in Marvell - 5GBASE-R is
> just the serdes clocking the MAC/PCS at half the rate that 10GBASE-R
> would run at.
> 
> I suspect this Xilinx hardware is just the same - clock the transmit
> path it at 62.5MHz, and you get 1G speeds. Clock it at 156.25MHz,
> and you get 2.5G speeds.

Hey, I'm just a l^Huser.

In the synthesis settings for the PCS, you can select

  - 1G
    - 1000BASEX
    - SGMII
    - BOTH
  - 2 5G
    - 2500 BASEX
    - 2.5G SGMII

(all of the above being exclusive choices)

In the synthesis settings for the MAC, you can select

  - 1 Gbps
    - Tri speed
    - 1000 Mbps
  - 2.5 Gbps
    - 2500 Mbps

(ditto)

I can't comment on what happens when you over/underclock the MAC or PCS.

--Sean

