Return-Path: <netdev+bounces-273681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKYuA+bsy2mlMgYAu9opvQ
	(envelope-from <netdev+bounces-273681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:48:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FBB36C10B
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C339A30B064E
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A3C421F12;
	Tue, 31 Mar 2026 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="tP5/ZHNT";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="kEhfbqic"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7A6421F0F;
	Tue, 31 Mar 2026 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971501; cv=none; b=g06zve0QryAvs9A+J0VqK6O0MzRpvhiuiMyMl1qESXYRYzU7XoSShE2yW/ll3os1zzKAjfRfBleTwzWZ7t55iiGSN5isgBcAWzP7BAT2zyoQ1q4YkkArgSafCObdEXa9ZjT49Ad2btep719V28mVBvC3nBC5HaQRVe6aFl3hPwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971501; c=relaxed/simple;
	bh=+atFSHa3fBSLRwnffHL60TLEuwq7BlNCBg5rhe0thHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LvZN92wi4o8MVcWWZllZYEathUb/d/Otyg3KXNv4TMCcELhI0xFYn6AwgNh7q/Hulw98KOEARmRp17IPApiqhg5TxpmfO7QNL/Rf3O4I0iBbg4LKt5y18ahKJ1CzlsZ3vagnL23B1qJQWAoy4cNv9eQvIRJDv+wwoAms2S4RYgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=tP5/ZHNT; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=kEhfbqic; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1774971492;
	bh=+atFSHa3fBSLRwnffHL60TLEuwq7BlNCBg5rhe0thHw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tP5/ZHNTXN7nYdYpaCHAzNsuV6cca3LKvt1lSd6HR922oKpq6yxXE1mISGDMLXXQ1
	 i8sET7fenl0jpjM93f8235Wtw9+RLsTXpQieTN0NydSqtQyXbWVnTJwGDF96CEl13P
	 F0+qrMDfcnLUwXIEKMKEf6AScKegFAcgsXMOd57Tj5sa7VgBzrvhmN1p7WIKH0IkKk
	 1Ry2+gsfEQqwd6kdf+HbBdtCbPb3kM8C9fAbEEWPYt/I4dlPxA4FN53K0BqpJNPTEP
	 o5xsTZ/zZwllqVwz5aHY9y2DNSL7gUn1smLSsshIgTBTHBoKnd9Z+9t9V5iLGXwgDL
	 T22oBhfMehRtA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 343AB406EA; Tue, 31 Mar 2026 15:38:12 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1774971491;
	bh=+atFSHa3fBSLRwnffHL60TLEuwq7BlNCBg5rhe0thHw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kEhfbqicaXuBWu1SIm/N+xu5LdpE3KiykRaaQ+YOiCx3Ckockc2ESeCohhbhhJQnZ
	 0kI1pRJsKXbjqBW5U9SJl5nN9MWjVmDFU+1mNMz+Sg46OLR/o5DO3BpbGCI7bw/GFp
	 GpRWDe1UEmnhZdsJVYRz59hY8GD+anxV6hSjhyFWRiYGuea3DTJb2WEGghA3i6gWbD
	 qEpWjtRCHgjCDSQDcWu2yDe9eB358w5gp3762FOpcO1INd8ASn/Ih41X+HvZEB87Ub
	 GKKY5P1TMXsf29EKXDJzTcOHG2Ks/mPsSTIanrDoinbMcUL6Yk8xl3pkvJbhb7kbRH
	 Ue+CLhxzYJ+7g==
Received: from [IPV6:2003:c6:9f04:eb00::1c8] (p200300c69f04eb0000000000000001c8.dip0.t-ipconnect.de [IPv6:2003:c6:9f04:eb00::1c8])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 24F4D406E4;
	Tue, 31 Mar 2026 15:38:11 +0000 (UTC)
Message-ID: <50dc7e8c-6c6d-47d1-866e-677638b4deaf@birger-koblitz.de>
Date: Tue, 31 Mar 2026 17:38:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/2] r8152: Add support for 5Gbit Link Speeds
 and EEE
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260324-rtl8157_next-v4-1-034312b12de5@birger-koblitz.de>
 <20260329193449.2764517-1-kuba@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260329193449.2764517-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-273681-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lkml.org:url]
X-Rspamd-Queue-Id: E4FBB36C10B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jakub,

thanks a lot for reviewing the patch!
On 3/29/26 21:34, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> r8152: Add support for 5Gbit Link Speeds and EEE
> 
> This commit adds support for 5GBit link speeds and EEE to the RTL8157
> driver. It updates the speed and duplex settings, ethtool integration,
> and EEE advertisement parameters to handle the new 5G capabilities.
> 
>> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
>> index 3b6d4252d34c..bab8e10e5f99 100644
>> --- a/drivers/net/usb/r8152.c
>> +++ b/drivers/net/usb/r8152.c
>> @@ -604,6 +604,7 @@ enum spd_duplex {
>>   	FORCE_100M_FULL,
>>   	FORCE_1000M_FULL,
>>   	NWAY_2500M_FULL,
>> +	NWAY_5000M_FULL,
>>   };
> 
> Are there missing switch cases for NWAY_5000M_FULL in the hardware UPS
> flag configurations, such as r8156_ups_flags?
This question has now been raised the third time, see here:
https://lkml.org/lkml/2026/3/24/1902 and here https://lkml.org/lkml/2026/3/19/1765
However, while I share the concern, I cannot provide a better answer than
the first time or second time.

> Is it intentional that the MAC idle speed down feature (IDLE_SPDWN_EN) is
> disabled for _2500bps but remains enabled for _5000bps?
Yes, this is intentional. IDLE_SPDWN_EN is indeed only disabled for _2500bps
in the out-of-tree driver (and not for 5GBit or 10GBit).

> 
>> @@ -6343,15 +6356,20 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
>>   				r8152_mdio_write(tp, MII_CTRL1000, new1);
>>   		}
>>   
>> -		if (tp->support_2500full) {
>> +		if (tp->support_2500full || tp->support_5000full) {
>>   			orig = ocp_reg_read(tp, OCP_10GBT_CTRL);
>> -			new1 = orig & ~MDIO_AN_10GBT_CTRL_ADV2_5G;
>> +			new1 = orig & ~(MDIO_AN_10GBT_CTRL_ADV2_5G | MDIO_AN_10GBT_CTRL_ADV5G);
>>   
>>   			if (advertising & RTL_ADVERTISED_2500_FULL) {
>>   				new1 |= MDIO_AN_10GBT_CTRL_ADV2_5G;
>>   				tp->ups_info.speed_duplex = NWAY_2500M_FULL;
>>   			}
>>   
>> +			if (advertising & RTL_ADVERTISED_5000_FULL) {
>> +				new1 |= MDIO_AN_10GBT_CTRL_ADV5G;
>> +				tp->ups_info.speed_duplex = NWAY_5000M_FULL;
>> +			}
>> +
> 
> Could this unintentionally advertise 5GbE on a 2.5GbE-only adapter if
> userspace requests it?
> 
> The earlier check in this function:
> 
> 		if (!(advertising & support))
> 			return -EINVAL;
> 
> only ensures that at least one supported speed is requested, but it does
> not strip unsupported speeds from the advertising mask. Since this block
> is now entered when support_2500full is true, checking the advertising mask
> for RTL_ADVERTISED_5000_FULL without verifying tp->support_5000full could
> erroneously write the 5G bit to the PHY and misconfigure the hardware
> state.

I will change this to:

         advertising &= support;
         if (!advertising)
                 return -EINVAL;

in v5, to be on the safe side.

> [ ... ]
> 
>> @@ -8793,6 +8814,19 @@ int rtl8152_get_link_ksettings(struct net_device *netdev,
>>   			cmd->base.speed = SPEED_2500;
>>   	}
>>   
>> +	if (tp->support_5000full) {
>> +		linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
>> +				 cmd->link_modes.advertising,
>> +				 ocp_reg_read(tp, OCP_10GBT_CTRL) & MDIO_AN_10GBT_CTRL_ADV5G);
>> +
>> +		linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
>> +				 cmd->link_modes.lp_advertising,
>> +				 ocp_reg_read(tp, OCP_10GBT_STAT) & MDIO_AN_10GBT_STAT_LP5G);
>> +
>> +		if (is_speed_5000(rtl8152_get_speed(tp)))
>> +			cmd->base.speed = SPEED_5000;
>> +	}
> 
> Since 5G adapters like the RTL8157 will have both support_2500full and
> support_5000full set, will this result in duplicate blocking USB control
> transfers?
You are right. Also in view of future 10GBit support, I will change this to:
         if (tp->support_2500full || tp->support_5000full) {
                 u16 ocp_10bt_ctrl = ocp_reg_read(tp, OCP_10GBT_CTR)L;
                 u16 ocp_10bt_stat = ocp_reg_read(tp, OCP_10GBT_STAT);

                 if (tp->support_2500full) {
                         ...
                 }
                 if (tp->support_5000full) {
                         ...
                 }
         }

> In r8153_get_eee, the reading of OCP_EEE_ADV2 and OCP_EEE_LPABLE2 is
> performed inside the if (tp->support_2500full) block that precedes this new
> code.
> 
> Since those registers contain the EEE capability bits for both 2.5G
> and 5G speeds, what happens if a device has support_5000full enabled but
> support_2500full disabled? It looks like the registers would never be read,
> and the 5Gbps EEE capabilities would fail to populate correctly.
The driver supports RTL815x-chips, and all RTL815x-chips, which support 5GBit also
support 2.5gbit (the RTL8157 and the RTL8159). My understanding is, that the
802.3bz standard even requires this fallback. However, to be on the safe side and
to also support possible future chips, I will change this to:
	if (tp->support_2500full || tp->support_5000full) {
		val = ocp_reg_read(tp, OCP_EEE_ADV2);
		mii_eee_cap2_mod_linkmode_adv_t(eee->advertised, val);

		val = ocp_reg_read(tp, OCP_EEE_LPABLE2);
		mii_eee_cap2_mod_linkmode_adv_t(eee->lp_advertised, val);
	}

	if (tp->support_2500full) {
		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, eee->supported);

		if (speed & _2500bps)
			linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, common);
	}

	if (tp->support_5000full) {
		linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, eee->supported);

		if (speed & _5000bps)
			linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, common);
	}


Cheers,
   Birger


