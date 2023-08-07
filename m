Return-Path: <netdev+bounces-24814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CFF771C26
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 10:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C7B281135
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 08:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC69EC8C1;
	Mon,  7 Aug 2023 08:19:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E59C2E3
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 08:19:55 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B980210EF
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 01:19:53 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9b458b441so7714961fa.1
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 01:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1691396392; x=1692001192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3B6TBdcDjV8f6/IGB2eVnNxIMBi0e9O51cTO2cydUo=;
        b=V310OcmylpedUbu9700c0wQOjk18lc9QgeCvhXRYNzv5hi/klJhpbbhOpV4TO+r9uX
         u4nv9r3MQPWHqYDO58xiUALjmROHBNS8kpvHqIONCnbwq697AvzpXH5G8MqZ4WYXyZ0U
         oTGn36V19twBrBcB4+1jN9mWMAfMw7s7YZZ2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691396392; x=1692001192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3B6TBdcDjV8f6/IGB2eVnNxIMBi0e9O51cTO2cydUo=;
        b=fLvAf4EuA0xzi2wxIecx55T+7BIZSr7uNlIZ31WrkdqO6dPNM7JgyZOXrv4qAfZe3L
         bd8HK1P0HM3H/+yBjH4iu0HR9+Lnx+O9USA9ZwM3UqCjiliyJzJpVbwOqW79mcXPoFKW
         FLZeGhw9bGNeyFo2XMX/d8ZPwBdaxJTxUVCEiyLX9tknAf10V3dujegtG0zlk2+2IGND
         ZmeBO8KPvb11Gz6V33veqL6WjaivR4Nl2Q5RaI5zTqMULBz4eT/+8X+0pkcuK87PuZqj
         xRqZgrRjP+JbyfAW8eCnfNU690ViIL+4g5m99lvawwRi85fdtZMzqKWJMl/8p/RU0AEu
         HCPA==
X-Gm-Message-State: ABy/qLYUWpHw2fIF6j/pWIFgYxb7fszQxAAx9HKQym+eyZIayDr+8FQ6
	IJhVQ+2nkBKRkP1PVJWBphKZWXnczwhTD6M06Rzwgg==
X-Google-Smtp-Source: APBJJlHFJH7skI9aCD17HK8OgIL1DT94p3vNFH0xCtb5o+QHnTIFCodtOi56DX75+U1cAjwlpo0BObwmwOtA4hHaVyg=
X-Received: by 2002:a2e:b54b:0:b0:2b9:3c1d:6ec0 with SMTP id
 a11-20020a2eb54b000000b002b93c1d6ec0mr12272862ljn.4.1691396391840; Mon, 07
 Aug 2023 01:19:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230807081225.816199-1-david@readahead.eu>
In-Reply-To: <20230807081225.816199-1-david@readahead.eu>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 7 Aug 2023 10:19:40 +0200
Message-ID: <CAJqdLrr4PjV0O2dCOMKvf6YcM1d_dhBgXaOFGm-4PBNmoZ-=ow@mail.gmail.com>
Subject: Re: [PATCH] net/unix: use consistent error code in SO_PEERPIDFD
To: David Rheinsberg <david@readahead.eu>
Cc: netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Stanislav Fomichev <sdf@google.com>, Luca Boccassi <bluca@debian.org>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 7, 2023 at 10:12=E2=80=AFAM David Rheinsberg <david@readahead.e=
u> wrote:
>
> Change the new (unreleased) SO_PEERPIDFD sockopt to return ENODATA
> rather than ESRCH if a socket type does not support remote peer-PID
> queries.
>
> Currently, SO_PEERPIDFD returns ESRCH when the socket in question is
> not an AF_UNIX socket. This is quite unexpected, given that one would
> assume ESRCH means the peer process already exited and thus cannot be
> found. However, in that case the sockopt actually returns EINVAL (via
> pidfd_prepare()). This is rather inconsistent with other syscalls, which
> usually return ESRCH if a given PID refers to a non-existant process.
>
> This changes SO_PEERPIDFD to return ENODATA instead. This is also what
> SO_PEERGROUPS returns, and thus keeps a consistent behavior across
> sockopts.
>
> Note that this code is returned in 2 cases: First, if the socket type is
> not AF_UNIX, and secondly if the socket was not yet connected. In both
> cases ENODATA seems suitable.
>
> Signed-off-by: David Rheinsberg <david@readahead.eu>

Hi David!

I generally agree with this. But just to be more precise, l2cap
sockets (AF_BLUETOOTH) also properly
set ->sk_peer_pid and SO_PEERPIDFD will work just fine. This thing is
not limited
only to AF_UNIX sockets.

Kind regards,
Alex

> ---
> Hi!
>
> The SO_PEERPIDFD sockopt has been queued for 6.5, so hopefully we can
> get that in before the release?
>
> Thanks
> David
>
>  net/core/sock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 6d4f28efe29a..732fc37a4771 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1778,7 +1778,7 @@ int sk_getsockopt(struct sock *sk, int level, int o=
ptname,
>                 spin_unlock(&sk->sk_peer_lock);
>
>                 if (!peer_pid)
> -                       return -ESRCH;
> +                       return -ENODATA;
>
>                 pidfd =3D pidfd_prepare(peer_pid, 0, &pidfd_file);
>                 put_pid(peer_pid);
> --
> 2.41.0
>

