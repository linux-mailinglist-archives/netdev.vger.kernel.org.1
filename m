Return-Path: <netdev+bounces-283008-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHepG3bf82kC8QEAu9opvQ
	(envelope-from <netdev+bounces-283008-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 01:02:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C87DE4A8B0E
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 01:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F4733005D22
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 23:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4922389473;
	Thu, 30 Apr 2026 23:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MOnNKTW1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f225.google.com (mail-dy1-f225.google.com [74.125.82.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB2A37F8C6
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 23:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777590131; cv=none; b=X1Pbzzn4DEu4YPptuZlXuW9GJUPhzIQVxKqJdL//Q75wo0Hn4qsWJvXcs30avoK83nW5CxIR+waKPl8jyn+bbQgU6hizATIw5NIcHLFomqO2mMVPQ5ldUGGYba366AmIUIfFIQDY2qJ3IsyiJpmH/eaOqnXkEqdFjKi08qwmRLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777590131; c=relaxed/simple;
	bh=4/8lnxUTYpYRP6cjn7kFqKxNNGXeu+aLqyxkxxChz4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=krUzFLD+ngRhpZDEd0XsX42idrX/vdImqSo15cA/++/d5zQ/Z9wWMCrlV6ibr1O2ViI0WMA5iXoKBl4+PQ60HgeXCdsgr9tBFAVtgh97/jyHnCh2kdcJ/6Zye4gQNck0TGNL74ZLDzySB5RL2MsXa+m3vQP1qomcqXxoG5PUG0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MOnNKTW1; arc=none smtp.client-ip=74.125.82.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f225.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso1721807eec.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 16:02:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777590129; x=1778194929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJ81Pef+B3Dc5BnrdQj2nwCfvwT9t1jIFAWHa4CEN/k=;
        b=rFKr5df0lbH9jnwke0YxnxAHHq2aAT7E1DfoZqm+Y49+r8y35gp60VK3l2OKlhIjPF
         cYw12dh50400oL6AZIOMEkEsJ18aE1uJFUft04122ZQ4dyZY06zvNJSw3NxMJ0uSvX+y
         4+bmeRZH5fqIaUfaOfmg9diXQIUnpjrJ2V29HEPLfj+fCaWxqOostE/id+drcv70X4jW
         Tb1Fe3Jtry40+txgUF0mPZJKnwyZNsVcvsj2hhtJxzu9L4F+w8UnK2Kq90FuKRkv720O
         VYPvfW4OD7b/y27IyOqZqJiRW6XBmR7pgxyz2NR+3V3Y6Xqfb9CfAykA1Q4BbVOPDU/6
         7fLA==
X-Gm-Message-State: AOJu0Yzu9OmTl2ZlQDg3EsDE2iNCqQunw91vDyay9pRfLiEsD1nVlJ2R
	b9y8GSfwfu9IQAWRA1UK2PxsQDAbhPWsnB8Nn8SO9HYkRSf5Q09hMRFoZssXJicjzXUCa4j4jJE
	Lwd2ZNvXaO6qZ68pC9Os0Xy2tlb4MGRYcjCXED8CqK0UY6DBW3RSKGolugaNwC43TxfdG3iGVJD
	CAKujK0Oz5TdZu1Hyo8ldPZKtx2H7ytPeJFGm1OABDWq6B7aW+c1b324TZP6UfrvEOdwc52f0aO
	nZ7ZzcpPA==
X-Gm-Gg: AeBDiesi0/kQJAa0aihVfG7tIPANLCobgEb/twAfciGqVQ00QrW0S5wF55Md/i8dqO8
	1owNz5sh3TZ+MpFHi//oOqmM/Qbmy7vNrZIYU3j2tw/P4rW2nAkiI/S4l3Ql5VblJZpidbIOvuP
	3iG8dcWTd2MEcP2T3fADUwjlM9jD6gapjabHYaMz57EFwGr6C6XEx6EHcZUXdVLgvkugWRdI+94
	si8ig9un7A2/HURVsTWHxr9LrIHMxWJS+uiYzTLWtwCbbcBbIMtH0HVjfVg/Xxo4LlfigjGv5ef
	VKfrnUDf7+13bSpSw7MQ9VtFuuodqFzLUrBQnVuJ+tKBaUOxVTLAhKv6kNyxsbCHdweCXXWiVcs
	5v7GkAYbbqIp1h+Zerb/4tvaZ/iVWy1uJCrLAC6EUVByZuSRRPYfakhWln5z9M2+fL3jcCjLJvH
	G3I2ZjF6MH83ws9p6xjhFCGpsDT5G0qHxPkVaVQd5VH2jbe+8UD2fMWAeW65CE1X3Pog==
X-Received: by 2002:a05:7300:220e:b0:2c9:ee15:a0d6 with SMTP id 5a478bee46e88-2ed3fd62fabmr2671506eec.29.1777590128778;
        Thu, 30 Apr 2026 16:02:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2ee39fec315sm110403eec.9.2026.04.30.16.02.08
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2026 16:02:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2ee34588671so729784eec.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 16:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777590127; x=1778194927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GJ81Pef+B3Dc5BnrdQj2nwCfvwT9t1jIFAWHa4CEN/k=;
        b=MOnNKTW1ePouS4yF2GbL5R6kxqkIiFZzjwWPm3oBF3DwsMhx4JCy+6lrlZvr9xtlOw
         XnW+WjZSg2/GNZD81Oahd9W53dvZhv2bWaxB5eliMfgTk4Y9YwYiCQEOyNxRi4k7Ku09
         DYoPV6d7mWIWp2iPub9d+3UVim6laOfaawkPo=
X-Received: by 2002:a05:7301:6009:b0:2ed:e14:42e5 with SMTP id 5a478bee46e88-2ed3fd663c9mr2066845eec.30.1777590126728;
        Thu, 30 Apr 2026 16:02:06 -0700 (PDT)
X-Received: by 2002:a05:7301:6009:b0:2ed:e14:42e5 with SMTP id 5a478bee46e88-2ed3fd663c9mr2066819eec.30.1777590125615;
        Thu, 30 Apr 2026 16:02:05 -0700 (PDT)
Received: from [10.14.6.173] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3bb60811sm2004491eec.24.2026.04.30.16.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 16:02:04 -0700 (PDT)
Message-ID: <e13eb2f3-ed6e-4e2d-8f01-f108afa4f4df@broadcom.com>
Date: Thu, 30 Apr 2026 16:02:03 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: bcmasp: Keep PHY link during WoL sleep
 cycle
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, florian.fainelli@broadcom.com
References: <20260428220858.2076469-3-justin.chen@broadcom.com>
 <20260429232030.2187222-1-kuba@kernel.org>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20260429232030.2187222-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: C87DE4A8B0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283008-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]



On 4/29/26 4:20 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email says "Blindly sending out since there will be a repost,
> anyway."
> ---
> net: bcmasp: Keep PHY link during WoL sleep cycle
> 
> We currently more or less restart all the HW on resume. Since we also
> stop the PHY, it takes a while for the PHY link to be re-negotiated on
> resume. Instead of doing a full restart, we keep the HW state and the
> PHY link, that way we can resume network traffic with a much smaller
> delay.
> 
>> diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
>> index aff0a6d84126..bab2a4f82e4e 100644
>> --- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
>> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> [ ... ]
>> @@ -1383,15 +1384,20 @@ int bcmasp_interface_suspend(struct bcmasp_intf *intf)
>>   {
>>   	struct device *kdev = &intf->parent->pdev->dev;
>>   	struct net_device *dev = intf->ndev;
>> +	bool wake;
>>   
>>   	if (!netif_running(dev))
>>   		return 0;
>>   
>>   	netif_device_detach(dev);
>>   
>> -	bcmasp_netif_deinit(dev);
>> +	wake = device_may_wakeup(kdev) && intf->wolopts;
>>   
>> -	if (!intf->wolopts) {
>> +	bcmasp_netif_deinit(dev, !wake);
>> +
>> +	if (wake) {
>> +		bcmasp_suspend_to_wol(intf);
>> +	} else {
>>   		bcmasp_phy_hw_unprepare(intf);
>>   
>>   		/* If Wake-on-LAN is disabled, we can safely
>> @@ -1400,9 +1406,6 @@ int bcmasp_interface_suspend(struct bcmasp_intf *intf)
>>   		bcmasp_core_clock_set_intf(intf, false);
>>   	}
>>   
>> -	if (device_may_wakeup(kdev) && intf->wolopts)
>> -		bcmasp_suspend_to_wol(intf);
>> -
>>   	clk_disable_unprepare(intf->parent->clk);
> 
> If wake is true, phy_stop() is skipped during bcmasp_netif_deinit().
> This leaves the phylib state machine active and polling on its delayed
> workqueue.
> 
> At the end of bcmasp_interface_suspend(), the main MAC clock is
> unconditionally disabled via clk_disable_unprepare(intf->parent->clk).
> 
> If the PHY state machine executes while this clock is disabled, will it
> attempt to access PHY registers over the MDIO bus, resulting in a
> synchronous external abort (bus fault) or kernel panic?
> 
> Could the active state machine also concurrently invoke the MAC's
> adjust_link callback while bcmasp_interface_resume() is executing,
> causing a data race on MAC registers?
> 

Just tested this. Added an infinite loop after we call 
clk_disable_unprepare() and don't see the state machine running, so I 
think we are good here.

>>   	return 0;
>>   }
>> @@ -1426,8 +1429,11 @@ static void bcmasp_resume_from_wol(struct bcmasp_intf *intf)
>>   
>>   int bcmasp_interface_resume(struct bcmasp_intf *intf)
>>   {
> [ ... ]
>> +	/* The interface might be HW reset in some suspend modes, so we may
>> +	 * need to restore the UNIMAC/PHY if that is the case.
>> +	 */
>> +	reg = umac_rl(intf, UMC_CMD);
>> +	if (wake && (reg & UMC_CMD_RX_EN)) {
>> +		umac_enable_set(intf, UMC_CMD_TX_EN, 1);
>> +		bcmasp_resume_from_wol(intf);
>> +	} else {
>> +		bcmasp_phy_hw_prepare(intf);
>> +		umac_reset_and_init(intf, dev->dev_addr);
>> +	}
> 
> If wake is true but the MAC hardware was reset (reg & UMC_CMD_RX_EN
> is false), the code branches to the else block and skips calling
> bcmasp_resume_from_wol().
> 
> Since bcmasp_resume_from_wol() is responsible for reversing the WoL
> configuration applied during suspend (like restoring the EEE fixup state
> and masking the wakeup interrupt), does skipping this teardown leave the
> wakeup interrupt unmasked during normal operation and risk an interrupt
> storm?
> 

In the case that the MAC hardware is reset, there is no WoL 
configuration to reverse since it was HW reset. Interrupts are also 
reset, so the HW default of everything being masked means this isn't an 
issue.

>>   	bcmasp_netif_init(dev);
>>   
>> -	phy_start(dev->phydev);
>> +	/* If HW was reset, we need to force a link re-negotiation */
>> +	if (wake && !(reg & UMC_CMD_RX_EN)) {
>> +		phy_restart_aneg(dev->phydev);
> 
> If the user has explicitly configured forced speed and duplex with
> autonegotiation disabled, will this unconditional call to
> phy_restart_aneg() override the user's configuration? It appears to
> enable autonegotiation without checking if phydev->autoneg ==
> AUTONEG_ENABLE.
> 
> Also, because phy_stop() was skipped during suspend, the PHY state
> machine is still actively running in the background. Does calling
> phy_restart_aneg() without holding phydev->lock create a data race
> with the concurrent PHY state machine?
> 

Will fix. I think need to just put the phy state back to PHY_UP state 
and have the state machine take care of relinking whatever the 
configuration is set at.

Justin

>> +		phy_trigger_machine(dev->phydev);
>> +	} else if (!wake) {
>> +		phy_start(dev->phydev);
>> +	}
>>   
>>   	netif_device_attach(dev);


