Return-Path: <netdev+bounces-271192-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0J3DBX3EwmlflgQAu9opvQ
	(envelope-from <netdev+bounces-271192-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:06:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 731CF319AC3
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CF32313D886
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2064E4070E9;
	Tue, 24 Mar 2026 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="JJPGGqPp";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="e3+ogGaA"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402893A0B39;
	Tue, 24 Mar 2026 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774371614; cv=none; b=kd6eB8HtdIj52U0LLig+GZ+JadiHAj6OvQKutzhLdeusDs0CkvqKEa/Q/s7X4q9ycXe3qz2yMzVoqtVLrNnI86y4YKSo2iz35P7BFlw+2GUhn5J6xwOChka30QWAOKxfvXuwvfzMJ61SVTILphLplEm1wOlWNhBu10+U4jt6+oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774371614; c=relaxed/simple;
	bh=u38ICIkw85dvG9+E0F0nmzvZgnzaHXcn9KNBe8qnq1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h5yMGEXoGkDTBzGMxy1+UBTWx6jcc9LQqdnwYCLD0RU+aJIwwgv6ylF3JGcn0j10hqDX0QocMvkizKsU/byGrlS8ZhL4i4hX905IHo5spdpOOCvmcAtc2s10r/aCfDoH7Wy98fTmC4wuaYHxZBiT1ZdqCtGrzTkmfNasoV6vpn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=JJPGGqPp; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=e3+ogGaA; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1774371610;
	bh=u38ICIkw85dvG9+E0F0nmzvZgnzaHXcn9KNBe8qnq1w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JJPGGqPp9WS4zDU3VQJMBcD6vZEEBfLEUZNnE8pobkbi4VPIARNJwtqroLcYeOSS+
	 9s54WB3Xt8y2v2GmQq9JcDEpwoAl4vENmEBicNmXqu3HZYL4osHGWx+W4fBd3BaObm
	 gwKySMoaEgU0WUyybO5BgFB+FL95aEV5v/0w6rugSOQiM2V7MDXgI76egl1ApBVIEt
	 bHCPOus4kDcp/tsS9xKKDqpyDExb1NjDKv1gBt/1YLj0+zJbkgdZWRvM478h9cNhyh
	 FUncr581tFpb2pzZa7hYABa9UKgUgBHMKWk2+FzXWwj2v7yHIkLjGf0uzAztTtzb8N
	 wsR38EtL11CIw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 1212C4006A; Tue, 24 Mar 2026 17:00:10 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1774371608;
	bh=u38ICIkw85dvG9+E0F0nmzvZgnzaHXcn9KNBe8qnq1w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e3+ogGaADFKrGah/pp6CbM4PKY/jvYT7WUKnlOUyLnpFQmSIXttQsHuNNr7LRH/G+
	 kvuTmBkyVmw+HxGdHW2HkPEnw2Vfc1NxOkmNKkvegfZ/Vu0JidnTPL/dW8uk7pJWWJ
	 Yx9XMIv6IJ99MfUtfJ8lqeb/mJFRQQtJYfrbkz03oM/jq6Z9aFFkORqeqsViyDomVp
	 +3837ujWhJDvfRluCwDa2uoExvgX6GTqEP4rC44o4kK1pYKJtZnKtLXmKjNOwCswI2
	 hxonwCIKCAGPyXY1DJSfO9P1gv9CRS+TOLNTJaEEpP9TThlJJMgbocHE86fyUUGJJg
	 AEbluBIQJ3tCw==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id E7CFC4005B;
	Tue, 24 Mar 2026 17:00:07 +0000 (UTC)
Message-ID: <eb941ea7-4bca-457f-9a40-5300affe7e8e@birger-koblitz.de>
Date: Tue, 24 Mar 2026 18:00:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] r8152: Add support for the RTL8157
 hardware
To: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260320-rtl8157_next-v3-0-1aefeca7fda7@birger-koblitz.de>
 <20260320-rtl8157_next-v3-2-1aefeca7fda7@birger-koblitz.de>
 <5ff51617-deb6-48b0-b9e2-2d7066fa2562@redhat.com>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <5ff51617-deb6-48b0-b9e2-2d7066fa2562@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-271192-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,birger-koblitz.de:dkim,birger-koblitz.de:mid]
X-Rspamd-Queue-Id: 731CF319AC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 24/03/2026 11:58 am, Paolo Abeni wrote:
> On 3/20/26 12:14 PM, Birger Koblitz wrote:
>> @@ -2022,14 +2277,14 @@ static void intr_callback(struct urb *urb)
>>   	}
>>   }
>>   
>> -static inline void *rx_agg_align(void *data)
>> +static inline void *rx_agg_align(struct r8152 *tp, void *data)
>>   {
>> -	return (void *)ALIGN((uintptr_t)data, RX_ALIGN);
>> +	return (void *)ALIGN((uintptr_t)data, tp->rx_desc.align);
>>   }
>>   
>> -static inline void *tx_agg_align(void *data)
>> +static inline void *tx_agg_align(struct r8152 *tp, void *data)
> 
> Since you are touching this functions, in the next revision please
> additionally drop the 'inline' keyword; the compiler should be good
> enough to get them inlined anyway.
Will be fixed in the next version.

