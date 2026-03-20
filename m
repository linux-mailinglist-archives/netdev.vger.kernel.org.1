Return-Path: <netdev+bounces-269793-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJpQBzjbvGk63wIAu9opvQ
	(envelope-from <netdev+bounces-269793-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 06:29:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 688AA2D5F88
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 06:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE72930879F8
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 05:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E5A2FCBF5;
	Fri, 20 Mar 2026 05:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="b4dTk39X";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="b4dTk39X"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F50B279DCC;
	Fri, 20 Mar 2026 05:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773984564; cv=none; b=B/+rL+QxdJhVUHk0HFbauZbZT8TMwTM5ynzw5dDLmyoG3QgFBzve7bIejn5nH06GmOIM0Lyrv5vUPCKGxgtvGltkJP6PekhU0Kwp4BoyANjePbJDRS1dfJaXM7ioK3RxOUC9p5HAjlOL3ZhLRjBTC91sb7At9Z/906Q3I8d85Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773984564; c=relaxed/simple;
	bh=5TVNEMyUV6Nyt8igSSYIMZQ785TLtaLYhsQIRWIusQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GGwsqsa0spyV4htC6upnXV+7gs5gGcZrGmAA4fMbAFki+Dqa1jH2SUz/2wtSXzu4ugTCCKW+fk/x21D6vh0TBpLISsAL4IrnTr65OfRgQhOK8HqmCMDKAQSX+IidZ6zQtiXt0gy7pg9TuFtOzw58hk6CtkqnyunN3zvi+jgKvxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=b4dTk39X; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=b4dTk39X; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773984561;
	bh=5TVNEMyUV6Nyt8igSSYIMZQ785TLtaLYhsQIRWIusQs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b4dTk39XxeASjobqM5VCZZFikZZ0nNpuQsorBt627XPAZ2f238drrss32u+PD8v8+
	 EflKBJqgCaIHw6Fz0MLbTIe55TyI7Y+VrzXNk5zEjEgJP8JvS8og3x3Ly4pR/vTsLd
	 3eI6eOu8p561kkPQV6vckomlWDy+w1zBNXnslRKBiqoFgJSeNNIJ4XT4fff8epC2AU
	 nAva5Eb1T6/aM+CcnuFWJc2gQHExk531mwSQkyr9arCm834ct+yw2KRqcljJmxDtBY
	 v/DZF3RxTAy+vlLAbu+m22UrTKCt9CeO8q4fWmC3VON+Rk/pYNVbE6kFB5EewSUu1Z
	 Cmg3IxVD/BP7A==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id E28F33FEE3; Fri, 20 Mar 2026 05:29:21 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773984561;
	bh=5TVNEMyUV6Nyt8igSSYIMZQ785TLtaLYhsQIRWIusQs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b4dTk39XxeASjobqM5VCZZFikZZ0nNpuQsorBt627XPAZ2f238drrss32u+PD8v8+
	 EflKBJqgCaIHw6Fz0MLbTIe55TyI7Y+VrzXNk5zEjEgJP8JvS8og3x3Ly4pR/vTsLd
	 3eI6eOu8p561kkPQV6vckomlWDy+w1zBNXnslRKBiqoFgJSeNNIJ4XT4fff8epC2AU
	 nAva5Eb1T6/aM+CcnuFWJc2gQHExk531mwSQkyr9arCm834ct+yw2KRqcljJmxDtBY
	 v/DZF3RxTAy+vlLAbu+m22UrTKCt9CeO8q4fWmC3VON+Rk/pYNVbE6kFB5EewSUu1Z
	 Cmg3IxVD/BP7A==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id E70B43F9FD;
	Fri, 20 Mar 2026 05:29:20 +0000 (UTC)
Message-ID: <3bdcd08a-8001-4343-b150-693b58ead886@birger-koblitz.de>
Date: Fri, 20 Mar 2026 06:29:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] r8152: Add support for 5Gbit Link Speeds
 and EEE
To: Simon Horman <horms@kernel.org>
Cc: edumazet@google.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org, pabeni@redhat.com,
 kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net
References: <20260317-rtl8157_next-v2-1-10ea1fa488d1@birger-koblitz.de>
 <20260319165100.1988286-1-horms@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260319165100.1988286-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	TAGGED_FROM(0.00)[bounces-269793-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 688AA2D5F88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Simon, thanks a lot for reviewing this patch!

On 19/03/2026 5:51 pm, Simon Horman wrote:
>> The RTL8157 supports 5GBit Link speeds. Add support for this speed
>> in the setup and setting/getting through ethool. Also add 5GBit EEE.
>                                            ^^^^^^
> This isn't a bug, but there's a typo: 'ethool' should be 'ethtool'.
Will be fixed in v3.

> When rtl8152_set_speed() sets tp->ups_info.speed_duplex = NWAY_5000M_FULL
> and r8156_ups_en(enable=true) subsequently calls r8156_ups_flags(), the
> switch falls through to the default case and no speed bits are set in the
> UPS flags word.
Yes, this analysis is correct.

> 
> Is the UPS power management configuration incorrect for 5Gbit link speeds
> without a case for NWAY_5000M_FULL in r8156_ups_flags()?
The out-of-tree driver also does not set any flags in USB_UPS_FLAGS in 
the 5000M case. Maybe this is an oversight in that driver, but according 
to my tests, the power management works. In any case, I would not be 
able to guess the correct register value with any confidence for the 
NWAY_5000M_FULL case: the bits are different from the speed bits in 
PLA_PHYSTATUS. The RTL8157 also has other differences in USB power 
management compared to previous generations, such as introducing 
register USB_U2P3_V2_CTRL. So, to the best of my knowledge, the proposed 
patch is correct.

> 
> This path is activated by the next commit in the series (58ba3b6c476d
> 'r8152: Add support for the RTL8157 hardware') which sets
> support_5000full = 1.
> 
> [ ... ]


