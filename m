Return-Path: <netdev+bounces-207979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1821B092F6
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 19:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F39A464FD
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301051F872D;
	Thu, 17 Jul 2025 17:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ckjsxq98"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F82149C6F
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752772348; cv=none; b=X7UW4S9IecUWXwv4qTiMqfEJZ/pFPHagulBSb8RXZlNKtWaVuqGvtoJ6gu1lDbjbqxbapA8NJz8gc6p912Vl81sCcmXcmqhxvrJN3sQ0HAm53z8u/5qE/o/kIjAjQwxIcouscwtBZ8Hbj0kV3bF2gSucxNt5aV64T20IG40vJ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752772348; c=relaxed/simple;
	bh=sCE3tND/kAdfqxtUPKTFdyza9LdXuQv8mqJC9NtHFRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ogAT/uO2MrE0tZX4kNE/zjP+WL+9jnOL+m/n6SnIst1kvUsBKcrjRruPnxFxb3RwwJlxB66Jjv/ChHBb5Gkrrq5y5jPKUOzpwjX0cUKNGo7V4ugbpCxFTv3be6yFN0GzuFfWgmYADElp3I06xrwjwf9LbDpyVnrBHNdvSOKWGdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ckjsxq98; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5ee4bac4-957b-481a-8608-15886da458c2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752772333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+EluqO2moZ07z54L0ghbT5HaZt1N6sU75p1MHiMf6X4=;
	b=ckjsxq98tfEm25Th4zH5CRqje3rC68aGTOC/Bz9djpqcTCgTf7FWRD/UptBN0Z8iycl2fz
	Urr+zWCtba04bzEP+CB2lSUU7vfWCQcHB1Q4/Eo5D2a1CgSN2dm79DE3nsMuIvl/8Oxqg7
	GOayi3n/u+4ztkqeCj69hLCLZkwdNdg=
Date: Thu, 17 Jul 2025 13:12:08 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2 1/4] auxiliary: Support hexadecimal ids
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Dave Ertman <david.m.ertman@intel.com>,
 Saravana Kannan <saravanak@google.com>, Leon Romanovsky <leon@kernel.org>,
 linux-kernel@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
 linux-arm-kernel@lists.infradead.org, Ira Weiny <ira.weiny@intel.com>
References: <20250716000110.2267189-1-sean.anderson@linux.dev>
 <20250716000110.2267189-2-sean.anderson@linux.dev>
 <2025071637-doubling-subject-25de@gregkh>
 <719ff2ee-67e3-4df1-9cec-2d9587c681be@linux.dev>
 <2025071747-icing-issuing-b62a@gregkh>
 <5d8205e1-b384-446b-822a-b5737ea7bd6c@linux.dev>
 <2025071736-viscous-entertain-ff6c@gregkh>
 <03e04d98-e5eb-41c0-8407-23cccd578dbe@linux.dev>
 <2025071726-ramp-friend-a3e5@gregkh>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <2025071726-ramp-friend-a3e5@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/17/25 12:33, Greg Kroah-Hartman wrote:
> On Thu, Jul 17, 2025 at 12:27:44PM -0400, Sean Anderson wrote:
>> On 7/17/25 12:21, Greg Kroah-Hartman wrote:
>> > On Thu, Jul 17, 2025 at 12:04:15PM -0400, Sean Anderson wrote:
>> >> On 7/17/25 11:59, Greg Kroah-Hartman wrote:
>> >> > On Thu, Jul 17, 2025 at 11:49:37AM -0400, Sean Anderson wrote:
>> >> >> On 7/16/25 01:09, Greg Kroah-Hartman wrote:
>> >> >> > On Tue, Jul 15, 2025 at 08:01:07PM -0400, Sean Anderson wrote:
>> >> >> >> Support creating auxiliary devices with the id included as part of the
>> >> >> >> name. This allows for hexadecimal ids, which may be more appropriate for
>> >> >> >> auxiliary devices created as children of memory-mapped devices. If an
>> >> >> >> auxiliary device's id is set to AUXILIARY_DEVID_NONE, the name must
>> >> >> >> be of the form "name.id".
>> >> >> >> 
>> >> >> >> With this patch, dmesg logs from an auxiliary device might look something
>> >> >> >> like
>> >> >> >> 
>> >> >> >> [    4.781268] xilinx_axienet 80200000.ethernet: autodetected 64-bit DMA range
>> >> >> >> [   21.889563] xilinx_emac.mac xilinx_emac.mac.80200000 net4: renamed from eth0
>> >> >> >> [   32.296965] xilinx_emac.mac xilinx_emac.mac.80200000 net4: PHY [axienet-80200000:05] driver [RTL8211F Gigabit Ethernet] (irq=70)
>> >> >> >> [   32.313456] xilinx_emac.mac xilinx_emac.mac.80200000 net4: configuring for inband/sgmii link mode
>> >> >> >> [   65.095419] xilinx_emac.mac xilinx_emac.mac.80200000 net4: Link is Up - 1Gbps/Full - flow control rx/tx
>> >> >> >> 
>> >> >> >> this is especially useful when compared to what might happen if there is
>> >> >> >> an error before userspace has the chance to assign a name to the netdev:
>> >> >> >> 
>> >> >> >> [    4.947215] xilinx_emac.mac xilinx_emac.mac.1 (unnamed net_device) (uninitialized): incorrect link mode  for in-band status
>> >> >> >> 
>> >> >> >> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> >> >> >> ---
>> >> >> >> 
>> >> >> >> Changes in v2:
>> >> >> >> - Add example log output to commit message
>> >> >> > 
>> >> >> > I rejected v1, why is this being sent again?
>> >> >> 
>> >> >> You asked for explanation, I provided it. I specifically pointed out why
>> >> >> I wanted to do things this way. But I got no response. So here in v2.
>> >> > 
>> >> > Again, I said, "do not do that, this is not how ids work in the driver
>> >> > model", and you tried to show lots of reasons why you wanted to do it
>> >> > this way despite me saying so.
>> >> > 
>> >> > So again, no, sorry, this isn't ok.  Don't attempt to encode information
>> >> > in a device id like you are trying to do here, that's not what a device
>> >> > id is for at all.  I need to go dig up my old patch that made all device
>> >> > ids random numbers just to see what foolish assumptions busses and
>> >> > userspace tools are making....
>> >> 
>> >> But it *is* how ids work in platform devices.
>> > 
>> > No one should ever use platform devices/bus as an excuse to do anything,
>> > it's "wrong" in so many ways, but needs to be because of special
>> > reasons.  No other bus should work like that, sorry.
>> > 
>> >> And because my auxiliary
>> >> devices are created by a platform device, it is guaranteed that the
>> >> platform device id is unique and that it will also be unique for
>> >> auxiliary devices. So there is no assumption here about the uniqueness
>> >> of any given id.
>> > 
>> > Then perhaps use the faux device api instead?
>> 
>> There's *another* pseudo bus? OK the reason why is that faux was added
>> four months ago and there is nothing under Documentation for it. So I
>> had no idea it existed. I will have a look, but perhaps you should write
>> up some documentation about why someone might want to use a "faux" bus
>> over the auxiliary bus or MFD.
> 
> "faux" is for when platform devices were being abused because someone
> just wanted a device in the device tree, and did not use any of the
> platform device resources.

OK, well that's not this. These are real devices and there may be more
than one per system. Actually, that's the primary problem I wanted to
address with this patch: you can't create more than one device with
devm_auxiliary_device_create because they will have the same id (0).

Anyway, if you really think ids should be random or whatever, why not
just ida_alloc one in axiliary_device_init and ignore whatever's
provided? I'd say around half the auxiliary drivers just use 0 (or some
other constant), which is just as deterministic as using the device
address. Another third use ida_alloc (or xa_alloc) so all that could be
removed. And the remainder just use an address of some kind (which ends
up be formatted as decimal).

--Sean

