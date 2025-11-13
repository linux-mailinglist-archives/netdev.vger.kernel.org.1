Return-Path: <netdev+bounces-238459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A84C5919D
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 18:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 269D34F0690
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 16:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A88265CA2;
	Thu, 13 Nov 2025 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SxZFDrYy"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F2D1E1A05
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 16:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052498; cv=none; b=omyiUjhz59j4GH955GrqlwN1n01+eYN1hNsyjOSCAt4svUF2lZxyqAda+B2w2eRRZamLg/xZTpoSlhukKRzj+D29lI/I1mBAXkQTOlwkRUS/h+BdHm7duw13L++6rdy2RA8k5jelQpEiNMB9rtELTq3G3jCUZvFWB2BNPxDSJjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052498; c=relaxed/simple;
	bh=WzJnQHiEm5GvXZ6bWT9UlBhZ0i8qoJzGCAyO1nmmAYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UOZHKOr8gBNI29URB5CCFiWrGWZ3CO6PgiG6bZZSDpUS5V8rKA4xZRcakhsiyaj+RZd7+FppAv+eBrnxZEa4KRwqHyUyTR1GExj8W6q3vCs0tWi+VbNOQDfKapQ6hAjvMiUKvxVPRUuCXTcs+QgFvRBlTr8WCNY6yKSIAT+Fq1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SxZFDrYy; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b428f0f0-d194-4f93-affd-dae34d0c86f1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763052491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=67l6uxqsHXujvz0HslC5pDU+DJfAMbKEJMP2I/butIA=;
	b=SxZFDrYyApI7FC6dgYK5bPirLy3eFblfm2+yrXtylnbkBRXdXMIPIAFqTTQLW7EReCHUtl
	X7EfxrwM9uWlgeRxmahBR+aF5wBmQalPGoitUBQdh0qDaIDqjG17a2ARYnTfDqvkDd0mXK
	Og1J2MDrvsiiYoAmqGPfnHnN7oS7T+c=
Date: Thu, 13 Nov 2025 16:48:00 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 2/9] phy: add hwtstamp_get callback to phy
 drivers
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrei Botila <andrei.botila@oss.nxp.com>,
 Richard Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org
References: <20251113113207.3928966-1-vadim.fedorenko@linux.dev>
 <20251113113207.3928966-3-vadim.fedorenko@linux.dev>
 <aRXIuckumra-3Y0L@shell.armlinux.org.uk>
 <12c8b9e9-4375-4d52-b8f4-afccba49448c@linux.dev>
 <a4b391f4-7acd-4109-a144-b128b2cc09b2@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <a4b391f4-7acd-4109-a144-b128b2cc09b2@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/11/2025 13:36, Andrew Lunn wrote:
>> I was planning to remove SIOCSHWTSTAMP/SIOCGHWTSTAMP dev_eth_ioctl calls
>> later once everything has landed and we have tests confirming that ioctl
>> and netlink interfaces work exactly the same way.
> 
> I don't think you can remove SIOCSHWTSTAMP, it is ABI. All you can
> really do is change the implementation so that it uses the same path
> as the netlink code.

Probably wrong explanation from my side. The plan is not to remove ABI,
but to let it go through netlink path in the core. As you suggest.

> You can avoid this for _get by never adding it in the first
> place. Only support the netlink API for PHYs.
Andrew, could you please check if I understand things correctly. PHY
devices are not exposed to user-space directly, and thus cannot be
configured via ioctl without netdev's .ndo_eth_ioctl(). The core netdev 
part falls back to ioctl for SIOCSHWTSTAMP/SIOCGHWTSTAMP only in case
when there is no ndo_hwtstamp_get/ndo_hwtstamp_set implemented in
network device driver. Once all network drivers are converted, there
will be no way user-space SIOCSHWTSTAMP/SIOCGHWTSTAMP ABI can reach
phy_mii_ioctl().

If the above is correct, then yes, there is no reason to implement
SIOCGHWTSTAMP, and even more, SIOCSHWTSTAMP can be technically removed
as a dead code.

