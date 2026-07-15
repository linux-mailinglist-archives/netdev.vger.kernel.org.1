Return-Path: <netdev+bounces-307737-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OpJnMvx1V2pOOgEAu9opvQ
	(envelope-from <netdev+bounces-307737-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 13:58:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7138575DDA1
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 13:58:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307737-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307737-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=motor-comm.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B28A1301EC4A
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 11:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE041448391;
	Wed, 15 Jul 2026 11:57:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-122.mail.aliyun.com (out28-122.mail.aliyun.com [115.124.28.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CFD44C641;
	Wed, 15 Jul 2026 11:57:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784116629; cv=none; b=cofpW7Y8EsPuL7ncZk1DIih24GmPh2PzPrf+QpW3MsYxhfZYNzkE5A0I6b1vcoZQm3Zk7AwgR0ALKIg2BtJE2Pnaf1rZqKLnQ7t1cHUQoeLcbw8YAyk3gVmsrFi3jCNjFJSZ8o/UPId5NbdOzqVvRs2ntQ9g2TODbszYBjspdXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784116629; c=relaxed/simple;
	bh=db1L9OnnXwHnIHYUhA6U0FpDLSkQ8Hwlej3bT2npRbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PRUQ1zKmTR1Iit2y4Z4M7d48gFj/RDQBOLtQ85/aRpgC3jPUvGAHVFTHfV1wNTtYhXuo4mXOxGYYg/7KUWpQv5j4oPAknMs2eIoXYOZqdnSffXiYBpBrkbfZNJaCAA6VsVcmTAXI+Zhilp0hukceigNx+zQC+eF1UntdMKKRB5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.122
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0725335|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00787841-0.119412-0.87271;FP=18372274822953045179|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045018182;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.iM2Pum6_1784116614;
Received: from 10.30.1.98(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.iM2Pum6_1784116614 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 15 Jul 2026 19:56:56 +0800
Message-ID: <50549cc2-c5e4-42b1-9b81-8b9e7bebd60a@motor-comm.com>
Date: Wed, 15 Jul 2026 19:56:53 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: Add driver for Motorcomm Quad 2.5GbE phy
To: Andrew Lunn <andrew@lunn.ch>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 jianmin.wang@motor-comm.com, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jie.han@motor-comm.com
References: <20260714111203.3852126-1-kyle.switch@motor-comm.com>
 <a0e43216-d215-4c81-9954-c5e497b2d50f@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <a0e43216-d215-4c81-9954-c5e497b2d50f@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[motor-comm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:Frank.Sae@motor-comm.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianmin.wang@motor-comm.com,m:ming.xu@motor-comm.com,m:xiaolin.xu@motor-comm.com,m:jie.han@motor-comm.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kyle.switch@motor-comm.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-307737-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[motor-comm.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kyle.switch@motor-comm.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,motor-comm.com:from_mime,motor-comm.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7138575DDA1



On 7/15/26 05:43, Andrew Lunn wrote:
> On Tue, Jul 14, 2026 at 07:12:03PM +0800, Kyle Switch wrote:
>> Add a driver for motorcomm yt8824 quad 2.5G ethernet phy, supports
>> 2.5G/1000M/100M/10M speed.
> 
> Please take a read of:
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> 
> and set the Subject line correctly.
> 
>> +#define REG_MII_MMD_CTRL			0x0D
>> +#define REG_MII_MMD_DATA			0x0E
> 
> include/uapi/linux/mii.h
> 
> #define	MII_MMD_CTRL		0x0d	/* MMD Access Control Register */
> #define	MII_MMD_DATA		0x0e	/* MMD Access Data Register */
> 
> Please don't repeat something which already exists. But i also wounder
> why you need these.
> 
>> +static int ytphy_write_mmd(struct phy_device *phydev,
>> +			   u16 device, u16 reg,
>> +			   u16 value)
>> +{
>> +	int ret;
>> +
>> +	ret = __phy_write(phydev, REG_MII_MMD_CTRL, device);
>> +	if (ret)
>> +		return ret;
>> +	ret = __phy_write(phydev, REG_MII_MMD_DATA, reg);
>> +	if (ret)
>> +		return ret;
>> +	ret = __phy_write(phydev, REG_MII_MMD_CTRL, device | 0x4000);
>> +	if (ret)
>> +		return ret;
>> +	ret = __phy_write(phydev, REG_MII_MMD_DATA, value);
>> +
>> +	return ret;
>> +}
> 
> Why are you reinventing these functions when they already exist?
Ans: Sorry, I didn't notice the existing interface before. next patch, i will remove 
the duplicate functional interfaces include REG_MII_MMD_CTRL, REG_MII_MMD_DATA, and
ytphy_mmd_write api.

>> +
>>  /**
>>   * ytphy_get_wol() - report whether wake-on-lan is enabled
>>   * @phydev: a pointer to a &struct phy_device
>> @@ -3059,99 +3187,1620 @@ static int yt8821_resume(struct phy_device *phydev)
>>  	return yt8821_modify_utp_fiber_bmcr(phydev, BMCR_PDOWN, 0);
>>  }
>>  
>> -static struct phy_driver motorcomm_phy_drvs[] = {
>> -	{
>> -		PHY_ID_MATCH_EXACT(PHY_ID_YT8511),
>> -		.name		= "YT8511 Gigabit Ethernet",
>> -		.config_init	= yt8511_config_init,
>> -		.suspend	= genphy_suspend,
>> -		.resume		= genphy_resume,
>> -		.read_page	= yt8511_read_page,
>> -		.write_page	= yt8511_write_page,
>> -	},
>> -	{
>> -		PHY_ID_MATCH_EXACT(PHY_ID_YT8521),
>> -		.name		= "YT8521 Gigabit Ethernet",
>> -		.get_features	= yt8521_get_features,
>> -		.probe		= yt8521_probe,
> 
> Why are these all stoppering? diff would not remove them unless
> something is changing.
> 

Ans: after double check, no existing code logic has been modified. I guess the possible reason
is that git diff employs the Diff Algorithm, a "context minimization" strategy adopted to 
represent changes in the most compact manner. It consolidates modifications into a single block.

>     Andrew
> 
> ---
> pw-bot: cr

