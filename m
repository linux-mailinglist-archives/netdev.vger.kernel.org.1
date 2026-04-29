Return-Path: <netdev+bounces-282234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HLzFD2I8WnNhgEAu9opvQ
	(envelope-from <netdev+bounces-282234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 06:25:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A49FC48F2DC
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 06:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 148DD303A25C
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67502389116;
	Wed, 29 Apr 2026 04:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="JhDW8RIr";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="VBSVFHED"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0634937C0FE;
	Wed, 29 Apr 2026 04:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777436523; cv=none; b=irDCiOxpPbX0ohCIckqIbm0fMZ85xWmvzaApNvResPY6H093b6ThVmchEi0TTRiOQi7o+x5naG//6ijAJazU7iSi+jq/VJi5WMJJ0EDEOVIVuBC1luNdZA5gFmaYJG6CXgXd5HJpopww3Zj9Y/wV2od3hAV43qGg0Iot/ChKzKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777436523; c=relaxed/simple;
	bh=7l8u/XQ9bYX9CGyvV76WF8axww133+ROWtiMEj52Guw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ulg7MEraT+1GAFBUasTB+TDyXGhI+NHJsRWP/wUFuyr052YgjIkm/c4Zf3Gfw4+2Pc5mjA5YhW7ZRhxUJwrLD1+BIWggj9d9L55a5o49UdAW3nYy0UGsmz0EAYIAAA0BLa+kChyqbHkoHM8v8IpGvM4isaoClXvhqVO1AjBV+S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=JhDW8RIr; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=VBSVFHED; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777436520;
	bh=7l8u/XQ9bYX9CGyvV76WF8axww133+ROWtiMEj52Guw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JhDW8RIrrLQRlt2g392k+KxdcsoyS7AS8jLXsBjh4kJ6EGT1sMMHboWP7N4YQcg06
	 AvivAnJx/ZqAlRfS0/G/HcKSCLTwp+ZWbRX4XJNmu89SyMyKvK38FpNtDs4SNLT9Tg
	 7+MY+n4OypakVuy9a0pwmvZz89WvFDcQppYJ1zZ8W8UtDk6Q/UlumocpkjH6OJiJfQ
	 z4YHgUP8KSMbP2dAB0tQAj561pTvplPKzNOaTFLu7CrMGy7co2mf0zO0ZRymTH1yUi
	 ius7F/4/+AlSHbFXvgHiglbTIf7NvA0DWmYeCnQz+i6gn/Jqii8RunJP2AK4LTqbq7
	 MK9VGW0Tw8ouA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 6FAD847E06; Wed, 29 Apr 2026 04:22:00 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777436519;
	bh=7l8u/XQ9bYX9CGyvV76WF8axww133+ROWtiMEj52Guw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VBSVFHEDZl9BFlVTFuFLwkvXn7F9jP4Jbt1FL9dSEHqRDpUAklut/8upHFmFFyTx5
	 GO2BwuTjgr3M8fdd1E+ruxC2b5IIHHKjLteVwbOy7A57yd90EjoqaKfbzvxC8txS9/
	 lmhwkygcu/uEBH/CofFC941xwA2W8q7i0DHwKu71ytT8kPLiS9MsDvggDxQREfhaLz
	 +QSnkNDl9UIUWi6hEGCYqWDDBamLo3ZgUGTRb2PcCaSNXHwySuJF+HhUbHaFqCkIbS
	 agi3dOhDBFNpQEz6N7o10fWe9dAaDdltkSRpbvlsWkH1/FnD/XAbxDKVGjSgok0wnw
	 Hsj8O3PGLLZ2A==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 4211B46FB8;
	Wed, 29 Apr 2026 04:21:59 +0000 (UTC)
Message-ID: <877f67bd-6bd8-4d61-8f7b-d206b9125eda@birger-koblitz.de>
Date: Wed, 29 Apr 2026 06:21:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/4] r8152: Add firmware upload capability for
 RTL8157/RTL8159
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chih Kai Hsu <hsu.chih.kai@realtek.com>
References: <20260428-rtl8159_net_next-v1-0-52d03927b46f@birger-koblitz.de>
 <20260428-rtl8159_net_next-v1-4-52d03927b46f@birger-koblitz.de>
 <d9d69a5a-be6e-4566-9ec3-e742f745a530@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <d9d69a5a-be6e-4566-9ec3-e742f745a530@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A49FC48F2DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-282234-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[birger-koblitz.de:email,birger-koblitz.de:dkim,birger-koblitz.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 29/04/2026 3:57 am, Andrew Lunn wrote:
> On Tue, Apr 28, 2026 at 05:47:24AM +0200, Birger Koblitz wrote:
>> The RTL8159 requires firmware for its PHY in order to work at
>> connection speeds > 5GBit. Add support for uploading firmware for
>> the PHYs using the existing rtl8152_apply_firmware() function
>> in r8157_hw_phy_cfg() and set up the correct names for the firmware
>> files.
>>
>> If no firmware is found, both the RTL8157 and the RTL8159 will continue
>> to work.
>>
>> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
>> ---
>>   drivers/net/usb/r8152.c | 15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
>> index 08cc3c1dae0facb2400890ba4d093c97ed56d40b..56e00fe6f32405ce753df3e03e54a7daaf1a29ac 100644
>> --- a/drivers/net/usb/r8152.c
>> +++ b/drivers/net/usb/r8152.c
>> @@ -4663,10 +4663,11 @@ static bool rtl8152_is_fw_phy_speed_up_ok(struct r8152 *tp, struct fw_phy_speed_
>>   	case RTL_VER_11:
>>   	case RTL_VER_12:
>>   	case RTL_VER_14:
>> -	case RTL_VER_16:
>>   		goto out;
>>   	case RTL_VER_13:
>>   	case RTL_VER_15:
>> +	case RTL_VER_16:
>> +	case RTL_VER_17:
> 
> Is that a bug fix?
> 
> 	Andrew
No, since the RTL8157 (RTL_VER_16) also works in my experiments as 
expected without this change, i.e. without any updated firmware, or 
better the possibility to update the firmware. It is only for the 
RTL8159 where the firmware is necessary to even get 10GBit performance, 
at least for the link-partners I use for testing. My understanding of 
the Realtek "firmware" is that it mainly provides updated calibration 
constants, possibly better calibration routines for interoperability. 
Unlike for many other drivers, the firmware is not necessary to make the 
driver work at all.

Birger


