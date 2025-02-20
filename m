Return-Path: <netdev+bounces-168210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7A9A3E1A3
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 17:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 849327A57AA
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 16:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE02213237;
	Thu, 20 Feb 2025 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pb9PmXpW"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE711DFD85
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 16:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070718; cv=none; b=X9l6DqdYXgJQH12029/n38LWF4iWB9p/87DNWpHoNen6Z+STzLhzlgBCjLa1SAxSzdJj6QOkEqn9O+VBvLU9sNZo+kmP0d1OQ9U4fQ0tGdSap4+rvlKuUzervudgMS8IYGCRtx8SPLAtOnpbhBwnthpEP2COhKfiTtWSVOZrAks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070718; c=relaxed/simple;
	bh=Q+Jb7AfoCiGdFXi62io4F0vSXl1qRocAJVycKuaL/D0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=A3gbOGJnd3paqtfOepkH8BjAgRihi39OYImpI6q53x6rjEIsob80tlcoUrZfiba8Gbpi3OcPH0JRols2Ny+SNgGwmT5oxOoNUzIgPafk3Tq12LWOK0bC4J9Q24GIZ9UPT1hE/jUXyFPkVzRdmk4GncSWHzZl5v4ywxZDpXyiflw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pb9PmXpW; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3a6e95ea-cdb0-4239-bb47-b29df45f52cc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740070714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FSAZDU3AQ1VuBM+5kuWntriYIhfJE92ii0LczQ8TURY=;
	b=Pb9PmXpWIMKQJkmpnNqDfCGZgWDI5wwWnFau35gLZoTY+H8QCNvPYANLWGC+16l6mTPgFi
	orT1GIthN1+y33Gzcvs4n5kP7IVnIbKjiZ8FmvnzWUm2hlW9eOmfFIq+GnIF0SHefEN/o8
	5VPUYY5vg56awFcSldq+DXTogIDfAig=
Date: Thu, 20 Feb 2025 11:58:30 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: xilinx: axienet: Implement BQL
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: "Gupta, Suraj" <Suraj.Gupta2@amd.com>,
 "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>
References: <20250214211252.2615573-1-sean.anderson@linux.dev>
 <BL3PR12MB6571A18DA9E284A301FF70FAC9F92@BL3PR12MB6571.namprd12.prod.outlook.com>
 <aa58373c-a4ac-4994-821b-40574e19be3d@linux.dev>
Content-Language: en-US
In-Reply-To: <aa58373c-a4ac-4994-821b-40574e19be3d@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/18/25 11:00, Sean Anderson wrote:
> On 2/15/25 06:32, Gupta, Suraj wrote:
>> 
>> 
>>> -----Original Message-----
>>> From: Sean Anderson <sean.anderson@linux.dev>
>>> Sent: Saturday, February 15, 2025 2:43 AM
>>> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>;
>>> netdev@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org; Paolo Abeni <pabeni@redhat.com>; David S .
>>> Miller <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>; Simek, Michal
>>> <michal.simek@amd.com>; linux-arm-kernel@lists.infradead.org; Eric Dumazet
>>> <edumazet@google.com>; Andrew Lunn <andrew+netdev@lunn.ch>; Sean
>>> Anderson <sean.anderson@linux.dev>
>>> Subject: [PATCH net-next] net: xilinx: axienet: Implement BQL
>>> 
>>> Caution: This message originated from an External Source. Use proper caution
>>> when opening attachments, clicking links, or responding.
>>> 
>>> 
>>> Implement byte queue limits to allow queueing disciplines to account for packets
>>> enqueued in the ring buffers but not yet transmitted.
>>> 
>> 
>> Could you please check if BQL can be implemented for DMAengine flow?
> 
> I can have a look, but TBH I do not test the dma engine configuration since it is
> so much slower.

I had a look, and BQL is already implemented for dmaengine.

--Sean

