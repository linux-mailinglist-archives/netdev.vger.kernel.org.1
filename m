Return-Path: <netdev+bounces-135291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C865399D714
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 21:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF3A2B22589
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 19:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC1E1C7603;
	Mon, 14 Oct 2024 19:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="sXifZNbi"
X-Original-To: netdev@vger.kernel.org
Received: from mx09lb.world4you.com (mx09lb.world4you.com [81.19.149.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A491C3306
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 19:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728933315; cv=none; b=MuSJWEejmB5+tCNDNK8IyJsPh7pkNZO5/zzPK8i0C0OWj4JHVatJ5t+rMyM1pmaVkXKKm3Bv5a9AxGxzoZnR80ivEkXMTlUtLmOPO4IsJcp39M/NHF1p7LeBdikMcfwbnH4DB76TbsMywZKefatLq4KBhcfrFhJdku+07lUPJVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728933315; c=relaxed/simple;
	bh=MMvUSRb3hsQCsLjN+p94fgRzpUrEqtu6wMtabPdTwfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YDodjTqDMLCM7Wg7WMxeEmMuzyAk1EgVK+dXf0/2HkZAsinos2hpATE+V/+bmQmmkKmN2RWU/KuM718s5h8uaV2To174m4QlCah6qMcL+q3b96yPPQAgg935VLI0Xe55iCbsB5o6mUjla+m1BBR7LrOh+7h9QMl7+Ec8PN/NRHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=sXifZNbi; arc=none smtp.client-ip=81.19.149.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NpiFOxMjDOI1s6M2dDGRxm7ZqqtS7QwC3673jWn+xGM=; b=sXifZNbiIIEqoHWsqFRVPSCyv8
	IknJQDZ0kiAVLSim9OAv5eR+C1TGMdq9qKwdAyEoGHdjGQ+/dNTgPKJmCdXu3Y0IbOKovIRXzmBdi
	pdli3BYSg5ZYRtfY27USPpjOXLP4mYTlmNADehpPJ09+6y+ruT4IJpWDQTYa/3WLcwdg=;
Received: from [88.117.56.173] (helo=[10.0.0.160])
	by mx09lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1t0Pzk-000000000zA-3djb;
	Mon, 14 Oct 2024 20:40:40 +0200
Message-ID: <3c77d9b2-0933-4da5-a12b-1dd7ebcfebad@engleder-embedded.com>
Date: Mon, 14 Oct 2024 20:40:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] net: phy: micrel: Improve loopback support
 if autoneg is enabled
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
References: <20241013202430.93851-1-gerhard@engleder-embedded.com>
 <63352ee3-f056-4e28-bc10-b6e971e2c775@lunn.ch>
 <Zw0jHKKt6z4O3D5U@shell.armlinux.org.uk>
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <Zw0jHKKt6z4O3D5U@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 14.10.24 15:56, Russell King (Oracle) wrote:
> On Mon, Oct 14, 2024 at 03:18:29PM +0200, Andrew Lunn wrote:
>> Russell's reading of 802.3 is that 1G requires autoneg. Hence the
>> change. Loopback is however special. Either the PHY needs to do
>> autoneg with itself, which is pretty unlikely, or it needs to ignore
>> autoneg and loopback packets independent of the autoneg status.
>>
>> What does 802.3 say about loopback? At least the bit in BMCR must be
>> defined. Is there more? Any mention of how it should work in
>> combination with autoneg?
> 
> Loopback is not defined to a great degree in 802.3, its only suggesting
> that as much of the PHY data path should be exercised as possible.
> However, it does state in clause 22 that the duplex bit should not
> affect loopback.
> 
> It doesn't make any reference to speed or autoneg.
> 
> Given that PHYs that support multiple speeds need to have different
> data paths through them, and the requirement for loopback to use as
> much of the data path as possible, it does seem sensible that some
> PHYs may not be able to negotiate with themselves in loopback mode,
> (e.g. at 1G speeds, one PHY needs to be master the other slave, how
> does a single PHY become both master and slave at the same time...)
> then maybe forced speed is necessary when entering loopback.
> 
> So probably yes, when entering loopback, we probably ought to force
> the PHY speed, but that gets difficult for a PHY that is down and
> as autoneg enabled (what speed do we force?)
> 
> We do have the forced-settings in phy->autoneg, phy->speed and
> phy->duplex even after the referred to commit, so we could use
> that to switch the PHY back to a forced mode. However, I suepct
> we're into PHY specific waters here - whether the PHY supports
> 1G without AN even in loopback mode is probably implementation
> specific.

I posted as a RFC, because I felt not able to suggest a more generic
solution without any input. But I can add some facts about the KSZ9031
PHY. The data sheet agrees with Russells commit: "For 1000BASE-T mode,
auto-negotiation is required and always used to establish a link"
It also requests autoneg disable, full duplex and speed bits set for
loopback. So loopback speed is configurable. For 1000 Mbps it also
requires some slave configuration. genphy_loopback() mostly follows
the data sheet.

In my opinion the genphy_loopback() seems to work with most PHYs
or most real use cases. Otherwise, there would have been more PHY
specific set_loopback() implementations. The only problem is how
speed/duplex is determined. It is not guaranteed that phydev->speed and
phydev->duplex have reasonable values if autoneg has been triggered,
maybe because autoneg is still in progress or link is down or just
because the PHY state machine has not run so far. Always enabling
autoneg for 1000 Mbps only made the problem more apparent.

My suggestion would be to improve the speed/duplex selection for
loopback in the generic code. The selected speed/duplex should be
forwarded to genphy_loopback() or PHY specific set_loopback().
If speed/duplex have valid values, then these values should be used.
Otherwise the maximum speed/duplex of the PHY should be used.
Would that be a valid solution?

Gerhard

