Return-Path: <netdev+bounces-269805-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLIQCD70vGms4wIAu9opvQ
	(envelope-from <netdev+bounces-269805-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:16:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 932FE2D67BE
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95530303CEF5
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 07:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265503128D4;
	Fri, 20 Mar 2026 07:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="TRlxXDDD";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="3FXFMYuy"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7696B2472A6;
	Fri, 20 Mar 2026 07:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773990962; cv=none; b=dnW9OOV99yvNBQ2zfnEXrZ7V0aqdXCGT2SKIqXSUaGlxh8Nhbxg4Iu38yNCeZm16zJwo/+OGPLF0KbRCoErD4rSbmmQiM8odaBXe0g4Dym1fUcPRyq3Ol92c2iFEp+OG+54pf3OKAh66eY+r/XEmG/rM5ZBwF+aQlryjRIRn/Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773990962; c=relaxed/simple;
	bh=2VPZnVTs8tuWaMepUH7rXwMM9ZYqMiXOBUGOswyaMm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQuvSvDZ7syW718HZGfJX9XUXnmVq7FBgS8+eAJmMMfxGW7JZ1YfC5s9Uk2CK4vn0Z63JLYJMlbDafWi4kIQlQHJUSUCVvcbfo5UxD+CBeZS+9/7o2C3qQLeBMW/DrgoqArhm17yVSIJHxo4Xxmfy9v8H9MHFl93cJa3njyX4VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=TRlxXDDD; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=3FXFMYuy; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773990958;
	bh=2VPZnVTs8tuWaMepUH7rXwMM9ZYqMiXOBUGOswyaMm0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TRlxXDDDNEy9olDleVJnORvJqcIkx/8EGTel/sMrM7a9+3bBnS3auPLYmbok244YD
	 YE7IljIPJ/xEKvmtSOJTVLaMgwQSlsMrSKS9c9bI1eWbzK8x/PdOqLC1dR6J4YMjRN
	 /vLTc31lL1B+BFi8qwqJ1dya794CgtPKGqBidnnaKj8IAnxD4dcgX3Ht2e2xd8YQ3L
	 EQR48rKREeJyqGeGqtlMJFBu7ny/RXL73y4EsF+M5RCJereNGW6Lq4XS2kp1X7haOx
	 PBEeQi60E7YFOeqWbXYOHf1i+VfKxL6VEBYTo0HJ6BiA5tMLHUjM9E0NoDjOhT3lZa
	 kVg7QiRoF5x6A==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id A9E1D3FEE5; Fri, 20 Mar 2026 07:15:58 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773990957;
	bh=2VPZnVTs8tuWaMepUH7rXwMM9ZYqMiXOBUGOswyaMm0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=3FXFMYuyqpAsAq36ej14KmA9damwUvvO2WV+5qgB8aaKbVTG8MgogWz+kPcUEMSCs
	 MuPun+lMg03W0rChE0u7M6s7A84a1ophmnwKvGcfpASHiLzKnOPmUE1UiEWvbKfZj3
	 w1nWsxvm+d/L2ZK74IkTZfg7FwHPmYcC0NUZTqadN3+91lOflfhKmDqgB+dWtpqMcf
	 NcqyoB0ih/dotr2AdaMX7NMRYfSx/HQbA5/Q+qg08iVg8Syp9XjA/Y8jGKlOYBpEZy
	 EqMPbOTFAZkiX+9trwPNgTdTgqO6gQF0j9qmk4r36r7bDEuGciLwi3r1AEIM+W3PRn
	 /0vud9Cts1RAA==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 7E6FC3F9FD;
	Fri, 20 Mar 2026 07:15:57 +0000 (UTC)
Message-ID: <4a32e356-f818-452c-bde5-a3850ad9b21a@birger-koblitz.de>
Date: Fri, 20 Mar 2026 08:15:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] r8152: Add support for the RTL8157
 hardware
To: Simon Horman <horms@kernel.org>
Cc: edumazet@google.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org, pabeni@redhat.com,
 kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net
References: <20260317-rtl8157_next-v2-2-10ea1fa488d1@birger-koblitz.de>
 <20260319165118.1988383-1-horms@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260319165118.1988383-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	TAGGED_FROM(0.00)[bounces-269805-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 932FE2D67BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 19/03/2026 5:51 pm, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> r8152: Add support for the RTL8157 hardware
> 
> The RTL8157 uses a different packet descriptor format compared to the
> previous generation of chips. The commit adds support for the new format,
> SRAM and ADV access interfaces, and consolidates RTL8156/RTL8156B/RTL8157
> initialization into a single function.
> 
>> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
>> index bab8e10e5f99..05531ea43791 100644
>> --- a/drivers/net/usb/r8152.c
>> +++ b/drivers/net/usb/r8152.c
> 
> [ ... ]
> 
>> @@ -6151,15 +6562,24 @@ static void rtl8156_enable(struct r8152 *tp)
>>   	u32 ocp_data;
>>   	u16 speed;
>>
>> +	if (tp->version <= RTL_VER_16)
>> +		return rtl_enable(tp);
>> +
>>   	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL4);
> 
The comparison operation is indeed wrong, it should be
   tp->version >= RTL_VER_16
Note that RTL_VER_17 will be used for the RTL8159, and the enable 
functions for these chips are identical, so we are already using >= here.

> Before this patch, both rtl8156_enable (VER_10/11) and rtl8156b_enable
> (VER_12/13/15) executed all of these operations unconditionally.
Indeed, this will be again the case with the correction to
tp->version >= 16

I also verified that the new enable() function for the RTL8157 as found 
in the out-of-tree driver is indeed as short as implemented by the early 
return from rtl8156_enable() function, here.

This will be fixed in v3.

>> -	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3);
>> -	ocp_data &= ~PLA_MCU_SPDWN_EN;
>> -	ocp_write_word(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, ocp_data);
>> +	if (tp->version != RTL_VER_16)
>> +		ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, PLA_MCU_SPDWN_EN);
> 
> Is ocp_byte_clr_bits() the correct function here? PLA_MCU_SPDWN_EN is
> defined as BIT(14) (0x4000), which requires 16-bit access. ocp_byte_clr_bits()
> performs an 8-bit read/modify/write via ocp_read_byte/ocp_write_byte,
> accessing only bits 0-7 of the register. Bit 14 is outside the byte range.
Indeed, this is wrong, it should be ocp_word_clr_bits. Will be fixed in v3.

> The other hw_phy_cfg functions (r8156_hw_phy_cfg, r8156b_hw_phy_cfg)
> use 'u16 data' and don't attempt error handling on r8153_phy_status().
The analysis is correct and the code will not correctly handle errors.
I will use the same approach as in the other hw_phy_cfg functions and 
not attempt error handling. Will be fixed in v3.

> 
> If the device becomes inaccessible during r8153_phy_status(), the function
> continues to program PHY registers with potentially invalid values instead
> of returning early.
The driver uses a different approach to error handling. Once the device 
becomes inaccessible, this state is detected and the device reset.

> 
> [ ... ]
> 
>> @@ -8191,59 +8543,180 @@ static int r8156_init(struct r8152 *tp)
>>
>>   	ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_MISC_1);
>>   	if (ocp_data & PCUT_STATUS) {
> 
> [ ... ]
> 
>> +	if (tp->version != RTL_VER_16)
>> +		ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, PLA_MCU_SPDWN_EN);
> 
> Same issue as above - is ocp_byte_clr_bits() the correct function for
> clearing BIT(14)? PLA_MCU_SPDWN_EN is 0x4000, which exceeds the 8-bit range.
This is the same passage as above, found a second time by the AI. Will 
be fixed in v3.

>> @@ -9541,6 +10056,7 @@ static void rtl_ops_init(struct r8152 *tp)
>>   	case RTL_VER_12:
>>   	case RTL_VER_13:
>>   	case RTL_VER_15:
>> +		ops->init		= r8156_init;
>>   		ops->enable		= rtl8156_enable;
>>   		ops->disable		= rtl8153_disable;
> 
> The ops->enable assignment changes from rtl8156b_enable to rtl8156_enable
> for RTL_VER_12/13/15 (RTL8156B). Does the new rtl8156_enable provide the
> same functionality?
> 
> As noted in the earlier issue, rtl8156_enable has an early return at line
> 6581 that causes it to skip the PLA_MAC_PWR_CTRL4, USB_L1_CTRL, and
> FC_PATCH_TASK configuration for all current versions. The old
> rtl8156b_enable performed these operations.
This will be fixed with the correct comparison in rtl8156_enable as 
mentioned before, for that function. The function will then provide the 
same functionality as before for RTL_VER_12/13/15, so this will be fixed 
in v3.

Birger

