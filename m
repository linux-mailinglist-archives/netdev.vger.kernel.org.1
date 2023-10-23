Return-Path: <netdev+bounces-43378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFBA7D2C98
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 10:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D6C9B20C87
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 08:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EEB1171F;
	Mon, 23 Oct 2023 08:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f99mqQ4U"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1B11C27
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 08:24:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50996DA
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 01:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698049476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9hWqXpcum8UpgdtzYDc5SfWpjkSwHlgNWkRpARUv+ls=;
	b=f99mqQ4UBfKmmigO9jzJjGrE5gSOjpQ4AzMqLT2WFAsdqHsdeLhN0mI8qx2sHP+uC5utpz
	3Cd1XnipOOClt2IM1FXSgWZyJ7x4jO20aprxJW2/yHG4o5jt0wnjQpp4IJkX/XueAdVCRH
	KWJvn2N6MuceeTQz5UoY0o7lLnjvusM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-b5Sy91R8M6as_aC7UkRvYg-1; Mon, 23 Oct 2023 04:24:34 -0400
X-MC-Unique: b5Sy91R8M6as_aC7UkRvYg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5401004754cso345991a12.1
        for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 01:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698049473; x=1698654273;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9hWqXpcum8UpgdtzYDc5SfWpjkSwHlgNWkRpARUv+ls=;
        b=m9M6XuKSfUvTu6OdHMS88iGYtaBu2bWnlmxiWS6AoHIH10JlAdw41oARC+pKpt6Q1z
         P12qcGkY8yY9V9G/0Y+o7HHp+CZUfXxZTBRINmgCLdeYhbQa9QDDlaz3Bj+BDTJJgyju
         N13b/ylCuLblpuy+O/UMInoIDty3uo90MfErUJMTNx99/zgK9Hqb38oN7/e0WqAIn4cf
         itaWxhvf2DsbjGrMIAmQnQEiKhrt4SWCh1zh5yuweGv4LZ3fc0h6Mo3sxl/aPVbZiMCR
         FTGQ3iX+rs7/j8RqugOCZxLfA+2UlZK9z5J/QlbcXKxxGorLCfhoTB6G3nemK98a3bRI
         Tt4g==
X-Gm-Message-State: AOJu0Yw9uQBz+f+eyBWq4PBnz06mFcrkYRpfdH35khaF0m+ht9h0FTqP
	z3YC4xMCZy57JibhcD85MHaOR4bQJRChUb/MAQIpmcQtZ4u3V1sjQmBVJdDPRb9VzHBAA5tuOew
	78Ktb1gtKoJ0FAAYLY0EC4kIC
X-Received: by 2002:a50:d799:0:b0:53f:92a8:652d with SMTP id w25-20020a50d799000000b0053f92a8652dmr6596705edi.1.1698049473695;
        Mon, 23 Oct 2023 01:24:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJHeeajUrPiZJZx1l1P9zk9Vmy7Oa1duTYSDEAey2AJMST6Y6TjSVGV+Bu8MEIw2ThxwR76A==
X-Received: by 2002:a50:d799:0:b0:53f:92a8:652d with SMTP id w25-20020a50d799000000b0053f92a8652dmr6596683edi.1.1698049473236;
        Mon, 23 Oct 2023 01:24:33 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-237-0.dyn.eolo.it. [146.241.237.0])
        by smtp.gmail.com with ESMTPSA id v30-20020a50a45e000000b0053da3a9847csm6061880edb.42.2023.10.23.01.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 01:24:32 -0700 (PDT)
Message-ID: <f9bc6eb8fb9c0771d7fff0b4da1a75528c5d6c07.camel@redhat.com>
Subject: Re: [PATCH net-next 00/17] Change cork to a pointer in sockets
From: Paolo Abeni <pabeni@redhat.com>
To: Oliver Crumrine <ozlinuxc@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net
Date: Mon, 23 Oct 2023 10:24:31 +0200
In-Reply-To: <cover.1697989543.git.ozlinuxc@gmail.com>
References: <cover.1697989543.git.ozlinuxc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2023-10-22 at 12:19 -0400, Oliver Crumrine wrote:
> This patch changes the cork field of both the inet_sock and inet6_sk
> structs to a pointer, reducing their size.
>=20
> Oliver Crumrine (17):
>   Make cork in inet_sock a pointer.
>   Allocate and free cork in inet_create and inet_release in file
>     net/ipv4/af_inet.c
>   Change cork in ipv6_pinfo to a pointer.
>   Allocate and free cork in inet6_sk.
>   Change occurence of cork in inet_sock to pointer in include/net/ip.h
>   Since cork in inet_sock and inet6_sk will be a pointer, they don't
>     need to be referenced in this function in include/net/ipv6.h
>   Change occurences of cork in inet_sock to pointer in file
>     net/ipv4/af_inet.c
>   Change occurence of cork to pointer in file net/ipv4/datagram.c
>   Change instances of cork in net/ipv4/inet_connection_sock.c to
>     pointer.
>   Change instances of cork to pointer in net/ipv4/ip_output.c
>   Update occurences of cork to pointer in net/ipv4/syncookies.c
>   Change occurences of cork to pointer in net/ipv4/tcp_output.c
>   Change instances of cork to a pointer in file net/ipv4/udp.c
>   Update usages of cork in net/ipv6/ip6_output.c to pointer.
>   Modify occurences of cork in net/ipv6/raw.c to use a pointer
>   Change usages of cork to pointer in net/ipv6/udp.c
>   Change instance of cork to pointer in net/ipv4/tcp_ipv4.c
>=20
>  include/linux/ipv6.h            |  2 +-
>  include/net/inet_sock.h         |  2 +-
>  include/net/ip.h                |  2 +-
>  include/net/ipv6.h              |  4 ++--
>  net/ipv4/af_inet.c              |  6 ++++--
>  net/ipv4/datagram.c             |  2 +-
>  net/ipv4/inet_connection_sock.c |  6 +++---
>  net/ipv4/ip_output.c            |  6 +++---
>  net/ipv4/syncookies.c           |  2 +-
>  net/ipv4/tcp_ipv4.c             |  2 +-
>  net/ipv4/tcp_output.c           |  2 +-
>  net/ipv4/udp.c                  |  8 ++++----
>  net/ipv6/af_inet6.c             |  5 +++++
>  net/ipv6/ip6_output.c           | 10 +++++-----
>  net/ipv6/raw.c                  |  4 ++--
>  net/ipv6/udp.c                  |  4 ++--
>  16 files changed, 37 insertions(+), 30 deletions(-)

Could you please explain the rationale behind such changes?=C2=A0

As the cork struct is still allocated for each inet/inet6 socket, the
total memory used by the the now smaller socket struct and the cork=20
struct will be greater then the memory used originally by such socket.
And the double allocation/free will be slower then the original one.

This also adds a bunch of additional pointer de-reference in the xmit
path.

Finally the above change will probably conflict with the goodies
introduced by:

https://lore.kernel.org/netdev/20231017014716.3944813-1-lixiaoyan@google.co=
m/

I'm sorry, but this looks really a no-go.

Before future submissions, please read thoroughly the process
documentation, including the netdev specific bits in maintainer-
netdev.rst: there a bit of issues with the process here (the recipients
list does not include a lot of relevant ones, there are typos there,
the patch series is too long, it breaks the builds ...)

Cheers,

Paolo


