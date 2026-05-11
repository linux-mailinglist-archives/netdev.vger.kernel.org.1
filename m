Return-Path: <netdev+bounces-286810-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wfR/I1wxAmrSowEAu9opvQ
	(envelope-from <netdev+bounces-286810-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 21:43:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3A1515371
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 21:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD015302DF40
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B0B4CA295;
	Mon, 11 May 2026 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HT9yZdMd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F91E298991
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 19:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778528600; cv=none; b=RB5TEtxoZZqaxJH23EDkQk9NTQ5MTB2pAaSomcCeSEm+2RmAJpRq5fOxrbZFBCDR1+Y4nyscWKm/x6E6OWGBzeTpXp5BkmHotH4WB4Tz4xiIF8jkc3JclcQmlyZ+SM8hEViue/pmWNd6Vd1ooV6CXMXyuIUbi4nLIZ9Qp14hpW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778528600; c=relaxed/simple;
	bh=szLzmRZarXyWr8SO+fRMyJ6QTaS/hMAQekENEHmtaLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ivNye/jaE5paM06JbVGNl3xRtvx1q76ytDV/0YaU9GZCO1AkWmS6PdEN7dV4tBLmSCHeiKxsiNzNPoU7gFX2CTbFrGRwAIe0aDQr20A2uH+mIgzU6AKbFPOTz+NKAKFrEgYCcUR38m2HQ9cFOHzuTv915BCsF8ln83/O3XsI06g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HT9yZdMd; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-902deb2412fso512707885a.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 12:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778528598; x=1779133398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pbeL3Dfq5lDna1KNPbdBKzZTNNWlbcBTDo2AtQ5eJ78=;
        b=HT9yZdMdlq+vc2reVxqBjHcSsktuMr+XHvwY7OceuuCfkCo1d6AxfvsCPD0Tyx7iwV
         Ayva66nUfy3IaTwoPyNTsO9bGyX8fMv4+Sn2F9hEDTpx8LE1xmbESCmEk8vKT+jHHMFd
         l0yAfAf3qJD6TcCAb5fT78DHzPfdthhUKvUUu3Z/MaEHQpq5FHh7ZJhYi+X0cHNfepZ0
         YRn+kHOnL0LD2GpWG612HRQ52jHGDNc3AxHqo6bcFjhp7qyIBaEufMdXtvYeD6SwE1tM
         TDjEh0jhgDUZPaJTN9f6u2FWq9Jnhv3tGd+GnEHPyek3QV0x0yPrUd7Otmhyx825pMzV
         JeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778528598; x=1779133398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pbeL3Dfq5lDna1KNPbdBKzZTNNWlbcBTDo2AtQ5eJ78=;
        b=HBNEeFhDWsJF/FffLiyGz2wPoK1iYGZ+aeKaBNenN27VAcuvevYxNtKHy5Bj4fF19E
         YaFwDDBQ6DWVwH0G23fgIbMsYjLpYP5QDqZkByZLipsFYp27k5V2aJ/atx0eAIIRa96p
         iwH92C1ZlXPmxsfxO4ooeXBQG8AtTJUFrpG1O+Q2v/K/89+yW+jKdZqOrd/Zpf8UkRb/
         kMuuDcVnE0q60FyvJLUCxkhKJWXfqDfpbHwXCGZiMUqoRV/FyMe2qX6gfIDfeftFhB8N
         /1ZJxnYgxc7RENzPGnHZX5jF8iAo1723qqFMsCjQMK/FNxmk58bSX6SbftEZ3IFtkxMt
         +OnQ==
X-Gm-Message-State: AOJu0YwNc31/0QfOZtO5DVxi/N0ivbfJ3ncd5t/mEK/zl2DwP3BAAblV
	Zh25hzqMU28dujy+MI6M34m0+2jWnCEQ8Fn0fnTfjjaoj9Xjcgk9XxCl
X-Gm-Gg: Acq92OEqLPBirpzrBF7eFyYeNfoR8SPxmymzt7jMlf2WIKeDyvkxTDSa5d1kpWlXNle
	QX9BEnHIanGCl3MdM36zeBeuFi2Gwq8OQlRrQP+zI302foPDyvaegcQLhtpNlZxuruzh3uhNQHI
	8aQvi3espuG32FSYf5pThAAy82F+kBYX62Q/Jp9rxIVWXd/YSBThTB3OBaW1t1dce07r9uX7TEF
	8V66rvws95L9AcS+76Klkjt/D0VWvMzCRG8aMPYIqkRLMc8s6UCvvneySSLH8nRdN2C+CgC66WO
	49c4ESyoGilMR+HxZeISM69L8BIUIsryzZT31xYPROdwNrua+Z7f3pu9V/ma/WxMqMZ0vDrNFFH
	oRAalBIjif02UTxs+2Lkc3grsVEb9cl7ZrA6zWf/S73JSD69sQGxvMXE/qk9ckHHuXTKl3rd0ZM
	N+t3FgCeT0fLL617qAVkfi4uF40SeYQ3pKAt5LzXYVBX6At27zLJQJKSyMIJLx1X8IuDWHTA==
X-Received: by 2002:a05:620a:a58:b0:90c:e49a:ec1e with SMTP id af79cd13be357-90ce49af921mr25510385a.15.1778528598324;
        Mon, 11 May 2026 12:43:18 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0a8:11d1::1011? ([2620:10d:c091:400::5:9448])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c9229c8sm3444411185a.36.2026.05.11.12.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 12:43:17 -0700 (PDT)
Message-ID: <e961b20a-8bfb-4142-b7c1-14c640c47df0@gmail.com>
Date: Mon, 11 May 2026 15:43:17 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/6] netdevsim: psp: remove unnecessary UDP
 checksum computation
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260508-nsim-psp-crypto-v1-0-4b50ed09b794@gmail.com>
 <20260508-nsim-psp-crypto-v1-2-4b50ed09b794@gmail.com>
 <willemdebruijn.kernel.1d153b0dc9762@gmail.com>
 <d962b7e2-7506-4ae6-91c1-58b4e712270c@gmail.com>
 <willemdebruijn.kernel.20208e72aa400@gmail.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <willemdebruijn.kernel.20208e72aa400@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BB3A1515371
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286810-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On 5/11/26 3:01 PM, Willem de Bruijn wrote:
> Daniel Zahka wrote:
>    
> @@ -81,36 +79,6 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
>    			      skb->len - skb_inner_transport_offset(skb));
>    		u64_stats_update_end(&ns->psp.syncp);
>    	} else {
> -		struct ipv6hdr *ip6h __maybe_unused;
> -		struct iphdr *iph;
> -		struct udphdr *uh;
> -		__wsum csum;
> -
> -		/* Do not decapsulate. Receive the skb with the udp and psp
> -		 * headers still there as if this is a normal udp packet.
> -		 * psp_dev_encapsulate() sets udp checksum to 0, so we need to
> -		 * provide a valid checksum here, so the skb isn't dropped.
> -		 */
>>> Perhaps this was here as IPv6 does not allow zero checksums except for
>>> tunneling in specific cases (RFC 6936)?
>>
>> Yes it was originally here for IPv6. It was needed to make a test case
>> pass that ultimately never got upstreamed (yet). The test basically used
>> the psp_dev_ops::set_config() function to turn psp rx off midflow, and
>> then tried to catch packets with a udp socket listening on port 1000. At
>> the time I didn't realize that I could probably make the test work by
>> opting the socket into a setting for RFC 6936 with setsockopt().
> Just curious: which setsockopt is this?

I was thinking of UDP_NO_CHECK6_RX, though I probably shouldn't have 
characterized it as relating to RFC 6936. I haven't dug through the code 
or history to figure out if that was added for tunnels or to implement 
that rfc. I can see that tunnel driver callers of udp_sock_create() can 
configure the 0 checksum behavior, which seems to actually implement 
what's described in the rfc.

>> though as I mentioned, none of the current tests cover that the
>> psp-udp csum is correct.
> .. actually based on this, preferable even


I agree. My plan would be to add the psp-udp checksum calculation back 
when we have a test that actually depends on it to pass.


