Return-Path: <netdev+bounces-261093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uG3REnlxn2kccAQAu9opvQ
	(envelope-from <netdev+bounces-261093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 23:02:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BC18619E159
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 23:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42A68303B169
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 22:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A43314B96;
	Wed, 25 Feb 2026 22:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="pPg9bHIT";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="n+m1OIfM"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D2126056C;
	Wed, 25 Feb 2026 22:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772056947; cv=none; b=qjuEGRbonUybHotnNJ8G6N7C+XjGH4bTNiq7zCURQff9VWHNz1yMYVnL4+QowFtQh8EoR/qtisFozckKUuygvn/grbi9GFGguJHfuuUPbP2G7Ba/yYZyc6nLViabVDITE7rk2kj/vTbovvwdLYpjqL2JMeevXQD3uCcRjyYIMo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772056947; c=relaxed/simple;
	bh=2EwLmgtd7PvhslbFocxLbm8nki3+rjfcT6Nly2AXDvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qdoEX3SslhxLmBVwkqnfD5rU8+F9Q0NiRoH0B+459XUAIbWw20jMVmCjSv/vpFG7tD0l3uQyEAIMzMn+GUpMJ1M5xtKLLYB6V0ReirVhDCEdHr/cpio3YkOEZfv8XfHsBIzuQ1tFxiKRLuhRuPoIPsflw2ZXbEQaM+TXKXpYiqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=pPg9bHIT; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=n+m1OIfM; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1772056939;
	bh=2EwLmgtd7PvhslbFocxLbm8nki3+rjfcT6Nly2AXDvw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pPg9bHIT3WKVJWeSgAdG0n5HuUXVTskfkvOxe7ZtLBoaY4J9U9pAHtsaaoXDEucyT
	 DzIVHXDF4f1c+LcVDx7Cyxe1U8XZrRG59IY9h1jZ8FgapCAacq4T1HXq2Qp1v+eq2D
	 wJwOEgzONp/XhGB5XEaOL1jUWAMVajGp7hkf38qdEAahsChzQ0XN2h39lyv18JP87w
	 KfiBnDyUF/mMnPlJJ07lesMhaQML0XJgzBEeRdLM8uFCfVOHlX3KqVojmU50/LgP/X
	 tsU1C5/h0pU6sylshfBnBwCoPLwW9PWjA2zpDVLttzsnZYDg12QNAGoV4JA+e+mIUh
	 jjeOtxEF9wv9g==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 271363F7A7; Wed, 25 Feb 2026 22:02:19 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1772056937;
	bh=2EwLmgtd7PvhslbFocxLbm8nki3+rjfcT6Nly2AXDvw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n+m1OIfMoxR0hMEWKhhXg66j2civj0j4naizbWF6F/CmorS86mLgJS04HRUTOXCYC
	 wYxP4Ttmm5M1cPtL1y13uuCiQacPF4w/QvhlxUbOG0eG6OEoSpmkonIMBFxGAchiZW
	 3Dpi3xHT5tgD0mGwnYTcOlmLWYFKAIffg3D4k3eoka9pnWo8FANh8QQO1HHJ+LLvJG
	 QwqTrMuL6DKoMRgTFqSGo90IR2tIsrSNr3GQeQQO8qWAF9Hy0Ei9LnddJs8O0ymd+9
	 jzqJXAczWL3OA0XQ9ljN49fZoFtHcj+ZO3o44Q3Q0+nMxOaGc56HBt7EKUE2I5RIvl
	 7qVtW1Xu72PCQ==
Received: from [IPV6:2a00:6020:47a3:e800:94d3:d213:724a:4e07] (unknown [IPv6:2a00:6020:47a3:e800:94d3:d213:724a:4e07])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id A7EDD3F631;
	Wed, 25 Feb 2026 22:02:17 +0000 (UTC)
Message-ID: <875598e7-5fa1-49b0-be14-181b18ae97fe@birger-koblitz.de>
Date: Wed, 25 Feb 2026 23:02:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v2] r8152: Add 2500baseT EEE status/configuration
 support
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, kuba@kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, edumazet@google.com, opensource@vdorst.com
References: <20260224-b4-eee2g5-v2-1-cf5c83df036e@birger-koblitz.de>
 <20260225194848.188081-2-horms@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260225194848.188081-2-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-261093-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC18619E159
X-Rspamd-Action: no action

Hi Simon,

Thanks for the thorough analysis!

On 25/02/2026 8:48 pm, Simon Horman wrote:

> 
>> @@ -8922,7 +8924,8 @@ static void rtl8152_get_strings(struct net_device *dev, u32 stringset, u8 *data)
>>
>>   static int r8152_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
>>   {
>> -	__ETHTOOL_DECLARE_LINK_MODE_MASK(common);
>> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(common) = {};
>> +	u16 speed = rtl8152_get_speed(tp);
>>   	u16 val;
>>
>>   	val = r8152_mmd_read(tp, MDIO_MMD_PCS, MDIO_PCS_EEE_ABLE);
> 
> This isn't a bug, but the variable declarations are not in reverse
> Christmas tree order. Simon Horman's AI review raised this in v1, you
> acknowledged it and said it would be fixed in v2, but the ordering issue
> remains. The longest line should come first, followed by shorter lines.
> Should be:
> 
> 	__ETHTOOL_DECLARE_LINK_MODE_MASK(common) = {};
> 	u16 speed = rtl8152_get_speed(tp);
> 	u16 val;
> 
I do not understand what the AI is complaining about, here. The lines in 
the v2 patch are in exactly the order you requested:
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(common);
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(common) = {};
+	u16 speed = rtl8152_get_speed(tp);
  	u16 val;
gives
	__ETHTOOL_DECLARE_LINK_MODE_MASK(common) = {};
	u16 speed = rtl8152_get_speed(tp);
  	u16 val;

> (Reference: https://lore.kernel.org/all/20260224170206.146491-3-horms@kernel.org/)
> 
> [ ... ]
> 
>> @@ -8956,7 +8968,8 @@ static int r8152_set_eee(struct r8152 *tp, struct ethtool_keee *eee)
>>
>>   static int r8153_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
>>   {
>> -	__ETHTOOL_DECLARE_LINK_MODE_MASK(common);
>> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(common) = {};
>> +	u16 speed = rtl8152_get_speed(tp);
>>   	u16 val;
>>
>>   	val = ocp_reg_read(tp, OCP_EEE_ABLE);
> 
> Same reverse Christmas tree order issue here. The same pattern should be
> applied as in r8152_get_eee().
Same argument as above.

> 
> [ ... ]
> 
>> @@ -8968,10 +8981,29 @@ static int r8153_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
>>   	val = ocp_reg_read(tp, OCP_EEE_LPABLE);
>>   	mii_eee_cap1_mod_linkmode_t(eee->lp_advertised, val);
>>
>> +	if (tp->support_2500full) {
>> +		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, eee->supported);
>> +
>> +		val = ocp_reg_read(tp, OCP_EEE_ADV2);
>> +		mii_eee_cap2_mod_linkmode_adv_t(eee->advertised, val);
>> +
>> +		val = ocp_reg_read(tp, OCP_EEE_LPABLE2);
>> +		mii_eee_cap2_mod_linkmode_adv_t(eee->lp_advertised, val);
>> +
>> +		if (speed & _2500bps)
>> +			linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, common);
>> +	}
>> +
>>   	eee->eee_enabled = tp->eee_en;
>>
>> -	linkmode_and(common, eee->advertised, eee->lp_advertised);
>> -	eee->eee_active = phy_check_valid(tp->speed, tp->duplex, common);
>> +	if (speed & _1000bps)
>> +		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, common);
>> +	if (speed & _100bps)
>> +		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, common);
>> +
>> +	linkmode_and(common, common, eee->advertised);
>> +	linkmode_and(common, common, eee->lp_advertised);
>> +	eee->eee_active = !linkmode_empty(common);
>>
>>   	return 0;
>>   }
> 
> The eee_active determination logic is now duplicated between
> r8152_get_eee() and r8153_get_eee(). Both functions convert speed
> register bits to linkmode bits, AND with advertised and lp_advertised,
> and test emptiness in the same way. Would it make sense to factor this
> into a shared helper to reduce maintenance burden?
This could make sense, but I tried to make this as minimally intrusive 
as possible and was already at a doubt whether I should even fix the 
RTL8152 version of get_eee() to correctly depend on the actual, not the 
desired speed. Then I decided for fixing this incorrect behavior and 
have consistency. The style of the existing code has plenty of duplicate 
code for the different chip-versions and is already difficult to follow 
to this point depending on the chip version. Personally, I find the 
readability improved if the few lines of code are repeated instead of 
separating this out into yet another nested function, and readability 
also helps code maintenance. Plus, it is quite likely that these 
functions further diverge with e.g. support for the RTL8157 (5GBit/s).

> 
>> @@ -9512,6 +9544,7 @@ static int rtl_ops_init(struct r8152 *tp)
>>   	case RTL_VER_11:
>>   		tp->eee_en		= true;
>>   		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
>> +		tp->eee_adv2		= MDIO_EEE_2_5GT;
>>   		fallthrough;
>>   	case RTL_VER_10:
>>   		ops->init		= r8156_init;
> 
> [ ... ]
> 
>> @@ -9537,6 +9570,7 @@ static int rtl_ops_init(struct r8152 *tp)
>>   	case RTL_VER_15:
>>   		tp->eee_en		= true;
>>   		tp->eee_adv		= MDIO_EEE_1000T | MDIO_EEE_100TX;
>> +		tp->eee_adv2		= MDIO_EEE_2_5GT;
>>   		ops->init		= r8156b_init;
>>   		ops->enable		= rtl8156b_enable;
>>   		ops->disable		= rtl8153_disable;
> 
> Does RTL_VER_15 support 2.5G links? Looking at the code, only RTL_VER_12
> and RTL_VER_13 set tp->support_2500full before falling through, but
> RTL_VER_15 does not. With this change, tp->eee_adv2 = MDIO_EEE_2_5GT is
> set for VER_15.
VER 15 supports 2.5GBit links. The existing code enabled 2.5GBit EEE 
unconditionally in rtl_eee_enable():
	case RTL_VER_10:
	case RTL_VER_11:
	case RTL_VER_12:
	case RTL_VER_13:
	case RTL_VER_15:
		if (enable) {
			r8156_eee_en(tp, true);
			ocp_reg_write(tp, OCP_EEE_ADV, tp->eee_adv);
		} else {
			r8156_eee_en(tp, false);
			ocp_reg_write(tp, OCP_EEE_ADV, 0);
		}
		break;
Note that previously r8156_eee_en() did not conditionally enable the 
2.5GBit advertisement depending on tp->eee_adv2, but always enabled it, 
also for VER 15.

> 
> When r8156_eee_en() is called for a VER_15 device with EEE enabled:
> 
> static void r8156_eee_en(struct r8152 *tp, bool enable)
> {
> 	u16 config;
> 
> 	config = ocp_reg_read(tp, OCP_EEE_ADV2);
> 
> 	if (enable && (tp->eee_adv2 & MDIO_EEE_2_5GT))
> 		config |= MDIO_EEE_2_5GT;
> 
> The condition (tp->eee_adv2 & MDIO_EEE_2_5GT) will be true, causing
> MDIO_EEE_2_5GT to be written into the OCP_EEE_ADV2 hardware register.
> This would advertise 2.5G EEE capability to the link partner on a device
> that does not support 2.5Gbit links.
> 
> Should the eee_adv2 initialization be moved into the RTL_VER_12/13 block
> (before the fallthrough), or should RTL_VER_15 be given eee_adv2 = 0 to
> remain consistent with its lack of support_2500full?
No, see above.

   Birger

