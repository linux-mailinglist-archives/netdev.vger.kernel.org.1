Return-Path: <netdev+bounces-207938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61872B0914B
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 18:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0C5E16DC2F
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 16:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3051F8725;
	Thu, 17 Jul 2025 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GKhYxmFr"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BD835963
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752768269; cv=none; b=HDVUnlmeXaGq4soMiBZIomTn8JSPV4tZOwkit9Qj1DewT3KGied6H7ldDMuskKRsWvCDw2DBuz0x8N87EAur/FNP+YkTmTN3VCmOiKtZ/XOA/pwWp1/1H0B6iPnGz4SshUqh9UhDkRYSd/JlyuEIqdV8tHS8OHvNJ3mJHjWSEg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752768269; c=relaxed/simple;
	bh=mDWGVprR2+VsVVoENcQ7OT/z+qDLlGIt3Dkp0PqQJyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZrcLuqZN+9xyyOn8QjqBhSpavUOADfd/EresA6Yzah80zq9DooUaISrbxT7eiaLOyBHCUa32tKYh6qwkMrGRzgDeG/UOac9mLx0SOmuDTKQyP2i2lTNaj8sFN3izYcyshPCCOCoQ5kBGBaCzCyaEkOdwlxytRjZuQpGmjYHbToA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GKhYxmFr; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5d8205e1-b384-446b-822a-b5737ea7bd6c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752768260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8bzKSGrhyOoLt0Kx60uLjktSA1PTjmxFM+e27mk4UbU=;
	b=GKhYxmFruq5OeEbVxVgjGE0ISMtNy3g1vP6GEHXIPucWPjMz/zHVYN176TP4e0y7r5Z3fu
	yo0lI5uISo1gkGUU/b4/4eibmyPnZ2HLVysU3xkXKBMbdHbjvKM09gL+SMNQ7LT72cU547
	414aq6tz4PRX4sxbPrdtoGKP+pPVVfM=
Date: Thu, 17 Jul 2025 12:04:15 -0400
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <2025071747-icing-issuing-b62a@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/17/25 11:59, Greg Kroah-Hartman wrote:
> On Thu, Jul 17, 2025 at 11:49:37AM -0400, Sean Anderson wrote:
>> On 7/16/25 01:09, Greg Kroah-Hartman wrote:
>> > On Tue, Jul 15, 2025 at 08:01:07PM -0400, Sean Anderson wrote:
>> >> Support creating auxiliary devices with the id included as part of the
>> >> name. This allows for hexadecimal ids, which may be more appropriate for
>> >> auxiliary devices created as children of memory-mapped devices. If an
>> >> auxiliary device's id is set to AUXILIARY_DEVID_NONE, the name must
>> >> be of the form "name.id".
>> >> 
>> >> With this patch, dmesg logs from an auxiliary device might look something
>> >> like
>> >> 
>> >> [    4.781268] xilinx_axienet 80200000.ethernet: autodetected 64-bit DMA range
>> >> [   21.889563] xilinx_emac.mac xilinx_emac.mac.80200000 net4: renamed from eth0
>> >> [   32.296965] xilinx_emac.mac xilinx_emac.mac.80200000 net4: PHY [axienet-80200000:05] driver [RTL8211F Gigabit Ethernet] (irq=70)
>> >> [   32.313456] xilinx_emac.mac xilinx_emac.mac.80200000 net4: configuring for inband/sgmii link mode
>> >> [   65.095419] xilinx_emac.mac xilinx_emac.mac.80200000 net4: Link is Up - 1Gbps/Full - flow control rx/tx
>> >> 
>> >> this is especially useful when compared to what might happen if there is
>> >> an error before userspace has the chance to assign a name to the netdev:
>> >> 
>> >> [    4.947215] xilinx_emac.mac xilinx_emac.mac.1 (unnamed net_device) (uninitialized): incorrect link mode  for in-band status
>> >> 
>> >> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> >> ---
>> >> 
>> >> Changes in v2:
>> >> - Add example log output to commit message
>> > 
>> > I rejected v1, why is this being sent again?
>> 
>> You asked for explanation, I provided it. I specifically pointed out why
>> I wanted to do things this way. But I got no response. So here in v2.
> 
> Again, I said, "do not do that, this is not how ids work in the driver
> model", and you tried to show lots of reasons why you wanted to do it
> this way despite me saying so.
> 
> So again, no, sorry, this isn't ok.  Don't attempt to encode information
> in a device id like you are trying to do here, that's not what a device
> id is for at all.  I need to go dig up my old patch that made all device
> ids random numbers just to see what foolish assumptions busses and
> userspace tools are making....

But it *is* how ids work in platform devices. And because my auxiliary
devices are created by a platform device, it is guaranteed that the
platform device id is unique and that it will also be unique for
auxiliary devices. So there is no assumption here about the uniqueness
of any given id.

--Sean

