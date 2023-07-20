Return-Path: <netdev+bounces-19629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258C075B7BE
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 21:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53F961C21494
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 19:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2304E19BD5;
	Thu, 20 Jul 2023 19:15:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CA819BD0
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 19:15:08 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0543F1724
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 12:15:00 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-521e046f6c7so2530a12.1
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 12:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689880498; x=1690485298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAy1IEMzEKnBqRGLhWLekSm4eET+PZas5kwMX/alrsM=;
        b=w32q6DB+CVWrHhcm6JkTEoQAAVTVDyS/PnK86FjgSSB/Lr3/lB3ACqhaNaaUrNDK0w
         icepJnmeU5mGKl9Kw6h5BsdGKexycm4ybvnnbOF/p6TWatoZvr8yucvBaP9vfrUrri2E
         xJG35S8oppQqnj/p37imqF+tIcjHj2PGMkdrLR8++vIRXEMCWc39qJh2XxGuyz9l7TWh
         EunZd/KPmhsKGyBoN9w9OmvVnkgfq1XwtW7CblUxKSkMHmanbUoqIB1Uw5FemMm47yCx
         NMMGIZNfrHfTf90+CRzJf3kys3TAM6pfhLwX/Gdp0GR32iXuviO4kB5zW0aDk6i3otiZ
         W21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689880498; x=1690485298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAy1IEMzEKnBqRGLhWLekSm4eET+PZas5kwMX/alrsM=;
        b=JrTi+Rfvox9nt3xRKz9BPTeMX66Ror42yAj8pDoiwOXN560wD8xcsJaHC/fIF8yWz3
         kJV5Fj3afm3TXhnvxo7MZjsV57KpXKvTWkBMh3/RPnM2U9LQT8NUs3oeMw6ZRcaDRCHz
         FByiC7s8BnKwSDCtVvOmKiA8DW4u734TiKeqE3X1ZDtXjuMak6YRsrX+1uIvwid0OiCH
         zE6ADwG/X+jvQtrt6XKyNZopeqnRED6i1jgc694MdZVBWZsAUve2OTKii8ThXWNms8kP
         YJnUH8ZUSDhvepYyzjTBX0xc2PKPvv8/hlb3kgOFUYjzpIe15PEKgDfV1S2NgeEKW8ss
         +bfw==
X-Gm-Message-State: ABy/qLYuwvEXh630hQzZEqlWUa5DwQTeOeAK0/gqa0laAMlX1JlZQFw+
	jyLa6e0X0N9HPLg3CetSA0NMvQWWwjpO2UFGZ4pHaQ==
X-Google-Smtp-Source: APBJJlHQg9NmnVAiEnIEfExWOiEKsBneck65xNomT9GlPUYaiO3MdCoUT1IayLIR4gMV5Eqe7ILOteX01vOKqXcPros=
X-Received: by 2002:a50:d50b:0:b0:51a:1ffd:10e with SMTP id
 u11-20020a50d50b000000b0051a1ffd010emr19916edi.3.1689880498256; Thu, 20 Jul
 2023 12:14:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230720-upstream-net-next-20230720-mptcp-fix-rcv-buffer-auto-tuning-v1-1-175ef12b8380@tessares.net>
 <CANn89iL-tLZwjYPqmXx9-DbSHV9=epEK9iahqjwu=nsyW_tVrg@mail.gmail.com>
In-Reply-To: <CANn89iL-tLZwjYPqmXx9-DbSHV9=epEK9iahqjwu=nsyW_tVrg@mail.gmail.com>
From: Soheil Hassas Yeganeh <soheil@google.com>
Date: Thu, 20 Jul 2023 15:14:20 -0400
Message-ID: <CACSApvaBBmQsEJBZcht0--zqyWcoJm0vfiCw4RiA0AyyaJQsMw@mail.gmail.com>
Subject: Re: [PATCH net-next] mptcp: fix rcv buffer auto-tuning
To: Eric Dumazet <edumazet@google.com>
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Mat Martineau <martineau@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 3:07=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Jul 20, 2023 at 8:48=E2=80=AFPM Matthieu Baerts
> <matthieu.baerts@tessares.net> wrote:
> >
> > From: Paolo Abeni <pabeni@redhat.com>
> >
> > The MPTCP code uses the assumption that the tcp_win_from_space() helper
> > does not use any TCP-specific field, and thus works correctly operating
> > on an MPTCP socket.
> >
> > The commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> > broke such assumption, and as a consequence most MPTCP connections stal=
l
> > on zero-window event due to auto-tuning changing the rcv buffer size
> > quite randomly.
> >
> > Address the issue syncing again the MPTCP auto-tuning code with the TCP
> > one. To achieve that, factor out the windows size logic in socket
> > independent helpers, and reuse them in mptcp_rcv_space_adjust(). The
> > MPTCP level scaling_ratio is selected as the minimum one from the all
> > the subflows, as a worst-case estimate.
> >
> > Fixes: dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > ---
> >  include/net/tcp.h    | 20 +++++++++++++++-----
> >  net/mptcp/protocol.c | 15 +++++++--------
> >  net/mptcp/protocol.h |  8 +++++++-
> >  net/mptcp/subflow.c  |  2 +-
> >  4 files changed, 30 insertions(+), 15 deletions(-)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index c5fb90079920..794642fbd724 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -1430,22 +1430,32 @@ void tcp_select_initial_window(const struct soc=
k *sk, int __space,
> >                                __u32 *window_clamp, int wscale_ok,
> >                                __u8 *rcv_wscale, __u32 init_rcv_wnd);
> >
> > -static inline int tcp_win_from_space(const struct sock *sk, int space)
> > +static inline int __tcp_win_from_space(u8 scaling_ratio, int space)
> >  {
> > -       s64 scaled_space =3D (s64)space * tcp_sk(sk)->scaling_ratio;
> > +       s64 scaled_space =3D (s64)space * scaling_ratio;
> >
> >         return scaled_space >> TCP_RMEM_TO_WIN_SCALE;
> >  }
> >
> > -/* inverse of tcp_win_from_space() */
> > -static inline int tcp_space_from_win(const struct sock *sk, int win)
> > +static inline int tcp_win_from_space(const struct sock *sk, int space)
>
> Maybe in a follow up patch we could change the prototype of this helper
> to avoid future mis use :)
>
> static inline int tcp_win_from_space(const struct tcp_sock *tp, int space=
)
> {
> }
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Acked-by: Soheil Hassas Yeganeh <soheil@google.com>

Thank you for the fix!

> > +{
> > +       return __tcp_win_from_space(tcp_sk(sk)->scaling_ratio, space);
> > +}
> > +
> > +/* inverse of __tcp_win_from_space() */
> > +static inline int __tcp_space_from_win(u8 scaling_ratio, int win)
> >  {
> >         u64 val =3D (u64)win << TCP_RMEM_TO_WIN_SCALE;
> >
> > -       do_div(val, tcp_sk(sk)->scaling_ratio);
> > +       do_div(val, scaling_ratio);
> >         return val;
> >  }
> >
> > +static inline int tcp_space_from_win(const struct sock *sk, int win
>
> Same remark here.
>
> Thanks for the fix !

