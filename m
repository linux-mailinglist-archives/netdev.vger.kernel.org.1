Return-Path: <netdev+bounces-158220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 659D9A111BA
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 21:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159153A0434
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 20:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5F620767A;
	Tue, 14 Jan 2025 20:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="xD/J0slP"
X-Original-To: netdev@vger.kernel.org
Received: from mx17lb.world4you.com (mx17lb.world4you.com [81.19.149.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E9519149F
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 20:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736885403; cv=none; b=AM+d5sft8wl84GBKqhkc3SmlhOtS+/jTLHAt7uCxuJ8+g66JfaMCcmpBr5TbN5Told6/Q3rcv44sjW5VQQ9qQ/MidtRLH8QYh/hMWLUHYaf4GjU3wCyAmFsX1BhdMia05zZQi8K9yIRqAH/7/vIBJIhXfvOP3a9R1ednuqi6Vv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736885403; c=relaxed/simple;
	bh=+Oc8tGDzrFr65IJ7GGlCOFWNMQhpdl4aXrLOTtIQy/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XniVvvi6s7R0S+RGT8D7RLLwBev+XP+zuhVddS/przyQNMzFhOLRV4Nzx3ISN9JWC2B+yob7dVno4yf9WVAdAe+xalSB95uoM9T5RxiV44Xmizj799sYAlRepiLwLjItF4bbO8flv/2Ce57P/x9iNZ+n20z/JGOpwKPwUaX7bfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=xD/J0slP; arc=none smtp.client-ip=81.19.149.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8Kl54t9fosv2NbHFrW+h/ob8c2DLjJDfpQZ9NTUY5Ls=; b=xD/J0slPyRwm+5qwhXKPOu9imv
	KddIWvjojtJWaAbN9lCG8gI8bd0nBcw7m+yJN/qvKjj0aPhrYwLpCmdeeKBkgtJToNEbBM8lB9+0f
	K92u9SPuqPvNUUssAP7P2pRHmpE4Phe35mKpWTOJ+ia99sSXeGiGsCmAUeiO4h8v0xDs=;
Received: from [88.117.60.28] (helo=[10.0.0.160])
	by mx17lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tXnET-000000001KQ-1o9v;
	Tue, 14 Jan 2025 21:09:49 +0100
Message-ID: <384e051a-3226-4851-8284-13acf4869965@engleder-embedded.com>
Date: Tue, 14 Jan 2025 21:09:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/5] net: phy: micrel: Add loopback support
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20250110144828.4943-1-gerhard@engleder-embedded.com>
 <20250110144828.4943-4-gerhard@engleder-embedded.com>
 <e92b60fa-b3d0-4f45-b9a1-90bc9bb3ec7c@lunn.ch>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <e92b60fa-b3d0-4f45-b9a1-90bc9bb3ec7c@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 13.01.25 22:55, Andrew Lunn wrote:
>> @@ -1030,6 +1030,33 @@ static int ksz9021_config_init(struct phy_device *phydev)
>>   #define MII_KSZ9031RN_EDPD		0x23
>>   #define MII_KSZ9031RN_EDPD_ENABLE	BIT(0)
>>   
>> +static int ksz9031_set_loopback(struct phy_device *phydev, bool enable,
>> +				int speed)
>> +{
>> +	u16 ctl = BMCR_LOOPBACK;
>> +	int ret, val;
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
>> +	phy_modify(phydev, MII_BMCR, ~0, ctl);
>> +
>> +	ret = phy_read_poll_timeout(phydev, MII_BMSR, val, val & BMSR_LSTATUS,
>> +				    5000, 500000, true);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
> 
> As far as i can see, the marvell PHY is the only other one you can
> specify the speed? I think it would be better if the marvell
> set_loopback and this one looked similar. Either clearing the loopback
> bit and configuring aneg should be here, or the marvell driver should
> be modified to use genphy_loopback to disable loopback.

You are right, they should look similar. I will modify the marvell
driver to also use genphy_loopback() to disable loopback. This way the
same code is used to disable loopback.

genphy_loopback() does not check return codes of phy_modify() and
phy_config_aneg() if loopback is disabled, but marvell driver does.
I will keep genphy_loopback() logic without checking return codes,
as there is no reasonable error handling if loopback disable fails.

Gerhard


