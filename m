Return-Path: <netdev+bounces-174517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5AFA5F0E9
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 11:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6183A74FC
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 10:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56C32571BF;
	Thu, 13 Mar 2025 10:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="S9Qw2rRh"
X-Original-To: netdev@vger.kernel.org
Received: from mx05lb.world4you.com (mx05lb.world4you.com [81.19.149.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BE91DF975
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861837; cv=none; b=rmyPtpQ1oFkDHxVOorjC/oyIzsXFiOaj50vqUCKIucK5rQE+orceo3H6ao3qeajVUo+trwd78xyZCO5dlLUnwgAj0hdIuFwYZ3jFaka55i1OuZTHNoGNHp8hlYplGyttMsE41vuoY5sDUjuYwkSKbZbtY/KGfRTo9XnVkbj2jdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861837; c=relaxed/simple;
	bh=m5pbpbLYpwJSyLc0V4CphWHwkl+Dotrs0MjAqVYTn7A=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=MxCZmfDHmXbqRbeDgLEndTBzgwjaehP3mVTWNpygG4fUTfdKnQTgeOKDHDaUxVPgtVfPmy8FGCWsQR1RXqpx5Z1viHAWNoGpSm5QaIVBuxdYv8UYft/UxiaN0rzi8Yw6sOcmG0SZxqajXAFaXcCpM2C2a0wfRmITcDfoIoKU51M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=S9Qw2rRh; arc=none smtp.client-ip=81.19.149.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WTKwqv8fhSkg8kXBqznMdAIzww4mvBQswwBZ5xc61eg=; b=S9Qw2rRhyda5O8kIH+pD3CaB3V
	WmqTfxrwOMBqn6yLQJ0ujTPPCJoetyxX87shy3G0Db05z/KmPhsnsU4hseLbL/8h3W6+/w4R+uPf2
	CXamHd4pgKgdXn98XMnN9mF8u+zb0NRsKGuFlBrM4QCqYiR6lE6yFxzATwc3JidYvMcY=;
Received: from [81.19.149.44] (helo=webmail.world4you.com)
	by mx05lb.world4you.com with esmtpa (Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tseyi-000000001Qf-1pzZ;
	Thu, 13 Mar 2025 10:35:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Mar 2025 10:35:47 +0100
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v10 3/5] net: phy: micrel: Add loopback support
In-Reply-To: <20250313095729.53a621e0@fedora-2.home>
References: <20250312203010.47429-1-gerhard@engleder-embedded.com>
 <20250312203010.47429-4-gerhard@engleder-embedded.com>
 <20250313095729.53a621e0@fedora-2.home>
User-Agent: World4You Webmail
Message-ID: <9b61088921bafd7da5739c786274c083@engleder-embedded.com>
X-Sender: gerhard@engleder-embedded.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

Am 13.03.2025 09:57, schrieb Maxime Chevallier:
> Hello Gerhard,
> 
> On Wed, 12 Mar 2025 21:30:08 +0100
> Gerhard Engleder <gerhard@engleder-embedded.com> wrote:
> 
>> The KSZ9031 PHYs requires full duplex for loopback mode. Add PHY
>> specific set_loopback() to ensure this.
>> 
>> Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
>> ---
>>  drivers/net/phy/micrel.c | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>> 
>> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
>> index 289e1d56aa65..24882d30f685 100644
>> --- a/drivers/net/phy/micrel.c
>> +++ b/drivers/net/phy/micrel.c
>> @@ -1032,6 +1032,29 @@ static int ksz9021_config_init(struct 
>> phy_device *phydev)
>>  #define MII_KSZ9031RN_EDPD		0x23
>>  #define MII_KSZ9031RN_EDPD_ENABLE	BIT(0)
>> 
>> +static int ksz9031_set_loopback(struct phy_device *phydev, bool 
>> enable,
>> +				int speed)
>> +{
>> +	u16 ctl = BMCR_LOOPBACK;
>> +	int val;
>> +
>> +	if (!enable)
>> +		return genphy_loopback(phydev, enable, 0);
>> +
>> +	if (speed == SPEED_10 || speed == SPEED_100 || speed == SPEED_1000)
>> +		phydev->speed = speed;
>> +	else if (speed)
>> +		return -EINVAL;
>> +	phydev->duplex = DUPLEX_FULL;
>> +
>> +	ctl |= mii_bmcr_encode_fixed(phydev->speed, phydev->duplex);
>> +
>> +	phy_write(phydev, MII_BMCR, ctl);
>> +
>> +	return phy_read_poll_timeout(phydev, MII_BMSR, val, val & 
>> BMSR_LSTATUS,
>> +				     5000, 500000, true);
> 
> Maybe I don't fully get it, but it looks to me that you poll, waiting
> for the link to become up. As you are in local loopback mode, how does
> that work ? Do you need connection to an active LP for loopback to
> work, or does the BMSR_LSTATUS bit behave differently under local
> loopback ?

Yes I'm polling for link to come up. This is identical to 
genphy_loopback().
There is no need for a link partner to get a link up in loopback mode.
BMSR_LSTATUS reflects the loopback as link in this case.

This series allows to configure a loopback with defined speed without 
any
link partner. Currently for PHY loopback a link partner is needed in 
some
cases (starting with 1 Gbps loopback).

Gerhard

