Return-Path: <netdev+bounces-31052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 132D278B168
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 15:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C047A280E21
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 13:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D773712B63;
	Mon, 28 Aug 2023 13:13:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBCC12B62
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 13:13:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEF69D
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 06:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693228396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S523gr4MdHiwr4uyw9+ZPJkjHmfhDiqToxLKBqfpIWk=;
	b=Se1n5cgFKj3jutW5hJhBiutc1lHZ6C7iTdGxweLERKvqeOtS3MDLTE+XpGvdsQHMfIWZ5i
	+7Dvj9L7r4XvlwUGjbqqaxub1DrlZlnCDNKDDt21Z2thHj+R3FzCoK1trZhWjJfJ5P6tJs
	QTxfRMoeebqPu2/or4pDlfNDEecZ9Ik=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-SldDJtdHOE-oVwsXkazkIw-1; Mon, 28 Aug 2023 09:13:15 -0400
X-MC-Unique: SldDJtdHOE-oVwsXkazkIw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b9d5bc6161so7756061fa.0
        for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 06:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693228394; x=1693833194;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S523gr4MdHiwr4uyw9+ZPJkjHmfhDiqToxLKBqfpIWk=;
        b=MqGA44a12+ACGVfyDyGxrUYVZboSAO2aRD58w2biQQir2zg2xKR1f6C86wRt7Vip4E
         7Z6yaByEiVdN85oxBn5Vwtms3rfM33bbSVSG9/+lJQX04NWynMWebv85FUvDD8FceCWQ
         LyPQV4ECftD6MLCzH3uw9TNl+FhM37B20kzR6K2OGnqh/oeoc6WshOWPfIViknYzNKgb
         DcgRqotkrMRN8Ze0THONgeRf/zy6mDjWfKqL5HMtok1TUyHN3DpoqHIKDvHhxx+u0gEt
         BgnrmR37CqJVyj6k14QCVCxvDQBlAX+/NXmFJHdC87T6SO/JNrQVm3Qnm6dBifzikyVG
         ZuQw==
X-Gm-Message-State: AOJu0YyKbG3Vo2PFfnt6R7sDtkur2ssIhE4IXwcF1EfNwExefxoTGA6A
	TBrSijsdjCBdKc4kH9b8u23lzQjkZeCCspR/Y/z0bBCG4UlDO0xiklc2LRgtAu2H8WA2SQ0qlPm
	2Gre1zno4boe64r2P
X-Received: by 2002:a2e:be1b:0:b0:2bd:cfe:66aa with SMTP id z27-20020a2ebe1b000000b002bd0cfe66aamr2266339ljq.4.1693228393810;
        Mon, 28 Aug 2023 06:13:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMiLcOBmHyiB5YG9tc8EsJz5Vuc94K9oaVLolgoleqTsFOZRfRRve1eqwbodgUcXSF8AmiAw==
X-Received: by 2002:a2e:be1b:0:b0:2bd:cfe:66aa with SMTP id z27-20020a2ebe1b000000b002bd0cfe66aamr2266328ljq.4.1693228393379;
        Mon, 28 Aug 2023 06:13:13 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-245-240.dyn.eolo.it. [146.241.245.240])
        by smtp.gmail.com with ESMTPSA id q4-20020a170906144400b00992f81122e1sm4624407ejc.21.2023.08.28.06.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 06:13:13 -0700 (PDT)
Message-ID: <dd0c339f4ee4f58a7439589ce6e7766d7ce844ae.camel@redhat.com>
Subject: Re: [PATCH net-next] net: annotate data-races around sock->ops
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>,  netdev@vger.kernel.org, eric.dumazet@gmail.com, syzbot
 <syzkaller@googlegroups.com>
Date: Mon, 28 Aug 2023 15:13:11 +0200
In-Reply-To: <CANn89iJSjug5+UaLMQ0QLa49nFRnO6a_x7pCJUQggnmfezj62g@mail.gmail.com>
References: <20230808135809.2300241-1-edumazet@google.com>
	 <bdf7db1a44ab0ee46fc621329ef9bc61734a723a.camel@redhat.com>
	 <CANn89iJSjug5+UaLMQ0QLa49nFRnO6a_x7pCJUQggnmfezj62g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-08-28 at 13:20 +0200, Eric Dumazet wrote:
> On Mon, Aug 28, 2023 at 12:17=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> =
wrote:
> > On Tue, 2023-08-08 at 13:58 +0000, Eric Dumazet wrote:
> > > IPV6_ADDRFORM socket option is evil, because it can change sock->ops
> > > while other threads might read it. Same issue for sk->sk_family
> > > being set to AF_INET.
> > >=20
> > > Adding READ_ONCE() over sock->ops reads is needed for sockets
> > > that might be impacted by IPV6_ADDRFORM.
> > >=20
> > > Note that mptcp_is_tcpsk() can also overwrite sock->ops.
> > >=20
> > > Adding annotations for all sk->sk_family reads will require
> > > more patches :/
> >=20
> > I was unable to give the above a proper look before due to OoO on my
> > side.
> >=20
> > The mptcp code calls mptcp_is_tcpsk() only before the fd for the newly
> > accepted socket is installed, so we should not have concurrent racing
> > access to sock->ops?!? Do you have any related splat handy?
> >=20
>=20
> syzbot splat was on another layer. I tried to fix all sites that could
> trigger a similar issue.
>=20
> BUG: KCSAN: data-race in ____sys_sendmsg / do_ipv6_setsockopt
>=20
> write to 0xffff888109f24ca0 of 8 bytes by task 4470 on cpu 0:
> do_ipv6_setsockopt+0x2c5e/0x2ce0 net/ipv6/ipv6_sockglue.c:491
> ipv6_setsockopt+0x57/0x130 net/ipv6/ipv6_sockglue.c:1012
> udpv6_setsockopt+0x95/0xa0 net/ipv6/udp.c:1690
> sock_common_setsockopt+0x61/0x70 net/core/sock.c:3663
> __sys_setsockopt+0x1c3/0x230 net/socket.c:2273
> __do_sys_setsockopt net/socket.c:2284 [inline]
> __se_sys_setsockopt net/socket.c:2281 [inline]
> __x64_sys_setsockopt+0x66/0x80 net/socket.c:2281
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
>=20
> read to 0xffff888109f24ca0 of 8 bytes by task 4469 on cpu 1:
> sock_sendmsg_nosec net/socket.c:724 [inline]
> sock_sendmsg net/socket.c:747 [inline]
> ____sys_sendmsg+0x349/0x4c0 net/socket.c:2503
> ___sys_sendmsg net/socket.c:2557 [inline]
> __sys_sendmmsg+0x263/0x500 net/socket.c:2643
> __do_sys_sendmmsg net/socket.c:2672 [inline]
> __se_sys_sendmmsg net/socket.c:2669 [inline]
> __x64_sys_sendmmsg+0x57/0x60 net/socket.c:2669
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
>=20
> value changed: 0xffffffff850e32b8 -> 0xffffffff850da890
>=20
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 4469 Comm: syz-executor.1 Not tainted
> 6.4.0-rc5-syzkaller-00313-g4c605260bc60 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 05/25/2023
>=20
> Maybe MPTCP side (mptcp_is_tcpsk()) was ok,
> but  the fact that mptcp_is_tcpsk() was able to write over sock->ops
> was a bit strange to me.
>=20
> mptcp_is_tcpsk() should answer a question, with a read-only argument.
>=20
> I suggest changing the name of the helper to better reflect what it is do=
ing.

Thanks for double checking. Indeed such helper name is confusing, and
should be renamed; I'll try to take care of it after the merge window.

Cheers,

Paolo



