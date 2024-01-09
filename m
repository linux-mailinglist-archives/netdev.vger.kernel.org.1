Return-Path: <netdev+bounces-62658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943648285F0
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 13:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9BCC1C214CA
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 12:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5410C381AD;
	Tue,  9 Jan 2024 12:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="BK7Tfngp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983BD374F5
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 12:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e7d6565b5so3098498e87.0
        for <netdev@vger.kernel.org>; Tue, 09 Jan 2024 04:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1704802694; x=1705407494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K4o30ABpMr7Bq13YJsCb13n+Tl2g9yqdUhB9B1VXl9o=;
        b=BK7Tfngp0r3BZnK1sONL3H99Rd1eXFspXgi3zYQrqSbpDi+rXHlGx8YEnVUSSvhEZz
         ctTMb8vNenCU87/OwyXmupR8Z219epjWnXAy3WX9ZfOaKzIKBd01bZDj7ip/V1NNQ/w3
         fFHv+tqPn3KMmI7ZB+ZcsgDlj11ajoWHT0dYSS8rMrrryNLMc/sRsi/xX/6K7aZfxnTa
         e8OLSMRgsUNybvdaHPq2w0+uKCNXXiIF5mzO2Y/n9Gf2AcoasjaW91P6hxocx4FejggC
         9cqKo+RqAYaHQtvWcPtmxIPE2OJzJpag2eFD8bgqal1Cnwp38wql6yI5p1dFFaqDeQri
         TmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704802694; x=1705407494;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4o30ABpMr7Bq13YJsCb13n+Tl2g9yqdUhB9B1VXl9o=;
        b=hlWt5mRI6+jkgIDh1G2X5ShlTAZRTRSDVH7IwmOGWpt5LdulnGV7FoAnSghGV+k6oy
         mwcPQJO9Qz8iucbGqBNByfHSAPrCxsi/FoMwwn7LjAkpByRjJ1WrKsoa2c/btlyA+PsZ
         Rurwjp3Mc5+tneclbJiKWTpUBRvue49gk9Tetqno8F246QeSxqss4WsodPGaTvxkBnDH
         gMV9ipzR2i3WdeRL+mnRbWndXfWUKhCU5VNT0aw6/eBRLn+l1Foj0z84aLBQOmLpdHO3
         BPaPfc71r7YYNuP6eJsVp+rcgdZqGmLLhpC/Afv9hKia4MPY+2sL1YRQoi6BrvDb0L98
         /ygg==
X-Gm-Message-State: AOJu0YwfU3oV0pQwYrtEYL0uFVhnIdlujYnIDKU30pC7srJFiH8Cj3WS
	IAjdgJjKndtlKMU6AzWyOksftoDI72M9sSFTGtHFX/aqq5Q=
X-Google-Smtp-Source: AGHT+IF1/PGrT36cR+6Co+y13HT1pGnewgTjb83DEzZfw5J2HnCOx18Rnpif15x2UqvgyXC4W3Nhww==
X-Received: by 2002:a05:6512:31c8:b0:50e:20fc:5136 with SMTP id j8-20020a05651231c800b0050e20fc5136mr2801351lfe.71.1704802694445;
        Tue, 09 Jan 2024 04:18:14 -0800 (PST)
Received: from [192.168.0.161] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id b19-20020aa7dc13000000b005574787f023sm898698edu.52.2024.01.09.04.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 04:18:14 -0800 (PST)
Message-ID: <73f2854c-f532-462f-addc-f275fbd3e5d9@blackwall.org>
Date: Tue, 9 Jan 2024 14:18:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: bridge: do not send arp replies if src and
 target hw addr is the same
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Felix Fietkau <nbd@nbd.name>,
 netdev@vger.kernel.org
References: <20240104142501.81092-1-nbd@nbd.name>
 <6b43ec63a2bbb91e78f7ea7954f6d5148a33df00.camel@redhat.com>
 <e5d1e7da-0b90-45d7-b7ab-75ce2ef79208@nbd.name>
 <88e2f7747f9692d1585d84a4c75a46590b9e76c9.camel@redhat.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <88e2f7747f9692d1585d84a4c75a46590b9e76c9.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/01/2024 14:14, Paolo Abeni wrote:
> On Tue, 2024-01-09 at 12:58 +0100, Felix Fietkau wrote:
>> On 09.01.24 12:36, Paolo Abeni wrote:
>>> On Thu, 2024-01-04 at 15:25 +0100, Felix Fietkau wrote:
>>>> There are broken devices in the wild that handle duplicate IP address
>>>> detection by sending out ARP requests for the IP that they received from a
>>>> DHCP server and refuse the address if they get a reply.
>>>> When proxyarp is enabled, they would go into a loop of requesting an address
>>>> and then NAKing it again.
>>>
>>> Can you instead provide the same functionality with some nft/tc
>>> ingress/ebpf filter?
>>>
>>> I feel uneasy to hard code this kind of policy, even if it looks
>>> sensible. I suspect it could break some other currently working weird
>>> device behavior.
>>>
>>> Otherwise it could be nice provide some arpfilter flag to
>>> enable/disable this kind filtering.
>>
>> I don't see how it could break anything, 
> 
> FTR, I don't either. But I've been surprised too much times from
> extremely weird expectations from random devices, broken by "obviously
> correct" behaviors change.
> 
>> because it wouldn't suppress 
>> non-proxied responses. nft/arpfilter is just too expensive, and I don't 
>> think it makes sense to force the use of tc filters to suppress 
>> nonsensical responses generated by the bridge layer.
> 
> Then what about adding a flag to enable/disable this new behavior?
> 

If you decide to go down this path consider using bridge's boolopts. Personally
I still prefer to avoid adding such policies in the bridge, but instead to implement
them via other means, it's not a hard "no" so an option with default to current
behaviour would be acceptable.

> Cheers,
> 
> Paolo
> 


