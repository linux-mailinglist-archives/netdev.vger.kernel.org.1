Return-Path: <netdev+bounces-60938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF9A821F02
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 16:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A7128385C
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 15:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25D114ABD;
	Tue,  2 Jan 2024 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hv9Tmw02"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A9214A82
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso101391a12.0
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 07:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704210641; x=1704815441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEhPCVqbUPPnWg/1WnoBR6d16GOqX/0/8GhWm9dP5cw=;
        b=Hv9Tmw02qBwEa2nfJxYLqbKHUN86D9AricewgJcYQHrezkipNmuYofI0eLFu2NK+Dh
         bPCQOIfq7ShNOqzzH24evcLo64e0Nzcdbz6bGgNSws6QnOBB6V+tNmfJPVAHiyCtRlja
         XvHDPAsK7gdiZsmwDoKgwJ0L217NGtrT72BRsjG/YKAefnhUwVA3eQ58VW8Z1AO2hhW2
         lvVGC7wFISko3l5b955BSWcRtedH/ub/meImlaQkzEV+G/p0yovDw8Ccb+zDQp4pXzMx
         3/CJf8JyApFExuuMdYqOOJEW/q03ew6KqVnlfO/1Bqe+2TDiuJENCqTsMrE9kdDWH4hm
         j1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704210641; x=1704815441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEhPCVqbUPPnWg/1WnoBR6d16GOqX/0/8GhWm9dP5cw=;
        b=U9AFRCdO02alR5TWR2Vw4PLhUfUqHeLWIEh8IKHeRCv3fqQXGxcYub7eo4IOShvM0h
         spB71sVALcIfsN+pm3XkzAJaHiM7me7OMtGMFZPv1G6Ke0NHRIvhtLU3vu1RzwI+Wlp4
         Lh5Ke6QvvU1op3XgTGdruSfQi5hhPY+wItdAtGieC8AASPuDE8nVxvyldYjJ6aApWnIX
         HRCW+K7htCuy+qs7fq1Nzvu899ZFbM1lWdJtNHi+wxDRZSybjDttBKPuUA8FjaNA323J
         tU/p0poLd9/s2wsZ26QCXBCRn9dmScbnoimpNNjQruRwbf+nsiFkAYwWY1ZFXNBANhMo
         AIeg==
X-Gm-Message-State: AOJu0YwymJnFPY9MShCdv3VFGS9m4uFzd6AKchgLf8YgVtqZG+/RII0O
	7t+5B4WJLTIBUCjhSawLNjugqY/xIoBdyQE9YhaMZWY92qC1
X-Google-Smtp-Source: AGHT+IEBp/pdgn+E2AzHJMW6+rShXs0Jm1nSLfQs9dRBksK4a8xe83xZMLkNn4emFb/UywGMoHKmopxwcBnGixzyMvA=
X-Received: by 2002:a50:d705:0:b0:553:62b4:5063 with SMTP id
 t5-20020a50d705000000b0055362b45063mr1107144edi.4.1704210641364; Tue, 02 Jan
 2024 07:50:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221140747.1171134-1-edumazet@google.com> <20231223161620.GF201037@kernel.org>
In-Reply-To: <20231223161620.GF201037@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Jan 2024 16:50:28 +0100
Message-ID: <CANn89i+4jOEOrE3=T7XfEypKoQaFaGeYbbPdfXSHQaEHiXgWWw@mail.gmail.com>
Subject: Re: [PATCH net-next] net-device: move gso_partial_features to net_device_read_tx
To: Simon Horman <horms@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Coco Li <lixiaoyan@google.com>, 
	David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 5:16=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Thu, Dec 21, 2023 at 02:07:47PM +0000, Eric Dumazet wrote:
> > dev->gso_partial_features is read from tx fast path for GSO packets.
> >
> > Move it to appropriate section to avoid a cache line miss.
> >
> > Fixes: 43a71cd66b9c ("net-device: reorganize net_device fast path varia=
bles")
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Coco Li <lixiaoyan@google.com>
> > Cc: David Ahern <dsahern@kernel.org>
>
> Thanks Eric,
>
> FWIIW, this change looks good to me.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
>
> I have a follow-up question below.
>
> ...
>
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 75c7725e5e4fdf59da55923cd803e084956b0fa0..5d1ec780122919c31e42153=
58d736aef3f8a0acd 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -2114,6 +2114,7 @@ struct net_device {
> >       const struct net_device_ops *netdev_ops;
> >       const struct header_ops *header_ops;
> >       struct netdev_queue     *_tx;
> > +     netdev_features_t       gso_partial_features;
> >       unsigned int            real_num_tx_queues;
> >       unsigned int            gso_max_size;
> >       unsigned int            gso_ipv4_max_size;
>
> While looking at this I came to wonder if it would
> be worth adding a 16bit pad a little below this hunk
> so that tc_to_txq sits on it's own cacheline.
>

Hi Simon, thanks for the suggestion.

I am still working on struct net_device layout (after being off for
last ~10 days), I will try to address your feedback soon.


> I'm unsure if the access pattern of tc_to_txq makes this worthwhile.
> But if so it would be a simple tweak.
>
> With such a change in place, on top of your patch, the diff of pahole out=
put
> on x86_64 is:
>
> @@ -7432,10 +7432,9 @@
>         s16                        num_tc;               /*    54     2 *=
/
>         unsigned int               mtu;                  /*    56     4 *=
/
>         short unsigned int         needed_headroom;      /*    60     2 *=
/
> -       struct netdev_tc_txq       tc_to_txq[16];        /*    62    64 *=
/
> -
> -       /* XXX 2 bytes hole, try to pack */
> -
> +       u16                        pad1;                 /*    62     2 *=
/
> +       /* --- cacheline 1 boundary (64 bytes) --- */
> +       struct netdev_tc_txq       tc_to_txq[16];        /*    64    64 *=
/
>         /* --- cacheline 2 boundary (128 bytes) --- */
>         struct xps_dev_maps *      xps_maps[2];          /*   128    16 *=
/
>         struct nf_hook_entries *   nf_hooks_egress;      /*   144     8 *=
/

