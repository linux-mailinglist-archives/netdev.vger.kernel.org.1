Return-Path: <netdev+bounces-283011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEMFE7bk82kK8gEAu9opvQ
	(envelope-from <netdev+bounces-283011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 01:24:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8224A8CA0
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 01:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4ED48300BBB7
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 23:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BF238239B;
	Thu, 30 Apr 2026 23:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KynUS+1K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7C93C13E3
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 23:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777591476; cv=none; b=Dav6dLSdwmcD2cXxo1L5UAtmT+KmpT/qsXiNhPQD694oAQdGMUxh47mPof1juNQ+Dg0ua4n8h+GgVOexlMksQOEaEfpRcro6dPv+LfjkRAzdtBlZJ3xWku1m7NDjKXF7I6WOlcYxU22YMD6kUc0m8tx10DP/jdq8uYep6ED0yNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777591476; c=relaxed/simple;
	bh=GcJOJaUsIgdRMlN5SGMwgv9YpwwuAB1UAnPA4o6H528=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+PN20bsSFwZxIloeW6yd8vQ78i7YIArWv13XgaQMNzInKc2YpHaObu/dqQduUBx1GVHmwCaGFPS+lRq/NmrwkdxzDIwE+kaXqW7t53R+G7ukmTaahnlLgb2lAY0G0S/UuGXUvcwARBM0EQ/ZyKJ5SJs0knS/6d7fUvZcMsMro8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KynUS+1K; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-35d9f68d011so937207a91.2
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 16:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777591474; x=1778196274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qGX2lKhnwcGqmmaEkT04wPBPp3ir4xuIODYnD95jd0=;
        b=UvH/ZZWfl8uJceerVktfrV6Hb2GYGiY910drZoXEkuDFSrko7uI/qyvepX9NanMln6
         +PcAya2rMLd0/3S7uipBjAFeJkmTdlKt5UI1QF235/LStycXRuLEV1r2k6iAQKtsXIc3
         CPhAnqaC2e6T9rMAWZCnOuuC0P5bg5J0/EbWp8RGXiCdm4jsGean3Hk4d4nZPGOP4mB8
         4RDuQhyHdDsuSrfTwWW5uuljdhuFpVyTBtwRg7rX449dm/aioIJguABk7MccQuEG+C/a
         ED8JWZiJbpjBYGWJAGOQaFFn3KzyUgp7JuPKdznw60O9vSJjr9L5v0ejRzdq5cNRwUVM
         E5ZQ==
X-Gm-Message-State: AOJu0YwHnDhyElGQ5BN0yLGFxIdt0MzN3aCq294AwmlQiBKvmrxDrFPc
	FTNMjqPPqtiojNvSjs9qU7BdhfyiMLTB1NnQFqvclHrHZnIXMOMsyIu5Sye3u6ngi6DYFfjdnaP
	cSTAh99QV26EhsibbsCUTGNjPzwSfGiRG6h2yGSJBFQrF9BhIKMwYfLiAVPFfPxbfLUjsK17I+p
	WPn28WbwBLV9VPh0E9aGbwqJoXy0BrqxT3LL5m689M6DvNpzjswJmoY5SUHilljOFIDi3WwHKMn
	MynSq1UKw==
X-Gm-Gg: AeBDieuAsHOHFdOjH0VcxW9RHMH7ID+OPESpMLWKjvsyoY4CfC/JS9HhB0RXlc0NQ22
	b4wDivbm6U1J7qFc4mXowfMpL1aMYM5eHSjBZ+yVnbpZw+D/EAlxcM48Q6326XbIB28KcrYaqnR
	rEr/ieU3LpR2jHndwaj8dwPVWqelrzLtmsw+r4d8exN5KefClQXacwLXaFjo3tp434NdQHNihLD
	8pTEuYo1R5jvmAfYsavFPdYcmcsVtR8Vvsdi0xx1fg6WbsPTYF5RHWMJWU0GZzuTaM0Ym/fiJSi
	oLBBY9jrTE4qJIK3/E5su8nIAOZDG+bI24t+kWhzM6I4bsdtfZ27EgEFRXfAKj2RqLIQ5jtBLcD
	CISdA42LjvoFzFONlBeRidiajBit+Cq+24qRbjxEkoNzSJnZ9QTzVG6t3MmQebSkziHur8pQNFV
	ojARcNd0SHuPTpKptRJ5Vypv79I7kxgGRoelaukNMYYXYwwGJ7xFDHfCuLpBuNFNx0MA==
X-Received: by 2002:a17:902:c3d2:b0:2ae:cb0e:fd59 with SMTP id d9443c01a7336-2b9a2301139mr37623235ad.8.1777591473884;
        Thu, 30 Apr 2026 16:24:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b9cab67bbfsm762935ad.29.2026.04.30.16.24.33
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2026 16:24:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1275c6fc58aso2926896c88.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 16:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777591472; x=1778196272; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7qGX2lKhnwcGqmmaEkT04wPBPp3ir4xuIODYnD95jd0=;
        b=KynUS+1KAVN6S2e7LQXf6Jv1KfDRMTclCb/O7UHXiyk0xrJpDpdQXKE0pDWJ82wa7B
         5V1mrOmAA1V6dWG5BCi7cUEeP4nnm0bmV+ygVeE4YAwxKsxe3t5eqnFZe+eaJI2NZjkq
         mBPpo03EDrVUggu8PVZLkiOp92vvqD/Ly3yCo=
X-Received: by 2002:a05:7022:100b:b0:12d:b329:987d with SMTP id a92af1059eb24-12deacdfe84mr1958626c88.24.1777591472252;
        Thu, 30 Apr 2026 16:24:32 -0700 (PDT)
X-Received: by 2002:a05:7022:100b:b0:12d:b329:987d with SMTP id a92af1059eb24-12deacdfe84mr1958618c88.24.1777591471610;
        Thu, 30 Apr 2026 16:24:31 -0700 (PDT)
Received: from [10.14.6.173] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df8431037sm629654c88.12.2026.04.30.16.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 16:24:30 -0700 (PDT)
Message-ID: <0b34c7af-a348-4222-8741-0567659d64ce@broadcom.com>
Date: Thu, 30 Apr 2026 16:24:29 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: bcmasp: Divide init to allow partial
 bring up
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, florian.fainelli@broadcom.com
References: <20260428220858.2076469-2-justin.chen@broadcom.com>
 <20260429232021.2186988-2-kuba@kernel.org>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20260429232021.2186988-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: DE8224A8CA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-283011-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]



On 4/29/26 4:20 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email says "Blindly sending out since there will be a repost,
> anyway."
> ---
> net: bcmasp: Divide init to allow partial bring up
> 
> To prepare for a partial bring up of the interface during resume,
> we break apart the bcmasp_netif_init() function into smaller chunks
> that can be called as necessary.
> 
>> diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
>> index ec63f50a849e..aff0a6d84126 100644
>> --- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
>> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> [ ... ]
>> -static void umac_reset(struct bcmasp_intf *intf)
>> +static void umac_reset_and_init(struct bcmasp_intf *intf,
>> +				const unsigned char *addr)
>>   {
>> +	struct phy_device *phydev = intf->ndev->phydev;
>> +	u32 mac0, mac1;
>>   
>>   	umac_wl(intf, 0x0, UMC_CMD);
>>   	umac_wl(intf, UMC_CMD_SW_RESET, UMC_CMD);
>>   	usleep_range(10, 100);
>>   	/* We hold the umac in reset and bring it out of
>>   	 * reset when phy link is up.
>>   	 */
>> -}
>>   
>> -static void umac_set_hw_addr(struct bcmasp_intf *intf,
>> -			     const unsigned char *addr)
>> -{
>> -	u32 mac0 = (addr[0] << 24) | (addr[1] << 16) | (addr[2] << 8) |
>> -		    addr[3];
>> -	u32 mac1 = (addr[4] << 8) | addr[5];
>> +	umac_wl(intf, 0x800, UMC_FRM_LEN);
>> +	umac_wl(intf, 0xffff, UMC_PAUSE_CNTRL);
>> +	umac_wl(intf, 0x800, UMC_RX_MAX_PKT_SZ);
>> +
>> +	mac0 = (addr[0] << 24) | (addr[1] << 16) | (addr[2] << 8) |
>> +		addr[3];
>> +	mac1 = (addr[4] << 8) | addr[5];
>>   
>>   	umac_wl(intf, mac0, UMC_MAC0);
>>   	umac_wl(intf, mac1, UMC_MAC1);
>> +
>> +	/* Reset shadow values since we reset the umac */
>> +	intf->old_duplex = -1;
>> +	intf->old_link = -1;
>> +	intf->old_pause = -1;
>> +	phydev->eee_cfg.tx_lpi_timer = umac_rl(intf, UMC_EEE_LPI_TIMER);
>>   }
> 
> Since UMC_CMD_SW_RESET was just asserted above, won't reading
> UMC_EEE_LPI_TIMER here return 0 or a hardware default value, effectively
> overwriting the bootloader-configured EEE TX LPI timer?
> 
> Also, since umac_reset_and_init() is now called unconditionally during
> bcmasp_interface_resume(), does this dangerously overwrite
> phydev->eee_cfg.tx_lpi_timer without holding mutex_lock(&phydev->lock)?
> This seems like it could create a data race with concurrent accesses, for
> example from ethtool.
> 

Hmm yea, let me remove this and put into bcmasp_open. We only want to 
get the timer value on open, not every suspend cycle.


> [ ... ]
>> +static void bcmasp_netif_init(struct net_device *dev)
>> +{
>> +	struct bcmasp_intf *intf = netdev_priv(dev);
>>   
>>   	bcmasp_init_tx(intf);
>>   	netif_napi_add_tx(intf->ndev, &intf->tx_napi, bcmasp_tx_poll);
> 
> This existed prior to this patch, but since bcmasp_netif_init() and
> bcmasp_netif_deinit() are called directly from bcmasp_interface_resume()
> and bcmasp_interface_suspend() (which execute asynchronously without
> rtnl_lock), can modifying the global dev->napi_list via netif_napi_add_tx()
> and netif_napi_del() cause a race condition with concurrent list readers?
> 
> Suspend and resume paths typically rely on napi_enable() and napi_disable()
> rather than adding and deleting the NAPI structures entirely.
> 

Not sure about this, but such a fix shouldn't be part of a restructure 
commit like this one. So I'll investigate further and fix in another 
patch if needed.

> [ ... ]
>> @@ -1454,17 +1436,19 @@ int bcmasp_interface_resume(struct bcmasp_intf *intf)
>>   	if (ret)
>>   		return ret;
>>   
>> -	ret = bcmasp_netif_init(dev, false);
>> -	if (ret)
>> -		goto out;
>> +	bcmasp_core_clock_set_intf(intf, true);
>>   
>>   	bcmasp_resume_from_wol(intf);
>>   
>> +	bcmasp_phy_hw_prepare(intf);
>> +
>> +	umac_reset_and_init(intf, dev->dev_addr);
>> +
> 
> If Wake-on-LAN is disabled, bcmasp_interface_suspend() un-prepares the PHY
> by asserting reset and disabling clocks. By calling bcmasp_resume_from_wol()
> before bcmasp_phy_hw_prepare(), if EEE is enabled and invokes eee_fixup(),
> won't the MDIO access timeout or cause a bus error because the PHY hardware
> isn't prepared yet?
> 

eee_fixup() doesn't use a MDIO accesses.

> Additionally, won't any WOL state changes (like clearing
> UMC_MPD_CTRL_MPD_EN) be immediately wiped out by the MAC software reset
> inside the subsequent umac_reset_and_init() call?
> 

Yes, but this was the original (incorrect) logic and as mentioned below, 
it is required in the next commit where we do not always reset the UNIMAC.

Justin

> I noticed this is fixed later in the series by commit 6994d859a69dd
> (net: bcmasp: Keep PHY link during WoL sleep cycle), but does leaving it
> like this here break bisection?
> 
>> +	bcmasp_netif_init(dev);
>> +
>> +	phy_start(dev->phydev);
>> +
>>   	netif_device_attach(dev);
>>   
>>   	return 0;
>> -
>> -out:
>> -	clk_disable_unprepare(intf->parent->clk);
>> -	return ret;
>>   }


