Return-Path: <netdev+bounces-282233-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cL4WENyD8WnihQEAu9opvQ
	(envelope-from <netdev+bounces-282233-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 06:06:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA00148EF54
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 06:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6477C3009CEE
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE342F12A1;
	Wed, 29 Apr 2026 04:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="yVyr+EhR";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="ksdqMqjy"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF2624A067;
	Wed, 29 Apr 2026 04:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777435595; cv=none; b=rWVusDgPVpTyXeeSRGv9CrMq6J3lvx0t+FUhD/uZoHjMRBZDrkFhCeQJTm+m34x2iPp6cOuNLLhLd++gNq0bJTT2CbEDPOojtSX+eI/tRiC6MBhC5b6dHqfWBAVm8yFv/NQmsd+zCMKNKWGZfPC/E5FDCEB3iopqLhMralrzOTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777435595; c=relaxed/simple;
	bh=j61Vay+FtdT936qn7W/yr4bXC4HItVT4+lmWwjGl/Oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OvQN6ywc6FL2hvKAxcMsxr4mHjnY8CF/CUtrJB2Qwhzn/lhWN/FDf7LSV13Fkm+hBbv2uDKty/PLMve93P/vtfuosHPQhvVlWqSfpl3aUGhOnID9BbM/lMY9BKeCP3YGi9kJ4U5WqQ3gnimPxWRzUFe8KP0SuaaEbjrPDrmWg3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=yVyr+EhR; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=ksdqMqjy; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777435592;
	bh=j61Vay+FtdT936qn7W/yr4bXC4HItVT4+lmWwjGl/Oc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=yVyr+EhRXqlQfoIPoCNsOynXKrWvHDtsbLXmeRZXdiMuTKhZeTRBy4HCPIBWh0jbG
	 tbSBUQmb5StDa1MB5kgMqkkt7ix1yUZ9Sx4mYYPQDkKA1aao+tloYH1elRcBm+tcb/
	 z2k6Yo3gNzxm/nLqlakkm9nlmpojv3uPphqIZ00A6H0HoEWe5QO4+ZMqzRZ0fRVAE1
	 s92rnDJ5FaxZOMJ9QTmOrumS6ZBIPqr/4530NQ+Gmis+Mu35FBwjkzkQ+uZ5JHez+7
	 UMG6h/RHnFWEGlaYKmL6Ec8GQWhuULVVYhv1zXMoBAypTvymztMZOeynzE85IUYJUv
	 WX2kYNl5Itlww==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 8587B47DF8; Wed, 29 Apr 2026 04:06:32 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777435591;
	bh=j61Vay+FtdT936qn7W/yr4bXC4HItVT4+lmWwjGl/Oc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ksdqMqjyQ1w62Zloz2LmQaXAq+ZYhrOlnuUTLVk+c0GV0PTdpC5ZxRP7liLHD1wTy
	 n+NbtnO9Ak3W76yiUZxwnN3TC4TD6uxA0QbzKhygQg8nQ3r/iGGteSMLf/x2XS+vw+
	 FGERae8KROf57oFg7SOmUMNlEps5bfBY4SVBRiYZZ5/zynSzhmGyDMYXuvPWEyUH+Y
	 P6RGt9kkhfJglx7x0kaUJO/znKjv2zGfIiUATGqpW+agMueRg26Jvc0cxF3WitqlS1
	 FQbbAm1/7yjeX+Nfjn3t8tEJRS9zVtb8armc1ydXrdj6uXU5e/PTdWqbzGQ3906p6d
	 JJpEGCRBSboEQ==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id A769E46FB3;
	Wed, 29 Apr 2026 04:06:31 +0000 (UTC)
Message-ID: <9feb0bc1-b817-46f8-9092-e2beff30ec9d@birger-koblitz.de>
Date: Wed, 29 Apr 2026 06:06:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/4] r8152: Add irq mitigation for RTL8157/9
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chih Kai Hsu <hsu.chih.kai@realtek.com>
References: <20260428-rtl8159_net_next-v1-0-52d03927b46f@birger-koblitz.de>
 <20260428-rtl8159_net_next-v1-3-52d03927b46f@birger-koblitz.de>
 <06a42ba1-b714-45b1-be30-4a793752e495@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <06a42ba1-b714-45b1-be30-4a793752e495@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CA00148EF54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-282233-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,birger-koblitz.de:email,birger-koblitz.de:dkim,birger-koblitz.de:mid]

On 29/04/2026 3:56 am, Andrew Lunn wrote:
> On Tue, Apr 28, 2026 at 05:47:23AM +0200, Birger Koblitz wrote:
>> Add interrupt mitigation code for both RTL8157 and RTL8159 that prevents
>> USB interrupt callbacks with urb->status ESHUTDOWN being triggered. While the
>> issue is rarely seen on the RTL8157, without the mitigation, it is
>> common on the RTL8159:
>> [273.561863] r8152 7-1:1.0 enx88c9b3b5xxxx: Stop submitting intr, status -108
>>
>> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
>> ---
>>   drivers/net/usb/r8152.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
>> index 8255261d73148a7b4dabe0188faf07cb1f356437..08cc3c1dae0facb2400890ba4d093c97ed56d40b 100644
>> --- a/drivers/net/usb/r8152.c
>> +++ b/drivers/net/usb/r8152.c
>> @@ -8444,6 +8444,12 @@ static void r8156_init(struct r8152 *tp)
>>   	else
>>   		r8153_u2p3en(tp, false);
>>   
>> +	if (tp->version >= RTL_VER_16) {
>> +		/* Disable Interrupt Mitigation */
>> +		ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xcf04,
>> +				  BIT(0) | BIT(1) | BIT(2) | BIT(7));
>> +	}
> 
> What does interrupt mitigation do?
> 
> Is this a different name for interrupt coalescence, where the MAC
> delays interrupts for a period of time so more packets are in the
> receive ring when it does interrupt, so reducing the number of
> interrupts, and bigger bursts of packets are processed at once?
> 

I do not understand what the mechanism behind this is, there is no more
documentation in the original driver. I experimented with this for some
time and the effect that I see is that it prevents interrupts after
shutdown. That is, why it is already done in rtl8153_unload(), again 
like in the original driver, where it was more critical to prevent the 
warnings.
I was hoping that Realtek could enlighten us.

Birger

