Return-Path: <netdev+bounces-16141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3557574B848
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 22:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D391C2108E
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 20:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09413171C7;
	Fri,  7 Jul 2023 20:46:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB967168C8
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 20:46:09 +0000 (UTC)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152D81FEB
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 13:46:08 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7659db6339eso117325685a.1
        for <netdev@vger.kernel.org>; Fri, 07 Jul 2023 13:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688762767; x=1691354767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0aYVMvYe1G1Ct9F0r9UZVqRVY35bvxFcxuMPw9DOHvw=;
        b=lkuqLxF14A/w/d+fV/ttf+K3Ub3mN4dsNqaNLTsP+ZDcGTajiX2EvRqyzkSjnpw90h
         2/kSM88bqsMjXMcVJVwmaRQGqOm4/nSCxcUal0Du0s8hegtUlJy/KdIPSt3tU5D0lEw0
         WN36Zgo/31PlXBRBCDW4zoA6ZdCUY76aH/bC14sD01W8wnDCdG9bYPTUABJxt5CYePd+
         lDwNBBGzo8oQPeOZ7xteUlOayvMdyzlP9mBMsp2tPYiyDWDygUa0ybaVaKei63uKBEih
         5lPTF8ShwuPVLnHlcCIXQLPBhagZJxmmubKJEEIZbSH7Snzkbfqr4uNsd1A2DxzC8zKa
         yTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688762767; x=1691354767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0aYVMvYe1G1Ct9F0r9UZVqRVY35bvxFcxuMPw9DOHvw=;
        b=X+ZRx4oOjmf+6BUOhPvzexRjEEhCqIo/pmZNLqW11jZHCq44Nqk09QsFQdp0xItaig
         /i3+Iu3pHbvStSD3pudYcMCvwtRhhXNtl1RiKlkwUJCh8nlrLuKpYjloyF440pk9o8IY
         pS4aRK8ZnImBOc0+vfez6hEQMFCJBTSUtvwOhixetEE3Op7KIfwwYUAs90q4jjRl3Tpi
         obiw/KArC1zgrdUE4nRuptxx2ly1grhtrQHQ1rbhlf3hWxZFTfIsgHJolwDrNhRQxjPK
         5peHmcOsLFi/fBpD0+pNPyBRZ6jMKHRHX6cby8quDD5MZJTtNQh6qEIWjDfOw8k6FM7+
         dMDQ==
X-Gm-Message-State: ABy/qLapLYl8IjDj01J3NPQE7YxAjdn8pHfinwtLMWV/YuueVepjZt1Z
	OFFAocydVGRfoP5IvRg5mTYhWhG86ZyzOfYpkge4vQ==
X-Google-Smtp-Source: APBJJlHUf0rmBIyOI/T2pORO24BydSGObRtEeKTOwPbRW6TmxkjVJRfSahixaV1hd2/4VLJVPsq9WGAU0WIhQb6nXas=
X-Received: by 2002:a05:620a:2687:b0:765:449d:1397 with SMTP id
 c7-20020a05620a268700b00765449d1397mr10632093qkp.13.1688762767012; Fri, 07
 Jul 2023 13:46:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <253mt0il43o.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
 <20230620145338.1300897-1-dhowells@redhat.com> <20230620145338.1300897-11-dhowells@redhat.com>
 <58466.1688074499@warthog.procyon.org.uk> <20230629164318.44f45caf@kernel.org>
 <20230630161043.GA2902645@dev-arch.thelio-3990X> <20230630091442.172ec67f@kernel.org>
 <20230630192825.GA2745548@dev-arch.thelio-3990X>
In-Reply-To: <20230630192825.GA2745548@dev-arch.thelio-3990X>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 7 Jul 2023 13:45:55 -0700
Message-ID: <CAKwvOd=H3R0sZjFSNs4xyFdw5yGgxSWk2=v+dmR5TrZfjjXaWA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 10/18] nvme/host: Use sendmsg(MSG_SPLICE_PAGES)
 rather then sendpage
To: Nathan Chancellor <nathan@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, David Howells <dhowells@redhat.com>, 
	Aurelien Aptel <aaptel@nvidia.com>, netdev@vger.kernel.org, 
	Alexander Duyck <alexander.duyck@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>, 
	Willem de Bruijn <willemb@google.com>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, 
	Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 12:28=E2=80=AFPM Nathan Chancellor <nathan@kernel.o=
rg> wrote:
>
> On Fri, Jun 30, 2023 at 09:14:42AM -0700, Jakub Kicinski wrote:
> > On Fri, 30 Jun 2023 09:10:43 -0700 Nathan Chancellor wrote:
> > > > Let me CC llvm@ in case someone's there is willing to make
> > > > the compiler warn about this.
> > >
> > > Turns out clang already has a warning for this, -Wcomma:
> > >
> > >   drivers/nvme/host/tcp.c:1017:38: error: possible misuse of comma op=
erator here [-Werror,-Wcomma]
> > >    1017 |                         msg.msg_flags &=3D ~MSG_SPLICE_PAGE=
S,
> > >         |                                                           ^
> > >   drivers/nvme/host/tcp.c:1017:4: note: cast expression to void to si=
lence warning
> > >    1017 |                         msg.msg_flags &=3D ~MSG_SPLICE_PAGE=
S,
> > >         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >         |                         (void)(                           )
> > >   1 error generated.
> > >
> > > Let me do some wider build testing to see if it is viable to turn thi=
s
> > > on for the whole kernel because it seems worth it, at least in this
> > > case. There are a lot of cases where a warning won't be emitted (see =
the
> > > original upstream review for a list: https://reviews.llvm.org/D3976) =
but
> > > something is better than nothing, right? :)
>
> Well, that was a pipe dream :/ In ARCH=3Darm multi_v7_defconfig alone,
> there are 289 unique instances of the warning (although a good number
> have multiple instances per line, so it is not quite as bad as it seems,
> but still bad):
>
> $ rg -- -Wcomma arm-multi_v7_defconfig.log | sort | uniq -c | wc -l
> 289
>
> https://gist.github.com/nathanchance/907867e0a7adffc877fd39fd08853801

It's definitely interesting to take a look at some of these cases.
Some are pretty funny IMO.

>
> Probably not a good sign of the signal to noise ratio, I looked through
> a good handful and all the cases I saw were not interesting... Perhaps
> the warning could be tuned further to become useful for the kernel but
> in its current form, it is definitely a no-go :/
>
> > Ah, neat. Misleading indentation is another possible angle, I reckon,
> > but not sure if that's enabled/possible to enable for the entire kernel
>
> Yeah, I was surprised there was no warning for misleading indentation...
> it is a part of -Wall for both clang and GCC, so it is on for the
> kernel, it just appears not to trigger in this case.
>
> > either :( We test-build with W=3D1 in networking, FWIW, so W=3D1 would =
be
> > enough for us.
>
> Unfortunately, even in its current form, it is way too noisy for W=3D1, a=
s
> the qualifier for W=3D1 is "do not occur too often". Probably could be
> placed under W=3D2 but it still has the problem of wading through every
> instance and it is basically a no-op because nobody tests with W=3D2.
>
> Cheers,
> Nathan
>


--=20
Thanks,
~Nick Desaulniers

