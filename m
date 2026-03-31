Return-Path: <netdev+bounces-273683-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACOiJv/sy2m5MgYAu9opvQ
	(envelope-from <netdev+bounces-273683-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:49:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 632ED36C13A
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D74973111623
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137D4423A95;
	Tue, 31 Mar 2026 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="EsFS25m3";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="2w+5FIGK"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F31423173;
	Tue, 31 Mar 2026 15:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971505; cv=none; b=GdmQE7qj4Pu/9rQxsMIOmiL+c+esksHLkltr0okxnRJTGFCa070ijBZ/+c1q/7kbUwTJzDm+AzgazSAB0YMk1owlgSSfXkB5En6ZRfqje8bIrgsRR8NL9qFyTloH5mfJV21lxokwZBgHF8Yh2vDy1f2Ll+ZsYylKl4m2cdZl68c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971505; c=relaxed/simple;
	bh=sha5iUK+ld7auJ1XsQIL2NCgXgH7GuElZWKOLIy6d48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NE2p8XijzNQlSvMSoHwszIYaM8k+ywG6Q8SWv5l+ffkzxhloYoTDlqqgUp2hNzE6+UkLSFajDNrsZRwSiLoN9siO2hDaH50IwmZL45X9sJTm2HbKhWoAGQfEVTJNViHygyyYu1w8TNNl9V4y5lFek0y8nFgvQ4N180w4pVkTLJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=EsFS25m3; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=2w+5FIGK; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1774971496;
	bh=sha5iUK+ld7auJ1XsQIL2NCgXgH7GuElZWKOLIy6d48=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EsFS25m3fA7jYymqF1oFYslXKPxhG40OEqFP2FWS4k2bTtxjNGTQH953ReQohGtgl
	 R17xTasDUQ1E2WWVGf3Mf77kdn2ZETFNeI/pcsDTmT5uuJu+VMz9ygfkjQflWfMSMA
	 NMDpS6WUh/D+4WF9Br/vTe0vCvM+/mz9m4kOThyj4a15KV8/NIUXneLoONZ3Uyrg0P
	 EfqK3mjVMEjxc68qIiJO6WIGZJrlzrwph0w7FEn7pI5b4sVFAjU8SWu2hVKkZ8Yt5K
	 HrvBDP4qIQ+FYaC8dta0OzYzOVqG/cnizmB9kcUwKTDxY7/cRAUkzjTj5qSrAHG/0k
	 /1GAzPM8E1kuQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 38DA0406F0; Tue, 31 Mar 2026 15:38:16 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1774971495;
	bh=sha5iUK+ld7auJ1XsQIL2NCgXgH7GuElZWKOLIy6d48=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=2w+5FIGK7kyu1OdIgcWAnnEi3yl2X/GYDlFxOUMt4HcUWvXp93LMtkmyouZfZGAEn
	 UX1Sd+jnWPtEkCxUO+lrDWcXXGJuUOQw76Q/ScW/VSfqaWDS5JwsQvRG+gRH5iC4uR
	 rPbBM0EIXv3UmB18/XAA/W9cW46l0oOBy4dHRNs45jSWNvjpFJs+j5B6g4vI7c9izH
	 FtbsUqGeZFzG8pgjXk5icd09tAxNqLvTkDFSQi7EG41Lb6XroDWBuWs7vD87AOWceC
	 vIRlHoHy3aCJm0um172KWQ6MbERutet7T/uSLSd0anM4CKxX/74QrK904ErLS4Mj3p
	 aDxR7epkyt2tg==
Received: from [IPV6:2003:c6:9f04:eb00::1c8] (p200300c69f04eb0000000000000001c8.dip0.t-ipconnect.de [IPv6:2003:c6:9f04:eb00::1c8])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 3A1AE406E4;
	Tue, 31 Mar 2026 15:38:15 +0000 (UTC)
Message-ID: <203f565c-4cf9-4591-9d1a-34c68577cf18@birger-koblitz.de>
Date: Tue, 31 Mar 2026 17:38:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/2] r8152: Add support for the RTL8157
 hardware
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260324-rtl8157_next-v4-2-034312b12de5@birger-koblitz.de>
 <20260329193457.2764549-2-kuba@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260329193457.2764549-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-273683-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 632ED36C13A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/29/26 21:34, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> r8152: Add support for the RTL8157 hardware
> 
> This commit adds support for the RTL8157 chip, including its new 16-byte
> descriptor format, SRAM/ADV interfaces, and PHY setup. It reuses existing
> initialization functions where possible while branching for chip-specific
> logic.
> 
>> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
>> index bab8e10e5f99..010126e6dae4 100644
>> --- a/drivers/net/usb/r8152.c
>> +++ b/drivers/net/usb/r8152.c
>> @@ -1629,6 +1862,28 @@ static u16 sram_read(struct r8152 *tp, u16 addr)
>>   	return ocp_reg_read(tp, OCP_SRAM_DATA);
>>   }
>>   
>> +static void sram_write_w0w1(struct r8152 *tp, u16 addr, u16 clear, u16 set)
>> +{
>> +	u16 data = sram_read(tp, addr);
>> +
>> +	data = (data & ~clear) | set;
>> +	ocp_reg_write(tp, OCP_SRAM_DATA, data);
>> +}
> 
> Does this sequence write the modified data back to the wrong address?
> 
> Indirect SRAM access ports typically auto-increment their internal address
> pointer upon read. Since sram_read() reads OCP_SRAM_DATA, the address
> pointer likely advances, causing the subsequent ocp_reg_write() to corrupt
> the adjacent register instead of the intended one. Should this use
> sram_write(tp, addr, data) to reset the address before writing?
> 
The SRAM access does not have this alleged behaviour. This optimization is
found in the out-of-tree driver by Realtek. I also read back the values written
into the SRAM address as well as the following address, and the code is correct.

> 
> Is the same auto-increment issue present here with OCP_SRAM2_DATA?
No. Again, the optimization is also found in the out-of-tree driver and I explicitly
verified the data written.


> 
> [ ... ]
> 
>> @@ -4080,6 +4473,14 @@ static void rtl8156_runtime_enable(struct r8152 *tp, bool enable)
>>   	}
>>   }
>>   
>> +static void rtl8157_runtime_enable(struct r8152 *tp, bool enable)
>> +{
>> +	r8153_queue_wake(tp, enable);
>> +	r8153b_u1u2en(tp, false);
>> +	r8157_u2p3en(tp, false);
>> +	rtl_runtime_suspend_enable(tp, enable);
>> +}
> 
> Does this function break power management upon the first suspend and resume
> cycle? Unlike rtl8156_runtime_enable() which checks the enable parameter,
> this implementation unconditionally calls r8153b_u1u2en(tp, false) and
> r8157_u2p3en(tp, false) even when resuming.
This appears to be a bug in the out-of-tree driver. I will change this
function to follow the behaviour of rtl8156_runtime_enable() in v5. I have also traced
the PM functions while entering and leaving S3 sleep, and the behavior is now correct.


> 
> [ ... ]
> 
>> @@ -6693,7 +7052,7 @@ static void rtl8156_up(struct r8152 *tp)
>>   	r8153_aldps_en(tp, true);
>>   	r8153_u2p3en(tp, true);
>>   
>> -	if (tp->udev->speed >= USB_SPEED_SUPER)
>> +	if (tp->version != RTL_VER_16 && tp->udev->speed >= USB_SPEED_SUPER)
>>   		r8153b_u1u2en(tp, true);
>>   }
> 
> Because r8153_u2p3en(tp, true) is called unconditionally just before the
> modified lines, will RTL8157 incorrectly write to the legacy USB_U2P3_CTRL
> register instead of using its specific r8157_u2p3en() function?
This was a mistake. I will fix this to call r8153_u2p3en() only for non-RTL8157
chips.


> 
> [ ... ]
> 
>> @@ -6706,13 +7065,13 @@ static void rtl8156_down(struct r8152 *tp)
>>   		return;
>>   	}
>>   
>> -	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3);
>> -	ocp_data |= PLA_MCU_SPDWN_EN;
>> -	ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, ocp_data);
>> +	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, PLA_MCU_SPDWN_EN);
>>   
>>   	r8153b_u1u2en(tp, false);
>> -	r8153_u2p3en(tp, false);
>> -	r8153b_power_cut_en(tp, false);
>> +	if (tp->version != RTL_VER_16) {
>> +		r8153_u2p3en(tp, false);
>> +		r8153b_power_cut_en(tp, false);
>> +	}
>>   	r8153_aldps_en(tp, false);
> 
> While the legacy registers are correctly avoided for RTL_VER_16 here, are we
> missing calls to r8157_u2p3en(tp, false) and r8157_power_cut_en(tp, false)?
> If omitted, these power states might remain permanently enabled when the
> interface goes down.
These calls are not in the out-of-tree driver. It appears the r8157_u2p3en()
is not used in the _up and _down functions. I measured the USB power
consumption with an interposed USB dongle on the port, and the power use is
better than for the RTL8153 when the link is down.

> 
> [ ... ]
> 
>> @@ -8362,10 +8825,21 @@ static void r8156b_init(struct r8152 *tp)
>>   
>>   	set_bit(GREEN_ETHERNET, &tp->flags);
>>   
>> -	/* rx aggregation */
>> -	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_USB_CTRL);
>> -	ocp_data &= ~(RX_AGG_DISABLE | RX_ZERO_EN);
>> -	ocp_write_word(tp, MCU_TYPE_USB, USB_USB_CTRL, ocp_data);
>> +	/* rx aggregation / 16 bytes Rx descriptor */
>> +	if (tp->version == RTL_VER_16)
>> +		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL, RX_AGG_DISABLE | RX_DESC_16B);
> 
> Is it intended to clear the RX_DESC_16B bit for RTL_VER_16? The driver uses
> sizeof(struct rx_desc_v2) which is a 16-byte descriptor for RTL8157.
> Clearing this bit might configure the hardware to send 8-byte descriptors
> instead, leading to packet parsing corruption in rx_bottom().
The code is correct as per the out-of-tree driver. I also tested packet
transmission in various stress-tests.

> 
> [ ... ]
> 
>> @@ -9647,6 +10158,29 @@ static int rtl_ops_init(struct r8152 *tp)
>>   		tp->rx_buf_sz		= 32 * 1024;
>>   		tp->eee_en		= true;
>>   		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
>> +		r8152_desc_init(tp);
>> +		break;
>> +
>> +	case RTL_VER_16:
>> +		tp->eee_en		= true;
>> +		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
>> +		tp->eee_adv2		= MDIO_EEE_2_5GT | MDIO_EEE_5GT;
>> +		ops->init		= r8156_init;
>> +		ops->enable		= rtl8156_enable;
>> +		ops->disable		= rtl8153_disable;
>> +		ops->up			= rtl8156_up;
>> +		ops->down		= rtl8156_down;
>> +		ops->unload		= rtl8153_unload;
> 
> Will using rtl8153_unload for RTL_VER_16 result in incorrect power cut
> teardown? rtl8153_unload calls the legacy r8153_power_cut_en(tp, false).
> RTL8157 seems to require r8157_power_cut_en(tp, false) to properly clear
> USB_MISC_2 bit 1 and PCUT_STATUS on module unload.
This behaviour is also found in the out-of-tree driver by Realtek.
The out-of-tree function reads:

static void rtl8157_unload(struct r8152 *tp)
{
	if (test_bit(RTL8152_UNPLUG, &tp->flags))
		return;

	r8153_power_cut_en(tp, false);

	/* Disable Interrupt Mitigation */
	if (ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xcf04,
			      BIT(0) | BIT(1) | BIT(2) | BIT(7)) < 0)
		return;
}

However, I had forgotten to add the "Disable Interrupt Mitigation" part.
I therefore added it, depending on RTL_VER_16.

I tested unloading and re-loading the driver, again while measuring the USB power
consumption with an interposed USB dongle on the port, and the wattage
in the state where the driver is unloaded for the RTL8157 is lower than the
one for the RTL8153 (280mW vs 450mW). The driver behavior now appear
correct.



