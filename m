Return-Path: <netdev+bounces-31307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECF078CD24
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 21:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0810528128B
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 19:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E8218049;
	Tue, 29 Aug 2023 19:45:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9740A174E6
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 19:45:11 +0000 (UTC)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0CB1B1
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 12:45:10 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d7b89c596d8so660392276.3
        for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 12:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693338309; x=1693943109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jijHRnu69Kg5rSYFP51KuY9+nU2Oa5Kw8OE4nsWTp74=;
        b=Uu7ECylCrotM6DOHT+2CedC++wZqTlEY3FIfjkVoCH8r0FoPVphy/E6lXQ1rmqWow5
         pgkmBmRGAsTHlAwur9T5aqeDQx3wrSwoeRf4aDxy/yHpbw16rmXKGOHPYpRSc685CfL6
         xfrIM9pY39ARhWGNu4ARG/X91c3sNbXa49u4T8IU1Gbt6hujCXYqqfOWsf4pLBVjR4Wb
         geD0p/4HYm6OGK0v/rcXIIiF/y/eJH1gyY//Usp2QmgJLMcWeNk/Y0JegsbKDb5bP0F2
         RMjCfUDG+0d7EPGzxsglr23IVb4uqX+1PuEWuM8qcKGK0jWy0bFqFKiaSg6Dpf/o4Ri3
         fURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693338309; x=1693943109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jijHRnu69Kg5rSYFP51KuY9+nU2Oa5Kw8OE4nsWTp74=;
        b=kD6cZdcmWhVrRYp0B0koKwwYM5wLMfNMvvzxQLmDJshat4UwooRAPtJvfK2ZYykRtX
         nckZHDQ2FuHe+tZQ9ZGewuCbR/wrlknKsUO6/zL47yjvIFe0Vgc+3LZwoafBYjgSO37q
         xZQJGgEhKy3clo99GhlDU+Ulmxeipo+HJTMWEpgGGHlbo+6evb6i4n3Q3DlFk/CgmLFG
         NR86LrM4W6mQd7R68dMUaq7f3xdZ2aFs2+dw/Hoo7VrzK6YEtVKKue3ID1ymXiMoTanU
         odxJ37+4hnrF6WZvuwWayf6HkEFOWRn3AoSKNg0pEayyoolkkft5Bc1IzTE5nOLV1mfo
         pN4g==
X-Gm-Message-State: AOJu0YwODx2IR4xSEdQdsVBxdrwHttQ0I8GQLyaNkklZ1wCjSXtamA5K
	UzfAfxDSTvnVLQrvl4S5c/SGoZeMQ/wZU+w+tYk=
X-Google-Smtp-Source: AGHT+IH+K2+/kNXq9qWv3bz0QonK3j7qOpnnWKA+5rt4PUC4QtcprLvD2XSlLeVCtkivJrIAvv3evQ0CUdZHh+ZAk0k=
X-Received: by 2002:a25:ad4e:0:b0:d4d:f8f4:e409 with SMTP id
 l14-20020a25ad4e000000b00d4df8f4e409mr118004ybe.57.1693338309225; Tue, 29 Aug
 2023 12:45:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230828124419.2915961-1-edumazet@google.com> <CADvbK_eRLiosLw9mFbRJ5mmoCmR8vrYchk+Lvt9WjO_f=SLUwg@mail.gmail.com>
 <CANn89iL_OU1w6TTdZe45PaDkR9o8BbdXoTuF1XS9Ed=5g_NdAA@mail.gmail.com>
 <CADvbK_fTP1x0uqz3w9OPLpGPLMD5AcCfwT0-Lx2dkPXDGLVqxw@mail.gmail.com> <CANn89iKDKR+PDXMO9e76+NJt_a-WMGaD1Gk7Yer7Mn4hD2sX9A@mail.gmail.com>
In-Reply-To: <CANn89iKDKR+PDXMO9e76+NJt_a-WMGaD1Gk7Yer7Mn4hD2sX9A@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 29 Aug 2023 15:44:48 -0400
Message-ID: <CADvbK_d07SQ=xO=GtGL8DzOQH2x=T2ObMWdUknQrTnQT+-JZLw@mail.gmail.com>
Subject: Re: [PATCH net] sctp: annotate data-races around sk->sk_wmem_queued
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 29, 2023 at 3:24=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Aug 29, 2023 at 9:05=E2=80=AFPM Xin Long <lucien.xin@gmail.com> w=
rote:
> >
> > On Tue, Aug 29, 2023 at 2:19=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Tue, Aug 29, 2023 at 8:14=E2=80=AFPM Xin Long <lucien.xin@gmail.co=
m> wrote:
> > > >
> > > > On Mon, Aug 28, 2023 at 8:44=E2=80=AFAM Eric Dumazet <edumazet@goog=
le.com> wrote:
> > > > >
> > > > > sk->sk_wmem_queued can be read locklessly from sctp_poll()
> > > > >
> > > > >                 sk->sk_rcvbuf);
> > > > Just wondering why sk->sk_sndbuf/sk_rcvbuf doesn't need READ_ONCE()
> > > > while adding READ_ONCE for sk->sk_wmem_queued in here?
> > > >
> > >
> > > Separate patches for sk_sndbuf, sk_rcvbuf, sk_err, sk_shutdown, and
> > > many other socket fields.
> > >
> > > I prefer having small patches to reduce merge conflicts in backports.
> > >
> > > Note that I used  READ_ONCE(sk->sk_sndbuf) in sctp_writeable(),
> > > (I assume this is why you asked)
> > Yes.
> >
> > Not sure about tcp's seq_show, but as sctp_assocs_seq_show() is only
>
> tcp seq_show uses requested spinlocks on lhash or ehash tables, but
> not socket lock.
>
> > under rcu_read_lock() and with a hold of transport/association/socket,
> > does it mean all members of assoc should also use READ_ONCE()?
>
> Probably...
OK, just thinking syzbot may report it in the future here.

>
> > (Note I think we don't expect the seq show to be that accurate.)
>
> Yeah, this is really best effort, inet_diag is probably what we want
> to harden these days.

Acked-by: Xin Long <lucien.xin@gmail.com>

Thanks.

