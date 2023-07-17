Return-Path: <netdev+bounces-18362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05E47569AC
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 18:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7394D2811F7
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 16:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CCD1855;
	Mon, 17 Jul 2023 16:53:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8656A10E7
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 16:53:12 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A07710C0
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 09:52:46 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f86840c45dso5891e87.1
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 09:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689612764; x=1692204764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0oEurlGe3+Mk7OGAM2ybaaJ/Egck4h3rfyEcCp4qpc=;
        b=V5UXVGvDAiwYMQIXQwBCrP/IpnlT4++CKsKoEsn74v8gKpHy2YvO/tR71AT1VMS0HD
         giT+VXsm7mWSJCcMMnsdnzjaVZae2pqfY7hiESIQYQ12AIMyXzH7Dcg1/4OLDTBrNOBb
         Rqqf8RPg0EAbwY1AADmliv3kOEYkfxNXcnFZmACo9pvyh2nPry1Eq/viV+j6laTNIV3X
         5fk7PTAnNBJLACTuAmVx17beCqsIv9oR6Cb1+Qm7tifxwFKixXZMWIYCeIMV2IsMUIH6
         DgxbevyMU/7UG7miNmqUttLvZxBOelYy2W8QcFuyBXj/8j3h3SS47A86hysOmHPlIWz8
         wbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689612764; x=1692204764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w0oEurlGe3+Mk7OGAM2ybaaJ/Egck4h3rfyEcCp4qpc=;
        b=GfCu1MqICk8qC8EmJFMpOSrv0WqygHHvj6iLB1hbaflKzALj1a3ZvrcuBcI943af25
         JmffHUeUVL/wyi6PabjGGTLdP5xjUdQtLVQx83JvSHTcGkqUrWaGhYKanfooJ7LxIMwY
         3tKiEKzeaYBltCaExfRR64bKP8wov2+ygddMFnxVtTQDmnF5wsCbi76P+4CQsUl9EdGe
         HamK1xnVF8EAmBSzJE3mx70ybsiZxY3zF+4xG50Ri82RnQbTy2gzzhogwhu+mVALDiyT
         mLUJuBcfhIzYHOcDqnuivLw7A82LKUo0+UGLjrFkdxW5DLk+X2GU7ptWX6KBTKl14yns
         oKnQ==
X-Gm-Message-State: ABy/qLZ7Pc6T22edNjij8zkyzx4g+zFptwi1E0iaAWPO2qoKXAeq6hCg
	e8o6kO3Y1V0OcCJG+gZ9ZZwbgkp1wD/pUN3X0CgTYg==
X-Google-Smtp-Source: APBJJlGVFMy90Uzalsb2ZzwN4fa2va3UDr3xjY+xvN0ImZRLtI0ZatlFM922758CCjqhYOHz5ZrEi5kydPikhgu6rRE=
X-Received: by 2002:ac2:47f9:0:b0:4f3:a7c6:590e with SMTP id
 b25-20020ac247f9000000b004f3a7c6590emr370431lfp.7.1689612763539; Mon, 17 Jul
 2023 09:52:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230717152917.751987-1-edumazet@google.com>
In-Reply-To: <20230717152917.751987-1-edumazet@google.com>
From: Soheil Hassas Yeganeh <soheil@google.com>
Date: Mon, 17 Jul 2023 12:52:06 -0400
Message-ID: <CACSApvYwQah8Lxs_6ogBGigTSo=eK4YAVPahdU8oWmGjrujw3w@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: get rid of sysctl_tcp_adv_win_scale
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 17, 2023 at 11:29=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> With modern NIC drivers shifting to full page allocations per
> received frame, we face the following issue:
>
> TCP has one per-netns sysctl used to tweak how to translate
> a memory use into an expected payload (RWIN), in RX path.
>
> tcp_win_from_space() implementation is limited to few cases.
>
> For hosts dealing with various MSS, we either under estimate
> or over estimate the RWIN we send to the remote peers.
>
> For instance with the default sysctl_tcp_adv_win_scale value,
> we expect to store 50% of payload per allocated chunk of memory.
>
> For the typical use of MTU=3D1500 traffic, and order-0 pages allocations
> by NIC drivers, we are sending too big RWIN, leading to potential
> tcp collapse operations, which are extremely expensive and source
> of latency spikes.
>
> This patch makes sysctl_tcp_adv_win_scale obsolete, and instead
> uses a per socket scaling factor, so that we can precisely
> adjust the RWIN based on effective skb->len/skb->truesize ratio.
>
> This patch alone can double TCP receive performance when receivers
> are too slow to drain their receive queue, or by allowing
> a bigger RWIN when MSS is close to PAGE_SIZE.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Great idea!

Acked-by: Soheil Hassas Yeganeh <soheil@google.com>

> ---
>  Documentation/networking/ip-sysctl.rst |  1 +
>  include/linux/tcp.h                    |  4 +++-
>  include/net/netns/ipv4.h               |  2 +-
>  include/net/tcp.h                      | 24 ++++++++++++++++++++----
>  net/ipv4/tcp.c                         | 11 ++++++-----
>  net/ipv4/tcp_input.c                   | 19 ++++++++++++-------
>  6 files changed, 43 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/netwo=
rking/ip-sysctl.rst
> index 4a010a7cde7f8085db5ba6f1b9af53e9e5223cd5..82f2117cf2b36a834e5e391fe=
da0210d916bff8b 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -321,6 +321,7 @@ tcp_abort_on_overflow - BOOLEAN
>         option can harm clients of your server.
>
>  tcp_adv_win_scale - INTEGER
> +       Obsolete since linux-6.6
>         Count buffering overhead as bytes/2^tcp_adv_win_scale
>         (if tcp_adv_win_scale > 0) or bytes-bytes/2^(-tcp_adv_win_scale),
>         if it is <=3D 0.
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index b4c08ac86983568a9511258708724da15d0b999e..fbcb0ce13171d46aa3697abcd=
48482b08e78e5e0 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -172,6 +172,8 @@ static inline struct tcp_request_sock *tcp_rsk(const =
struct request_sock *req)
>         return (struct tcp_request_sock *)req;
>  }
>
> +#define TCP_RMEM_TO_WIN_SCALE 8
> +
>  struct tcp_sock {
>         /* inet_connection_sock has to be the first member of tcp_sock */
>         struct inet_connection_sock     inet_conn;
> @@ -238,7 +240,7 @@ struct tcp_sock {
>
>         u32     window_clamp;   /* Maximal window to advertise          *=
/
>         u32     rcv_ssthresh;   /* Current window clamp                 *=
/
> -
> +       u8      scaling_ratio;  /* see tcp_win_from_space() */
>         /* Information of the most recently (s)acked skb */
>         struct tcp_rack {
>                 u64 mstamp; /* (Re)sent time of the skb */
> diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
> index f003747181593559a4efe1838be719d445417041..7a41c4791536732005cedbb80=
c223b86aa43249e 100644
> --- a/include/net/netns/ipv4.h
> +++ b/include/net/netns/ipv4.h
> @@ -152,7 +152,7 @@ struct netns_ipv4 {
>         u8 sysctl_tcp_abort_on_overflow;
>         u8 sysctl_tcp_fack; /* obsolete */
>         int sysctl_tcp_max_reordering;
> -       int sysctl_tcp_adv_win_scale;
> +       int sysctl_tcp_adv_win_scale; /* obsolete */
>         u8 sysctl_tcp_dsack;
>         u8 sysctl_tcp_app_win;
>         u8 sysctl_tcp_frto;
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 226bce6d1e8c30185260baadec449b67323db91c..2104a71c75ba7eee40612395b=
e4103ae370b3c03 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1434,11 +1434,27 @@ void tcp_select_initial_window(const struct sock =
*sk, int __space,
>
>  static inline int tcp_win_from_space(const struct sock *sk, int space)
>  {
> -       int tcp_adv_win_scale =3D READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp=
_adv_win_scale);
> +       s64 scaled_space =3D (s64)space * tcp_sk(sk)->scaling_ratio;
>
> -       return tcp_adv_win_scale <=3D 0 ?
> -               (space>>(-tcp_adv_win_scale)) :
> -               space - (space>>tcp_adv_win_scale);
> +       return scaled_space >> TCP_RMEM_TO_WIN_SCALE;
> +}
> +
> +/* inverse of tcp_win_from_space() */
> +static inline int tcp_space_from_win(const struct sock *sk, int win)
> +{
> +       u64 val =3D (u64)win << TCP_RMEM_TO_WIN_SCALE;
> +
> +       do_div(val, tcp_sk(sk)->scaling_ratio);
> +       return val;
> +}
> +
> +static inline void tcp_scaling_ratio_init(struct sock *sk)
> +{
> +       /* Assume a conservative default of 1200 bytes of payload per 4K =
page.
> +        * This may be adjusted later in tcp_measure_rcv_mss().
> +        */
> +       tcp_sk(sk)->scaling_ratio =3D (1200 << TCP_RMEM_TO_WIN_SCALE) /
> +                                   SKB_TRUESIZE(4096);

Should we use PAGE_SIZE instead of 4096?

>  }
>
>  /* Note: caller must be prepared to deal with negative returns */
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index e03e08745308189c9d64509c2cff94da56c86a0c..88f4ebab12acc11d5f3feb6b1=
3974a0b8e565671 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -457,6 +457,7 @@ void tcp_init_sock(struct sock *sk)
>
>         WRITE_ONCE(sk->sk_sndbuf, READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp=
_wmem[1]));
>         WRITE_ONCE(sk->sk_rcvbuf, READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp=
_rmem[1]));
> +       tcp_scaling_ratio_init(sk);
>
>         set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
>         sk_sockets_allocated_inc(sk);
> @@ -1700,7 +1701,7 @@ EXPORT_SYMBOL(tcp_peek_len);
>  /* Make sure sk_rcvbuf is big enough to satisfy SO_RCVLOWAT hint */
>  int tcp_set_rcvlowat(struct sock *sk, int val)
>  {
> -       int cap;
> +       int space, cap;
>
>         if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
>                 cap =3D sk->sk_rcvbuf >> 1;
> @@ -1715,10 +1716,10 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
>         if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
>                 return 0;
>
> -       val <<=3D 1;
> -       if (val > sk->sk_rcvbuf) {
> -               WRITE_ONCE(sk->sk_rcvbuf, val);
> -               tcp_sk(sk)->window_clamp =3D tcp_win_from_space(sk, val);
> +       space =3D tcp_space_from_win(sk, val);
> +       if (space > sk->sk_rcvbuf) {
> +               WRITE_ONCE(sk->sk_rcvbuf, space);
> +               tcp_sk(sk)->window_clamp =3D val;
>         }
>         return 0;
>  }
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 57c8af1859c16eba5e952a23ea959b628006f9c1..3cd92035e0902298baa8afd89=
ae5edcbfce300e5 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -237,6 +237,16 @@ static void tcp_measure_rcv_mss(struct sock *sk, con=
st struct sk_buff *skb)
>          */
>         len =3D skb_shinfo(skb)->gso_size ? : skb->len;
>         if (len >=3D icsk->icsk_ack.rcv_mss) {
> +               /* Note: divides are still a bit expensive.
> +                * For the moment, only adjust scaling_ratio
> +                * when we update icsk_ack.rcv_mss.
> +                */
> +               if (unlikely(len !=3D icsk->icsk_ack.rcv_mss)) {
> +                       u64 val =3D (u64)skb->len << TCP_RMEM_TO_WIN_SCAL=
E;
> +
> +                       do_div(val, skb->truesize);
> +                       tcp_sk(sk)->scaling_ratio =3D val ? val : 1;
> +               }
>                 icsk->icsk_ack.rcv_mss =3D min_t(unsigned int, len,
>                                                tcp_sk(sk)->advmss);
>                 /* Account for possibly-removed options */
> @@ -727,8 +737,8 @@ void tcp_rcv_space_adjust(struct sock *sk)
>
>         if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_moderate_rcvbuf) &&
>             !(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
> -               int rcvmem, rcvbuf;
>                 u64 rcvwin, grow;
> +               int rcvbuf;
>
>                 /* minimal window to cope with packet losses, assuming
>                  * steady state. Add some cushion because of small variat=
ions.
> @@ -740,12 +750,7 @@ void tcp_rcv_space_adjust(struct sock *sk)
>                 do_div(grow, tp->rcvq_space.space);
>                 rcvwin +=3D (grow << 1);
>
> -               rcvmem =3D SKB_TRUESIZE(tp->advmss + MAX_TCP_HEADER);
> -               while (tcp_win_from_space(sk, rcvmem) < tp->advmss)
> -                       rcvmem +=3D 128;
> -
> -               do_div(rcvwin, tp->advmss);
> -               rcvbuf =3D min_t(u64, rcvwin * rcvmem,
> +               rcvbuf =3D min_t(u64, tcp_space_from_win(sk, rcvwin),
>                                READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rm=
em[2]));
>                 if (rcvbuf > sk->sk_rcvbuf) {
>                         WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
> --
> 2.41.0.255.g8b1d071c50-goog
>

