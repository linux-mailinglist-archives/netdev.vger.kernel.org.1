Return-Path: <netdev+bounces-19623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 934AE75B771
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 21:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EEE1281F71
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 19:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B58619BD0;
	Thu, 20 Jul 2023 19:07:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4A919BCD
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 19:07:55 +0000 (UTC)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EA41984
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 12:07:52 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40371070eb7so63471cf.1
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 12:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689880071; x=1690484871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4XG/fB8WpES5L9ZA04wwj/o6tX3jA1gLNRCsTQHJyI=;
        b=lHLZY3Ewd8Ty/3BcHCByP7EV4tgjVjwB9NSqtCgVqzs95PgXPyLDBRvrA7C2uJBnGP
         lnOwzsq3sqNxj9jEUP2/aVqPJFk4I9QWp/z+Uq+fI+Q/Xyh2zcO8BYvF+8gNYwhis8GX
         BcjfAYa+Wcnti46YaH3C+G45A79yR7/YR7di4XdREX7pbNR7g8dpW59GmEYKhigkvZqz
         wL+MHGGVgKLRUShoM6vlJaxdJqkMF673n+jvCweu6jJrujfqJzsmD+J9ZPlDlzbJr/zU
         g4nMAhm5+VYavMaJC1CbD3XFAMMGqv8i6cTVzbOBmhRKKID7TIERIAvYG/wyX6RgT2yn
         PQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689880071; x=1690484871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4XG/fB8WpES5L9ZA04wwj/o6tX3jA1gLNRCsTQHJyI=;
        b=FsMe25qwCsea3R0TNzFZuteqem1CCAu5Xsi5ibaYc1zUicNPyR1fd1rhG1QFKF2fA/
         T9vuu7DbOrRJRiRbQPCs44cK9sawSYQsfvgere+SWXX9HyVmCP3NmnmmS9M+yyS+oqDQ
         qb7xRK6c8L2n8a8y68bbPF77JorA83qWYTrxeElYHxOLUW1u7/Zme9VAJ9CLa2QCCYs3
         SK8FbuJ0ORmFMhoEjEVbEkGx+VrKHm1PRQM3BfJFlSfyhzUsjAx0l8BjWm/MpJnTnCpU
         NXoSrhZWsFhz3SzXgtNvJeb3e9eFkgHkq1hkqxaRv/avQJwx3RcizyJjQU7G5ZIehuLc
         Xhtw==
X-Gm-Message-State: ABy/qLYIF5WxHt2HqxKTkDOqVAJ72otSCqCPLIttlk83HYYlONqIHjg0
	5ESBv3oUjGW/v9ksrspLlsmqpvczY4+PIBZOFPIfug==
X-Google-Smtp-Source: APBJJlEur6cHnlzJHXbLUn2GBZ0Ah3NwAqthv5DSX4rSx/tBDaSx89c7j31E72vgVfMeFIXZvzcYQK3D0t4u03+tbqk=
X-Received: by 2002:a05:622a:1a87:b0:3f9:56c:1129 with SMTP id
 s7-20020a05622a1a8700b003f9056c1129mr31665qtc.5.1689880071131; Thu, 20 Jul
 2023 12:07:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230720-upstream-net-next-20230720-mptcp-fix-rcv-buffer-auto-tuning-v1-1-175ef12b8380@tessares.net>
In-Reply-To: <20230720-upstream-net-next-20230720-mptcp-fix-rcv-buffer-auto-tuning-v1-1-175ef12b8380@tessares.net>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Jul 2023 21:07:39 +0200
Message-ID: <CANn89iL-tLZwjYPqmXx9-DbSHV9=epEK9iahqjwu=nsyW_tVrg@mail.gmail.com>
Subject: Re: [PATCH net-next] mptcp: fix rcv buffer auto-tuning
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Mat Martineau <martineau@kernel.org>, Soheil Hassas Yeganeh <soheil@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 8:48=E2=80=AFPM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> From: Paolo Abeni <pabeni@redhat.com>
>
> The MPTCP code uses the assumption that the tcp_win_from_space() helper
> does not use any TCP-specific field, and thus works correctly operating
> on an MPTCP socket.
>
> The commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> broke such assumption, and as a consequence most MPTCP connections stall
> on zero-window event due to auto-tuning changing the rcv buffer size
> quite randomly.
>
> Address the issue syncing again the MPTCP auto-tuning code with the TCP
> one. To achieve that, factor out the windows size logic in socket
> independent helpers, and reuse them in mptcp_rcv_space_adjust(). The
> MPTCP level scaling_ratio is selected as the minimum one from the all
> the subflows, as a worst-case estimate.
>
> Fixes: dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  include/net/tcp.h    | 20 +++++++++++++++-----
>  net/mptcp/protocol.c | 15 +++++++--------
>  net/mptcp/protocol.h |  8 +++++++-
>  net/mptcp/subflow.c  |  2 +-
>  4 files changed, 30 insertions(+), 15 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index c5fb90079920..794642fbd724 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1430,22 +1430,32 @@ void tcp_select_initial_window(const struct sock =
*sk, int __space,
>                                __u32 *window_clamp, int wscale_ok,
>                                __u8 *rcv_wscale, __u32 init_rcv_wnd);
>
> -static inline int tcp_win_from_space(const struct sock *sk, int space)
> +static inline int __tcp_win_from_space(u8 scaling_ratio, int space)
>  {
> -       s64 scaled_space =3D (s64)space * tcp_sk(sk)->scaling_ratio;
> +       s64 scaled_space =3D (s64)space * scaling_ratio;
>
>         return scaled_space >> TCP_RMEM_TO_WIN_SCALE;
>  }
>
> -/* inverse of tcp_win_from_space() */
> -static inline int tcp_space_from_win(const struct sock *sk, int win)
> +static inline int tcp_win_from_space(const struct sock *sk, int space)

Maybe in a follow up patch we could change the prototype of this helper
to avoid future mis use :)

static inline int tcp_win_from_space(const struct tcp_sock *tp, int space)
{
}

Reviewed-by: Eric Dumazet <edumazet@google.com>


> +{
> +       return __tcp_win_from_space(tcp_sk(sk)->scaling_ratio, space);
> +}
> +
> +/* inverse of __tcp_win_from_space() */
> +static inline int __tcp_space_from_win(u8 scaling_ratio, int win)
>  {
>         u64 val =3D (u64)win << TCP_RMEM_TO_WIN_SCALE;
>
> -       do_div(val, tcp_sk(sk)->scaling_ratio);
> +       do_div(val, scaling_ratio);
>         return val;
>  }
>
> +static inline int tcp_space_from_win(const struct sock *sk, int win

Same remark here.

Thanks for the fix !

