Return-Path: <netdev+bounces-285013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKDsAuWY+2ladAMAu9opvQ
	(envelope-from <netdev+bounces-285013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 21:39:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6584DFE0F
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 21:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A2F73018AF4
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 19:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76CE33A005;
	Wed,  6 May 2026 19:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SZW5sVt7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f228.google.com (mail-vk1-f228.google.com [209.85.221.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D28231E82F
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 19:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778096086; cv=none; b=pgoeZd9QgjHMlK7amkSBpfoXxl494LDSUE4j+7rxSj0XRsmQRXqB9rF0POcpSWGMviGpiw4xnNviKQVjm9hW7XRpyN9YTTegzH8uIEtrXroq27jFF6WOEgRCKhM+bPEJARNHLPRcwAoNaEBDy97TrPS9NdFmuDx6SrCTcyU6LjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778096086; c=relaxed/simple;
	bh=rnUvZBHfAlAsbf7J3uEwUVJtx0yKWh0YZLjvEYpxrOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qolEZ1kjCjhx1oPRlIsZseeCJsmvH7LCcHRX6DpJdWLlH5Yz1FXDSz8f+3IaAWX6q9imSw90V8EvqsdckGn/2+y0AvB89WkOzc8oB6EDuRFQmR4JLabZjTEJhObJgrRK2RoUxZxvbjXlVVhCJRBAw0fTDg9wW2Do8E/r9ZjBWb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SZW5sVt7; arc=none smtp.client-ip=209.85.221.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f228.google.com with SMTP id 71dfb90a1353d-57524e52a3dso59029e0c.2
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 12:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778096083; x=1778700883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5R2qH7c8Ax43mqThAVF1BATB6A7vPlrphUvLELnDtY=;
        b=c/shQD0iErHUiZ0bDVKwaoz3QUzV1O5u4+NSW195xp7xOvrihnVQuLJEdGvV2S/pw5
         GzfDuFKNs0+rcAX8RR1WVfE5j133fNmiNf8JF72zpC2d60v6QRnzNBkMlSlB1di5k1GD
         WNyVgbvJIYdV+CScNde0NxpebXMf6CjeVB4u/axa4RVGh7ZbQqVu9HJ65VMDlHgGlFko
         EHoGimN9z8p81psDdVCHNvgwo+Quh8dLRHAx+9MRIH3JON417LjxrZ1trS+NgO0vsigk
         q0cWQMTOisXmhtivVjxHf87ShQLdfmLfpE6R0mtb8R8nQP34nWokBOuCto+1qJyGbPSE
         LtOA==
X-Gm-Message-State: AOJu0Yxg8VC02S8YQRw8cEOv7OfW8yunPIAx61tHV72Z/YrbNZtrN4gY
	qjJkYhyqIJvujSq5/g3t8vOIaLEN6+ELsdanViQGRS4aTLBCmZ1YcdrNCOewkQN9ugwqwgPdYF/
	it0Vu/Xl5qNdfVy67m0ZS1wEh++Xntw1NPqYcIDviBJllpCZvsB55JKDMMskLg32yJN4eZz69zq
	vcvuKWyoWpdVAugEAy8rEMuRlZJ2mHXnUgXnPfT8mlHIuNySaUuMjCfaEO4IIZ/Kc43/exbTqAs
	y9PPqNvLw==
X-Gm-Gg: AeBDieteECYTklkCclhJjAhKNY5PsIIQbOoNoMl2N3S2OBRGOYCOKcKLp0HUzsZKmvU
	wYDaqtup18+RagbZ4+hlEmI3pMTh95chaNqLXVfmiN1cNuJBRsvntATHBwK/nhFhe47zeEwzyVy
	iXysYCZbE9hV/JsUH9SAdWYUK3iO9HblZvF2nGaLy5gEK4HHqmTk2T2le2LHVI6i4FJ2nEBCYBY
	lA6qtRYwuHfncxdFEVmEZafDaEW/NjyygPvGvDEbxIglkh8Q5mNEyld31MzeTus4vvPRQdY6nAB
	uf0V9I00BoQhwYu0n3QCMAoj4sbFw7CZZyEJnkBPezlO91pi9bvUKoRgkHGPHOXSWgwUcZ/xqCQ
	FLwzPlHQH/sEowcNu6NuKAgZJQO5px/CwMRCscfqlpR9SvifVkVtufRIR0ZvZNqDlADHr90SC5x
	q1WwVxPKV7epg+SQ==
X-Received: by 2002:a05:6122:3a18:b0:56d:b4d1:3c1e with SMTP id 71dfb90a1353d-575595cd9a9mr2982979e0c.10.1778096083252;
        Wed, 06 May 2026 12:34:43 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-57561e7680csm201687e0c.2.2026.05.06.12.34.42
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2026 12:34:43 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so134005eec.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 12:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778096082; x=1778700882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q5R2qH7c8Ax43mqThAVF1BATB6A7vPlrphUvLELnDtY=;
        b=SZW5sVt7BfQGZJgWeOU8SIQaJ6aMzWqX2AHK0agHWvpFeEoIzr8i2mFqmCr7I5vrTe
         Zl7xq0gORdKMaF4awgOf9CCPvhVQNzIPgL3ryxq3+IMHl7bFePNq2ChZ7qIRUKqt48zi
         4VF03+hBxsw+puhw7OrjddB3luzEAWmWgdf+Y=
X-Received: by 2002:a05:693c:2c01:b0:2d9:db50:c6d6 with SMTP id 5a478bee46e88-2f54d79b988mr2410633eec.21.1778096082040;
        Wed, 06 May 2026 12:34:42 -0700 (PDT)
X-Received: by 2002:a05:693c:2c01:b0:2d9:db50:c6d6 with SMTP id 5a478bee46e88-2f54d79b988mr2410607eec.21.1778096081270;
        Wed, 06 May 2026 12:34:41 -0700 (PDT)
Received: from [10.69.74.94] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56f88f4a4sm4444236eec.17.2026.05.06.12.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 12:34:40 -0700 (PDT)
Message-ID: <ed33329c-13f5-4f2d-8352-b805a07bdefb@broadcom.com>
Date: Wed, 6 May 2026 12:34:40 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: bcmasp: Keep PHY link during WoL
 sleep cycle
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, florian.fainelli@broadcom.com
References: <20260501185625.422361-3-justin.chen@broadcom.com>
 <20260506002536.1521518-1-kuba@kernel.org>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20260506002536.1521518-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 5D6584DFE0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285013-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]



On 5/5/26 5:25 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: bcmasp: Keep PHY link during WoL sleep cycle
> 
> This patch splits the suspend/resume paths so that when WoL is enabled
> the PHY is left running and the MAC is only partially re-initialized on
> resume. phy_stop() is skipped during suspend and phy_start() is replaced
> with a forced relink via phy_trigger_machine() when the MAC was reset.
> 
>> diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
>> index e2b51ec903af..9ffd0dfa5969 100644
>> --- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
>> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> 
> [ ... ]
> 
>> @@ -946,7 +946,8 @@ static void bcmasp_netif_deinit(struct net_device *dev)
>>   
>>   	umac_enable_set(intf, UMC_CMD_TX_EN, 0);
>>   
>> -	phy_stop(dev->phydev);
>> +	if (stop_phy)
>> +		phy_stop(dev->phydev);
> 
> Skipping phy_stop() in the WoL path means phy_stop_machine() and the
> cancel_delayed_work_sync() on phydev->state_queue are no longer executed
> before the ASP clock is disabled in bcmasp_interface_suspend().
> 
> The PHY state machine runs on system_power_efficient_wq, which is not
> WQ_FREEZABLE, so task freeze does not stop it.  If a PHY IRQ fires (or
> the polling timer expires) between clk_disable_unprepare(intf->parent->clk)
> and the matching clk_prepare_enable() on resume, the state machine can
> reach bcmasp_adj_link() via phy_check_link_status() ->
> phy_link_up()/phy_link_down() -> phydev->adjust_link.
> 
> bcmasp_adj_link() reads and writes UMC_CMD, UMC_EEE_LPI_TIMER,
> UMC_EEE_CTRL and RGMII_OOB_CNTRL, which sit behind the disabled ASP
> clock.  Can those accesses hang the bus or return 0xffffffff on these
> SoCs?
> 
> bcmgenet pins phydev->state = PHY_READY during WoL suspend specifically
> to freeze the state machine in a no-op state.  Is an equivalent
> protection needed here?
> 

Will mirror something closer to bcmgenet for v3.

>> @@ -1385,15 +1386,20 @@ int bcmasp_interface_suspend(struct bcmasp_intf *intf)
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
> 
> [ ... ]
> 
>> @@ -1438,17 +1444,34 @@ int bcmasp_interface_resume(struct bcmasp_intf *intf)
>>   	if (ret)
>>   		return ret;
>>   
>> -	bcmasp_core_clock_set_intf(intf, true);
>> -
>> -	bcmasp_resume_from_wol(intf);
>> +	wake = device_may_wakeup(kdev) && intf->wolopts;
>>   
>> -	bcmasp_phy_hw_prepare(intf);
>> +	bcmasp_core_clock_set_intf(intf, true);
>>   
>> -	umac_reset_and_init(intf, dev->dev_addr);
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
> In the wake && !(reg & UMC_CMD_RX_EN) branch (MAC was HW reset during
> suspend), bcmasp_resume_from_wol() is not called.

In this case, the HW is reset. So bcmasp_resume_from_wol() doesn't need 
to restore what bcmasp_suspend_to_wol() did as it was erased.

Same thing for PROMISC. The default state is SW_RESET, so when we force 
the state machine to run again it will reset PROMISC. So everything 
below should be irrelevant. I also verified on resume in this case the 
registers are the same, so we resumed back to the original state.

> 
> bcmasp_suspend_to_wol() unconditionally does two things that live in
> the shared parent register block, not the per-interface UMC block:
> 
> 	wakeup_intr2_core_wl(intf->parent, 0xffffffff,
> 			     ASP_WAKEUP_INTR2_MASK_CLEAR);
> 
> 	if (ndev->phydev && ndev->phydev->eee_cfg.eee_enabled &&
> 	    intf->parent->eee_fixup)
> 		intf->parent->eee_fixup(intf, true);
> 
> The wakeup interrupt mask and the EEE fixup bits (phy_lpi_overwrite in
> ASP_EDPKT_SPARE_REG) are not cleared by a reset that only wipes UMC_CMD.
> 
> In this branch the wakeup IRQ remains unmasked (bcmasp_isr_wol would
> then fire on subsequent MPD/FILT events during normal traffic) and the
> EEE fixup stays asserted.  Should this branch also invoke the parts of
> bcmasp_resume_from_wol() / eee_fixup(false) that live in the shared
> register block?
> 
> Separately, bcmasp_suspend_to_wol() explicitly programs
> UMC_CMD_PROMISC:
> 
> 	reg |= UMC_CMD_RX_EN | UMC_CMD_PROMISC;
> 	umac_wl(intf, reg, UMC_CMD);
> 
> In the wake && (reg & UMC_CMD_RX_EN) fast-resume branch, the only
> writes to UMC_CMD are:
> 
> 	umac_enable_set(intf, UMC_CMD_TX_EN, 1);
> 
> and whatever bcmasp_resume_from_wol() does, which only touches
> UMC_MPD_CTRL and ASP_WAKEUP_INTR2_MASK_SET.  bcmasp_netif_init() calls
> bcmasp_set_rx_mode() which manages ASP_RX_FILTER_MDA but not
> UMC_CMD_PROMISC, and bcmasp_adj_link() only reprograms PROMISC inside
> its if (reg & UMC_CMD_SW_RESET) branch (not taken here).  Since
> old_link/old_duplex/old_pause are preserved across the fast path,
> adj_link's changed flag stays zero and it returns without rewriting
> UMC_CMD.
> 
> Does this leave the MAC stuck in UMC_CMD_PROMISC after every WoL
> resume, until the interface is toggled down/up?
> 
>>   
>>   	bcmasp_netif_init(dev);
>>   
>> -	phy_start(dev->phydev);
>> +	/* If HW was reset, we need to force a relink */
>> +	if (wake && !(reg & UMC_CMD_RX_EN)) {
>> +		mutex_lock(&dev->phydev->lock);
>> +		if (dev->phydev->state == PHY_RUNNING)
>> +			dev->phydev->state = PHY_UP;
>> +		mutex_unlock(&dev->phydev->lock);
>> +		phy_trigger_machine(dev->phydev);
>> +	} else if (!wake) {
>> +		phy_start(dev->phydev);
>> +	}
> 
> The forced-relink branch only demotes PHY_RUNNING -> PHY_UP before
> phy_trigger_machine().  Since phy_stop() was skipped during suspend,
> phydev->state is whatever it was at suspend time, which may instead be
> PHY_NOLINK (cable was unplugged), PHY_HALTED or PHY_ERROR.
> 
> For PHY_NOLINK, _phy_state_machine() runs phy_check_link_status() +
> phy_update_stats() only; it does not trigger _phy_start_aneg() (that is
> the PHY_UP case).  If the HW reset that cleared UMC_CMD_RX_EN also
> touched the PHY chip (shared reset/power domain), autoneg may need to
> be restarted.
> 
> Does this path handle states other than PHY_RUNNING, and does it
> guarantee the PHY is reinitialized and autoneg restarted when the MAC
> has been reset?
> 

Will mirror to be more like bcmgenet in v3. The PHY chip is not reset or 
powered off in the WoL case, so we do not need to restart autoneg. It 
should look similar to the non HW reset case except we need to reprogram 
the UNIMAC.

Thanks,
Justin

>> +
>>   	netif_device_attach(dev);
>>   
>>   	return 0;


