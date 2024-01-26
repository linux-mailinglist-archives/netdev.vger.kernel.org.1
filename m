Return-Path: <netdev+bounces-66189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F9783DD71
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 16:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECCB6B287D2
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 15:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0905D1D539;
	Fri, 26 Jan 2024 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UM5SEB+u"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C32B1D522
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282772; cv=none; b=s8UJ98UJNa2MDRJnJxptn5Iy+1qRyL63yJrVCHtB21UyFzRZQnzDV2iel1mPx3DaGQYl5vrZaP0/rPfe3uSfdfa+NZ//gZQRaGyTDrgBErBeFnUdCoXxWOH/wkY0yw4MMRzhesKTzfqtR3Vc4QBybRLDQvfNXD5CKxc/3rkVs9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282772; c=relaxed/simple;
	bh=9Qc4d5sEmbHsESq4fFjTmGiC96Oi9yFdgok9xRrMQeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qCdgs3kJhCsOSkua3LX5TU8cjRXDonWCI3Ol+j/oT+dtPcrULqmdEEtVTnQICar51oLovWeZYP2Q6M+bqYkfiGR0gldIr3ZLL6zuTpHkNlhFAru6PdBAooFS9KeaNYUrE3Wz2Zib5P6l2D73+kAYOqtj2f2f5D3jq4ImjC1hXqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UM5SEB+u; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c554f7e6-7ed9-4298-b9f3-3f49a331fd07@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706282769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b/XtWJSlEPajpPJBC99SxXmFSOIVYebBbltEyKIScQo=;
	b=UM5SEB+uF0i9MwWGor56/zRWlvXexakJGaSGya26mfWheRo0UKehMh77jBib4gCEtOMBpj
	2edm+1ll+UjjnLXdmi+8AUYzUWZvXoY615OJBG0dxzhvnzpRn2Ql0tw6HJCOSo5/TDz6wK
	3q8pJutBcghviqdvk+XqGOV536ctwB0=
Date: Fri, 26 Jan 2024 15:26:00 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: micrel: Fix set/get PHC time for lan8814
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Divya Koppera <divya.koppera@microchip.com>
References: <20240126073042.1845153-1-horatiu.vultur@microchip.com>
 <8da0a157-6a09-4d82-ad36-7428fdb27f9b@linux.dev>
 <a962b46c-343d-411b-9152-514b35aa4f00@lunn.ch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <a962b46c-343d-411b-9152-514b35aa4f00@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 26/01/2024 13:15, Andrew Lunn wrote:
>>> +	*sec |= lanphy_read_page_reg(phydev, 4, PTP_CLOCK_READ_SEC_MID);
>>
>> lanphy_read_page_reg returns int, but only 16 bits have meanings here.
>> Is it safe to assume that other 16 bits will be zeros always?
> 
> Yes. __phy_read() should only return a negative error code, or a value
> which fits in a u16. If any of the top bits are set, its a bug in the
> MDIO driver which needs finding and fixing.

Got it. Thanks Andrew


