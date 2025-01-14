Return-Path: <netdev+bounces-158221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E9DA111CA
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 21:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7438B168247
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 20:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16940204590;
	Tue, 14 Jan 2025 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="iQ451GXT"
X-Original-To: netdev@vger.kernel.org
Received: from mx17lb.world4you.com (mx17lb.world4you.com [81.19.149.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6281E200BB8
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 20:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736885859; cv=none; b=hF8xTvSZDY31QRyY14Hr8UsaHWLoId1MJ/tKf1O2uEYoKfcfNTGCT43D08VUhzXj9Cp59R21t0EqIUvOVrScY46jDCNm6hj/5WKG4i8kRwgZnhwyT0rILIKPm9AwMKIylT7g+1n/FK9i/nAH16eS+5JX5mPbPFwlfEYOlqUKnS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736885859; c=relaxed/simple;
	bh=SsOxekMjHdrLRwmzjp9B8vnOMz6WBVPMuX8UxCxbaqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nPTr40Eb93G3v3pK85d4ylWD8lxN8QykoucwAixUudq++hvoegr0rG6dGlYs7NDYJapNAgttUGhDKpqpJa7KbGbtq3BX03whPXT4dXNYy9qTnNhU5FwIAy71pPgccrC1DMSaLwjNZx2OWHffmfl3xvSzWA14hShtW4sGlrmUUuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=iQ451GXT; arc=none smtp.client-ip=81.19.149.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JH0H1enMHPRAysBkfLICA95Tfu9HPKhyyJw7zcIGcrA=; b=iQ451GXTKGbCUeHUBQFBkRa1JR
	vPjUY2EaRijgmuSoA60597tbrgrQ0IFdXFsA10ggE6hxNSPkHANVYEUdgMVjnreAofXM3YzsB5IC8
	Gf7wIzUrgjKtchdhQTAZjJFyDeRc2Sc1xL23k/ZyrIO0P4Xxw0/Akk5lTT1RZAkr7yzw=;
Received: from [88.117.60.28] (helo=[10.0.0.160])
	by mx17lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tXnLx-000000002iY-2i6C;
	Tue, 14 Jan 2025 21:17:33 +0100
Message-ID: <fdfc759b-2bdd-427a-878f-e4294524841d@engleder-embedded.com>
Date: Tue, 14 Jan 2025 21:17:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/5] tsnep: Select speed for loopback
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20250110144828.4943-1-gerhard@engleder-embedded.com>
 <20250110144828.4943-5-gerhard@engleder-embedded.com>
 <65db2d1b-10aa-4bf6-8205-3ede6726d87b@lunn.ch>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <65db2d1b-10aa-4bf6-8205-3ede6726d87b@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 13.01.25 22:59, Andrew Lunn wrote:
> On Fri, Jan 10, 2025 at 03:48:27PM +0100, Gerhard Engleder wrote:
>> Use 100 Mbps only if the PHY is configured to this speed. Otherwise use
>> always the maximum speed of 1000 Mbps.
>>
>> Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
>> ---
>>   drivers/net/ethernet/engleder/tsnep_main.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
>> index 5c501e4f9e3e..45b9f5780902 100644
>> --- a/drivers/net/ethernet/engleder/tsnep_main.c
>> +++ b/drivers/net/ethernet/engleder/tsnep_main.c
>> @@ -229,8 +229,19 @@ static void tsnep_phy_link_status_change(struct net_device *netdev)
>>   static int tsnep_phy_loopback(struct tsnep_adapter *adapter, bool enable)
>>   {
>>   	int retval;
>> +	int speed;
>>   
>> -	retval = phy_loopback(adapter->phydev, enable, 0);
>> +	if (enable) {
>> +		if (adapter->phydev->autoneg == AUTONEG_DISABLE &&
>> +		    adapter->phydev->speed == SPEED_100)
>> +			speed = SPEED_100;
>> +		else
>> +			speed = SPEED_1000;
>> +	} else {
>> +		speed = 0;
>> +	}
>> +
>> +	retval = phy_loopback(adapter->phydev, enable, speed);
> 
> If phy_loopback() returns -EOPNOTSUPP, don't you want to retry without
> a speed? There is no guarantee the PHY paired with this MAC does
> support setting the loopback speed.

Some tests require 100 Mbps and other tests require 1000 Mbps for
loopback. So a defined loopback speed is required. For my tests it
is ok if they work only with PHYs which support setting the loopback
speed.

Gerhard


