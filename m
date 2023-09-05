Return-Path: <netdev+bounces-32078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D2279229E
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 14:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C6F280AA5
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 12:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58276D306;
	Tue,  5 Sep 2023 12:27:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B546D2E4
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 12:27:21 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123C31A8
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 05:27:21 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-40a47e8e38dso615741cf.1
        for <netdev@vger.kernel.org>; Tue, 05 Sep 2023 05:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693916840; x=1694521640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvOOtg1G7bSPS6GjvqhYxHE+6xw0xkfodGtgL+BzDoI=;
        b=oe9JtDlaUyVB4tzqv0ZEKiH2lPpD0GdB9klirrC6JpSikFrSHF36gM8+XkhfwVA6y4
         VEdyXDoPKvZEyziA3V0XLWju9Jyf7MDBk7rTv99PkPTmsDryC9gzVuC5QQEttPdVxhW/
         rKIMLryAK7L8nUag7WdZHU0n9eGAXRV5rBh6Bywz/bzcYXdlMtCZ+Ut9eIVmxp4CyprF
         ZDdu2XbjoGWeJ6vRb3mwNdW12L4Frwpodjorckb6JtYwVPHsgLOD/m4FQi8WlfOhLerT
         IBZ19kQhCHjejTVqZkBTfXtoMHr9EPxEBLrFuU923vvgaK568CHUV0kWLe+7Tym5NevV
         PTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693916840; x=1694521640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EvOOtg1G7bSPS6GjvqhYxHE+6xw0xkfodGtgL+BzDoI=;
        b=dNhKh0kYy4peZ933fqCU+3ufhBJ9lBr/3g2zqsMBRRh4+O3cZuRIRwpTQVrwwDVLE5
         Cu3e3bC3w1c6AC4PzulN7DbzuO9gqXVb9sJLHrn8DKSLPfclJlQKESqLXroK/rq2YBl9
         32OOFL3FPdUbYEwzvi8A0FmAixKaARo8PzM9T5P1TceVmTaG6sE5PWvDhd91COyHW0Hl
         9VivovzuMHC50YgtIsIxU82M3KgKfFLW+XzXye0xinHiV4PU4UE06JkheYgFM9lE4UWi
         TzbMY6XWk3DPQ+Y7QK749K1+uMPNOiqOLJp48jgFG16s5bQpg8vsfmpjq4ibsu8YY3gs
         kIPA==
X-Gm-Message-State: AOJu0YzjpwkrroI8MmM5aWLyD8Uw4/w531d9khlI6G7rlfME8ksIMb3A
	hTeHhq8NbToB0OQX9XjYfBOYHOVFCyXR/mZMpvDqUw==
X-Google-Smtp-Source: AGHT+IHB8C2y3rZrgd+6FEjEiSCydCRSu1ogLDyZ2dvL6kKd1Gnu6Zwnr/k81+VC2+XTpLPsh7sbItbyyZ3WX1I6Pes=
X-Received: by 2002:a05:622a:1011:b0:410:4c49:1aeb with SMTP id
 d17-20020a05622a101100b004104c491aebmr403717qte.7.1693916839926; Tue, 05 Sep
 2023 05:27:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230831183750.2952307-1-edumazet@google.com> <d273628df80f45428e739274ab9ecb72@AcuMS.aculab.com>
 <CANn89iJY4=Q0edL-mf2JrRiz8Ld7bQcogOrc4ozLEVD8qz8o2A@mail.gmail.com>
 <837a03d12d8345bfa7e9874c1e7d9156@AcuMS.aculab.com> <ZPZtBWm06f321Tp/@westworld>
 <CANn89iJDsm-xE4K2_BWngOQeuhOFmOhwVfk5=sszf0E+3UcH=g@mail.gmail.com> <0669d0d3fefb44aaa3f8021872751693@AcuMS.aculab.com>
In-Reply-To: <0669d0d3fefb44aaa3f8021872751693@AcuMS.aculab.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 Sep 2023 14:27:08 +0200
Message-ID: <CANn89iJtwNuLA2=dY-ZgLVtUrjt-K3K2gNv9XSt5Hyd2tV6+eQ@mail.gmail.com>
Subject: Re: [PATCH net] net: deal with integer overflows in kmalloc_reserve()
To: David Laight <David.Laight@aculab.com>
Cc: Kyle Zeng <zengyhkyle@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, 
	syzbot <syzkaller@googlegroups.com>, Kees Cook <keescook@chromium.org>, 
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

On Tue, Sep 5, 2023 at 10:36=E2=80=AFAM David Laight <David.Laight@aculab.c=
om> wrote:
>
> From: Eric Dumazet
> > Sent: 05 September 2023 04:42
> ...
> > Again, I do not want this patch, I want to fix the root cause(s).
> >
> > It makes no sense to allow dev->mtu to be as big as 0x7fffffff and
> > ultimately allow size to be bigger than 0x80000000
>
> kmem_alloc_reserve() also needs fixing.

Yes, this is what I said. Please provide a patch ?

I stopped caring about 32bit 10 years ago.

> It's purpose is to find the size that kmem_alloc() will
> allocated so that the full size can be allocated rather
> than later finding out the allocated size.
> The latter has issues with the compiler (etc) tracking
> the sizes of allocates.
>
> So it must never return a smaller size.
> Whether the path that returns 0 can happen or not
> the correct error return is the original size.
> The later kmalloc() will then probably fail and
> be checked for.
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)

