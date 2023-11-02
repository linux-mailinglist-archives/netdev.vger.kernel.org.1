Return-Path: <netdev+bounces-45778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CC37DF891
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 18:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E5C1C20E8C
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 17:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07C51DFE7;
	Thu,  2 Nov 2023 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N9doqdmV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0AF1DFE4
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 17:19:26 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD79123
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 10:19:24 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so882a12.0
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 10:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698945563; x=1699550363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+2TP0FOAoKmUn3WfaKaiXhu4WWIWVZ5gwov43r9xf4=;
        b=N9doqdmVxF79i1CtOgLr4JeM0Ru3xgQHTgoJUWdwWc61oKXxfpKU6iy1wCSAqo98/z
         pAKD1suXTHPTMLxihNTVELbJasgsAsQK2wbS4grcoAqE1AkK53rafINfivD+CmZVYxi/
         7O4od6aTgEfX+4Gd+AEiiRJStrys6oqljjzriyaDaAb152gF6y3BfjL+NgfB3O5T/sNY
         Q5nS7Ml7+MppTxKJWNZFa66rXuI4ER/HSjJ6mF/iA06ajxm0uI/oi8wVvoeq0xE8DCKN
         VDJ2ymvj95Vf9/Z0U08VrqZxnpJaZjI15vWdoo+U0KlDghTNghg7oVNvpdE7P3D5S03g
         x01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698945563; x=1699550363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+2TP0FOAoKmUn3WfaKaiXhu4WWIWVZ5gwov43r9xf4=;
        b=NhJlN/MbjjXEvsyIE8RZRrKPhTYPIGPpnQnohHop3UE7pd3bVZmWBWWh29a8TuUVsB
         P3lSb8LjnjarrWX2oLv0zRoIxcYr85+LrhLRYATLTqWCh4+kJK08inXGbLZUrVC6XmHP
         MhVfIUoRUArIqDK5yxsZsGVQvqxR8p6id9lSjmWKEkJJXJ1m2lndmdZKokRL3CFc96jV
         wJlr+8Xtg3pbnSmlQ+QRZOiQOH0NOh1+nD1Lo7Pju/jGyVJKcnbNM7qdD1kLATnRf3eV
         +y6A8830UGZPMaAnbXxXQHiBuSIWS0BSnaRDyix07lvF/lTNAz80HDS0dlBXtMSeq4bo
         R8OA==
X-Gm-Message-State: AOJu0Yz5PBo7EMBxRmbc3QDoH08WNHXtxDynVm7MPCub5Cj82vf+TeXL
	SDply1ee4baz16QRzGx8w4kDEIDxj6l50FrIoAAMxLyH5sW0Rm6G79Q=
X-Google-Smtp-Source: AGHT+IEl0B2JCgmhu5tHja5ZriE678sy3KdjaYV4bixvTouZPN/RkOvRcUSTmkfTdoy+2v/LEkWPE9gWCaQvAfiHb4I=
X-Received: by 2002:a50:d543:0:b0:543:5119:2853 with SMTP id
 f3-20020a50d543000000b0054351192853mr93522edj.6.1698945563136; Thu, 02 Nov
 2023 10:19:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023-send-net-next-20231023-2-v1-0-9dc60939d371@kernel.org> <20231023-send-net-next-20231023-2-v1-9-9dc60939d371@kernel.org>
In-Reply-To: <20231023-send-net-next-20231023-2-v1-9-9dc60939d371@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 2 Nov 2023 18:19:09 +0100
Message-ID: <CANn89iLZUA6S2a=K8GObnS62KK6Jt4B7PsAs7meMFooM8xaTgw@mail.gmail.com>
Subject: Re: [PATCH net-next 9/9] mptcp: refactor sndbuf auto-tuning
To: Mat Martineau <martineau@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 10:45=E2=80=AFPM Mat Martineau <martineau@kernel.or=
g> wrote:
>
> From: Paolo Abeni <pabeni@redhat.com>
>
> The MPTCP protocol account for the data enqueued on all the subflows
> to the main socket send buffer, while the send buffer auto-tuning
> algorithm set the main socket send buffer size as the max size among
> the subflows.
>
> That causes bad performances when at least one subflow is sndbuf
> limited, e.g. due to very high latency, as the MPTCP scheduler can't
> even fill such buffer.
>
> Change the send-buffer auto-tuning algorithm to compute the main socket
> send buffer size as the sum of all the subflows buffer size.
>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Mat Martineau <martineau@kernel.org

...

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index df208666fd19..2b43577f952e 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -421,6 +421,7 @@ static bool subflow_use_different_dport(struct mptcp_=
sock *msk, const struct soc
>
>  void __mptcp_set_connected(struct sock *sk)
>  {
> +       __mptcp_propagate_sndbuf(sk, mptcp_sk(sk)->first);

->first can be NULL here, according to syzbot.

>         if (sk->sk_state =3D=3D TCP_SYN_SENT) {
>                 inet_sk_state_store(sk, TCP_ESTABLISHED);
>                 sk->sk_state_change(sk);

