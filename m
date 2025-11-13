Return-Path: <netdev+bounces-238462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E53A8C592C6
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 18:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949E1425124
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 17:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3072F2914;
	Thu, 13 Nov 2025 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y933NnW6"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC45826F2B0
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053526; cv=none; b=m39ELW7QUvtPluJktSLIaczG0+z7crEto8aLg6COpuywV2Oy5k8YZHtEtqDs4A87aXsmMhq/EfwklTjBQXIsc8Am8DG+a5tQ3vWr4KD72HgzWTYJVT3WjS5e1bfVkyshO/BZ292GbSGVePlF/phl7oZn0rMcmmVut27WA34g7Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053526; c=relaxed/simple;
	bh=qEApP4OlRoDmKWQQ8dq9kruyJ5qW2wujdikj6zbPRmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lh/FskYILN5akJ4WCnYL85PjAgXD/eeq8pDSzEMwxSsbDqukdYJyH0ejdEZITIITnMTROXKLP6LpxWFJoOTdcOqvl8Aep9XQWZDB/M4HakH1oYbi2fN+P4+iz71oBs+NpgpPFcTf3xgRu1KBOMhnIrUmF6V/IFP1USWMTG5JZmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y933NnW6; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <69ec62f4-649b-4d88-8c06-6bf675160b0b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763053522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TAVYgHWupOmUFZAw93KBWNIGFfjC29Qxyt8mXwATTWQ=;
	b=Y933NnW6QUxtBNKoLKLW+VQItUqVpyU1zLmINXOe+ciWX0Yswc34oV12S61Z7safVJQIT1
	M3zZeBkoxh5Yjyy5maOOpdfiViwg4u1x165Afa8NJTsB7XRA9RFqB2PuOcsUDfherXfr6t
	G8OX84g28RVwoCVdFzTmIwyLPXKlBII=
Date: Thu, 13 Nov 2025 17:05:18 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 2/9] phy: add hwtstamp_get callback to phy
 drivers
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
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
 <b428f0f0-d194-4f93-affd-dae34d0c86f1@linux.dev>
 <aRYN-r7T9tz2eLip@shell.armlinux.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <aRYN-r7T9tz2eLip@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/11/2025 16:57, Russell King (Oracle) wrote:
> On Thu, Nov 13, 2025 at 04:48:00PM +0000, Vadim Fedorenko wrote:
>> If the above is correct, then yes, there is no reason to implement
>> SIOCGHWTSTAMP, and even more, SIOCSHWTSTAMP can be technically removed
>> as a dead code.
> 
> I think you're missing the clarification in this sentence "... to
> implement SIOCGHWTSTAMP in phy_mii_ioctl(), and even more,
> SIOCSHWTSTAMP can be removed from this function as dead code.""

Ok, it's better to "there is no reason to have SIOCGHWTSTAMP chunk,
provided in patch 2 of this series"

Or are you asking for the clarification of SIOCSHWTSTAMP removal?
I don't plan to remove it, at least not in this series. I just wanted
to mention that there will be no way to reach SIOCSHWTSTAMP case in
phy_mii_ioctl() from user-space ABI. Does it make sense?

