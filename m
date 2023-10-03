Return-Path: <netdev+bounces-37689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685D57B6A6A
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 15:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CE88E281654
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 13:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D91266B1;
	Tue,  3 Oct 2023 13:23:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180142137C
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 13:23:38 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3E5A1;
	Tue,  3 Oct 2023 06:23:36 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5a22eaafd72so11219977b3.3;
        Tue, 03 Oct 2023 06:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696339415; x=1696944215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RyqO5Si8x9tH0yrrGtUM2VgzCztD//mXgGUJcJBODIM=;
        b=a7vcZ9tiYUhbWGbLRzuEPbyxTT93C8FXysXVB4bAtaldp0D5/VtQR06OqRGMW40Twl
         oKV5tbTFweAs15zo/XospIWSqCZb7jA5tcLqotTkz4CXpl1uAQn8qQIt7f4ZuXIsy7pR
         PyZ0peXBHIctqpGNzjAZ9hgLA7BT/3FgR8Hee3/jOeIajNYEXODjMGfVkpcIenrLXUXj
         qKdiOwOM3HMeAl78kJrponz48R4dn9nUknOoqvSKyZoeqSfZK3QCvyxzwRcrLxqNo2hb
         WiO1wDKbhsBaMMLP1tiWJV8FjJQXpzPaaC4btiWb111RUTf3ftFfSVuHYi1IAWVkDJ6L
         rpGg==
X-Gm-Message-State: AOJu0YyP2hgQNRdagr89U6xVBubNOMbc2TxL8h+l1vly+geGMdCntv1f
	aUVZtd6dijEw0uaEVKuoGF4DnbIeg1HhPA==
X-Google-Smtp-Source: AGHT+IFU8dFMsoL99k55rFKjS/yIgR33TCJviv7HWMdQfJry+Qoxbwlp3gGKuVh8MnaTpRTsccW0aA==
X-Received: by 2002:a81:6c88:0:b0:5a1:c610:1154 with SMTP id h130-20020a816c88000000b005a1c6101154mr14046953ywc.10.1696339415219;
        Tue, 03 Oct 2023 06:23:35 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id j13-20020a81920d000000b0059f61be458esm367746ywg.82.2023.10.03.06.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 06:23:35 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5a200028437so11327487b3.1;
        Tue, 03 Oct 2023 06:23:35 -0700 (PDT)
X-Received: by 2002:a81:a0d2:0:b0:57a:9b2c:51f1 with SMTP id
 x201-20020a81a0d2000000b0057a9b2c51f1mr14931488ywg.1.1696339414847; Tue, 03
 Oct 2023 06:23:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231003142737.381e7dcb@canb.auug.org.au> <20230920092641.832134-12-konstantin.meskhidze@huawei.com>
 <20231003.ahPha5bengee@digikod.net>
In-Reply-To: <20231003.ahPha5bengee@digikod.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 3 Oct 2023 15:23:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVZsA4H47od6FV9+OzgWB2hnTQGr8YOcAL3yyURdm1AoA@mail.gmail.com>
Message-ID: <CAMuHMdVZsA4H47od6FV9+OzgWB2hnTQGr8YOcAL3yyURdm1AoA@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the landlock tree
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, willemdebruijn.kernel@gmail.com, 
	gnoack3000@gmail.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	yusongping@huawei.com, artem.kuzin@huawei.com, Arnd Bergmann <arnd@arndb.de>, 
	Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Micka=C3=ABl,

On Tue, Oct 3, 2023 at 3:15=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
> On Tue, Oct 03, 2023 at 02:27:37PM +1100, Stephen Rothwell wrote:
> > After merging the landlock tree, today's linux-next build (powerpc
> > allyesconfig) produced this warning:
> >
> > samples/landlock/sandboxer.c: In function 'populate_ruleset_net':
> > samples/landlock/sandboxer.c:170:78: warning: format '%llu' expects arg=
ument of type 'long long unsigned int', but argument 3 has type '__u64' {ak=
a 'long unsigned int'} [-Wformat=3D]
> >   170 |                                 "Failed to update the ruleset w=
ith port \"%llu\": %s\n",
> >       |                                                                =
           ~~~^
> >       |                                                                =
              |
> >       |                                                                =
              long long unsigned int
> >       |                                                                =
           %lu
> >   171 |                                 net_port.port, strerror(errno))=
;
> >       |                                 ~~~~~~~~~~~~~
> >       |                                         |
> >       |                                         __u64 {aka long unsigne=
d int}
> >
> > Introduced by commit
> >
> >   24889e7a2079 ("samples/landlock: Add network demo")
>
> PowerPC-64 follows the LP64 data model and then uses int-l64.h (instead o=
f
> int-ll64.h like most architectures) for user space code.
>
> Here is the same code with the (suggested) "%lu" token on x86_86:
>
>   samples/landlock/sandboxer.c: In function =E2=80=98populate_ruleset_net=
=E2=80=99:
>   samples/landlock/sandboxer.c:170:77: error: format =E2=80=98%lu=E2=80=
=99 expects argument of type =E2=80=98long unsigned int=E2=80=99, but argum=
ent 3 has type =E2=80=98__u64=E2=80=99 {aka =E2=80=98long long unsigned int=
=E2=80=99} [-Werror=3Dformat=3D]
>     170 |                                 "Failed to update the ruleset w=
ith port \"%lu\": %s\n",
>         |                                                                =
           ~~^
>         |                                                                =
             |
>         |                                                                =
             long unsigned int
>         |                                                                =
           %llu
>     171 |                                 net_port.port, strerror(errno))=
;
>         |                                 ~~~~~~~~~~~~~
>         |                                         |
>         |                                         __u64 {aka long long un=
signed int}
>
>
> We would then need to cast __u64 to unsigned long long to avoid this warn=
ing,
> which may look useless, of even buggy, for people taking a look at this s=
ample.

In userspace code, you are supposed to #include <inttypes.h>
and use PRIu64.

> Anyway, it makes more sense to cast it to __u16 because it is the
> expected type for a TCP port. I'm updating the patch with that.
> Konstantin, please take this fix for the next series:
> https://git.kernel.org/mic/c/fc9de206a61a

Until someone passes a too large number, and it becomes truncated...

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

