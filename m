Return-Path: <netdev+bounces-36718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1257C7B167A
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 10:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id C41651C20943
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 08:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC1731A8B;
	Thu, 28 Sep 2023 08:53:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB1E20B04
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 08:53:52 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C6E19E
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 01:53:49 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-6515d44b562so75758176d6.3
        for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 01:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695891229; x=1696496029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWjbhr/i5AJOQnijAmkEKk5R/r8HjHHMJzDBwWijXks=;
        b=JsZutkatV5I1AVeiID19gh5dID4UJP0DooQS2V51KZRt2Ey+a1y5/21Mweq0EoHrLw
         wowYvPuvFg20kx9xiDC96pmakwDmfD+o8vu8gPO/T7uzt3haaCoNyK6EPty1FPjiGwRP
         1U3wgwKDV9dTX8TRFPs9uKb2s4ByMlifc1AmXxADSe2nLU7Osbcp13ajSsyuwL83YY+P
         T+Mt8uJHfRAXz0/FLlwMeuxyDow6W97X6mhebYYVX92xLdLWZkPCX6cMgaFOrpFI9hZT
         GUOZq1diVN4ziZLKVpKFGfQ+oyecAukAweDyjx0Znfz5vIioVG4C4HY1bpeZxg+kgvCd
         bplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695891229; x=1696496029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWjbhr/i5AJOQnijAmkEKk5R/r8HjHHMJzDBwWijXks=;
        b=MZvcJX89hbsd/xvbFB9PGoiSBl7zcLTt3u6dlli3nRVoyabWBXrYTj8FFGB5BcnpW2
         A4bDNFOhfA68lIFAM9K+Kwkg/NYK8HWIJfKpFXSJQvl0JY3tzJCQ9bApaBK1v0TpKv4u
         WVN5SJ3K5f1KX83G7PzQguZn5JELqi4u4h4nTY2YyoSNP8bPAwBWxJxorgwYRv0G88MN
         EnmM66zYfMcUwHvJb4PKkK5Sux3V3M1+rTYF2nPr/IlopJuTN7AtzrJc7rCgz8asu4M2
         PV1vzsLkCUVMExwSRLP8DQHde05asavPg6fitcoHS2YNhkeV0aHb08SVLVZo5uJeP9uv
         RJjw==
X-Gm-Message-State: AOJu0YwWmvVwyh1djIc84AHon9F8cyBdXIecIpTPqRy1r5+W5OrOzaIL
	2+8m/FyOorjAz0BTc0GeETHrt5kz67fYIl0WAQ==
X-Google-Smtp-Source: AGHT+IGIQbJM7Pn/6613DIt+LjutOir/PYlM42z5Mk+Lc7As4H8TuIURnv52jE+Q93dafRQ/5JUBRcWEhGuFzF1qk20=
X-Received: by 2002:a05:6214:3d0a:b0:658:2857:ed69 with SMTP id
 ol10-20020a0562143d0a00b006582857ed69mr637779qvb.1.1695891228930; Thu, 28 Sep
 2023 01:53:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927151501.1549078-1-ncardwell.sw@gmail.com> <20230927151501.1549078-2-ncardwell.sw@gmail.com>
In-Reply-To: <20230927151501.1549078-2-ncardwell.sw@gmail.com>
From: Xin Guo <guoxin0309@gmail.com>
Date: Thu, 28 Sep 2023 16:53:38 +0800
Message-ID: <CAMaK5_gz=B5wJhaC5MtgwiQi9Tm8fkhLdiWQLz9DX+jf0S7P=Q@mail.gmail.com>
Subject: Re: [PATCH net 2/2] tcp: fix delayed ACKs for MSS boundary condition
To: Neal Cardwell <ncardwell.sw@gmail.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Neal:
Cannot understand "if an app reads > 1*MSS data" , " If an app reads <
1*MSS data" and " if an app reads exactly 1*MSS of data" in the commit
message.
In my view, it should be like:"if an app reads and received data > 1*MSS",
" If an app reads and received data < 1*MSS" and " if an app reads and
received data exactly 1*MSS".

Regards
Guo Xin

Neal Cardwell <ncardwell.sw@gmail.com> =E4=BA=8E2023=E5=B9=B49=E6=9C=8827=
=E6=97=A5=E5=91=A8=E4=B8=89 23:15=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Neal Cardwell <ncardwell@google.com>
>
> This commit fixes poor delayed ACK behavior that can cause poor TCP
> latency in a particular boundary condition: when an application makes
> a TCP socket write that is an exact multiple of the MSS size.
>
> The problem is that there is painful boundary discontinuity in the
> current delayed ACK behavior. With the current delayed ACK behavior,
> we have:
>
> (1) If an app reads > 1*MSS data, tcp_cleanup_rbuf() ACKs immediately
>     because of:
>
>      tp->rcv_nxt - tp->rcv_wup > icsk->icsk_ack.rcv_mss ||
>
> (2) If an app reads < 1*MSS data and either (a) app is not ping-pong or
>     (b) we received two packets <1*MSS, then tcp_cleanup_rbuf() ACKs
>     immediately beecause of:
>
>      ((icsk->icsk_ack.pending & ICSK_ACK_PUSHED2) ||
>       ((icsk->icsk_ack.pending & ICSK_ACK_PUSHED) &&
>        !inet_csk_in_pingpong_mode(sk))) &&
>
> (3) *However*: if an app reads exactly 1*MSS of data,
>     tcp_cleanup_rbuf() does not send an immediate ACK. This is true
>     even if the app is not ping-pong and the 1*MSS of data had the PSH
>     bit set, suggesting the sending application completed an
>     application write.
>
> Thus if the app is not ping-pong, we have this painful case where
> >1*MSS gets an immediate ACK, and <1*MSS gets an immediate ACK, but a
> write whose last skb is an exact multiple of 1*MSS can get a 40ms
> delayed ACK. This means that any app that transfers data in one
> direction and takes care to align write size or packet size with MSS
> can suffer this problem. With receive zero copy making 4KB MSS values
> more common, it is becoming more common to have application writes
> naturally align with MSS, and more applications are likely to
> encounter this delayed ACK problem.
>
> The fix in this commit is to refine the delayed ACK heuristics with a
> simple check: immediately ACK a received 1*MSS skb with PSH bit set if
> the app reads all data. Why? If an skb has a len of exactly 1*MSS and
> has the PSH bit set then it is likely the end of an application
> write. So more data may not be arriving soon, and yet the data sender
> may be waiting for an ACK if cwnd-bound or using TX zero copy. Thus we
> set ICSK_ACK_PUSHED in this case so that tcp_cleanup_rbuf() will send
> an ACK immediately if the app reads all of the data and is not
> ping-pong. Note that this logic is also executed for the case where
> len > MSS, but in that case this logic does not matter (and does not
> hurt) because tcp_cleanup_rbuf() will always ACK immediately if the
> app reads data and there is more than an MSS of unACKed data.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Neal Cardwell <ncardwell@google.com>
> Reviewed-by: Yuchung Cheng <ycheng@google.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/tcp_input.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 06fe1cf645d5a..8afb0950a6979 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -253,6 +253,19 @@ static void tcp_measure_rcv_mss(struct sock *sk, con=
st struct sk_buff *skb)
>                 if (unlikely(len > icsk->icsk_ack.rcv_mss +
>                                    MAX_TCP_OPTION_SPACE))
>                         tcp_gro_dev_warn(sk, skb, len);
> +               /* If the skb has a len of exactly 1*MSS and has the PSH =
bit
> +                * set then it is likely the end of an application write.=
 So
> +                * more data may not be arriving soon, and yet the data s=
ender
> +                * may be waiting for an ACK if cwnd-bound or using TX ze=
ro
> +                * copy. So we set ICSK_ACK_PUSHED here so that
> +                * tcp_cleanup_rbuf() will send an ACK immediately if the=
 app
> +                * reads all of the data and is not ping-pong. If len > M=
SS
> +                * then this logic does not matter (and does not hurt) be=
cause
> +                * tcp_cleanup_rbuf() will always ACK immediately if the =
app
> +                * reads data and there is more than an MSS of unACKed da=
ta.
> +                */
> +               if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_PSH)
> +                       icsk->icsk_ack.pending |=3D ICSK_ACK_PUSHED;
>         } else {
>                 /* Otherwise, we make more careful check taking into acco=
unt,
>                  * that SACKs block is variable.
> --
> 2.42.0.515.g380fc7ccd1-goog
>
>

