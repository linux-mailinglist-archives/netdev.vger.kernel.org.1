Return-Path: <netdev+bounces-165682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EC0A3304F
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 21:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744DD1882E57
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 20:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2C9200118;
	Wed, 12 Feb 2025 20:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="tnat7P5L"
X-Original-To: netdev@vger.kernel.org
Received: from mx07lb.world4you.com (mx07lb.world4you.com [81.19.149.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9101D1FF601
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 20:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739390490; cv=none; b=KiYNZCLWlNqpxTzcJlCOuWvSAkIc6CTSSFyCBtDDG6Jk/rKFvVr5RN+76V/o98Ni6IE8E7ByVa7kYDDATwNmKf2TxyboH6n02s+JcAMBR4RM+ooUoMFfvptWLMp937oLG/eIXbaZxmnylrnk09IrcaFKBvLbpfyPzhDGZHMWgc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739390490; c=relaxed/simple;
	bh=apBaUobNnSDc4GymyOgb4nT9TR65zT5VGhsL1GWIe3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qOirFt8BajmAq8UXu8V80WFuSeOlAaOJ9+yN296lwDHTm9p8H81Y+RhmDq8jhpS6l3l54EiICDrwGB8XBrdjEqL4TL8rNkUZL9q0UWNnt8hFG8pjb7hHNdjD5UdHfL5mid4sds0c8cuIMU9xZ6552KayZ7yR5dsdTgBqi9INTFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=tnat7P5L; arc=none smtp.client-ip=81.19.149.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=58Kfr4sq1FA02mgIALY9t8CYOfgEAELomQAX0+T0wKc=; b=tnat7P5LfVytxaUZfjKSp2z1Iz
	DUXh39HW59XvVhbiErdEw937pD/0ii9MP6a63uDqKQHfeKnkvk8NH+FzsRo1x5zh3UXQPphT1+3XJ
	F8bUoP3tiENmQxprlEWi5NOMkYnkmb3jNNbqwImUSHEGNWAF3P4C2RfKMRSj+cawQJ5w=;
Received: from [88.117.55.1] (helo=[10.0.0.160])
	by mx07lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tiIv5-000000001rV-0zXg;
	Wed, 12 Feb 2025 21:01:15 +0100
Message-ID: <dad7188a-bdd9-4453-aa8d-1622fd8ea9d3@engleder-embedded.com>
Date: Wed, 12 Feb 2025 21:01:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/7] net: phy: Support speed selection for PHY
 loopback
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20250209190827.29128-1-gerhard@engleder-embedded.com>
 <20250209190827.29128-3-gerhard@engleder-embedded.com>
 <57e02f9b-ff5e-44fa-b2fa-cbd7dd93408a@lunn.ch>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <57e02f9b-ff5e-44fa-b2fa-cbd7dd93408a@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 12.02.25 02:48, Andrew Lunn wrote:
>> +int phy_loopback(struct phy_device *phydev, bool enable, int speed)
>> +{
>> +	bool link_up = false;
>> +	int ret = 0;
>> +
>> +	if (!phydev->drv)
>> +		return -EIO;
>> +
>> +	mutex_lock(&phydev->lock);
>> +
>> +	if (enable && phydev->loopback_enabled) {
>> +		ret = -EBUSY;
>> +		goto out;
>> +	}
>> +
>> +	if (!enable && !phydev->loopback_enabled) {
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	if (enable) {
>> +		/*
>> +		 * Link up is signaled with a defined speed. If speed changes,
>> +		 * then first link down and after that link up needs to be
>> +		 * signaled.
>> +		 */
>> +		if (phydev->link && phydev->state == PHY_RUNNING) {
>> +			/* link is up and signaled */
>> +			if (speed && phydev->speed != speed) {
>> +				/* signal link down and up for new speed */
>> +				phydev->link = false;
>> +				phydev->state = PHY_NOLINK;
>> +				phy_link_down(phydev);
> 
> If you set the link down here...
> 
>> +
>> +				link_up = true;
>> +			}
>> +		} else {
>> +			/* link is not signaled */
>> +			if (speed) {
>> +				/* signal link up for new speed */
>> +				link_up = true;
>> +			}
>> +		}
>> +	}
>> +
>> +	if (phydev->drv->set_loopback)
>> +		ret = phydev->drv->set_loopback(phydev, enable, speed);
>> +	else
>> +		ret = genphy_loopback(phydev, enable, speed);
>> +
>> +	if (ret)
>> +		goto out;
> 
> and this fails, you leave the link down. You should make an attempt to
> restore the link to the old state before returning the error.

I will try to do the same as for loopback disable to try to restore the
the link.

Gerhard


