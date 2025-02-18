Return-Path: <netdev+bounces-167393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 891CFA3A1F7
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 17:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82A2C1895835
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 16:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B074E26E177;
	Tue, 18 Feb 2025 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AiViI2f1"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63A626E16D
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739894464; cv=none; b=F1PAn63ZTZqjO27bYuZZ97LvIa9fY4diIZFq97XJ5iZSGXs5Rf5vjS2bQSPxFiut2eI082ie50fmEDfs5AHcoc2pTp5uRbQCfCtYHZezY5Vlmkraxv3jFThMO/RfFhwmS223e9wOq5jHwD14WsZ+ly2n92E0u/VCSpEO9YCkxhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739894464; c=relaxed/simple;
	bh=lQi5EQUPUXU3uF4qxASGc/bfF5ePI1UG/xZUTNsoJbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U7uCAFy5vnHKQoXhu2+yEHG0igNuCzKBa9BUIEHNSLoKIGZhw0MxL6pWps4yKThLOv3j65CDc7m+22SviYQ+fY3tBVhjO6hBEH2q600fo1FuGtRpB0Ly3hNv6GVJ+yXEI1a4zKdDtliMRYNFMvIFVMEFzKGiTi6PpLrk01AXFk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AiViI2f1; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <aa58373c-a4ac-4994-821b-40574e19be3d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739894460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fuAxe1oc0+r/u7FGuT0j5suXqns5H7z8OqHhywOTHjg=;
	b=AiViI2f17rbhBJI8KOYLFJYWwWSGZqWG/NxeVx1JFlMeXhiSvTpjyY4rN6FwcQEWo1V6tm
	/aj45MnJ2ZJPCQppMD7NkLREdcRMxNX/dIxKmb4mKy68bvWj1O2YZ9xfgzG7UKqh0k0SX4
	U5rLPbRq41B5c9cYoJzhvk9dZJKn7pQ=
Date: Tue, 18 Feb 2025 11:00:52 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: xilinx: axienet: Implement BQL
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <BL3PR12MB6571A18DA9E284A301FF70FAC9F92@BL3PR12MB6571.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/15/25 06:32, Gupta, Suraj wrote:
> 
> 
>> -----Original Message-----
>> From: Sean Anderson <sean.anderson@linux.dev>
>> Sent: Saturday, February 15, 2025 2:43 AM
>> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>;
>> netdev@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org; Paolo Abeni <pabeni@redhat.com>; David S .
>> Miller <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>; Simek, Michal
>> <michal.simek@amd.com>; linux-arm-kernel@lists.infradead.org; Eric Dumazet
>> <edumazet@google.com>; Andrew Lunn <andrew+netdev@lunn.ch>; Sean
>> Anderson <sean.anderson@linux.dev>
>> Subject: [PATCH net-next] net: xilinx: axienet: Implement BQL
>> 
>> Caution: This message originated from an External Source. Use proper caution
>> when opening attachments, clicking links, or responding.
>> 
>> 
>> Implement byte queue limits to allow queueing disciplines to account for packets
>> enqueued in the ring buffers but not yet transmitted.
>> 
> 
> Could you please check if BQL can be implemented for DMAengine flow?

I can have a look, but TBH I do not test the dma engine configuration since it is
so much slower.

--Sean


