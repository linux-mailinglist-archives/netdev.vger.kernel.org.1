Return-Path: <netdev+bounces-207931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7DEB090E6
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B244E18872C1
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 15:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59922F8C5B;
	Thu, 17 Jul 2025 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Oh9dEpt4"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DD8235C17
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767386; cv=none; b=fDge5D7mBF5/V5y5rEq5xuUpTbdCnzifHzcp8lGAVcpJvOmbHlnOcgxWqyjFybWi3XF6R5mz2DRpeGSSw6YqCYCRryyJ1EBtfTNwxzKsThW8ZoEyO4LH0rnOfDnkds8A8jLVsRYcvLlKjoXwXiR0mZXXl9LtK/Bjmp99kscQ3Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767386; c=relaxed/simple;
	bh=C20JjM0DSmFKiIBJjms9zXcql+GzYz19o6a4s2BiCp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UcgE+s50YBvzsuomDjWZJBZYre998bYFx61601pQMElKbWVLpluREnxx5r4fPklFVvkbrfmgdRXFWJATdxhYmaeidDMLcXX9AUVdZsbEu8Fb3QrCZQ8S8LLK4HmL7VFwFrv1cxAxSZPjOGKN8VFbkc3/BLCfs7ae8tVGq0Jeay4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Oh9dEpt4; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <719ff2ee-67e3-4df1-9cec-2d9587c681be@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752767381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QmyBVnSCWNBRTlsOdXKz3RmNsU7CI1q0RXFAMQ9Wydk=;
	b=Oh9dEpt4NBGGciIxe5lj+3Tk12hdtngpQ6Jtc+Bcf+EDW8yCs7dzUVajfES84GLOqKw5FF
	fgPuR4LeyCRiw05DsiitphI4I3JVmDtHb4P5MgMiABARyGo72S41ON6JfWhUN6Pf4LaCcB
	wy4FEebRmiEdiUUuSluf6q0rD0CvJ6I=
Date: Thu, 17 Jul 2025 11:49:37 -0400
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <2025071637-doubling-subject-25de@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/16/25 01:09, Greg Kroah-Hartman wrote:
> On Tue, Jul 15, 2025 at 08:01:07PM -0400, Sean Anderson wrote:
>> Support creating auxiliary devices with the id included as part of the
>> name. This allows for hexadecimal ids, which may be more appropriate for
>> auxiliary devices created as children of memory-mapped devices. If an
>> auxiliary device's id is set to AUXILIARY_DEVID_NONE, the name must
>> be of the form "name.id".
>> 
>> With this patch, dmesg logs from an auxiliary device might look something
>> like
>> 
>> [    4.781268] xilinx_axienet 80200000.ethernet: autodetected 64-bit DMA range
>> [   21.889563] xilinx_emac.mac xilinx_emac.mac.80200000 net4: renamed from eth0
>> [   32.296965] xilinx_emac.mac xilinx_emac.mac.80200000 net4: PHY [axienet-80200000:05] driver [RTL8211F Gigabit Ethernet] (irq=70)
>> [   32.313456] xilinx_emac.mac xilinx_emac.mac.80200000 net4: configuring for inband/sgmii link mode
>> [   65.095419] xilinx_emac.mac xilinx_emac.mac.80200000 net4: Link is Up - 1Gbps/Full - flow control rx/tx
>> 
>> this is especially useful when compared to what might happen if there is
>> an error before userspace has the chance to assign a name to the netdev:
>> 
>> [    4.947215] xilinx_emac.mac xilinx_emac.mac.1 (unnamed net_device) (uninitialized): incorrect link mode  for in-band status
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>> 
>> Changes in v2:
>> - Add example log output to commit message
> 
> I rejected v1, why is this being sent again?

You asked for explanation, I provided it. I specifically pointed out why
I wanted to do things this way. But I got no response. So here in v2.

--Sean

