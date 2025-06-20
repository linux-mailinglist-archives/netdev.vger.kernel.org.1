Return-Path: <netdev+bounces-199843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA528AE2023
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 18:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6071BC68AF
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 16:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B772E6106;
	Fri, 20 Jun 2025 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xBvbzMTi"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483C7482F2
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750437238; cv=none; b=Kw1OA+qQW1vWAcoPvOf6gA1k42KtPKZ3QSwg9HDE1sGmTJQ+tIz6F8SZiGqbH6bBrak8633vs4AX13h+oqV+//fo3nNVSUNQ0mKSoUDktvCYvIuhI04gYYFqObO9zQ/mnEtUTCmM1+IuMzamKR8qbnxNEFE27lBKlpxN+57W5HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750437238; c=relaxed/simple;
	bh=JXaGcp9pqsSbF9NRuSGal740IHNaqsO8ZHpcR3fj1vM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rBvw11fC4Z1Yn5LuyQXAZ+Plg0lBarsAVVJyOemowVV08mfhrV5jcWG2rRH6v/EnpN7J5FznNx0jUqgjGSpk8I2m++0JminS2hZqBmuLvjIfRNYn2n+aSPrlxeAhNwvhjTdbks3l62/rg75v3l+aTDgw5IYHiPhGL3P4qEsIESw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xBvbzMTi; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2abb8b06-960d-44d3-b2f1-b6d91f424a1b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750437233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XDnBVy0j4uCja073Cag+NZ+VuabbaY7i2eVJN3A6bdc=;
	b=xBvbzMTiiUh7ca29hegpZHXllXXE69lmTMxhvNKMpV77ymE7qvKufgg+3oHikqSy7X6Hp+
	h5gjRk9/eLpWIFN2f+GLHibm2yRLlUi1IyLJO+enBaGp0eUPczQP9yxyQ8U7C9riUHeDS3
	GG+Z4+Soc/nhStNZc7eFLa/Qwiz3OVE=
Date: Fri, 20 Jun 2025 12:33:48 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 1/4] auxiliary: Allow empty id
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
 Saravana Kannan <saravanak@google.com>, Leon Romanovsky <leon@kernel.org>,
 Dave Ertman <david.m.ertman@intel.com>, linux-kernel@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>, linux-arm-kernel@lists.infradead.org,
 Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
References: <20250619200537.260017-1-sean.anderson@linux.dev>
 <20250619200537.260017-2-sean.anderson@linux.dev>
 <2025062004-essay-pecan-d5be@gregkh>
 <8b9662ab-580c-44ea-96ee-b3fe3d4672ff@linux.dev>
 <2025062006-detergent-spruce-5ae2@gregkh>
 <91a9e80a-1a45-470b-90cf-12faae67debd@linux.dev>
 <2025062045-velocity-finite-f31c@gregkh>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <2025062045-velocity-finite-f31c@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/20/25 12:15, Greg Kroah-Hartman wrote:
> On Fri, Jun 20, 2025 at 12:09:29PM -0400, Sean Anderson wrote:
>> On 6/20/25 12:02, Greg Kroah-Hartman wrote:
>> > On Fri, Jun 20, 2025 at 11:37:40AM -0400, Sean Anderson wrote:
>> >> On 6/20/25 01:13, Greg Kroah-Hartman wrote:
>> >> > On Thu, Jun 19, 2025 at 04:05:34PM -0400, Sean Anderson wrote:
>> >> >> Support creating auxiliary devices with the id included as part of the
>> >> >> name. This allows for non-decimal ids, which may be more appropriate for
>> >> >> auxiliary devices created as children of memory-mapped devices. For
>> >> >> example, a name like "xilinx_emac.mac.802c0000" could be achieved by
>> >> >> setting .name to "mac.802c0000" and .id to AUXILIARY_DEVID_NONE.
>> >> > 
>> >> > I don't see the justification for this, sorry.  An id is just an id, it
>> >> > doesn't matter what is is and nothing should be relying on it to be the
>> >> > same across reboots or anywhere else.  The only requirement is that it
>> >> > be unique at this point in time in the system.
>> >> 
>> >> It identifies the device in log messages. Without this you have to read
>> >> sysfs to determine what device is (for example) producing an error.
>> > 
>> > That's fine, read sysfs :)
>> 
>> I should not have to read sysfs to decode boot output. If there is an
>> error during boot I should be able to determine the offending device.
>> This very important when the boot process fails before init is started,
>> and very convenient otherwise. 
> 
> The boot log will show you the name of the device that is having a
> problem.  And you get to pick a portion of that name to make it make
> some kind of sense to users if you want.

As noted below, I can't! The name has to be in a very particular format
which does not allow for any differentiation *except* in the "id" portion.
Really the only thing I want to do is print the id in hexadecimal rather
than decimal.

>> >> This
>> >> may be inconvenient to do if the error prevents the system from booting.
>> >> This series converts a platform device with a legible ID like
>> >> "802c0000.ethernet" to an auxiliary device, and I believe descriptive
>> >> device names produce a better developer experience.
>> > 
>> > You can still have 802c0000.ethernet be the prefix of the name, that's
>> > fine.
>> 
>> This is not possible due to how the auxiliary bus works. If device's
>> name is in the form "foo.id", then the driver must have an
>> auxiliary_device_id in its id_table with .name = "foo". So the address
>> *must* come after the last period in the name.
> 
> So what is the new name without this aux patch that looks so wrong?
> What is the current log line before and after the change you made?

Well, without this patch if you have multiple devices the subsequent
ones can't be created because they all have id 0 and this conflicts in sysfs.

With this patch it looks something like

[    4.781268] xilinx_axienet 80200000.ethernet: autodetected 64-bit DMA range
[   21.889563] xilinx_emac.mac xilinx_emac.mac.80200000 net4: renamed from eth0
[   32.296965] xilinx_emac.mac xilinx_emac.mac.80200000 net4: PHY [axienet-80200000:05] driver [RTL8211F Gigabit Ethernet] (irq=70)
[   32.313456] xilinx_emac.mac xilinx_emac.mac.80200000 net4: configuring for inband/sgmii link mode
[   65.095419] xilinx_emac.mac xilinx_emac.mac.80200000 net4: Link is Up - 1Gbps/Full - flow control rx/tx

I also prototyped a version of PLATFORM_DEVID_AUTO which looks roughly
like:

[    5.424220] xilinx_axienet 80240000.ethernet: autodetected 64-bit DMA range
[  178.249494] xilinx_emac.mac xilinx_emac.mac.1-auto net4: renamed from eth0
[  178.714048] xilinx_emac.mac xilinx_emac.mac.1-auto net4: PHY [axienet-80200000:05] driver [RTL8211F Gigabit Ethernet] (irq=70)
[  178.731272] xilinx_emac.mac xilinx_emac.mac.1-auto net4: configuring for inband/sgmii link mode
[  182.818831] xilinx_emac.mac xilinx_emac.mac.1-auto net4: Link is Up - 1Gbps/Full - flow control rx/tx

The only identifying part of the name is the "net4" part of the netdev.
However, if there's a failure before creating the netdev then userspace
will never have a chance to rename it. For example, you might get

[    4.947215] xilinx_emac.mac xilinx_emac.mac.1-auto (unnamed net_device) (uninitialized): incorrect link mode  for in-band status

which leaves you with no clue as to what device went wrong.

--Sean

