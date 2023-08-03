Return-Path: <netdev+bounces-23895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D4576E09F
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 08:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88E151C21414
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 06:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8F38F6B;
	Thu,  3 Aug 2023 06:59:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5C42585
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 06:59:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E23E194
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 23:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691045977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HNFcEr/bWLLN+SwRJr60ydUfMRfFyMLKicAzKUwM6D8=;
	b=V6R/7AgX/dmRCb92mM1ETVneBm9AMN62ZH8h6ThxcBXJnrdh90KxPuGLT/xgSblXlQ56dz
	Laa1nxqjaMtlWra8Ke6YQmwIWPZtdHXjhBcL2jLAeigUBM3Wni5CDLs2lmAi9Q7FBy8Nl9
	CE+Fin3SY5x+lw1/P8yzYqEWc6pQpxQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-b83YzcHTOiS_nc9lXX254Q-1; Thu, 03 Aug 2023 02:59:36 -0400
X-MC-Unique: b83YzcHTOiS_nc9lXX254Q-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-63d05a56b4dso1489086d6.0
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 23:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691045976; x=1691650776;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HNFcEr/bWLLN+SwRJr60ydUfMRfFyMLKicAzKUwM6D8=;
        b=J9qQxe+/MCz6P8I7yA8d7zHANsrrsBllVX7tN1j3zyaO4GaGgqonW0OeHort5hkzGO
         cq6usH+b7aBIQSsHoQmOdBD7j7kRSN5d+OrovrkQBX3OpG/+pyT3oDcrcATPFWAlO5d8
         c+l/zd98oMAzdwspTBRk4uYYgxv1o1JIUnq2Z/vtuQ5ZouAL8tTyzOkUUMBZwJyLSaAG
         Qz2JjUOpOxUE6WGo9H33Kf0ppaRmTE/MozfY7o8K3xWSmmX92kZc+vNvnOM7oe+czUkX
         C4sjxJZHuMZwQc3DWh3xe3HqUgX0JxyxgB0tb2t84NHG6nudmT6iiuFeY6KRt160uq9T
         2FzA==
X-Gm-Message-State: ABy/qLYEfLZEMjNbBr0MyB7XG47a/rSxwttdLr9Wt3fJ/mkiqk2XcUuG
	cwrc1W0l5HVWD+WQBCA1rYfCLYI8Aeli57LlHgLCrLz1eMLmr7HOGlN6rjxQY6qgUTnrV7ewHmH
	3bzSgMU+yjzTzOLKdq4A6Jx/w
X-Received: by 2002:a05:622a:1a8c:b0:403:b001:be3b with SMTP id s12-20020a05622a1a8c00b00403b001be3bmr21070391qtc.6.1691045975770;
        Wed, 02 Aug 2023 23:59:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFkgqbNVKmQJaD+kXj55Ve3mi7oAH3CzWt6rSiBAlx7jGvgE69kkHuk2zxFPqnUmFg8v2EG5Q==
X-Received: by 2002:a05:622a:1a8c:b0:403:b001:be3b with SMTP id s12-20020a05622a1a8c00b00403b001be3bmr21070372qtc.6.1691045975432;
        Wed, 02 Aug 2023 23:59:35 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-226.dyn.eolo.it. [146.241.226.226])
        by smtp.gmail.com with ESMTPSA id t21-20020ac85895000000b00403cce833eesm5903269qta.27.2023.08.02.23.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 23:59:35 -0700 (PDT)
Message-ID: <58f719e442b92a37eb764685bf3d5c3cbae627f3.camel@redhat.com>
Subject: Re: [PATCH v2 net] tcp: Enable header prediction for active open
 connections with MD5.
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>,  David Ahern <dsahern@kernel.org>, YOSHIFUJI Hideaki
 <yoshfuji@linux-ipv6.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
Date: Thu, 03 Aug 2023 08:59:32 +0200
In-Reply-To: <CANn89iJbn2+KADkS_PJYvsm_hkSuxrp_TpYHcMDcdq71=VCSZQ@mail.gmail.com>
References: <20230803042214.38309-1-kuniyu@amazon.com>
	 <CANn89iJbn2+KADkS_PJYvsm_hkSuxrp_TpYHcMDcdq71=VCSZQ@mail.gmail.com>
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
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-08-03 at 08:44 +0200, Eric Dumazet wrote:
> On Thu, Aug 3, 2023 at 6:22=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
> >=20
> > TCP socket saves the minimum required header length in tcp_header_len
> > of struct tcp_sock, and later the value is used in __tcp_fast_path_on()
> > to generate a part of TCP header in tcp_sock(sk)->pred_flags.
> >=20
> > In tcp_rcv_established(), if the incoming packet has the same pattern
> > with pred_flags, we enter the fast path and skip full option parsing.
> >=20
> > The MD5 option is parsed in tcp_v[46]_rcv(), so we need not parse it
> > again later in tcp_rcv_established() unless other options exist.  Thus,
> > MD5 should add TCPOLEN_MD5SIG_ALIGNED to tcp_header_len and avoid the
> > slow path.
> >=20
> > For passive open connections with MD5, we add TCPOLEN_MD5SIG_ALIGNED
> > to tcp_header_len in tcp_create_openreq_child() after 3WHS.
> >=20
> > On the other hand, we do it in tcp_connect_init() for active open
> > connections.  However, the value is overwritten while processing
> > SYN+ACK or crossed SYN in tcp_rcv_synsent_state_process().
> >=20
> >   1) SYN+ACK
> >=20
> >     tcp_rcv_synsent_state_process
> >       tp->tcp_header_len =3D sizeof(struct tcphdr) or
> >                            sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGN=
ED
> >       tcp_finish_connect
> >         __tcp_fast_path_on
> >       tcp_send_ack
> >=20
> >   2) Crossed SYN and the following ACK
> >=20
> >     tcp_rcv_synsent_state_process
> >       tp->tcp_header_len =3D sizeof(struct tcphdr) or
> >                            sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGN=
ED
> >       tcp_set_state(sk, TCP_SYN_RECV)
> >       tcp_send_synack
> >=20
> >     -- ACK received --
> >     tcp_v4_rcv
> >       tcp_v4_do_rcv
> >         tcp_rcv_state_process
> >           tcp_fast_path_on
> >             __tcp_fast_path_on
> >=20
> > So these two cases will have the wrong value in pred_flags and never
> > go into the fast path.
> >=20
> > Let's add TCPOLEN_MD5SIG_ALIGNED in tcp_rcv_synsent_state_process()
> > to enable header prediction for active open connections.
>=20
> I do not think we want to slow down fast path (no MD5), for 'header
> prediction' of MD5 flows,
> considering how slow MD5 is anyway (no GSO/GRO), and add yet another
> ugly #ifdef CONFIG_TCP_MD5SIG
> in already convoluted code base.

Somewhat related, do you know how much header prediction makes a
difference for plain TCP? IIRC quite some time ago there was the idea
to remove header prediction completely to simplify the code overall -
then reverted because indeed caused regression in RR test-case. Do you
know if that is still true? would it make sense to re-evaluate that
thing (HP removal) again?

Thanks!

Paolo


