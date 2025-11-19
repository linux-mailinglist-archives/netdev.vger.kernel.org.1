Return-Path: <netdev+bounces-239843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 678B1C6CFFD
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 07:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 37BA82CD33
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 06:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E6F31197B;
	Wed, 19 Nov 2025 06:57:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCD131064B
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 06:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763535474; cv=none; b=hfMApW9YnDfz+/O+9ycRatkg0GZEEZUzyuGRFs6quUV3aUinu0GpEjpY4xczp5U0bf6wc7DfLJI1IHqN31AkaMXBUFXvlvZAyk3600NhOKlEnqniBUyluFPbXX96mQuvQv2n+rWXv8Nr31Ze3OumL4DaqixEGE+dLxkS82OwtgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763535474; c=relaxed/simple;
	bh=MTOcW0nrr12Em1mQ9ac2k8VtVYqOC7OCYUJEDT/tbUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0wNeYyX6or1hWTu8Feq+sHOgR1QnprKK0EsbzaTJyPgo/tqBrjWu0+ktOGWK7XVvA+8dVEE3OW6qdAbY37+XdCq8b6iBkTETNHcvgunNNvPhzA9ddMeyiE86ubYzdXd4D9F3P/ENZIDSYu4i7xLpXuXdRTiwhOSfcm6LIxGqsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=[192.168.1.226])
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_128_GCM_SHA256:128)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1vLc8N-0000xD-H9; Wed, 19 Nov 2025 06:57:43 +0000
Message-ID: <83128442-9e77-482a-ba8f-08883c3f3269@trager.us>
Date: Tue, 18 Nov 2025 22:57:36 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ethtool: advance phy debug support
To: Andrew Lunn <andrew@lunn.ch>, Alexander Duyck <alexander.duyck@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Susheela Doddagoudar <susheelavin@gmail.com>, netdev@vger.kernel.org,
 mkubecek@suse.cz, Hariprasad Kelam <hkelam@marvell.com>,
 Alexander Duyck <alexanderduyck@fb.com>
References: <CAOdo=cNAy4kTrJ7KxEf2CQ_kiuR5sMD6jG3mJSFeSwqD6RdUtw@mail.gmail.com>
 <843c25c6-dd49-4710-b449-b03303c7cf45@bootlin.com>
 <eca707a6-7161-4efc-9831-69fbfa56eb93@lunn.ch>
 <52e1917a-2030-4019-bb9f-a836dc47bda9@trager.us>
 <401e9d39-2c28-480e-b1c4-d3601131c1fb@lunn.ch>
 <399ca61a-abf0-4b37-af32-018a9ef08312@trager.us>
 <2fcc7d12-b1cf-4a24-ac39-a3257e407ef7@lunn.ch>
 <4b7f0ce90f17bd0168cbf3192a18b48cdabfa14b.camel@gmail.com>
 <e38b51f0-b403-42b0-a8e5-8069755683f6@lunn.ch>
 <CAKgT0UcVs9SwiGjmXQcLVX7pSRwoQ2ZaWorXOc7Tm_FFi80pJA@mail.gmail.com>
 <174e07b4-68cc-4fbc-8350-a429f3f4e40f@lunn.ch>
Content-Language: en-US
From: Lee Trager <lee@trager.us>
In-Reply-To: <174e07b4-68cc-4fbc-8350-a429f3f4e40f@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/18/25 9:29 AM, Andrew Lunn wrote:

>> Right. With PRBS you already should know what the link partner is
>> configured for. It is usually a manual process on both sides. That is
>> why I mentioned the cable/module EEPROM. The cable will indicate the
>> number of lanes present and the recommended/maximum frequency and
>> modulation it is supposed to be used at.
> But i also expect that is standard ksetting_set behaviour. If user
> space asks you do a specific link mode, you are going to check if it
> is supported and return -EINVAL if it is not. So in the general case,
> all this already exists. I call
>
> ethtool -s eth42 autoneg off 20000baseCR2
>
> and it should check if it is supported, and then configure the MAC,
> PCS and anything else in the path for that link mode. Or return
> -EINVAL if it is not supported.
>
> [I forget the exact ethtool syntax, its not something i use very
> often, to set a specific link mode]

Yes and no. PRBS is a signal integrity test primary used to verify TX 
coefficients with a link partner. There is no way to know what the link 
partner supports when testing. Setup is a manual process and it is 
expected the user will configure both ends correctly. Setup is typically 
mapped to various ethernet settings as that is our goal.

Strictly speaking settings don't have to be mapped to ethernet 
configurations, at least not in our IP. I could use a 3 lane setup 
alternating between NRZ and PAM4 each with different TX coefficients 
despite this not making any sense. This is where the argument comes in 
that PRBS testing and TX coefficients don't belong in ethtool. The 
argument for putting everything in phy is to create a generic interface 
that works for all phys, not just ethernet. That would give us something 
like

phy 00:01.0 lane 0 nrz-tx-coefficent 0 1 8 55 0

phy 00:01.0 lane 1 pam4-tx-cofficent 0 1 9 54 0

phy 00:01.0 lane 2 nrz-tx-officent 0 1 7 45 0

phy 00:01.0 lane 0 start-prbs prbs31

phy 00:01.0 lane 1 start-prbs prbs7

phy 00:01.0 lane 2 start-prbs prbs8

phy 00:01.0 lane 0 get-prbs-stats

...

I don't think there is much value in that which is why I like creating 
an ethernet specific version. It makes a cleaner user interface which 
require less technical details from the user. I like piggy backing off 
of ethtool -s since users are custom to NIC speed, not lanes and mode. 
That would give us something like

ethtool -s eth42 100000baseCR2  - Test fbnic in PAM4 with 2 lanes

ethtool --set-phy-tunable eth42 tx-coefficent 0 1 8 55 0 - Sets the 
tx-coefficent for PAM4, this way users doesn't have to know the mapping 
between mode and speed

ethtool --start-prbs eth42 prbs31 - Start the PRBS31 test

ethtool --get-prbs-stats eth42 - Dump stats collected while testing

ethtool --stop-prbs eth42 - Stop testing

I think that is pretty straight forward for users and allows developers 
to map to whatever backend API they need. I get the argument for a phy 
specific interface but it really complicates things for the user.

>
>> With that you can essentially
>> determine what the correct setup would be to test it as this is mostly
>> just a long duration cable test. The only imitation is if there is
>> something in between such as a PMA/PMD that is configured for 2 lanes
>> instead of 4.
> And the CR2 indicates you want to use 2 lanes. And you would then run
> RPBS on both of them. We could consider additional properties on the
> netlink API to run PRBS on a subset. But would you not actually want
> them all active to see if there is cross talk noise to deal with?
>
>> Yes. Again most of these settings appear to be per-lane in both the IP
>> we have and the IEEE specification. For example it occurs to me that a
>> device could be running a 25G or 50G link over a single QSFP cable,
>> and still have testing enabled for the unused 2 or 3 lanes on the
>> cable potentially assuming the PMA/PMD is a 4 lane link and is only
>> using one or two lanes for the link.
> So that would be 25000baseCR and 50000baseCR2, for the 25G and 50G,
> using 1 lane and 2 lanes, leaving the other 3/2 lanes unused?
In our setup 2500baseCR and 50000baseCR use 1 lane, during testing the 
other lane is unused.
>
> 	Andrew

