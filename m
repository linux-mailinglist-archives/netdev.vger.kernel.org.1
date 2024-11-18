Return-Path: <netdev+bounces-145913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056959D14E1
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF85328408D
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2561A9B3D;
	Mon, 18 Nov 2024 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WRZ32geY"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209974437A
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945631; cv=none; b=aZ2hUNXPUEghl0dbcF5wZ8iA/ZWvKNVc+KCZ1G6wwgMGvAgO/AdzzkJsTrfa84mzMKEHJmd1A3JL9gWlciFdrUa+EcF5QWvzzkPKX0YQ9ycDV9neQOlqE9fCzBWr6PewcpPYEZL3zd15YANYOPZJquJlomHPeF26V6QBsbMaVbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945631; c=relaxed/simple;
	bh=Ge0r2Ea6KyPvO6/MOe8wxcNH8Q7DIB9dNFPGQKRqvQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OFr+Bxrzll7OpQSk9iIcM0iotNDdyMu0mmJfn8B3liOqmjYP98phSTQ/mQB4PNJqWg4zYwwiMb0Mg4k4MpsHOT3GjyNfCqPucg0dE1iXU0+QDqwYcMtEOVMUWnjVJPXqsTrp3UfQkIg+35nkO+Ed73et1gYVasL8dVx2UOKhERg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WRZ32geY; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <657764fd-68a1-4826-b832-3bda91a0c13b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731945627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hZI0ToznCzhjHwYsDSDb01BcP4KuLMwEBrhHNS7BIoc=;
	b=WRZ32geYK58tbEOuvHdtvVxm1DNs9niOmZol4nD0+3Mp8Dh6xJRI+uVBqTQza9gc5xn31a
	72onjs3SehhdwbFfty9nLDSfYnnlGGc+e29TYEanwsJgvAy5RVSwrmcCrNMPECyUdxetI4
	aEM2/YUCYARPqIpYkKl9Nf1sh+X0xtg=
Date: Mon, 18 Nov 2024 11:00:22 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/2] net: axienet: Add support for AXI 2.5G MAC
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Suraj Gupta <suraj.gupta2@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
 radhey.shyam.pandey@amd.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 git@amd.com, harini.katakam@amd.com
References: <20241118081822.19383-1-suraj.gupta2@amd.com>
 <20241118081822.19383-3-suraj.gupta2@amd.com>
 <ZztjvkxbCiLER-PJ@shell.armlinux.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <ZztjvkxbCiLER-PJ@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/18/24 10:56, Russell King (Oracle) wrote:
> On Mon, Nov 18, 2024 at 01:48:22PM +0530, Suraj Gupta wrote:
>> Add AXI 2.5G MAC support, which is an incremental speed upgrade
>> of AXI 1G MAC and supports 2.5G speed only. "max-speed" DT property
>> is used in driver to distinguish 1G and 2.5G MACs of AXI 1G/2.5G IP.
>> If max-speed property is missing, 1G is assumed to support backward
>> compatibility.
>> 
>> Co-developed-by: Harini Katakam <harini.katakam@amd.com>
>> Signed-off-by: Harini Katakam <harini.katakam@amd.com>
>> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
>> ---
> 
> ...
> 
>> -	lp->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
>> -		MAC_10FD | MAC_100FD | MAC_1000FD;
>> +	lp->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
>> +
>> +	/* Set MAC capabilities based on MAC type */
>> +	if (lp->max_speed == SPEED_1000)
>> +		lp->phylink_config.mac_capabilities |= MAC_10FD | MAC_100FD | MAC_1000FD;
>> +	else
>> +		lp->phylink_config.mac_capabilities |= MAC_2500FD;
> 
> The MAC can only operate at (10M, 100M, 1G) _or_ 2.5G ?

It's a PCS limitation. It either does (1000Base-X and/or SGMII) OR
(2500Base-X). The MAC itself doesn't have this limitation AFAIK.

--Sean

> Normally, max speeds can be limited using phylink_limit_mac_speed()
> which will clear any MAC capabilities for speeds faster than the
> speed specified.
> 

