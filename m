Return-Path: <netdev+bounces-14761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A4A743B0F
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 13:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D87A2280FCC
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 11:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7C813ACD;
	Fri, 30 Jun 2023 11:43:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC37B101F8
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 11:43:40 +0000 (UTC)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405F8EE
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 04:43:39 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-78362f57500so75058939f.3
        for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 04:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688125418; x=1690717418;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NY+pHNYX++uPw0GdIA88Fg8qrzeAw3i64xZ2DUGb+XU=;
        b=mALpn/INM320JwgmXJ3mgi71Kga4fYNP3E4PyKcnacXgjqCZRO9ehSeO2U/6xeTMK/
         Zg1jidL3NDiwkrdriXpnVrieaXHFWnt2fp6OCr+5G7c0kFpeigOrXUC/y+3Vxg0IIL94
         mlvZHvcCe7kqOnT3WC9QngqI5aa+STAHICCNpBdjZL3jm5dXGQA2LP8Ms0cs6hCRdW1l
         fqeIRILF8eW1Qk6bF5dYSMiuG2nAqS/2jx3aFuCI2gAjbiXbJGPXisWOST/5rqyB6e15
         h3p6y4GGIaY+hYicx5CPBoWvzFPzM2PTnQebRGyfZhG6KJZ/IyinQEmt+68MVZcuyg9D
         8TZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688125418; x=1690717418;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NY+pHNYX++uPw0GdIA88Fg8qrzeAw3i64xZ2DUGb+XU=;
        b=MC1O1izxr+wD1fLjccM1yrItllU5Glv9PpoFIfVN5Fd9YNbsYwcZZO1fKw7COf51YX
         l9oqAa7YI/Uso1lHp9I7v48OxfHFgY0s5WdGLkYGJh6nVHdbnga5gNIL7TOYY4hPnjLk
         xgYPiE+5iYx7DvfdV4WxGyxJX1eJEu4cY9eBDSNKNO2DNk3z9ArOCWDwwXR3t9fGE4v2
         4eJggSw5fOI4OSwuzsHqTCD5eKNi30wI8PV0jH0ix+3Ki0SfIGCDn9ow0nEUw62yxbAs
         ZXONIIYsCb+TvrVGRmfw29DBGdxbARaDRsLKx5tLefNaKhgxFJJIqUN1Ofe3sLmx6E27
         JQOw==
X-Gm-Message-State: AC+VfDxWGliZKS8/OkTedXikb6SNoPGagn/FRiB2PX7/Gr8Vowjq3ZO3
	mvKG54rp4WW4MnU3W2mGMxtJ9cOJt2UBSjY+0Nngsw==
X-Google-Smtp-Source: ACHHUZ7S5AQ4Drl3wvgUZEsizLAitrLmIDVn8VCrMpfr0mmLA3IalJKmWl+w1jOIERtY09bBZvP50K083lArebc8PQs=
X-Received: by 2002:a5d:8183:0:b0:776:fd07:3c96 with SMTP id
 u3-20020a5d8183000000b00776fd073c96mr2933630ion.7.1688125418565; Fri, 30 Jun
 2023 04:43:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000008a7ae505aef61db1@google.com> <20200911170150.GA889@sol.localdomain>
 <c16e9ab9-13e0-b911-e33a-c9ae81e93a8d@I-love.SAKURA.ne.jp>
 <CAMj1kXFqYozjJ+qPeSApESb0Cb6CUaGXBrs5LP81ERRvb3+TAw@mail.gmail.com>
 <59e1d5c0-aedb-7b5b-f37f-0c20185d7e9b@I-love.SAKURA.ne.jp>
 <CAMj1kXGHRUUFYL09Lm-mO6MfGc19rC=-7mSJ1eDTcbw7QuEkaw@mail.gmail.com>
 <CAG_fn=X+eU=-WLXASidBCHWS3L7RvtN=mx3Bj8GD9GcA=Htf2w@mail.gmail.com>
 <CAMj1kXFrsc7bsjo2i0=9AqVNSCvXEnYAukzoXeaYEH9EpNviBA@mail.gmail.com>
 <f5c2d592-4b97-93f8-b62e-402eeeaa70d9@I-love.SAKURA.ne.jp> <CAMj1kXH6STkFX-SocCiqRgFwkQFZEG=DW6hu6H9W7Egxm2icrw@mail.gmail.com>
In-Reply-To: <CAMj1kXH6STkFX-SocCiqRgFwkQFZEG=DW6hu6H9W7Egxm2icrw@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 30 Jun 2023 13:43:02 +0200
Message-ID: <CAG_fn=X2kbdxAC0EAPQnpQU12Vqz0DjAt2Y=HsEmWuTsPbJojw@mail.gmail.com>
Subject: Re: [PATCH] net: tls: enable __GFP_ZERO upon tls_init()
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+828dfc12440b4f6f305d@syzkaller.appspotmail.com>, 
	Eric Biggers <ebiggers@kernel.org>, Aviad Yehezkel <aviadye@nvidia.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > >>>
> > >>> Could you please share your kernel config and the resulting kernel log
> > >>> when running the reproducer? I'll try to reproduce locally as well,
> > >>> and see if I can figure out what is going on in the crypto layer
> > >>
> > >> The config together with the repro is available at
> > >> https://syzkaller.appspot.com/bug?extid=828dfc12440b4f6f305d, see the
> > >> latest row of the "Crashes" table that contains a C repro.
> >
> > Kernel is commit e6bc8833d80f of https://github.com/google/kmsan/commits/master .
>
> That commit does not exist in that repo. Does it matter?

Apologies for this mess.
https://github.com/google/kmsan/commits/master is force-updated once a
week to point to the latest release candidate with KMSAN-specific
patches.
Older releases are called e.g. kmsan-v6.4-rc7.
Right now there's only one patch required to run torvalds/master with
KMSAN (https://github.com/google/kmsan/commit/e6bc8833d80f).
That patch will hit upstream in v6.5-rc1, after which I am going to
switch syzbot to test upstream.

For such a long-standing bug the exact version of KMSAN shouldn't matter.

