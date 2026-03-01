Return-Path: <netdev+bounces-262369-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOTOIe29o2mPLAUAu9opvQ
	(envelope-from <netdev+bounces-262369-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 05:17:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F0F1CE7DC
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 05:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 404F2300D69C
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 04:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D8A2DEA8F;
	Sun,  1 Mar 2026 04:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="bfdShYOc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ED81F875A
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 04:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772338666; cv=none; b=HVYM9UdpR4F0+w+ZncwGFS4N+fubwgpi2OHeH/4Ze1HX9Vfsppz7rfoRazaIOV0MKr/0+VzvaZCxFI/R1658cOFin/jbpvexRgxKRdo9mxga8trA8MMESdjvFwCdVmmnZuUPiQ4KT/r6cOM3u3dELRf1/2PGy8dSbhHiBL/kTrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772338666; c=relaxed/simple;
	bh=KJJ4cECWizV1DiLSPDhnm1jFX56BfKavUCiZVsqReZE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=juNd2bbynJ9O5MSxg//EN7RrXJ7mviYojHWl014rp6Ed+ROMAajMlyrU9sDBPlWDWaLbx3psxu9r7KvEuE5jAWdKuMSnOejxVGjKnu5Un9ZivebtSpSXJ53JigD2L837yB8cv23B0V71q3fhCq/83YS65hUfG8SuZR/Piq5V37E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=bfdShYOc; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cb39f64348so334027585a.0
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 20:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1772338664; x=1772943464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bkf58p5E6mW2R8Vu+Y4ot2ZtwCQqP1cLlx5WZ51GBr8=;
        b=bfdShYOcYr8Rhbpf1FO5GctCD2ysBQz3UwrmK/ykI71FigDKdoyWHL3gcTMDuTEQIJ
         0M0pS9Hi3u/jyBgel0KkjwX4BzBVSzKJB4JrPJStQ5MUPUdHXl7n9x9KWk5MOirqskUU
         kwfDbI2Ig9zz6uIOhB6JBMVfGD1Y1SVyz3JFqOzrDZg6P/f1Y7wAXcSKnh0CVpO1kasy
         ZR/EUFpolU3nPvpvjMRh0DvU9Xf/WfHTyIuAqg/jtCang3xOwMu6gCHIvoXTmdpcuDNM
         kPW3qaSb3mMGtFyoFTESjn49Y5qBeIEkQlUQHLY201u8MtXjKlHsAHAv4LYCtYwYmNQE
         b7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772338664; x=1772943464;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bkf58p5E6mW2R8Vu+Y4ot2ZtwCQqP1cLlx5WZ51GBr8=;
        b=pcrmfe8gpQpBTyWZ9jBIlpjMw1Swci+NKhr9fBo+2wHgUvcw7rJrOE/LOnZo14nUYg
         dtWHOVasT7ljB0WpqqMCMTrfRIqDTK7QOS8mKzdEP6OKIyQfec0Kf8qxapys+wkcELSC
         y6MHnvsIXJFNaHfqBXxs7AQvSPpe37N/LCO+n6aL+3rbdDiRrdoHZgkM1OovuFcn9RHM
         Q5kmjAX16KQfZzqVvVd0KrTzXhau7LlPeDvN3fd5Yq58+Pdj+Xb4TUWCU8x9PWOCAw10
         ktIMTLbggkp+KYGqWBnDAXAh7c0ThlGJjQQZya984UwDRQgK2A0QqwDY6t959epjd7hl
         PwZg==
X-Forwarded-Encrypted: i=1; AJvYcCXJijVQvPB80hgRKnt3KjUQjv9HwvwJIBfvvRrMI5BAtq1iSJbhA/XnxnBgGoYCyZyfbMrQVjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDHfjLzw48zibeS0KTLd6WobOfP7mokKEBBlykU7QX3nM8LOVb
	k72nIBVHq1Ngvw0WFpQdGQhLQMzHiIBGrpocRbM8CxIQpxIMOFFezcW3jKt8c0Q3uy8=
X-Gm-Gg: ATEYQzxcQbkPMeBHq+Ifm89I2FyN/E3sOy9KueSb57nitESwjeHP8RjuFA24kOEPKGG
	QkaGwhBhnj12GBHTGLMKXtn85VHz8E7c7LNxea1uV/R9N4Z30IWhGw8nSeorYtkc4nF5qGLWrJj
	2g1Wwgj4KfuDOca0dXfB5pCTCJG/pXQJg7waJFXopr9C4jKzBG+/oZ+2EXZfR64xwYl5Ve11chu
	AkJCYsKKbxFdxFt5BWpZoovV+dyU4ezLAOvTkee0bcDhVD1GwYmFE0n8wI2/BP/lq+hku+l6qQy
	h9MVlkyrPu4d+Fg6fwi6n4gCbVTFNfXlS/kofZ7AO7hsnUJGRg3813vMjclAmuT58GguBfEsztR
	MNqvfivnELo4ZHYmn8lODy7kIkPse5MOqKfHFrWhX7ryY2cWtsG32slOo6A6tMICf9qhi1brwwj
	5rMVbRV66HK1xtVXiCAaF2HYqeM/qbzKc1rmxk0KBVtv0Lvvqu1fdvHXvA/E940IC5Cg==
X-Received: by 2002:a05:620a:3f97:b0:8cb:4543:c5c5 with SMTP id af79cd13be357-8cbc8d988b1mr1104673585a.22.1772338663956;
        Sat, 28 Feb 2026 20:17:43 -0800 (PST)
Received: from [192.168.86.87] ([136.27.45.11])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf746fc5sm850052785a.51.2026.02.28.20.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 20:17:43 -0800 (PST)
Message-ID: <bf1032b7-44ba-4ccb-92e2-b221bd753bcb@davidwei.uk>
Date: Sat, 28 Feb 2026 20:17:36 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 3/9] selftests/net: Add env for container based
 tests
To: Jakub Kicinski <kuba@kernel.org>, Wei Wang <weibunny@fb.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, netdev@vger.kernel.org,
 Daniel Zahka <daniel.zahka@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Daniel Borkmann <daniel@iogearbox.net>
References: <20260224002410.1553838-1-weibunny@fb.com>
 <20260224002410.1553838-4-weibunny@fb.com>
 <aZ3pl177Q6+uJCCN@devvm11784.nha0.facebook.com>
 <20260227183045.234a841b@kernel.org>
Content-Language: en-US
In-Reply-To: <20260227183045.234a841b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,iogearbox.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262369-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[davidwei.uk];
	DKIM_TRACE(0.00)[davidwei-uk.20230601.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davidwei-uk.20230601.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,davidwei.uk:mid]
X-Rspamd-Queue-Id: F3F0F1CE7DC
X-Rspamd-Action: no action

On 2026-02-27 18:30, Jakub Kicinski wrote:
> On Tue, 24 Feb 2026 10:10:31 -0800 Bobby Eshleman wrote:
>>> +Local IP prefix/subnet which can be used to allocate extra IP addresses (for
>>> +network name spaces behind macvlan, veth, netkit devices). DUT must be
>>> +reachable using these addresses from the endpoint.
>>> +
>>> +  +-------------+        +----------------------------+
>>> +  | INIT NS     |        | TEST NS                    |
>>> +  | +---------+ |        | +------------------------+ |
>>> +  | | NETIF   | |  bpf   | | Netkit                 | |
>>> +  | |         |-|--------|>| nk_guest               | |
>>> +  | +---------+ |        | | {LOCAL_PREFIX_V6}::2:2 | |
>>> +  | +---------+ |        | +------------------------+ |
>>> +  | | Netkit  | |        +----------------------------+
>>> +  | | nk_host | |
>>> +  | +---------+ |
>>> +  +-------------+
>>> +
>>
>> One thing I noticed when I tested this was the flow broke down when
>> NETIF's address happened to match LOCAL_PREFIX_V6. I didn't fully reason
>> through why this was the case, but maybe it's worth mentioning in the
>> docs here?
> 
> +1 I think it may be useful to add to the diagram some example using
> the documentation IPv6 prefix, to explain what the addresses and routes
> are in each of the boxes (and please include the remote).

Thanks, I'll improve the diagram to better illustrate what's going on.

> 
> Also
> 
> 	local_prefix = local_prefix.rstrip("/64").rstrip("::").rstrip(":")
> 
> please use Python's built in ipaddress. The standard parser will be far
> more flexible for user input

Got it.

