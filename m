Return-Path: <netdev+bounces-283366-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEDWGw6A9WmRLwIAu9opvQ
	(envelope-from <netdev+bounces-283366-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 06:39:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C14D74B0E9D
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 06:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 152C630182BC
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 04:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D684296BA9;
	Sat,  2 May 2026 04:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="p7Vz9aBW";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="F/slKn4p"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D639D19C54E;
	Sat,  2 May 2026 04:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777696779; cv=none; b=EjYa65mvB3QxwlO9YBq8kst01gXoMdmRN5KuPCI8jbOnZhLLuNMCKyq1FqkYiJ+Yc0As00mrjFOLOAqDi2KAgx7F9AiqPvOIqxiaGo6UW7aOsCb02yxNXKfHVXgxPloytHuOuwjf2gru/MECT7UtitAtWt71RT1GL9zRMQFj9j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777696779; c=relaxed/simple;
	bh=vtXr8sWoxwMmxjqw362Df2/NstKNzJVooYGDc8KCzZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sM5qg5U0O8YFSfVIBS1ERYFCsCQcxdmS1xIioK6pfjT1AAFHKKnXRdSl0ekTs3USmoOAEmvIq1iYusGE5xqBx39tOcefh1smWlEgdnjnQT/TEBxnWi0+gxoaWXBN7Jjq0dpX7LkqYTo8R5jXJQ7slZSaRTbaA5Q1zKj1tHFBunw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=p7Vz9aBW; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=F/slKn4p; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777696776;
	bh=vtXr8sWoxwMmxjqw362Df2/NstKNzJVooYGDc8KCzZg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p7Vz9aBWrP6JZSksMtVkX1kkNrkYYQaYo0ng1Akj0g2VHBgMWWWQD3HvQa4Pe0gPv
	 PVpRz5oCgBHw11u6DjEL71RnCmDXyIDHVM2W+qNSaaV/cYwCo4hp4oLToFhLZ4xojW
	 OD6LLax4B/ZQKInD6NNlxSbqzQ77nq/ZL5obWtTi7zsmfjZK2ni7ztI1zo99/M0iis
	 7RNceJ0jJW0skY5RFub3xhyaTDXFMNdmRhnAEURr3zSs754r+pJhXN8k5lJAEJTXbH
	 5p3i/t93Xhnuf0S1EueucfrYXEnjWWMzuGcIf6yAWR6t/OVj2YDTGIfgzWRKWJDZ6L
	 x8wn2LFRkeqhw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 29E61482AC; Sat,  2 May 2026 04:39:36 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777696773;
	bh=vtXr8sWoxwMmxjqw362Df2/NstKNzJVooYGDc8KCzZg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F/slKn4paVcbb71j1rLs8o1+Y1bP0cmWNifmnZ75bomKDJNkrM1G0tUzFooQcvLQc
	 PLopxb3HzUpSqJhyuX5YhRCWeH/XOOHS+5D6bLLi5WKzO0iALOYQTwulxBJ9B+h0Kd
	 zuKJiuHuKNdqiFN+r8c49Yz4FwlX3DC5VsJYYVL44ewWVyF5ikXmUNGYH7sEllFDRV
	 gu1xv4Nim3yB2c5OX71jMzJL4h7vFfJ8+M+MlaniuhFSWCxNcbkqtEvCOwcRYQKyYD
	 qocNLtcSMbl6ngz0QQrPTZIRmQvGGm2J3xsf6t+Qi9hU1Mq/N2G/X2j4VWkEYswRTj
	 ZKoV5c4K4S62Q==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 3FE04412CF;
	Sat,  2 May 2026 04:39:33 +0000 (UTC)
Message-ID: <2982ff2d-688d-4a21-845b-91f372336a3e@birger-koblitz.de>
Date: Sat, 2 May 2026 06:39:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/4] r8152: Add support for the RTL8159 chip
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, hsu.chih.kai@realtek.com
References: <20260429-rtl8159_net_next-v2-2-bab3cd4e4c66@birger-koblitz.de>
 <20260501011558.3154185-1-kuba@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260501011558.3154185-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C14D74B0E9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-283366-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[birger-koblitz.de:dkim,birger-koblitz.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 01/05/2026 3:15 am, Jakub Kicinski wrote:
> The commit subject says RTL8159 is being added, but the body reads
> "The RTL8157 re-uses the packet descriptor format introduced with the
> RTL8157 ..." and later "Add support for the USB device ID of Realtek
> RTL8157-based adapters." Should these occurrences of RTL8157 actually
> be RTL8159?

Both are typos and RTL8159 was meant. Will be fixed in v3.

> 
>>      Most of the addiitonal code is added in r8157_hw_phy_cfg() to configure
>                  ^^^^^^^^^^
> 
> Typo: addiitonal.

Will fix.

> 
>>      Add support for the USB device ID of Realtek RTL8157-based adapters. Detect
>>      the RTL8159 as RTL_VER_17 and set it up.
> 
> The new entry in rtl8152_table is 0x815a, which breaks the earlier
> 0x815N-for-RTL815N naming convention (0x8157 for RTL8157, etc.). Could
> the commit message explain why the RTL8159 ships with product id
> 0x815a?

Will fix.

> 
>> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
>> index 01e65d845f87..2a07dde289e2 100644
>> --- a/drivers/net/usb/r8152.c
>> +++ b/drivers/net/usb/r8152.c
> 
> [ ... ]
> 
>> @@ -6894,7 +6903,7 @@ static void rtl8156_down(struct r8152 *tp)
>>   			  PLA_MCU_SPDWN_EN);
>>   
>>   	r8153b_u1u2en(tp, false);
>> -	if (tp->version != RTL_VER_16) {
>> +	if (tp->version < RTL_VER_16) {
>>   		r8153_u2p3en(tp, false);
>>   		r8153b_power_cut_en(tp, false);
>>   	}
> 
> rtl8156_down() is converted from "!= RTL_VER_16" to "< RTL_VER_16" so
> that RTL_VER_17 takes the same path as RTL_VER_16. rtl8156_up() is
> wired as ops->up for RTL_VER_17 in rtl_ops_init() but still uses
> "!= RTL_VER_16" / "== RTL_VER_16" checks that were not converted.

This was simply forgotten. The code-path for the RTL8159, i.e. 
RTL_VER_17 should be the same as for the RTL8157 (RTL_VER_16), will fix 
rtl8156_up() accordingly.

> The rest of the driver organizes helpers by chip family (r8152_,
> r8153_, r8156_, r8157_) and the commit message describes the RTL8159
> as reusing the RTL8157 scaffolding. Is the r8159_ prefix on this
> single helper intentional, or would r8157_wait_backup_restore() (or
> similar) fit better?

The prefix is intentional, since the function is only used for the
RTL8159.

> 
> Also, poll_timeout_us() is invoked with a 200 us poll interval and a
> 2000 us overall timeout, giving roughly ten iterations before the
> error path fires. Other GPHY-related waits in the driver allow up to
> the order of seconds. Is 2 ms known to be sufficient for the
> backup-restore handshake on RTL8159 across suspend/resume and on
> slower hosts?

Experimentally, the function returns always on the first iteration, 
which is the reason for the short poll interval. A safety factor of 10 
appears to be relatively generous. The out-of-tree code was busy waiting 
for 100 iterations without any delay. The polling in wait_cmd_ready() 
waits for up-to 20ms. Since it does not hurt and to be on the safe side, 
I will change the total poll time to 20ms, here, too.

> 
>> @@ -8184,14 +8389,14 @@ static void r8156_init(struct r8152 *tp)

> Later in the same function:
> 
> 	if (tp->version != RTL_VER_16)
> 		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
> 				  PLA_MCU_SPDWN_EN);
> 
> Was this site meant to be converted to "< RTL_VER_16" along with the
> others? As written, RTL_VER_17 clears PLA_MCU_SPDWN_EN during init,
> while RTL_VER_16 does not.

Indeed, this was an oversight, it should have been also converted to 
"<". Will fix.

> 
> [ ... ]
> 
>> @@ -8294,7 +8505,10 @@ static void r8156_init(struct r8152 *tp)
>>   	set_bit(GREEN_ETHERNET, &tp->flags);
>>   
>>   	/* rx aggregation / 16 bytes Rx descriptor */
>> -	if (tp->version == RTL_VER_16)
>> +	if (tp->version == RTL_VER_17)
>> +		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
>> +				  RX_AGG_DISABLE | RX_DESC_16B | BIT(11));
>> +	else if (tp->version == RTL_VER_16)
>>   		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL, RX_AGG_DISABLE | RX_DESC_16B);
> 
> Every other USB_USB_CTRL bit written in this driver uses a named
> macro (CDC_ECM_EN, RX_AGG_DISABLE, RX_ZERO_EN, RX_DESC_16B). Could
> BIT(11) be given a symbolic name so future multi-version handling of
> this register stays self-describing?

Unfortunately, BIT(11) just appears here, for the RTL8159 in the 
out-of-tree code, without any further explanation. For BIT(10) = 
RX_DESC_16B I guessed the name from the comment. That bit appears for 
both chips, but BIT(11) just is there for the RTL8159, while the comment 
stays the same. Any guess could turn out to be misleading.

> 
> [ ... ]
> 
>> @@ -9690,6 +9904,29 @@ static int rtl_ops_init(struct r8152 *tp)
>>   		r8157_desc_init(tp);
>>   		break;
>>   
>> +	case RTL_VER_17:
>> +		tp->eee_en		= true;
>> +		tp->eee_adv		= MDIO_EEE_100TX | MDIO_EEE_1000T | MDIO_EEE_10GT;
>> +		tp->eee_adv2		= MDIO_EEE_2_5GT | MDIO_EEE_5GT;
>> +		ops->init		= r8156_init;
>> +		ops->enable		= rtl8156_enable;
>> +		ops->disable		= rtl8153_disable;
>> +		ops->up			= rtl8156_up;
>> +		ops->down		= rtl8156_down;
> 
> ops->up is wired to rtl8156_up() here, but rtl8156_up() still checks
> for RTL_VER_16 exclusively at the sites noted above. See the
> rtl8156_down() hunk for the pattern that appears to be intended.

This is fixed, see above.

> RTL_VER_17 sets rx_buf_sz to 48 KiB and enables support_10000full,
> but the max_mtu switch in rtl8152_probe() does not include
> RTL_VER_17:
> 
> 	case RTL_VER_12:
> 	case RTL_VER_13:
> 	case RTL_VER_15:
> 	case RTL_VER_16:
> 		netdev->max_mtu = size_to_mtu(16 * 1024);
> 		break;
> 	...
> 	default:
> 		netdev->max_mtu = ETH_DATA_LEN;
> 		break;
> 
> Should RTL_VER_17 also select the 16 KiB max_mtu case so jumbo frames
> are available on the new 10 Gbit chip?

Yes, this was an oversight. Will be fixed.

> 
> Separately, rtl8156_enable() is set as ops->enable for RTL_VER_17 but
> the USB_RX_AGGR_NUM reset is guarded by
> "tp->version >= RTL_VER_12 && tp->version <= RTL_VER_16", so
> RTL_VER_17 does not execute it. Is that intended given RTL_VER_17
> otherwise shares the RTL_VER_16 descriptor/aggregation plumbing
> (r8157_desc_init(), and the USB_USB_CTRL aggregation bits cleared in
> r8156_init() for RTL_VER_17)?
> 
> [ ... ]
RTL_VER_17 should be included in that range. Will fix.


