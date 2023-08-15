Return-Path: <netdev+bounces-27538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637B877C59F
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 04:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9912812E4
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 02:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D892C17D8;
	Tue, 15 Aug 2023 02:08:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA80A17C4
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 02:08:52 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACCEE5F
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 19:08:51 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1c4cd0f6cb2so1350621fac.0
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 19:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692065329; x=1692670129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2UDUvk9L4rk/sB1K5vj/z+huF5pPgKiu4Sa/NKmZL8=;
        b=DqiKHqTB35P6yr9cocypAgK/MNggAr7HQaDgtauj/j0yn8ah/PnQmHcH6ERuyD98qh
         RkwDgTXwEeQVQaJcX0LTwV56lanbEwrR5NbPMte4JeX2cIVq0knep38JWmkqEYTqs2Cj
         TqipBaDv2Q4DSBLOhUZyLWS9thzPX+33luK94KKm207C1+SbKvUINA2I5B6Xm+DZw23e
         ezIwzIe1wp/n6K5AG8+bGkM4ffAH7BZbEj1nCsA2kYl1lFDaKoHMtVO91wzW6gIcJPvZ
         unE2fQTqdxdg1qm+BIpy1X+RNWFJwie50jwXo6KTDcDeJCzmNLal6+DRNluTV8jxO7eT
         q/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692065329; x=1692670129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2UDUvk9L4rk/sB1K5vj/z+huF5pPgKiu4Sa/NKmZL8=;
        b=UbKWue4+fuDM0udntwaA1fPQ50o57Qejm4BK6ARJXySvYQCtPil/E8CMCXeNn4YDwT
         LrkaIz0grN3kreryr7Z1JZUOciXnfQ5SMjA2Vo6qpUobv33UvsaMpq2W+6sKScKHAjC2
         sxr/ZKnGGvmeQhrOFQwZ2DgGmzM4FJhgqD0WGvC3Xpz4k9xuvjH3euqy7gk95x2Xd8Jr
         ymHAaQAsWHbu57M77eUog8eH8PNRlc47ITm6szlDL8DVUoSCpg9viC5BjN1yjSspxTbO
         2bPTll4rcVaTs71YeCoW0wifLmsDXWNNoYq7kk8mswEd5Zxid2g7dN0faMbUw7RxWb6W
         veVQ==
X-Gm-Message-State: AOJu0Yz8kDu/IEzzkOgnE6ULVlZWNUp0Q3S2FfH1vQtL/iQIodLr0OL6
	p3rxJZKAuR+O8YbFPPtKUVNFHXyht5VqKLLNejQ=
X-Google-Smtp-Source: AGHT+IFMY7eMLbidggEOSZIHqAyWzYP6Ywp3MC/It+5FDm0HFdnH8RsARLdDL4z0TpBDX5CAHRknj5/2dH3p46EIwgc=
X-Received: by 2002:a05:6870:3294:b0:1bb:7f1d:10f5 with SMTP id
 q20-20020a056870329400b001bb7f1d10f5mr499080oac.20.1692065329318; Mon, 14 Aug
 2023 19:08:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230811023747.12065-1-kerneljasonxing@gmail.com>
In-Reply-To: <20230811023747.12065-1-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 15 Aug 2023 10:08:13 +0800
Message-ID: <CAL+tcoArZtbDKFMCC=i+v3fE1iG+UOBn4KhPxB-85rJCh882Xg@mail.gmail.com>
Subject: Re: [PATCH v2 net] net: fix the RTO timer retransmitting skb every
 1ms if linear option is enabled
To: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com
Cc: apetlund@simula.no, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 11, 2023 at 10:38=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> In the real workload, I encountered an issue which could cause the RTO
> timer to retransmit the skb per 1ms with linear option enabled. The amoun=
t
> of lost-retransmitted skbs can go up to 1000+ instantly.
>
> The root cause is that if the icsk_rto happens to be zero in the 6th roun=
d
> (which is the TCP_THIN_LINEAR_RETRIES value), then it will always be zero
> due to the changed calculation method in tcp_retransmit_timer() as follow=
s:
>
> icsk->icsk_rto =3D min(icsk->icsk_rto << 1, TCP_RTO_MAX);
>
> Above line could be converted to
> icsk->icsk_rto =3D min(0 << 1, TCP_RTO_MAX) =3D 0
>
> Therefore, the timer expires so quickly without any doubt.
>
> I read through the RFC 6298 and found that the RTO value can be rounded
> up to a certain value, in Linux, say TCP_RTO_MIN as default, which is
> regarded as the lower bound in this patch as suggested by Eric.
>
> Fixes: 36e31b0af587 ("net: TCP thin linear timeouts")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Hello maintainers,

I wonder why someone in the patchwork[1] changed this v2 patch into
Superseded status without comments? Should I convert it to a new
status or something else?

[1]: https://patchwork.kernel.org/project/netdevbpf/patch/20230811023747.12=
065-1-kerneljasonxing@gmail.com/

Thanks,
Jason

> ---
> v2:
> 1) nit: alway->always and the indentation style suggested by Simon.
> ---
>  net/ipv4/tcp_timer.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index d45c96c7f5a4..69795b273419 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -599,7 +599,9 @@ void tcp_retransmit_timer(struct sock *sk)
>             tcp_stream_is_thin(tp) &&
>             icsk->icsk_retransmits <=3D TCP_THIN_LINEAR_RETRIES) {
>                 icsk->icsk_backoff =3D 0;
> -               icsk->icsk_rto =3D min(__tcp_set_rto(tp), TCP_RTO_MAX);
> +               icsk->icsk_rto =3D clamp(__tcp_set_rto(tp),
> +                                      tcp_rto_min(sk),
> +                                      TCP_RTO_MAX);
>         } else if (sk->sk_state !=3D TCP_SYN_SENT ||
>                    icsk->icsk_backoff >
>                    READ_ONCE(net->ipv4.sysctl_tcp_syn_linear_timeouts)) {
> --
> 2.37.3
>

