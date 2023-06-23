Return-Path: <netdev+bounces-13444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F3973B9FF
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 16:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC9828060F
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 14:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFDFC153;
	Fri, 23 Jun 2023 14:18:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3526B101E8
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 14:18:07 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1F6A2
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 07:18:05 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3fde9bfb3c8so253051cf.0
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 07:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687529885; x=1690121885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqrOV6uPyp0Bm45XxWRPLMhY4tbicbOdM6Td3Z8O4ic=;
        b=t5a5kgjSlooJNpntdaGIfM6rW1KSPEKYmc80wLjYQ2s1eGW/CoNHbcQKabRibTyztz
         tDez+5lphBQY2hruznB1f8ukcyXDcvTIzycTquNoYzH5VpO9PdnJGBBfVXnIDuP3LOxF
         TFCNmE0ljNVARCj6aaFbh+gxYMwWJPBFSbITrEGtRHJvq1zIC+j6jGQNaEepl2jTNwu9
         yMn6QgiqMxz/tWOZN+YD3Nae8hw/pAOpYnG0XNxDDCqTJMc2qEyuTES/YTpiyTd7pi2E
         J3zK57PR8v12hLbwBT2IrwmdVSAJexy65ydDdxtpiW5V33wFMMDVsEUPhpLMdNubiwRg
         G7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687529885; x=1690121885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqrOV6uPyp0Bm45XxWRPLMhY4tbicbOdM6Td3Z8O4ic=;
        b=bZTnymkrcdX0TaDcIaUnnhyi4D+fpo35G7E2YWfMG/FfgbY6SVgZaKnY8W3VRfE8D7
         iFOoQ1vpi6fMfT8+OH0zHd+I1s0WzEZIEEnNKm6iW2LJiJqpUC+b2/YnYw9igSSw20ti
         9if/DYlIalfON8ZkmKH3M/CSMTpfLuFByyE4nHU+3q6eK7zbVVvLpQ0/KXO2tMSyR+CA
         Nv/5tWtmVGUYTUrSS2LMWkZ6+UMrSHrBwH+ehnOQPV7l+zzEgMaslSFQ5nNVv4GeA+5v
         3UxPUkWCymdcsYMhtoCvvnwEZVaxZb3JfkzVaU0mWiTpVOj4Qxcpjb+8WovHvaRLngVL
         a97Q==
X-Gm-Message-State: AC+VfDzY/GnfFAMu1xGgJHizDNQf2TtVqrkbQoGRyph+EAtfbDFL677o
	gpJDB31N4ceey2qt48iUFdTMoLxSo9uO1Fh0J+X8Ug==
X-Google-Smtp-Source: ACHHUZ4XA8+sIBGERSQeh2hMsnVFixsElVgOEpmRL/ljifqwwOVCm/ymTKQQ6M+qkPEe1M66LxwsxyxOZIwsgJSfc28=
X-Received: by 2002:a05:622a:1aa8:b0:3ed:210b:e698 with SMTP id
 s40-20020a05622a1aa800b003ed210be698mr118504qtc.7.1687529884715; Fri, 23 Jun
 2023 07:18:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <80736a2cc6d478c383ea565ba825eaf4d1abd876.1687523671.git.asml.silence@gmail.com>
In-Reply-To: <80736a2cc6d478c383ea565ba825eaf4d1abd876.1687523671.git.asml.silence@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 23 Jun 2023 16:17:53 +0200
Message-ID: <CANn89i+fhE76=i2J0VFacQoOqqA_iJNLazjbcHFGpu4JA6+1BQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net/tcp: optimise locking for blocking splice
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	pabeni@redhat.com, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 2:40=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> Even when tcp_splice_read() reads all it was asked for, for blocking
> sockets it'll release and immediately regrab the socket lock, loop
> around and break on the while check.
>
> Check tss.len right after we adjust it, and return if we're done.
> That saves us one release_sock(); lock_sock(); pair per successful
> blocking splice read.
>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>
> v2: go with Paolo's suggestion
>     aggressively shrink the patch
>
>  net/ipv4/tcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 71b42eef9dbf..d56edc2c885f 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -839,7 +839,7 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *=
ppos,
>                 tss.len -=3D ret;
>                 spliced +=3D ret;
>
> -               if (!timeo)
> +               if (!tss.len || !timeo)
>                         break;
>                 release_sock(sk);
>                 lock_sock(sk);

SGTM, thanks.

Reviewed-by: Eric Dumazet <edumazet@google.com>

I wonder if the "release_sock();sock_lock();"  could be replaced by
sk_flush_backlog() anyway ?
Or is there any other reason for this dance ?

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 71b42eef9dbf527098963bc03deecf55042e2021..d03d38060944d63d2728a7bf90a=
5c117b7852d8b
100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -841,8 +841,7 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *pp=
os,

                if (!timeo)
                        break;
-               release_sock(sk);
-               lock_sock(sk);
+               sk_flush_backlog();

                if (sk->sk_err || sk->sk_state =3D=3D TCP_CLOSE ||
                    (sk->sk_shutdown & RCV_SHUTDOWN) ||

