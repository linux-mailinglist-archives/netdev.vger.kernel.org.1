Return-Path: <netdev+bounces-189839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3148AB3D9A
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B8E07ABA31
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8142512DA;
	Mon, 12 May 2025 16:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wA4CXoJ3"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E212512F5
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747067529; cv=none; b=d26gqJaUdS8wV4BJU+J9YNVOZlt0x1Ih/DdJc7hUNgvWeGS68NONXR+0LT5unF8OanG7MKFXDxzW5LPZdTXiOXEHoIm0p5PFvyR2EMTZaoxfHYku6EcYh9mwtT6kRU5GGHsd0VYkM0MFLgCd+JbhjzEsJj6Qa5jfKU7QkFo9LPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747067529; c=relaxed/simple;
	bh=YDNamgtt8tW7Nj4b41JyfmR8tsFyJmqcxJjdDYPLGb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYHOmYHbGbqLIgUaA+EmxIZ/ivX1N4zTh1uDLXMmTYe61JneUmCSzLVgU3+1ZsIIhk+5sIHxaBShrJmei4NmEbBS0iJcS4aQPuJN1r7Ywa4DD3pCevlvWrZkcCtqfYxR2xPK3soiXABxIsQQX60Vos8tlIkSdZAU09wUn6NxrFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wA4CXoJ3; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <76961134-0676-4ec5-b5e1-5a9693bff268@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747067523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JmNM1qr8paaatXiculJ5HFFWSqjMdY6Pe+6AalpRTVI=;
	b=wA4CXoJ3Ta2nrePmKsSMlFl45w4ah+sYkf90mdblqcv0w7R7YfJTu4FFoj6O+va9Nbua8V
	zJxlAWuM58jZjnzKgoGyEB8k0EzZ+hhfJ36dqnkC00BVGWfxGzckTK+coS29mkNyVtkbD/
	8yCOMdAmcCPjUDvV1EJyctB+tXS/UFI=
Date: Mon, 12 May 2025 17:31:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: stmmac: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Furong Xu <0x1207@gmail.com>
References: <20250512143607.595490-1-vladimir.oltean@nxp.com>
 <2ca5f592-74d3-41ff-8282-4359cb5ec171@linux.dev>
 <20250512155846.vbmc3wrvpidbzxqc@skbuf>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250512155846.vbmc3wrvpidbzxqc@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/05/2025 16:58, Vladimir Oltean wrote:
> On Mon, May 12, 2025 at 04:50:35PM +0100, Vadim Fedorenko wrote:
>> On 12/05/2025 15:36, Vladimir Oltean wrote:
>>> New timestamping API was introduced in commit 66f7223039c0 ("net: add
>>> NDOs for configuring hardware timestamping") from kernel v6.6. It is
>>> time to convert the stmmac driver to the new API, so that the
>>> ndo_eth_ioctl() path can be removed completely.
>>
>> The conversion to the new API looks good, but stmmac_ioctl() isn't
>> removed keeping ndo_eth_ioctl() path in place. Did I miss something in
>> the patch?
> 
> I was never intending with this work to remove ndo_eth_ioctl()
> completely, but instead to completely remove the timestamping
> configuration path that goes through ndo_eth_ioctl(). I apologize for
> any false marketing and I will be more explicit about this in further
> patches.

Got it. The patch itself looks good:
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

