Return-Path: <netdev+bounces-31306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCC478CCE0
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 21:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3E571C20A64
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 19:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DBC18034;
	Tue, 29 Aug 2023 19:24:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EA917AA5
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 19:24:03 +0000 (UTC)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4F6A8
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 12:24:03 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-40c72caec5cso68421cf.0
        for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 12:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693337042; x=1693941842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vaz4f62R8jrTuuyVszi20PDoKa3tCUShkYlPxOWGbZM=;
        b=Uum5FAkIPPoA392K7nEl5KAcoKEUeajQFDVz/EtKJQS2lRq6897lPfvotTMa8BlJei
         jX4gu7Fpk7vLVfzQTEpqZ3J7dzMGyP8uW0IJPItemBjcFMOhq3on/hzM/iInTMSyJT3t
         ZU3aqH6+lKwAHqGVas7WcosrCIkSLdeOmAmTMvleB26kU6lCuCK6Jn8l9U0qI5vuGA+M
         wAwaEKoxJKnrB78mptDtGwjyQvShSZJPwutA4bvNDkelXBquYt9bYpAPpoFkgFg+VxO8
         WoMtrMXs/zYEHS9iwsVCwOSLRUmWEJG2KWJj6Xx5NxSosE6i6g/cjq72lrfibJV9fFtJ
         FrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693337042; x=1693941842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vaz4f62R8jrTuuyVszi20PDoKa3tCUShkYlPxOWGbZM=;
        b=bnvP+2MZZr4R+hIqTsO508190kJzqqN6mOgwfxCTYRqdFPVq8KLSG3pVXzYzpppEXH
         TeNB2NiPGg7MO2ons4DydeQjFPFbWHFeJH0ZJaG7iUZ1dlUNnISJ7DTmpmfzNCXxIC0t
         6Y5F6LWqSndftu68ZgiZXy7S9XDUVf0Ed3cR0KuH2Tix8B2pdYxP3ZWWB6RJqzW6Px9D
         +4bcAOKrZmrt59ZQb47zTDklPgja97MxFOpwae7ISln9+HSU54JFdWFdAJynkNACXXpW
         RSEMcdjYm91Ye7Ibt+GCzLX8NsTJ14pF3x5foxPExvHFouRzwGoiJUNuO5WHR5Fx/nDf
         h7Mw==
X-Gm-Message-State: AOJu0Yx1UizrQ6jCPolC1SkclbZc87r+T7TeWQ5Z5CW+bkzWT9emdOxK
	BXnnhf2+OGjqSbhziGO2TRR77wq+moFWQk5OSYwu0w==
X-Google-Smtp-Source: AGHT+IET+KzLqsTVMChq+VSnmipAzaGcCdAe2XdaszdwUuel9Uf7OLnLkRlPtQ8ViNHu/r0vWAYIwut+x/V37NGllKM=
X-Received: by 2002:ac8:5c4c:0:b0:410:88a5:92f with SMTP id
 j12-20020ac85c4c000000b0041088a5092fmr412450qtj.0.1693337042002; Tue, 29 Aug
 2023 12:24:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230828124419.2915961-1-edumazet@google.com> <CADvbK_eRLiosLw9mFbRJ5mmoCmR8vrYchk+Lvt9WjO_f=SLUwg@mail.gmail.com>
 <CANn89iL_OU1w6TTdZe45PaDkR9o8BbdXoTuF1XS9Ed=5g_NdAA@mail.gmail.com> <CADvbK_fTP1x0uqz3w9OPLpGPLMD5AcCfwT0-Lx2dkPXDGLVqxw@mail.gmail.com>
In-Reply-To: <CADvbK_fTP1x0uqz3w9OPLpGPLMD5AcCfwT0-Lx2dkPXDGLVqxw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 29 Aug 2023 21:23:50 +0200
Message-ID: <CANn89iKDKR+PDXMO9e76+NJt_a-WMGaD1Gk7Yer7Mn4hD2sX9A@mail.gmail.com>
Subject: Re: [PATCH net] sctp: annotate data-races around sk->sk_wmem_queued
To: Xin Long <lucien.xin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 29, 2023 at 9:05=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wro=
te:
>
> On Tue, Aug 29, 2023 at 2:19=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Tue, Aug 29, 2023 at 8:14=E2=80=AFPM Xin Long <lucien.xin@gmail.com>=
 wrote:
> > >
> > > On Mon, Aug 28, 2023 at 8:44=E2=80=AFAM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > sk->sk_wmem_queued can be read locklessly from sctp_poll()
> > > >
> > > >                 sk->sk_rcvbuf);
> > > Just wondering why sk->sk_sndbuf/sk_rcvbuf doesn't need READ_ONCE()
> > > while adding READ_ONCE for sk->sk_wmem_queued in here?
> > >
> >
> > Separate patches for sk_sndbuf, sk_rcvbuf, sk_err, sk_shutdown, and
> > many other socket fields.
> >
> > I prefer having small patches to reduce merge conflicts in backports.
> >
> > Note that I used  READ_ONCE(sk->sk_sndbuf) in sctp_writeable(),
> > (I assume this is why you asked)
> Yes.
>
> Not sure about tcp's seq_show, but as sctp_assocs_seq_show() is only

tcp seq_show uses requested spinlocks on lhash or ehash tables, but
not socket lock.

> under rcu_read_lock() and with a hold of transport/association/socket,
> does it mean all members of assoc should also use READ_ONCE()?

Probably...

> (Note I think we don't expect the seq show to be that accurate.)

Yeah, this is really best effort, inet_diag is probably what we want
to harden these days.

