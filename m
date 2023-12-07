Return-Path: <netdev+bounces-54941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05BE808FAE
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B891C2088A
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A04A4D595;
	Thu,  7 Dec 2023 18:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bD2G98ll"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877E8170D
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 10:19:22 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5d95a3562faso11040817b3.2
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 10:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701973162; x=1702577962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xV1APpjHHz4WKcYOG3F+maZcNpJJQkCiCM1NxWsh0LA=;
        b=bD2G98lleUBDesnlyYLOsoEP0EJjqx6ZI2GLa9GN4LMj+eNpq1O8Q9xRfwSxV3ECZD
         kRq1FQTpKLieD+1n4hhCuKI/1KCK0VsAtbu71oC2FkqHMr36kiK+D63MmvqLHnKwzphM
         zKXD8kjOwI+r9plg0Ugngd0yYpb41v8wc3R5fjIFAQFKTO9FdZT1oICeHJlcr1iUK/R0
         5ctQS6AiLCAaPGu0pTs7n/r4zBpbMuTgWEuYXdVdGq03DqzhO6XCGqxAwOkoPM+41dpe
         zue5az3wdLTluLmgVWQY2duRNFenuwLA/LYe+yJb6ORt8g6ElOYfEmU1cx1eecIeyIU2
         s+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701973162; x=1702577962;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xV1APpjHHz4WKcYOG3F+maZcNpJJQkCiCM1NxWsh0LA=;
        b=u2kFXHre/ft2nLIP6IqxHIdgEjcHozvnDdoTKJl7pkhZvAy/J9pKIbxnwSoDt5hlzL
         +9NRTp6PR8rUmflnLk91vuvyNY2YFrJx8amWeO15arHzUG4JQEXOsi+bc+DY3X0ewNvM
         C31YV93VZLAbU2DnTykM3RYJrMPggFJ5IzZsXWwcVMCcryYlPCGWg2eu+0HDWiACZE1F
         10cEE2hxyMdr0xTycm+olSOkr1Dlw5WTrAF1lv1wrHzV6OteIQX9Gf6n4YIA/JhInw7V
         Y9QpEvYV3WM4w+U47cJFjGL8NNUXhikbUvst8Jemw3dH+wOdG/h5chLRcq00UyJjjO2g
         gNNQ==
X-Gm-Message-State: AOJu0YyYDZdieyyTIIK24leIKYyXPnM7ocN1Cb3YOesJgTasPZ6jHlT7
	l18ePVx1hKJmOUJ/5hh9+w4=
X-Google-Smtp-Source: AGHT+IGMEXzryHs79RB0J6XY2ByGm8A7KcrsKdPr6AXulfD3a3Z+GLmwuFc1Wtec5/n+XegCR1kcgQ==
X-Received: by 2002:a81:4c02:0:b0:5d7:9f0c:d36c with SMTP id z2-20020a814c02000000b005d79f0cd36cmr2634475ywa.28.1701973161754;
        Thu, 07 Dec 2023 10:19:21 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:57df:3a91:11ad:dcd? ([2600:1700:6cf8:1240:57df:3a91:11ad:dcd])
        by smtp.gmail.com with ESMTPSA id d18-20020a81d352000000b0059a34cfa2a8sm55976ywl.62.2023.12.07.10.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 10:19:21 -0800 (PST)
Message-ID: <2ba1bbde-0e80-4b73-be2b-7ce27c784089@gmail.com>
Date: Thu, 7 Dec 2023 10:19:20 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: add debug checks in fib6_info_release()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: patchwork-bot+netdevbpf@kernel.org, Kui-Feng Lee <thinker.li@gmail.com>,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20231205173250.2982846-1-edumazet@google.com>
 <170191862445.7525.14404095197034927243.git-patchwork-notify@kernel.org>
 <CANn89iKcFxJ68+M8UvHzqp1k-FDiZHZ8ujP79WJd1338DVJy6w@mail.gmail.com>
 <c4ca9c7d-12fa-4205-84e2-c1001242fc0d@gmail.com>
 <CANn89iKpM33oQ+2dwoLHzZvECAjwiKJTR3cDM64nE6VvZA99Sg@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CANn89iKpM33oQ+2dwoLHzZvECAjwiKJTR3cDM64nE6VvZA99Sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/7/23 10:10, Eric Dumazet wrote:
> On Thu, Dec 7, 2023 at 7:06 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
> 
>> Do you happen to have a test program that can reproduce it?
> 
> syzbot has a repro, let me release the bug.
> 
> Of course syzbot bisection points to my last patch.

I just looked into the code.
The origin issue mentioned at the thread head should be something
related to a GC change I made. But, the warnings you added doesn't
catch the the error correctly.  According to your stacktrace


 > ip6_route_add+0x26/0x1f0 net/ipv6/route.c:3843
 > ipv6_route_ioctl+0x3ff/0x590 net/ipv6/route.c:4467
 > inet6_ioctl+0x265/0x2b0 net/ipv6/af_inet6.c:575
 > sock_do_ioctl+0x113/0x270 net/socket.c:1220
 > sock_ioctl+0x22e/0x6b0 net/socket.c:1339
 > vfs_ioctl fs/ioctl.c:51 [inline]
 > __do_sys_ioctl fs/ioctl.c:871 [inline]
 > __se_sys_ioctl fs/ioctl.c:857 [inline]
 > __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 > do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 > do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 > entry_SYSCALL_64_after_hwframe+0x63/0x6b

and warning messages you provided

 > WARNING: CPU: 0 PID: 5059 at include/net/ip6_fib.h:332
 > fib6_info_release include/net/ip6_fib.h:332 [inline]
 > WARNING: CPU: 0 PID: 5059 at include/net/ip6_fib.h:332
 > ip6_route_info_create+0x1a1a/0x1f10 net/ipv6/route.c:3829

It takes place in ip6_route_info_create() to do error handling.
It can be fib6_has_expires() in fib6_info_release() in this case.

