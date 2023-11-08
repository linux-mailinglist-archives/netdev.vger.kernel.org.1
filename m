Return-Path: <netdev+bounces-46654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B10CA7E59BE
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 16:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EACC280FF1
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 15:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA4830328;
	Wed,  8 Nov 2023 15:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dm/3sO8n"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044A12592
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 15:10:40 +0000 (UTC)
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF8C1FE4
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 07:10:40 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-4ac0719457bso584909e0c.0
        for <netdev@vger.kernel.org>; Wed, 08 Nov 2023 07:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699456239; x=1700061039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfvmRBytKaz69wOAtnLg0uwO+ymX7F4EJbN3f30an0U=;
        b=dm/3sO8nwVHuRlicCn4LtBH/QQezPafXCEk0A7YO9G1MmGiAOglPokpiNk2S7feMo7
         N7GeKQZNUPAQ1CUnrRArej5Plfzxa8L266bYJSMmZ0Q/H/gnFrLsG+88EXHEakuYNcYg
         2MpR28u+UjPNj6b59jJccFxuq/RQ/vHavWtqZnfake7NDtNrtOpvhuRhe9iX7hy3tiaw
         W0feibYllT12tQ1JaC4eIgHw/JZnahZ4R9O7uVcKo6mH44w5riubDAm7bAsGDcs5mRyS
         jgPe4ZhmzZraTA5gTkz0a43Bn8QZuyUSuysTzOSakVbxAM+TPYVtTGaV4hVUsmnfdqsy
         xl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699456239; x=1700061039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfvmRBytKaz69wOAtnLg0uwO+ymX7F4EJbN3f30an0U=;
        b=cI4NBp6XvBjg7hVHg1eJ/MZ2j/7GO4z27vmrCif4W5Eg+FT3lYfWUIdOBLxDRwMR3s
         mZFGj2h7UsLnyxDrF2ywZkxFZNhxoevoOiT2iNfO06I8Jlcvz+puPh7rBHFe/bN+Jnrt
         X7XVZ2+hqbQDtEAW9g8fEAWVheGdIK2v+QVp67lJV9BnGEQkE2KkqK7eqDoAbRpBY9zo
         8Mp2OSMozrqh9b7SePDYFiN/X4qkYn2p94LNZS+donJwdd/H+/v53GS73DYDuhTf/GEj
         SH2SE2pOpR6YfZgxr9esT5QfFRw9bF/nlLxT28W5daEKq4wXMtNvHPFJkisXviTsFYtb
         INAw==
X-Gm-Message-State: AOJu0YwO+e0VUo5c+clTS++3/61osN3HZs8/MWnrBIpPX7Rdtn4j9IJt
	5LGWO/xVCPKJlWcB+vvr+7vdFO4ZaLhfNnG/RtY=
X-Google-Smtp-Source: AGHT+IHRHE39FBTqgGB5t0NjRMZ3A2UlMfdLJWppJgrl9G2Fo5S8UVAoOZjy4ptSXYP8PSCDKVysg/g95dEXTNiVne0=
X-Received: by 2002:a1f:2bd2:0:b0:4ab:da7a:c573 with SMTP id
 r201-20020a1f2bd2000000b004abda7ac573mr940228vkr.8.1699456239119; Wed, 08 Nov
 2023 07:10:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87jzqsld6q.fsf@cloudflare.com>
In-Reply-To: <87jzqsld6q.fsf@cloudflare.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 8 Nov 2023 10:10:02 -0500
Message-ID: <CAF=yD-+GNV_1HLyBKGeZuVkRGPEMmyQ4+MX9cLvyC1mC9a+dvg@mail.gmail.com>
Subject: Re: EIO on send with UDP_SEGMENT
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 6:03=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.com=
> wrote:
>
> Hi Willem et al,
>
> We have hit the EIO error path in udp_send_skb introduced in commit bec1f=
6f69736
> ("udp: generate gso with UDP_SEGMENT") [0]:
>
>         if (skb->ip_summed !=3D CHECKSUM_PARTIAL || ...) {
>                 kfree_skb(skb);
>                 return -EIO;
>         }
>
> ... when attempting to send a GSO packet, using UDP_SEGMENT option, from
> a TUN device which didn't have any offloads enabled (the default case).
>
> A trivial reproducer for that would be:
>
>   ip tuntap add dev tun0 mode tun
>   ip addr add dev tun0 192.0.2.1/24
>   ip link set dev tun0 up
>
>   strace -e %net python -c '
>   from socket import *
>   s =3D socket(AF_INET, SOCK_DGRAM)
>   s.setsockopt(SOL_UDP, 103, 1200)
>   s.sendto(b"x" * 3000, ("192.0.2.2", 9))
>   '
>
> which yields:
>
>   socket(AF_INET, SOCK_DGRAM|SOCK_CLOEXEC, IPPROTO_IP) =3D 3
>   setsockopt(3, SOL_UDP, UDP_SEGMENT, [1200], 4) =3D 0
>   sendto(3, "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"..., 3000, 0, {sa_family=3D=
AF_INET, sin_port=3Dhtons(9), sin_addr=3Dinet_addr("192.0.2.2")}, 16) =3D -=
1 EIO (Input/output error)
>
> This has been a surprise and caused us some pain. I think it comes down
> to that anyone using UDP_SEGMENT has to implement a segmentation
> fallback in user-space. Just to be on the safe side.  We can't really
> assume that any TUN/TAP interface, which happens to be our egress
> device, has at least checksum offload enabled and implemented.
>
> Which is not ideal.
> So it made us wonder if anything can be done about it?
>
> As it turns out, skb_segment() in GSO path implements a software
> fallback not only for segmentation but also for checksumming [1].
>
> What is more, when we removed the skb->ip_summed =3D=3D CHECKSUM_PARTIAL
> restriction in udp_send, as an experiment, we were able to observe fully
> checksummed segments in packet capture.
>
> Which brings me to my question -
>
> Do you think the restriction in udp_send_skb can be lifted or tweaked?

The argument against has been that segmentation offload offers no
performance benefit if the stack has to fall back onto software
checksumming.

If this limitation makes userspace code more complex, by having to
branch between segmentation offload and not depending on device
features, that would be an argument to drop it. As you point out, it
is not needed for correctness.

>
> Thanks,
> Jakub
>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Dbec1f6f697362c5bc635dacd7ac8499d0a10a4e7
> [1] https://elixir.bootlin.com/linux/v6.6/source/net/core/skbuff.c#L4626
>

