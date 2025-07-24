Return-Path: <netdev+bounces-209785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86897B10C3C
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 15:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26CB47A37E1
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 13:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663872D5418;
	Thu, 24 Jul 2025 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xDuFrqtb"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042782D8395
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365373; cv=none; b=qZxt/9eeTRQQXLLO5ru8FBJkF9FOuyXdxMPbwOm70ygOjzJ1iRhlHjvYClqATs6n2nP6TPSPzQS5A1Vn0tyK836yWoTrG5AmpnaefT7QM06sAjGi111QrnC+IDFgbiPIZqk5mHDB1sQ2JJNJ0UpkSvRavIRf9JIbmcO1LAghCUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365373; c=relaxed/simple;
	bh=9y7t1P4tvOdzFMOWceniFW8wFyn3duqWiK+tb2TQtTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qbfe7Cdtf90+Nr3hGag6gBJU+Wlk4tRHW88v9TNru4MfGXn9ZZ9gt1G2pGN23kTa66JOG82XJdMArabMwIkfdh0/uAZNpJy9kMXQuzRmjWOojAPhlrJ5IchPAyBYuVseuznb/t1l0HMW8XMJLPJiK5TwsgwiDup1tPtGVkovHo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xDuFrqtb; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <991cbb9a-a1b5-4ab8-9deb-9ecea203ce0f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753365364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=THb9OA/TiR1XzVuDY0Y6uYlj9r+f68Q+8bbXSQessY8=;
	b=xDuFrqtbleTFYgMfG/+dzmiNOf9WfMjEIQ+vyWpBK7H0ruFRSJm9fUTbxjbSvdfuMKPNup
	r1xVULgxavPiqQwoeGmwnAxOGIs91rie3H09SadgDcQYy9/1R/Wnlc/3Y3qQuo9RgbGV/3
	CY27SJIBzQmoYxre91whlvlQd+hSBpE=
Date: Thu, 24 Jul 2025 09:55:59 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2 1/4] auxiliary: Support hexadecimal ids
To: Leon Romanovsky <leon@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Dave Ertman <david.m.ertman@intel.com>,
 Saravana Kannan <saravanak@google.com>, linux-kernel@vger.kernel.org,
 Michal Simek <michal.simek@amd.com>, linux-arm-kernel@lists.infradead.org,
 Ira Weiny <ira.weiny@intel.com>
References: <2025071637-doubling-subject-25de@gregkh>
 <719ff2ee-67e3-4df1-9cec-2d9587c681be@linux.dev>
 <2025071747-icing-issuing-b62a@gregkh>
 <5d8205e1-b384-446b-822a-b5737ea7bd6c@linux.dev>
 <2025071736-viscous-entertain-ff6c@gregkh>
 <03e04d98-e5eb-41c0-8407-23cccd578dbe@linux.dev>
 <2025071726-ramp-friend-a3e5@gregkh>
 <5ee4bac4-957b-481a-8608-15886da458c2@linux.dev>
 <20250720081705.GE402218@unreal>
 <e4b5e4fa-45c4-4b67-b8f1-7d9ff9f8654f@linux.dev>
 <20250723081356.GM402218@unreal>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250723081356.GM402218@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/23/25 04:13, Leon Romanovsky wrote:
> On Mon, Jul 21, 2025 at 10:29:32AM -0400, Sean Anderson wrote:
>> On 7/20/25 04:17, Leon Romanovsky wrote:
>> > On Thu, Jul 17, 2025 at 01:12:08PM -0400, Sean Anderson wrote:
>> >> On 7/17/25 12:33, Greg Kroah-Hartman wrote:
>> > 
>> > <...>
>> > 
>> >> Anyway, if you really think ids should be random or whatever, why not
>> >> just ida_alloc one in axiliary_device_init and ignore whatever's
>> >> provided? I'd say around half the auxiliary drivers just use 0 (or some
>> >> other constant), which is just as deterministic as using the device
>> >> address.
>> > 
>> > I would say that auxiliary bus is not right fit for such devices. This
>> > bus was introduced for more complex devices, like the one who has their
>> > own ida_alloc logic.
>> 
>> I'd say that around 2/3 of the auxiliary drivers that have non-constant
>> ids use ida_alloc solely for the auxiliary bus and for no other purpose.
>> I don't think that's the kind of complexity you're referring to.
>> 
>> >> Another third use ida_alloc (or xa_alloc) so all that could be
>> >> removed.
>> > 
>> > These ID numbers need to be per-device.
>> 
>> Why? They are arbitrary with no semantic meaning, right?
> 
> Yes, officially there is no meaning, and this is how we would like to
> keep it.
> 
> Right now, they are very correlated with with their respective PCI function number.
> Is it important? No, however it doesn't mean that we should proactively harm user
> experience just because we can do it.
> 
> [leonro@c ~]$ l /sys/bus/auxiliary/devices/
> ,,,
> rwxrwxrwx 1 root root 0 Jul 21 15:25 mlx5_core.rdma.0 -> ../../../devices/pci0000:00/0000:00:02.7/0000:0
> 8:00.0/mlx5_core.rdma.0
> lrwxrwxrwx 1 root root 0 Jul 21 15:25 mlx5_core.rdma.1 -> ../../../devices/pci0000:00/0000:00:02.7/0000:0
> 8:00.1/mlx5_core.rdma

Well, I would certainly like to have semantic meaning for ids. But apparently
that is only allowed if you can sneak it past the review process.

--Sean


