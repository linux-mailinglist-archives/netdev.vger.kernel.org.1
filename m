Return-Path: <netdev+bounces-211791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D81B1BBAA
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 23:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242CF188CF6F
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 21:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D351B4F1F;
	Tue,  5 Aug 2025 21:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TsyzzyM6"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC299849C;
	Tue,  5 Aug 2025 21:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754428569; cv=none; b=ibex/4clx0A81yMkzy+TU28NuHV9lfDVDE3MW711txZGKL1C5OvvC6kDSO0M4Y7iP8shm9VzwdDe4uYRT25EefDblrDOeoji3KA30scJceLTp9YrKV9eTFuD/CwomcH21a9gPIFtpHAdl/XX0JvDakGnN/OiM2Nc0tVR2yqXR4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754428569; c=relaxed/simple;
	bh=gVWU27N9HqOZO+IUAKKSsMf/n2usEf6ekSZ3Ow/lwOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NmoDx03ZYTHyICvx0Kj8j+cfi/qaXPAJUWb8gcn3RPPebGpoxiRxUgvAKFr7pdJtzEI+4jCaizwCbDmu75s5yJ1sVRPwwUF8i31syK73ykqgpmhI4gDlxLVhQNGl8rcbVSJP2zbrgShC8zqQL1Gni5GpibB+oUTjjFaQWyweXCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TsyzzyM6; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6349fbbb-de1f-4ec9-abb0-96b4e2d37c97@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754428564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cDvcXYGl2SM9lHx0jfhT79En8esQte6fbgJAw4tuiQU=;
	b=TsyzzyM63LSewoRZ9QH/0uF5rJN/ZQvLNt6sIZ0oNVMt0VV7yXoh8+xXI77+nE1OgqEDkz
	GblkHkxXM0x1Qc/a1TurMcTEg9CrYt1QYiYBItv4jmOoaitNAVOnw7/TkwjZuEdL7eIiNP
	PTWOCUCvr2iFWc2IpLCZF9/+t6cmiaY=
Date: Tue, 5 Aug 2025 17:15:59 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 3/7] net: axienet: Use MDIO bus device in
 prints
To: Andrew Lunn <andrew@lunn.ch>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Michal Simek <michal.simek@amd.com>,
 Leon Romanovsky <leon@kernel.org>
References: <20250805153456.1313661-1-sean.anderson@linux.dev>
 <20250805153456.1313661-4-sean.anderson@linux.dev>
 <8a28ce41-f28d-4089-8a8e-a82ae2ccfc82@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <8a28ce41-f28d-4089-8a8e-a82ae2ccfc82@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/5/25 17:07, Andrew Lunn wrote:
> On Tue, Aug 05, 2025 at 11:34:52AM -0400, Sean Anderson wrote:
>> For clarity and to remove the dependency on the parent netdev, use the
>> MDIO bus device in print statements.
> 
>> @@ -186,28 +187,31 @@ static int axienet_mdio_enable(struct axienet_local *lp, struct device_node *np)
>>  		/* Legacy fallback: detect CPU clock frequency and use as AXI
>>  		 * bus clock frequency. This only works on certain platforms.
>>  		 */
>> -		np1 = of_find_node_by_name(NULL, "cpu");
>> +		np1 = of_find_node_by_name(NULL, "lpu");
> 
> There is nothing about dev in this change?

Whoops, this was left over from doing s/lp/cp/ and then reverting
it when I decided that there would be too much diffstat. Will fix for v5.

--Sean




