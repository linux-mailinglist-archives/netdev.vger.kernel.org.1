Return-Path: <netdev+bounces-23893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9BA76E078
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 08:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D16D281F9A
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 06:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FBD8F5A;
	Thu,  3 Aug 2023 06:44:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4D88BE5
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 06:44:52 +0000 (UTC)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB97530FB
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 23:44:26 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4036bd4fff1so205541cf.0
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 23:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691045066; x=1691649866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+YG3aOyTJDDAoo3IjkxzD7O5Fuj1vrET3mxUDhOF2c=;
        b=gSI+0eHwGzcTFtF32NXHFmvR6Y1VPoyZJ4BIrWk7q2h/Y0lGhYBgHBbX2BCoG3AxK/
         CcT6VR4H9QOkqm8QZ7E2WEAm4/wjAls/kiaSFmlSpEBWZuFMkQBE88ycsqRsEXx8ZcY8
         k6oSxiS+JOeAGycc+RyGAIzS183fUpXxf34SHDRZqo2nx0hLvyvuRjyPB3TN1ReKVmuK
         uDt4JeL56mfBBLPWRAijhz0XqWZ0ybFYxu3wSvQ4jK4lFoLKn6Hj7n8TBuPNbUbS1M+3
         8vZEKekdNNMY/XrjuzL3Uy5aWwNwbcDm9OuS+/RUMQ287CeEeEpmLcircpIZnQRF3yMg
         CBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691045066; x=1691649866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+YG3aOyTJDDAoo3IjkxzD7O5Fuj1vrET3mxUDhOF2c=;
        b=QA3IWATFWdu5MXLjZ8hHhxAAUiEiXbdKp1fth6S6hmaTs+sJ1VAYeoeQVfvQG7rppa
         OgTrsNut3Ok3iJI3M8bijHn1IFM5n7Duux+Nsk9itywiiUpO6jHWPw3/AVm6arquvNp0
         XUXTzv/9aGrQSF8gMSuF4autO0JZffMLvPcixjYDl0agVkcLBSCaH5hu4s2RNkxm/7IT
         NUv5siFlVVsecX6K1XbLI3ePGQQyRKGHEed3VTfUaa2XO0/M/vyX6vssbSC4Rkhok23U
         xLBz3NWytYnUKceX4C9Vo0Qso4GKKzL3DSAWKJY/Ri+/Lk8U6LXcETuaLYI9w53RkjYh
         2tHQ==
X-Gm-Message-State: ABy/qLaIqXTIa32tbQZ2cfW8KLCUpB6orFRUykFlWUnT8mvXteyPh64f
	NurkwQjENtQ3GOqivYcWhrqshf6+VdhN2FkS9YUIpg==
X-Google-Smtp-Source: APBJJlH/9mCCM6V7LHpYfn1YKKuuvFpGOgjwrD8veNIHYHlu27TXjGhTj/6POxA0JgeTI1pw2TGTDkGHkz5JVvz9DZ8=
X-Received: by 2002:ac8:5913:0:b0:3ef:5f97:258f with SMTP id
 19-20020ac85913000000b003ef5f97258fmr1539930qty.16.1691045065923; Wed, 02 Aug
 2023 23:44:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230803042214.38309-1-kuniyu@amazon.com>
In-Reply-To: <20230803042214.38309-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 3 Aug 2023 08:44:14 +0200
Message-ID: <CANn89iJbn2+KADkS_PJYvsm_hkSuxrp_TpYHcMDcdq71=VCSZQ@mail.gmail.com>
Subject: Re: [PATCH v2 net] tcp: Enable header prediction for active open
 connections with MD5.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 3, 2023 at 6:22=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> TCP socket saves the minimum required header length in tcp_header_len
> of struct tcp_sock, and later the value is used in __tcp_fast_path_on()
> to generate a part of TCP header in tcp_sock(sk)->pred_flags.
>
> In tcp_rcv_established(), if the incoming packet has the same pattern
> with pred_flags, we enter the fast path and skip full option parsing.
>
> The MD5 option is parsed in tcp_v[46]_rcv(), so we need not parse it
> again later in tcp_rcv_established() unless other options exist.  Thus,
> MD5 should add TCPOLEN_MD5SIG_ALIGNED to tcp_header_len and avoid the
> slow path.
>
> For passive open connections with MD5, we add TCPOLEN_MD5SIG_ALIGNED
> to tcp_header_len in tcp_create_openreq_child() after 3WHS.
>
> On the other hand, we do it in tcp_connect_init() for active open
> connections.  However, the value is overwritten while processing
> SYN+ACK or crossed SYN in tcp_rcv_synsent_state_process().
>
>   1) SYN+ACK
>
>     tcp_rcv_synsent_state_process
>       tp->tcp_header_len =3D sizeof(struct tcphdr) or
>                            sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED
>       tcp_finish_connect
>         __tcp_fast_path_on
>       tcp_send_ack
>
>   2) Crossed SYN and the following ACK
>
>     tcp_rcv_synsent_state_process
>       tp->tcp_header_len =3D sizeof(struct tcphdr) or
>                            sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED
>       tcp_set_state(sk, TCP_SYN_RECV)
>       tcp_send_synack
>
>     -- ACK received --
>     tcp_v4_rcv
>       tcp_v4_do_rcv
>         tcp_rcv_state_process
>           tcp_fast_path_on
>             __tcp_fast_path_on
>
> So these two cases will have the wrong value in pred_flags and never
> go into the fast path.
>
> Let's add TCPOLEN_MD5SIG_ALIGNED in tcp_rcv_synsent_state_process()
> to enable header prediction for active open connections.

I do not think we want to slow down fast path (no MD5), for 'header
prediction' of MD5 flows,
considering how slow MD5 is anyway (no GSO/GRO), and add yet another
ugly #ifdef CONFIG_TCP_MD5SIG
in already convoluted code base.

The case of cross-syn is kind of hilarious, if you ask me.

>
> Fixes: cfb6eeb4c860 ("[TCP]: MD5 Signature Option (RFC2385) support.")

This would be net-next material anyway, unless you show a huge
improvement after this patch,
which I doubt very much.
Or maybe the real intent is not fully expressed in your changelog ?

