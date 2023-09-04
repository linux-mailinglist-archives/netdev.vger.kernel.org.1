Return-Path: <netdev+bounces-31899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B123E791449
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 11:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 871FA1C20823
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 09:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74940138A;
	Mon,  4 Sep 2023 09:06:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C747E
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 09:06:31 +0000 (UTC)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F46A139
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 02:06:30 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-414ba610766so199921cf.0
        for <netdev@vger.kernel.org>; Mon, 04 Sep 2023 02:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693818389; x=1694423189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jImmS2kD2pYlWvpAtgkNc4mxAlxPmWxZipUdUGUf7Ok=;
        b=NJwIvBE3EzPJIcsxU0LTmWuML7i7LXcFMIxes8l1lKa5fKwta/imOU2Fj5PrTMpJ1s
         RUZUtJ2d07RWWDAXntiwzCch1gVDRkdKEO3Yov1vNB4vPI8obXw9fv6gkjRNtwb3bdYg
         gHgbjlAMnQqqLLgdl+Xzwsrb3Pq300Rt3w2OJTVUHODZyuhBDT6GsZXqwTk8KQD+u8cQ
         qlrMOkisloHP9zU4lqy2LU+kbpKDtUKWhEMJXynwkiIZJ69fViunJNb9SikorLj5fh3f
         w+IwmaE6UlRgAmilm+1jKfNgXRrGRC8sUBGbjjKYhRR3cKIvhzNVeUKPu+EnqpWXN2xS
         ATeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693818389; x=1694423189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jImmS2kD2pYlWvpAtgkNc4mxAlxPmWxZipUdUGUf7Ok=;
        b=Isgn9EcT+kznYhLiZi8btJ+ub90R4V0aKwG7X6+TNKvQ93q5AvWCUel+Wv/6+e8KSB
         O25i9KvPa4GkXlHAHmLFP1ccVunOnPhTuIoVTwmyvsLuSroPjfAHIHeJNapF9/uvGtcn
         S8mvP5czI5oImtV48RupyDOQzm7r5OsboCRD5M+b29zOsAcMvxU/64RWB3lUJHP7E75D
         8dqkdyEXFi4hnaUZIqo9JR22K7zSV8DVPCo1atZoNfwATWlPW2lY7VIZuG3G04QDFRdZ
         XYDc1SNcjHGHDUMv+M0ddfDiVWvzEd2C+rcQ9133zY7SJ59GLsrBxowu1z5gOBL5ryT3
         YUFg==
X-Gm-Message-State: AOJu0YxgExnB3mODoR+j2S/Rjm3zVwrDdfYu4EjUHovpiVKO4NDw+6fU
	BWoJ9gqv2GyYHT1xoPRcRYx/+FKN6HxzK7v7J/vCFQ==
X-Google-Smtp-Source: AGHT+IGn3OvRrY6O/lEbay9h5WK1RFlVrSVsvdKSIjpyuuUZT89jgnUlaQmpIwZafVfK3ifFKBn3/yMi6U8ZSg6x0x4=
X-Received: by 2002:ac8:5b51:0:b0:3de:1aaa:42f5 with SMTP id
 n17-20020ac85b51000000b003de1aaa42f5mr229084qtw.15.1693818388939; Mon, 04 Sep
 2023 02:06:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230831183750.2952307-1-edumazet@google.com> <d273628df80f45428e739274ab9ecb72@AcuMS.aculab.com>
In-Reply-To: <d273628df80f45428e739274ab9ecb72@AcuMS.aculab.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Sep 2023 11:06:17 +0200
Message-ID: <CANn89iJY4=Q0edL-mf2JrRiz8Ld7bQcogOrc4ozLEVD8qz8o2A@mail.gmail.com>
Subject: Re: [PATCH net] net: deal with integer overflows in kmalloc_reserve()
To: David Laight <David.Laight@aculab.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, syzbot <syzkaller@googlegroups.com>, 
	Kyle Zeng <zengyhkyle@gmail.com>, Kees Cook <keescook@chromium.org>, 
	Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 4, 2023 at 10:41=E2=80=AFAM David Laight <David.Laight@aculab.c=
om> wrote:
>
> From: Eric Dumazet
> > Sent: 31 August 2023 19:38
> >
> > Blamed commit changed:
> >     ptr =3D kmalloc(size);
> >     if (ptr)
> >       size =3D ksize(ptr);
> >
> > to:
> >     size =3D kmalloc_size_roundup(size);
> >     ptr =3D kmalloc(size);
> >
> > This allowed various crash as reported by syzbot [1]
> > and Kyle Zeng.
> >
> > Problem is that if @size is bigger than 0x80000001,
> > kmalloc_size_roundup(size) returns 2^32.
> >
> > kmalloc_reserve() uses a 32bit variable (obj_size),
> > so 2^32 is truncated to 0.
>
> Can this happen on 32bit arch?
> In that case kmalloc_size_roundup() will return 0.

Maybe, but this would be a bug in kmalloc_size_roundup()

I personally can not test 32bit kernels.

