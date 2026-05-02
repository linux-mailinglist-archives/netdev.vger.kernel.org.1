Return-Path: <netdev+bounces-283364-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zykrLT979WmKLgIAu9opvQ
	(envelope-from <netdev+bounces-283364-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 06:19:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1FF4B0D0F
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 06:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F444300FB41
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 04:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7579F265CA8;
	Sat,  2 May 2026 04:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="GWVNuaAS";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="K3UCuM5V"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D111326299;
	Sat,  2 May 2026 04:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777695546; cv=none; b=gv7IfrDSIZlSxWRQxkdYtWqTIvO6rkRPyV4+7fti4waaR+E+ITYdy1HmKrXhW2NREOpTEHJ2LWpNlKt1e1HtzNX0Nb2xu2gfN0x9DOM1JpCea1rg9/Tw3rZabM+YTdYfreeZC+LM0yogFEzXzv7PtDIc5yL4HcTlp7xniGFXnc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777695546; c=relaxed/simple;
	bh=1b77sLSfeXEOigrZw4MjY7aEQchhQA9i9p4wri9IWk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BvXVmZ48thq+laIFC+nHPkJ5MVlBWDkSysX+DlaxWqxYOQojTEIRC3MHE75VhELoAzKMngkJswPz9YddJkCjXSgGOBfuCsA0SB60dBAoLLjzEiYxaTW1uC2pG0KSmxVHzxcRHmSll1PS+wVxZjSC4z4/JhtJROpvslggvBQHvCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=GWVNuaAS; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=K3UCuM5V; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777695536;
	bh=1b77sLSfeXEOigrZw4MjY7aEQchhQA9i9p4wri9IWk4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GWVNuaASz/dqAig2c1xts30Opc374F1DmcTsc15lB6yOK/ljWCylMP0Bxu6yFg3vi
	 8BQY13Fl88UHXYLpPI0/RRyRoXOjaocXU6GE/QYRCOfcVE1f1snJtI1/VTCZ4q6w1F
	 xAV9fJkST0eiMT7H4wVGBs3CDkGLaLx3K+zJDRguQi4zIzGBAeizFRWEd3TTbXxrC6
	 fbkWxOEn6B7xv3dhEECYWh1Q3CNn7DHC+uEeRMFxVEpD4o468yHonBSlCYKgq7dBt0
	 UQ+GGfY+dh4BDJp3rFpIvv2bWhmpfuw2L8Mnr9qEUKXaeae8wSAJg7S0FF4NOTb75+
	 PNuKGQfBVFBUQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 9D640482A8; Sat,  2 May 2026 04:18:56 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777695535;
	bh=1b77sLSfeXEOigrZw4MjY7aEQchhQA9i9p4wri9IWk4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K3UCuM5VJBOc8I8znTEJVI27E5CpoAqK5t7DPEG1EqDT8zYo51E80FG9JL4A09QIh
	 MreL1j2gAqArCtV7bfktGZ7RlP9+H/BOHlGrPcGOgOgew8jqS2XuZInTCweqsP+j6l
	 M6O7wpjpCrbiqNFLSLdO//N6gVmlEgTJdUcVmAyibGtROCtznUo1bFBuomSckBbbvW
	 vbIRth99UpzkEXh1K557INd5053FR0hGeMzCa7pZTpLVIafRjVfesxW3q6QDtePr8g
	 dIQYIYWAkcEi/9Pa45q3LWozS+Y4wTJDC9gmGm18rOxbkwJjsixxsT2O5oX8f7FrrT
	 IooJDtQR7pD4g==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 6833C4122D;
	Sat,  2 May 2026 04:18:55 +0000 (UTC)
Message-ID: <575c9dc5-cf3b-451b-b6df-e8b533ba06c6@birger-koblitz.de>
Date: Sat, 2 May 2026 06:18:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/4] r8152: Add support for 10Gbit Link Speeds
 and EEE
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, hsu.chih.kai@realtek.com
References: <20260429-rtl8159_net_next-v2-1-bab3cd4e4c66@birger-koblitz.de>
 <20260501011556.3154166-1-kuba@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260501011556.3154166-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1D1FF4B0D0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-283364-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,birger-koblitz.de:dkim,birger-koblitz.de:mid]

Thanks a lot for reviewing this patch, Jakub!
On 01/05/2026 3:15 am, Jakub Kicinski wrote:

>> +	if (enable && (tp->eee_adv2 & MDIO_EEE_10GT))
>> +		config |= MDIO_EEE_10GT;
>> +	else
>> +		config &= ~MDIO_EEE_10GT;
>> +
>>   	ocp_reg_write(tp, OCP_EEE_ADV2, config);
>>   }
> 
> Is MDIO_EEE_10GT actually a bit of the EEE advertisement 2 register
> (7.62, cap2 / OCP_EEE_ADV2)?
> 
No, and it should have been clear to me. The entire bit of code is 
actually unneccessary, as the MDIO_EEE_10GT-BIT is part of OCP_EEE_ADV 
and is set in tp->eee_adv, so that rtl_eee_enable() correctly already 
sets it:
static void rtl_eee_enable(struct r8152 *tp, bool enable)
{
	case RTL_VER_17:
		if (enable) {
			r8156_eee_en(tp, true);
			ocp_reg_write(tp, OCP_EEE_ADV, tp->eee_adv);
		}
	...
}
Will be fixed in v3.

> 
> [ ... ]
> 
>> @@ -8968,6 +9008,13 @@ static int r8153_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
>>   			linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, common);
>>   	}
>>   
>> +	if (tp->support_10000full) {
>> +		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, eee->supported);
>> +
>> +		if (speed & _10000bps)
>> +			linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, common);
>> +	}
>> +
>>   	eee->eee_enabled = tp->eee_en;
> 
> Should this hunk also extend the earlier gating inside r8153_get_eee()?
> 
> A few lines above, the cap2 register reads are still gated on:
> 
> 	if (tp->support_2500full || tp->support_5000full) {
> 		val = ocp_reg_read(tp, OCP_EEE_ADV2);
> 		mii_eee_cap2_mod_linkmode_adv_t(eee->advertised, val);
> 
> 		val = ocp_reg_read(tp, OCP_EEE_LPABLE2);
> 		mii_eee_cap2_mod_linkmode_adv_t(eee->lp_advertised, val);
> 	}
> 
> The equivalent disjunction in rtl8152_set_speed() and
> rtl8152_get_link_ksettings() was updated to include support_10000full,
> but r8153_get_eee() (and r8152_set_eee() at the analogous spot) still
> only checks support_2500full || support_5000full.
> 
> A hypothetical chip that sets only support_10000full would bypass the
> OCP_EEE_ADV2 / OCP_EEE_LPABLE2 reads and never reflect 10G EEE into
> eee->advertised.  Should the condition be made consistent with the
> other sites?
The AI here actually contradicts itself with the previous issue. The 
10GBit modes are part of OCP_EEE_ADV (MMD 7.0x003C) and OCP_EEE_LPABLE 
(MMD 7.0x003D). A hypothetical chip that sets only support_10000full 
would still reflect the correct LP-ability 10GBit setting.

> 
>> @@ -9982,6 +10029,11 @@ static int rtl8152_probe_once(struct usb_interface *intf,
>>   			tp->speed = SPEED_5000;
>>   			tp->advertising |= RTL_ADVERTISED_5000_FULL;
>>   		}
>> +		if (tp->support_10000full &&
>> +		    tp->udev->speed >= USB_SPEED_SUPER) {
>> +			tp->speed = SPEED_10000;
>> +			tp->advertising |= RTL_ADVERTISED_10000_FULL;
>> +		}
>>   		tp->advertising |= RTL_ADVERTISED_1000_FULL;
>>   	}
>>   	tp->duplex = DUPLEX_FULL;
> 
> Is USB_SPEED_SUPER the correct gate for defaulting to a 10 Gbit link?
I believe this is the correct gate. In order to get the full speed out 
of the 10GBit Ethernet connection, a 20GBit USB link would be needed, 
anyway, with 10GBit USB-C, i.e. USB_SPEED_SUPER_PLUS, I see only about 
7.6GBit throughput. The difference of 10GBit wire-speed to 5GBit Speed 
for USB 3.0 is not that bad, and the overhead does not seem to make a 
problem.

But I think this is not the point: an important aspect of the 10GBit 
USB-Ethernet adapters is that they are used for testing 10GBit 
connections with network equipment. The RTL8159 is even put in 
connection with a media converter and an SFP+ cage in the same housing 
and advertised for testing 10GBit fiber lines. It should be possible to 
test and use 10GBit connectivity even on a 5GBit USB port.

Birger


