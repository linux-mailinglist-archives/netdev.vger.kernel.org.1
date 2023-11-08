Return-Path: <netdev+bounces-46599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201AA7E54AC
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 12:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5534E1C20952
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 11:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E369314261;
	Wed,  8 Nov 2023 11:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SnUPnd7n"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454AB15487
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 11:03:26 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89929199
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 03:03:25 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9c53e8b7cf4so1024606866b.1
        for <netdev@vger.kernel.org>; Wed, 08 Nov 2023 03:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1699441404; x=1700046204; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:user-agent:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M8tgvgRdl8qekMWLyBR4jj7OgNLFjHC8OJ7GB2+5eqM=;
        b=SnUPnd7nfS3ZYifdcyg9mMpelmSpSWiFjSmpT8vRm0085vOCBWXS0e83wB6t2apzG3
         6uQr5FirTHD2eR1e1msbiaZvEPbcwYrlkvnOd0fCcJwQevDDRHptO62DUKsn9eceISSz
         05KLKnTgZN3BtRazd5viT9ktS+agt/FFxJSCxm0TM3fEz/mtQkYJBL/Urj5zo3COMeeL
         dc4Y21WJ5Uuu+CZotSGjWxu93cqwLfm6vsx7rGLwJcoIwBR2dlb76fHB2NCdTqJdF07M
         zFfLxVcdl8HIjH1MsbDi1Dd81w8i4ctMiKnNTMUiFw1lWueIMVkKzYIwv/s/Asier9Qv
         y8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699441404; x=1700046204;
        h=mime-version:message-id:date:subject:cc:to:from:user-agent
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M8tgvgRdl8qekMWLyBR4jj7OgNLFjHC8OJ7GB2+5eqM=;
        b=AyZMCQEpb9dVvmM5bu87EPclcnVDpqmL3DwkKORW64UKN1E2YrYiYPAuHz3cC1eqer
         STyOl9Tf/MGskU3Q4ZRLss919/IGOqr6NXtEmJH0bBL9e4pB/IC4AY+AtDVYWgK0pRE8
         /V7hD5y2xoXkCDgoHfBq6owEx1abCER65GpbUgu1A3965L9LrSlhUFEsGpzl64JqNmH/
         SJYKwFZn0bBszN+hgkaYsUB8Y7R3hdry0e0oYemPn32q7Ei6EaGou3uIclh57/xYyADZ
         FvoeEJvzONx7qdnQY7lLfIANOgH5GyVrqCjGco3cX8tyRrAVv2NIYZF1etsT6nzAiqrW
         0sHw==
X-Gm-Message-State: AOJu0YyTM5BrEYwYfUX9+rQXQPHk8B+SWBjqvfDr5AmMD9sSwrO98Tjl
	q+ghducix5cozdMhMCYED65WQQ==
X-Google-Smtp-Source: AGHT+IGR4KTQVI4YXTJvEv0qF/FaNh1xjl8ZaMjSeSiEYDpyBpEdkL6+Ix4TVSEkvUvRwFwSpW+lmQ==
X-Received: by 2002:a17:907:1c05:b0:9b2:ecbd:8412 with SMTP id nc5-20020a1709071c0500b009b2ecbd8412mr1101318ejc.47.1699441403969;
        Wed, 08 Nov 2023 03:03:23 -0800 (PST)
Received: from cloudflare.com (79.184.209.104.ipv4.supernova.orange.pl. [79.184.209.104])
        by smtp.gmail.com with ESMTPSA id d21-20020a170906641500b009dd606ce80fsm863932ejm.31.2023.11.08.03.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 03:03:23 -0800 (PST)
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com
Subject: EIO on send with UDP_SEGMENT
Date: Wed, 08 Nov 2023 11:58:57 +0100
Message-ID: <87jzqsld6q.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Willem et al,

We have hit the EIO error path in udp_send_skb introduced in commit bec1f6f69736
("udp: generate gso with UDP_SEGMENT") [0]:

	if (skb->ip_summed != CHECKSUM_PARTIAL || ...) {
		kfree_skb(skb);
		return -EIO;
	}

... when attempting to send a GSO packet, using UDP_SEGMENT option, from
a TUN device which didn't have any offloads enabled (the default case).

A trivial reproducer for that would be:

  ip tuntap add dev tun0 mode tun
  ip addr add dev tun0 192.0.2.1/24
  ip link set dev tun0 up
  
  strace -e %net python -c '
  from socket import *
  s = socket(AF_INET, SOCK_DGRAM)
  s.setsockopt(SOL_UDP, 103, 1200)
  s.sendto(b"x" * 3000, ("192.0.2.2", 9))
  '

which yields:

  socket(AF_INET, SOCK_DGRAM|SOCK_CLOEXEC, IPPROTO_IP) = 3
  setsockopt(3, SOL_UDP, UDP_SEGMENT, [1200], 4) = 0
  sendto(3, "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"..., 3000, 0, {sa_family=AF_INET, sin_port=htons(9), sin_addr=inet_addr("192.0.2.2")}, 16) = -1 EIO (Input/output error)

This has been a surprise and caused us some pain. I think it comes down
to that anyone using UDP_SEGMENT has to implement a segmentation
fallback in user-space. Just to be on the safe side.  We can't really
assume that any TUN/TAP interface, which happens to be our egress
device, has at least checksum offload enabled and implemented.

Which is not ideal.
So it made us wonder if anything can be done about it?

As it turns out, skb_segment() in GSO path implements a software
fallback not only for segmentation but also for checksumming [1].

What is more, when we removed the skb->ip_summed == CHECKSUM_PARTIAL
restriction in udp_send, as an experiment, we were able to observe fully
checksummed segments in packet capture.

Which brings me to my question -

Do you think the restriction in udp_send_skb can be lifted or tweaked?

Thanks,
Jakub

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bec1f6f697362c5bc635dacd7ac8499d0a10a4e7
[1] https://elixir.bootlin.com/linux/v6.6/source/net/core/skbuff.c#L4626

