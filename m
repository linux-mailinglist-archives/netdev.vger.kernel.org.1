Return-Path: <netdev+bounces-28943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F39C8781328
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 20:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5392824B5
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D891BB35;
	Fri, 18 Aug 2023 18:57:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C0D1BB33
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 18:57:42 +0000 (UTC)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683653C3F
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 11:57:41 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-40c72caec5cso48751cf.0
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 11:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692385060; x=1692989860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIgAuz5Mwlqryv3+XcNAaf++qbcd0L+HCV2rlRMGris=;
        b=nqqciN+tp2snp8miI7cHKKjDiB1n/zL3+a5UQ8wqdPGIHnPuUI7Xvqds3x/MRCoIkE
         WyiZUCxffW6ziGJyXYUpGShbwlHXdx6beFqlot5dGQFx8xhsbixz6yFFCLlQ15IToEXN
         tvC12lwg79WJ6V6ScZsSHBiXV1a55XIecRSQw+NQ5c5HcG/y2Is4Fv7HGuCWZIeoK1DY
         E4fnC4DpmJ8OXratuW785Zx41HGTaCQi9JElsQ3HpZd9TsAPWs0tN6ltw4UzZ7BO9Fdj
         y8il+TmLu9Z2dtwElDtYP1PdS5xDKtOr0wyvMlNx2CSd6DW/9P8MrmHFXpEU7L9x+F+4
         ByOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692385060; x=1692989860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIgAuz5Mwlqryv3+XcNAaf++qbcd0L+HCV2rlRMGris=;
        b=fZQw7NynaPMyQqR+PakdcRwwk5hzAskNCCsLMlmR7p0vtqICi0xAxYF/rHb8xVRiug
         Q29XjrCTUJVjdkAJvb4kkrhQuyRoHe7JOsqWOM0WasGLzzFmskIH83bEq3RuWDh4Hx18
         wCcJhDS89Ga0nk+6lYTf6mT4/i1IEkgPR1/XM8d2Dhho52SprQddJnTpXbMTSF095yx/
         beZBCnEV/XfwZcIm8kO18dfKo00k6CaIkQuibpDQwQOkjn8nsb5Ax8YdP/wTBt193kMi
         dyp5gnRI3kirxceMhMV8sIfdw6X+AyN1iE/WnDLONMumGDIuBKbDmeKULdxbHmdRtKZm
         Ehdg==
X-Gm-Message-State: AOJu0YxM8LoeLkOjUvMxBCrxH7+bnvJViBVCW4Dkhn5627ksJHJ+hVsU
	U/WDYYu2+nWVjni7b835zVuefbSTENrpBIAhMPMfZg==
X-Google-Smtp-Source: AGHT+IF8IDHKPoQBMSWOBUKVKskBReMFcVorBdod/PP9aHVR+JRnG7F9a68rWxPzsSjT1LvtGiXqdDOqYD9gSOCDzjs=
X-Received: by 2002:ac8:7e93:0:b0:40f:c60d:1c79 with SMTP id
 w19-20020ac87e93000000b0040fc60d1c79mr290314qtj.28.1692385060265; Fri, 18 Aug
 2023 11:57:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230818183712.123455-1-xqjcool@gmail.com>
In-Reply-To: <20230818183712.123455-1-xqjcool@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 18 Aug 2023 20:57:28 +0200
Message-ID: <CANn89iJCDYteM_1SQ-h2=htUAE4FqrBAak0kHt_Z990XYZThzQ@mail.gmail.com>
Subject: Re: [PATCH] netlink: Fix the netlink socket malfunction due to concurrency
To: Qingjie Xing <xqjcool@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	keescook@chromium.org, johannes@sipsolutions.net, pctammela@mojatatu.com, 
	dhowells@redhat.com, fw@strlen.de, kuniyu@amazon.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 18, 2023 at 8:42=E2=80=AFPM Qingjie Xing <xqjcool@gmail.com> wr=
ote:
>
> The concurrent Invocation of netlink_attachskb() and netlink_recvmsg()
> on different CPUs causes malfunction of netlink socket.
>
> The concurrent scenario of netlink_recvmsg() and netlink_attachskb()
> as following:
>
> CPU A                           CPU B
> =3D=3D=3D=3D=3D=3D=3D=3D                        =3D=3D=3D=3D=3D=3D=3D=3D
> netlink_recvmsg()               netlink_attachskb()
>                                 [1]bit NETLINK_S_CONGESTED is set
>                                 netlink_overrun()
> netlink_rcv_wake()
> [2]sk_receive_queue is empty
> clear bit NETLINK_S_CONGESTED
>                                 [3]NETLINK_F_RECV_NO_ENOBUFS not set
>                                 set bit NETLINK_S_CONGESTED
>
> In this scenario, the socket's receive queue is empty. Additionally,
> due to the NETLINK_S_CONGESTED flag being set, all packets sent to
> this socket are discarded.
>
> To prevent this situation, we need to introduce a check for whether
> the socket receive buffer is full before setting the NETLINK_S_CONGESTED
> flag.
>
> Signed-off-by: Qingjie Xing <xqjcool@gmail.com>
> ---
>  net/netlink/af_netlink.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 383631873748..80bcce9acbfc 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -352,7 +352,8 @@ static void netlink_overrun(struct sock *sk)
>         struct netlink_sock *nlk =3D nlk_sk(sk);
>
>         if (!(nlk->flags & NETLINK_F_RECV_NO_ENOBUFS)) {
> -               if (!test_and_set_bit(NETLINK_S_CONGESTED,
> +               if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf
> +                       && !test_and_set_bit(NETLINK_S_CONGESTED,
>                                       &nlk_sk(sk)->state)) {
>                         sk->sk_err =3D ENOBUFS;
>                         sk_error_report(sk);

This does not look race-free to me.

sk->sk_rcvbuf can change anytime.

I wonder if we should instead remove all this CONGESTED thing and come
back to the fundamentals,
instead of having another bit mirroring some existing state.

Apparently part of it was added in

commit cd1df525da59c64244d27b4548ff5d132489488a
Author: Patrick McHardy <kaber@trash.net>
Date:   Wed Apr 17 06:47:05 2013 +0000

    netlink: add flow control for memory mapped I/O

    Add flow control for memory mapped RX. Since user-space usually doesn't
    invoke recvmsg() when using memory mapped I/O, flow control is performe=
d
    in netlink_poll(). Dumps are allowed to continue if at least half of th=
e
    ring frames are unused.

But I do not think we kept this memory mapped RX.

