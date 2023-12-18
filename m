Return-Path: <netdev+bounces-58404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1CC8163FC
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 02:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6864E1F21BB6
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 01:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DA41FA3;
	Mon, 18 Dec 2023 01:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+vycRc9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6A76FA4
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 01:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5e620df4815so2524357b3.2
        for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 17:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702862201; x=1703467001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vNYJZD5AGvGlv1DM3hiZqfJCKeiKiIedPs/0gYvLJCM=;
        b=U+vycRc9N7D2OAfpD3+7fLC+jMw66UN4BLIzmsJ3cGGCw0skyAipjctW97RXSHtcR+
         0wVTvU7vJEEd1juK0kcSqfBdEUsgze9S89rhyppusJEKUFytSJul2dQlHoeMGdP0e3Vg
         hwbbK5enX0PT+YSr+RXdU1SpJKRyddid6/m66XUkRwu4EtdiCHmRsdDoh3aLqj05sijw
         7OiET+Cpl3dEi2+k2O2YU2a5kZpBX7PuGcUHLGw0OF3O83qUmLGBOC2gjw3lPlgqIRBP
         +B4sNfDAwUpFzzmV+fhaNi+v4phvTPSdNkK5AHGDh1NEem8Lil4OI/K3AXkzQcBbFlRn
         ueeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702862201; x=1703467001;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vNYJZD5AGvGlv1DM3hiZqfJCKeiKiIedPs/0gYvLJCM=;
        b=hFE5UDBH3M0Nw5dmxyydYE9d3Mw8fyxhcr3rE2W0Zs+Yi61Zat2Z6gCK+s+RjWK1kV
         ulZ26MSPFq+1dmows3DEoqSLET65BrnzcU3VZzvhBxUHy8XJM1FPV67e27UfgRbXsSr+
         983vzHKvt2xEFviPBGiDDAU+eK37Hdde128FIHoxQby4goV4rjqkOivFZdaQTQB0QzGS
         g9mSYfgf9UF3wifiR9K1jswAkUNt+OKDjCj/cRo57q+lvFNES++y98yGkXlu9gND0cNK
         zQHXyeaK16KI0ESOUNDhMipv2Rib69zlpPCOvLnFCQ88OszZaJOjbpaGZXXK/seBCURY
         a/dQ==
X-Gm-Message-State: AOJu0YyOCdYs96SWuu+6/f3+KnhWl5WX1j8NoLKJAoW5Iiv0NQ51O76w
	/vHJkpTjZvqTHk9MJcL2Yog=
X-Google-Smtp-Source: AGHT+IH4357OnA0SaonpcZGyWG8lXk5nyKo80xBaco4UdtznDNUJxsqXQ19/TIEJLWOgT+jboLKmig==
X-Received: by 2002:a81:7b05:0:b0:5d7:1940:7d87 with SMTP id w5-20020a817b05000000b005d719407d87mr11311790ywc.94.1702862200821;
        Sun, 17 Dec 2023 17:16:40 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:6c55:8ec3:2883:1a4? ([2600:1700:6cf8:1240:6c55:8ec3:2883:1a4])
        by smtp.gmail.com with ESMTPSA id cg4-20020a05690c0a0400b005d39efe78f4sm5380416ywb.50.2023.12.17.17.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Dec 2023 17:16:40 -0800 (PST)
Message-ID: <0cde3fda-1b65-447c-a859-f583929da504@gmail.com>
Date: Sun, 17 Dec 2023 17:16:39 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] net/ipv6: insert a f6i to a GC list only
 if the f6i is in a fib6_table tree.
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
To: David Ahern <dsahern@kernel.org>, thinker.li@gmail.com,
 netdev@vger.kernel.org, martin.lau@linux.dev, kernel-team@meta.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: kuifeng@meta.com, syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com
References: <20231213213735.434249-1-thinker.li@gmail.com>
 <20231213213735.434249-2-thinker.li@gmail.com>
 <28f016bc-3514-444f-82df-719aeb2d013a@kernel.org>
 <185a3177-3281-4ead-838e-6d621151ea36@gmail.com>
In-Reply-To: <185a3177-3281-4ead-838e-6d621151ea36@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/15/23 11:12, Kui-Feng Lee wrote:
> 
> 
> On 12/13/23 22:11, David Ahern wrote:
>> On 12/13/23 2:37 PM, thinker.li@gmail.com wrote:
>>> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
>>> index b132feae3393..dcaeb88d73aa 100644
>>> --- a/net/ipv6/route.c
>>> +++ b/net/ipv6/route.c
>>> @@ -3763,10 +3763,10 @@ static struct fib6_info 
>>> *ip6_route_info_create(struct fib6_config *cfg,
>>>           rt->dst_nocount = true;
>>>       if (cfg->fc_flags & RTF_EXPIRES)
>>> -        fib6_set_expires_locked(rt, jiffies +
>>> -                    clock_t_to_jiffies(cfg->fc_expires));
>>> +        __fib6_set_expires(rt, jiffies +
>>> +                   clock_t_to_jiffies(cfg->fc_expires));
>>>       else
>>> -        fib6_clean_expires_locked(rt);
>>> +        __fib6_clean_expires(rt);
>>
>> as Eric noted in a past comment, the clean is not needed in this
>> function since memory is initialized to 0 (expires is never set).
>>
>> Also, this patch set does not fundamentally change the logic, so it
>> cannot fix the bug reported in
>>
>> https://lore.kernel.org/all/20231205173250.2982846-1-edumazet@google.com/
>>
>> please hold off future versions of this set until the problem in that
>> stack traced is fixed. I have tried a few things using RA's, but have
>> not been able to recreate UAF.
> 
> I tried to reproduce the issue yesterday, according to the hypothesis
> behind the patch of this thread. The following is the instructions
> to reproduce the UAF issue. However, this instruction doesn't create
> a crash at the place since the memory is still available even it has
> been free. But, the log shows a UAF.
> 
> The patch at the end of this message is required to reproduce and
> show UAF. The most critical change in the patch is to insert
> a 'mdelay(3000)' to sleep 3s in rt6_route_rcv(). That gives us
> a chance to manipulate the kernel to reproduce the UAF.
> 
> Here is my conclusion. There is no protection between finding
> a route and changing the route in rt6_route_rcv(), including inserting
> the entry to the gc list. It is possible to insert an entry that will be
> free later to the gc list, causing a UAF. There is more explanations
> along with the following logs.
> 
> Instructions:
>       - Preparation
>         - install ipv6toolkit on the host.
>         - run qemu with a patched kernel as a guest through
>           with the host through qemubr0 a bridge.
>         - On the guest
>           - stop systemd-networkd.service & systemd-networkd.socket if 
> there are.
>           - sysctl -w net.ipv6.conf.enp0s3.accept_ra=2
>           - sysctl -w net.ipv6.conf.enp0s3.accept_ra_rt_info_max_plen=127
>         - Assume the address of qemubr0 in the host is
>           fe80::4ce9:92ff:fe27:75df.
>       - Test
>         - ra6 -i qemubr0 -d ff02::1 -R 'fe82::/64#1#300' -t 300 # On the 
> host
>         - sleep 2; ip -6 route del fe82::/64                    # On the 
> guest
>         - ra6 -i qemubr0 -d ff02::1 -R 'fe82::/64#1#300' -t 300 # On the 
> host
>         - ra6 -i qemubr0 -d ff02::1 -R 'fe81::/64#1#300' -t 0   # On the 
> host
>       - The step 3 should start immediately after step 2 since we have
>         a gap of merely 3 seconds in the kernel.
> 

I did the same test with the fix patch along with this thread.
The following is the log I got.

# This is the log printed by the step 1.
# ffff888108066600 was add to the gc list.
[    4.596875] __ip6_ins_rt fe80::5054:ff:fe12:3456/128
[   38.925482] rt = 0000000000000000
[   38.925916] fib6_info_alloc: ffff888108066e00
[   38.926441] __ip6_ins_rt ::/0
[   38.926441] fib6_add: add ffff888108066e00 to gc list 
ffff888108066e38 pprev ffff888102a02800 next 0000000000000000
[   38.927084] rt = ffff888108066e00
[   38.927084] rt6_route_rcv
[   38.927084] fib6_info_alloc: ffff888108066600
[   38.929333] __ip6_ins_rt fe82::/64
[   38.929333] rt6_route_rcv: route info ffff888108066600, sleep 3s
[   40.948831] fib6_set_expires_locked: add ffff888108066600 to gc list 
ffff888108066638 pprev ffff888102a02800 next ffff888108066e38
[   41.932501] rt6_route_rcv: route info ffff888108066600, after release

# This is the log printed by the step 2 & 3.
# The entry (ffff888108066600) removed from the gc list by
# fib6_clean_expires_locked was not added back to the gc list again.
[   68.173441] rt = ffff888108066e00
[   68.173883] rt6_route_rcv
[   68.174245] rt6_route_rcv: route info ffff888108066600, sleep 3s
[   69.389112] fib6_clean_expires_locked: del ffff888108066600 from gc 
list pprev ffff888102a02800 next ffff888108066e38
[   70.900831] rt6_route_rcv: route info ffff888108066600, after release
[   71.182822] fib6_info_destroy_rcu ffff888108066600

# This is the log printed by the step 4.
[  109.017446] rt = ffff888108066e00
[  109.017893] __ip6_del_rt ::/0
[  109.018288] fib6_clean_expires_locked: del ffff888108066e00 from gc 
list pprev ffff888102a02800 next 0000000000000000
[  109.019471] rt6_route_rcv
[  109.019471] fib6_info_alloc: ffff888108066600
[  109.019471] __ip6_ins_rt fe81::/64
[  109.019471] rt6_route_rcv: route info ffff888108066600, sleep 3s
[  111.028831] fib6_set_expires_locked: add ffff888108066600 to gc list 
ffff888108066638 pprev ffff888102a02800 next 0000000000000000
[  112.023607] rt6_route_rcv: route info ffff888108066600, after release
[  112.031825] fib6_info_destroy_rcu ffff888108066e00

