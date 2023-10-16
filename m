Return-Path: <netdev+bounces-41269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 392AB7CA6DD
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 13:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626181C20940
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE9C23778;
	Mon, 16 Oct 2023 11:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2Q5uhr7K"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153DC24214
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 11:41:02 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14386E6
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 04:41:00 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so11469a12.0
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 04:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697456458; x=1698061258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2I6xiVgm8CDmOxobNPXJ5HYpt0gEXNwuNgT27rQ1pK8=;
        b=2Q5uhr7KZnIOPozm+oy0vHWbp03Q1sFUZSwBPx0LsVQC/w/dnP/c3KuRsVKTGEu7kM
         AROIj0DxDxL1/YKoSGX7rM5Lq1lTKGlp1lkaJWGbrOjLbVJXxdpyCT1WYWzb3vbWOBgk
         anltbr9L+X2Hn1JBwCIzkQjRdEjjugweYDFB8mohX2nuHlw0wCfQMUy4FqZzgBkBaHdR
         8SPVoFEJSGtEulLCD0j5oxaLuLvVE5dUJvuP0kmBS9RuKVQIuAeZGQ6X55Aqyj9Vn3md
         s2mtdAxgTRbWRYgZ+LzvH0GL2oEeUQ6/l+nyB3P1/YMPXJaPilTrFc8I/841CfVH1Yba
         CarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697456458; x=1698061258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2I6xiVgm8CDmOxobNPXJ5HYpt0gEXNwuNgT27rQ1pK8=;
        b=S5UIwdOKw11eZr5puhHhbx4Z1B2PprqUxSgj5ffIsSXUSsL71rPKkza5zpSBw5FTnK
         juXGboHkDVZ0Qa/sGTTgmaifEUTdvZ+2dnXnOzPmY7GEOMemzIjQnnPLQpoRlz/xrwaJ
         U30S31Pk/OvhwEPeWznNlsRil35MF5i21YNF5ZTnPIEN/ok9f8+wqVC/CZp0wnzaR+89
         pw3kCfA5nRKAacmq5VDH7Qdc8143bMQYWQaULDhG4/VOGhB5NtDwkKUXl0uB569Ban4u
         ulXGRBR79zA9oWoPaFRAwtv/mfz3ftduCGcLsmzCsoebBuUC2x2ujHijDzRSmbg3CWyX
         0ahw==
X-Gm-Message-State: AOJu0YyNMMTYPF7e2hswTGT86DG2rWcYriJu8Abx4ZK+t2zlrDbT7l2z
	EbJYrtP/tdTUabtwNk4l6D7EmXjPhOhgVW4PYx+BJg==
X-Google-Smtp-Source: AGHT+IEd7QsZDGvewhvSCOpW/J+FnpZ5jMRtoRoEZoPIfRkDvA7e50KC0N8Z+vcUAqp+1WNdbYbn6DP3CRW+eN2eV5Y=
X-Received: by 2002:a50:cd16:0:b0:538:1d3a:d704 with SMTP id
 z22-20020a50cd16000000b005381d3ad704mr155111edi.1.1697456458241; Mon, 16 Oct
 2023 04:40:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1697056244-21888-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1697056244-21888-1-git-send-email-haiyangz@microsoft.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 16 Oct 2023 13:40:43 +0200
Message-ID: <CANn89iLth-thO7=V=b+3dbP=K-m+hbBk75FtM+7cFiUphGXwoA@mail.gmail.com>
Subject: Re: [PATCH net-next,v3] tcp: Set pingpong threshold via sysctl
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, kys@microsoft.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, 
	dsahern@kernel.org, ncardwell@google.com, ycheng@google.com, 
	kuniyu@amazon.com, morleyd@google.com, mfreemon@cloudflare.com, 
	mubashirq@google.com, linux-doc@vger.kernel.org, weiwan@google.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 10:31=E2=80=AFPM Haiyang Zhang <haiyangz@microsoft.=
com> wrote:
>
> TCP pingpong threshold is 1 by default. But some applications, like SQL D=
B
> may prefer a higher pingpong threshold to activate delayed acks in quick
> ack mode for better performance.
>

...

>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index f207712eece1..7d0fe76d56ef 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -170,10 +170,10 @@ static void tcp_event_data_sent(struct tcp_sock *tp=
,
>         tp->lsndtime =3D now;
>
>         /* If it is a reply for ato after last received
> -        * packet, enter pingpong mode.
> +        * packet, increase pingpong count.
>          */
>         if ((u32)(now - icsk->icsk_ack.lrcvtime) < icsk->icsk_ack.ato)
> -               inet_csk_enter_pingpong_mode(sk);
> +               inet_csk_inc_pingpong_cnt(sk);
>  }
>
>  /* Account for an ACK we sent. */

OK, but I do not think we solved the fundamental problem of using
jiffies for this heuristic,
especially for HZ=3D100 or HZ=3D250 builds.

Reviewed-by: Eric Dumazet <edumazet@google.com>

