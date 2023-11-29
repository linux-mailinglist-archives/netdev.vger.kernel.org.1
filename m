Return-Path: <netdev+bounces-52258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1437FE09E
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 20:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369C7282722
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 19:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D618A5EE78;
	Wed, 29 Nov 2023 19:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="D68pgc9B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF43F12F
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 11:58:04 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7b3854d7270so3155739f.3
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 11:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701287884; x=1701892684; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T7FtbM3uCv3lCJgze8i3ailyZ7n1KeZA4b7KaXBphuU=;
        b=D68pgc9B5OHrjD1qFxlZF5KKwZTpaFtOuDdem9vOAEmj3woSoMeR9kx7SxpaJvVF/r
         UPdhWf0zPl8gFwtp6eMkDL3nu8HqNhn+OJT4QujIvh+vhbfS2PUXJTPS8IDfYXleUtZV
         TiTEN8WhpRJK67In+WzADbn6+HWJrS7O5IiV457RvkAvucMxjtKSLqLZx42wMc5U4z9B
         SunoMmnH+FoA9I69ULeUb6E02yQgVaVJExKtprI4Zo/8A86ffnwiEIbbp6O0u5J1ACd8
         cd8TY7djoThD15bz3B4mnTjzQL/84P7VX7I6pIDtNqgze05roCP3gHoHk+MBUH7qu8u4
         HBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701287884; x=1701892684;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T7FtbM3uCv3lCJgze8i3ailyZ7n1KeZA4b7KaXBphuU=;
        b=a+Pr3BDbU5j7Qsc8ibHYdb33tevJT54KxI6UdTTRoiG9IHpE9+GOLDx/6RQ7k6I1XK
         czD0sNplqBBpq32YK9h5hkyJYcZ/bNVnxBBbk6qeelUI8e0fwp+CYfnp55nhxTiVzr+g
         UIf3z6lF1kd8TroN4ZBO8HbjErQg9PokGKpfVTkJucS8LpOUD4BtM1plOVAUXhDpKztO
         EaSurfZxNk+fFVzkA+RcCooUovtUEDVDt/p0k1db3qUvhv2AthJ6L38i9hvIX0LMw9o0
         U7f76dLMrxEFlpPaxgEZvq3PjIuMPg42eEJpfAj/+3loNQ9MmIzccs1fGGjOWdeRq3no
         3p5Q==
X-Gm-Message-State: AOJu0YwCliGDw4YSkejKMhPBv/azWXFd4FiXqpeWNvGh2slJLEAPCaZI
	NzgarI9UCDzFWhObnizs72Muig==
X-Google-Smtp-Source: AGHT+IFiWuChYLAco5nOc66G1w6cYTjkov1Hu0LQyJZMR3/WFUC6rwA2Or451TlBtWEZwd6p/yyBWQ==
X-Received: by 2002:a5d:81d3:0:b0:7b3:b726:b57f with SMTP id t19-20020a5d81d3000000b007b3b726b57fmr9983661iol.19.1701287884069;
        Wed, 29 Nov 2023 11:58:04 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id v5-20020a02b905000000b0045458b7b4fcsm3601107jan.171.2023.11.29.11.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 11:58:03 -0800 (PST)
Message-ID: <137ab4f7-80af-4e00-a5bb-b1d4f4c75a67@arista.com>
Date: Wed, 29 Nov 2023 19:57:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] net/tcp: Store SNEs + SEQs on ao_info
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>,
 Francesco Ruggeri <fruggeri05@gmail.com>,
 Salam Noureddine <noureddine@arista.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
References: <20231129165721.337302-1-dima@arista.com>
 <20231129165721.337302-7-dima@arista.com>
 <CANn89iJcfn0yEM7Pe4RGY3P0LmOsppXO7c=eVqpwVNdOY2v3zA@mail.gmail.com>
 <df55eb1d-b63a-4652-8103-d2bd7b5d7eda@arista.com>
 <CANn89iLZx-SiV0BqHkEt9vS4LZzDxW2omvfOvNX6XWSRPFs7sw@mail.gmail.com>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <CANn89iLZx-SiV0BqHkEt9vS4LZzDxW2omvfOvNX6XWSRPFs7sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/29/23 18:34, Eric Dumazet wrote:
> On Wed, Nov 29, 2023 at 7:14 PM Dmitry Safonov <dima@arista.com> wrote:
>>
>> On 11/29/23 18:09, Eric Dumazet wrote:
>>> On Wed, Nov 29, 2023 at 5:57 PM Dmitry Safonov <dima@arista.com> wrote:
>>>>
>>>> RFC 5925 (6.2):
>>>>> TCP-AO emulates a 64-bit sequence number space by inferring when to
>>>>> increment the high-order 32-bit portion (the SNE) based on
>>>>> transitions in the low-order portion (the TCP sequence number).
>>>>
>>>> snd_sne and rcv_sne are the upper 4 bytes of extended SEQ number.
>>>> Unfortunately, reading two 4-bytes pointers can't be performed
>>>> atomically (without synchronization).
>>>>
>>>> In order to avoid locks on TCP fastpath, let's just double-account for
>>>> SEQ changes: snd_una/rcv_nxt will be lower 4 bytes of snd_sne/rcv_sne.
>>>>
>>>
>>> This will not work on 32bit kernels ?
>>
>> Yeah, unsure if there's someone who wants to run BGP on 32bit box, so at
>> this moment it's already limited:
>>
>> config TCP_AO
>>         bool "TCP: Authentication Option (RFC5925)"
>>         select CRYPTO
>>         select TCP_SIGPOOL
>>         depends on 64BIT && IPV6 != m # seq-number extension needs WRITE_ONCE(u64)
>>
> 
> Oh well, this seems quite strange to have such a limitation.

I guess so. On the other side, it seems that there aren't many
non-hobbyist 32bit platforms: ia32 compatible layer will even be limited
with a boot parameter/compile option. Maybe I'm not aware of, but it
seems that arm64/ppc64/risc-v/x86_64 are the ones everyone interested in
these days.

> 
>> Probably, if there will be a person who is interested in this, it can
>> get a spinlock for !CONFIG_64BIT.
> 
> 
>>
>>> Unless ao->snd_sne and ao->rcv_sneare only read/written under the
>>> socket lock (and in this case no READ_ONCE()/WRITE_ONCE() should be
>>> necessary)
>>
> 
> You have not commented on where these are read without the socket lock held ?

Sorry for missing this, the SNEs are used with this helper
tcp_ao_compute_sne(), so these places are (in square brackets AFAICS,
there is a chance that I miss something obvious from your message):

- tcp_v4_send_reset() => tcp_ao_prepare_reset() [rcu_read_lock()]
- __tcp_transmit_skb() => tcp_ao_transmit_skb() [TX softirq]
- tcp_v4_rcv() => tcp_inbound_ao_hash() [RX softirq]


> tcp_ao_get_repair() can lock the socket.

It can, sure.

> In TW state, I guess these values can not be changed ?

Currently, they are considered constant on TW. The incoming segments are
not verified on twsk (so no need for SNEs). And from ACK side not
expecting SEQ roll-over (tcp_ao_compute_sne() is not called) - this may
change, but not quite critical it seems.

If we go with this patch in question, I'll have to update this:
:		key.sne = READ_ONCE(ao_info->snd_sne);
(didn't adjust it for higher-bytes shift)

> I think you can remove all these READ_ONCE()/WRITE_ONCE() which are not needed,
> or please add a comment if they really are.

Not sure if I answered above..

> Then, you might be able to remove the 64BIT dependency ...

At this moment I fail to imagine anyone running BGP + TCP-AO on 32bit
kernel. I may be wrong, for sure.

Thanks,
             Dmitry


