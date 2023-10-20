Return-Path: <netdev+bounces-43075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 184B17D14D3
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 19:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10DA31C20AF4
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 17:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7952C20306;
	Fri, 20 Oct 2023 17:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="BV2Znb0v"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207C720302
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 17:25:40 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF002D6A
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 10:25:38 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53e08e439c7so1657690a12.0
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 10:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1697822737; x=1698427537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFL5iFVqH1m9kZwhGzflcon42CaVngVznmVmEIhmRWY=;
        b=BV2Znb0vBe22LbXjsB4Q3jfGBBM0t2vQrlyrdPMayg+G2oTwpcWOEzYE/k0Ffoz3Ve
         wUJt8mTwgB7qMBEfmbKP3cqo5X91+k+q/MZ//wWoymNVATe0u6MpOtpzimijGSPzngIW
         HtAUKLAfW+LBQ/w0FGVBxq4XsfKiGchu3lb5DsF9gW2fl0bK6PH0W+4LadLdXu+x7Tki
         ETBInNHvVrwD042lRYFvBWw9p5AqAzPfIbcBWLcSumnJgl3Ap+JUQFx8dpf8gFdm2cr7
         w0P9Lr7+wLQeDQuetED0tpWl6X9FVKQUhDw7A98jFDs2ZiqkVYcaeOCZAO9KUo6FtDxB
         GZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697822737; x=1698427537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFL5iFVqH1m9kZwhGzflcon42CaVngVznmVmEIhmRWY=;
        b=Qqh969tNpSA5Y4n5Z5L4LxMmaH9j08hR2VJF3Xin5rWviKKfFQllduzB4fblCLXnGs
         NMHnFkJA9LV3Ei4AsOkB+/hjavf/zgEY03s5wLFe5A28fNRbVTyzT5N1uwEibWgJuhhe
         xu3kyS1WSXGqXvYAS/nPzIBVtRMuhxYKgK0iElX7WkCCYjqyB6h4peDs0/DBY8/YdYXf
         8pi812pEbudE46UgYXhRwbCIwedRblF6pypmb/fvLdovZ0UPLa0yaQJL/xJopvDnUbDP
         CxXI5YyDxmS2OrrSilVdA4vOSXJIqhr85YIg8fMp4sfm4opK32IUk/eaPaTnvCkgMDHC
         Dg7g==
X-Gm-Message-State: AOJu0Yy5mtyzVjpPmmcyHcXJ2WNQ5XXWv3N4jNfnam68V/EHSEylh9BD
	ZygGUsc5oELjA2MSrRSbh10nyg9ZYOm2PDmHwB2g6Q==
X-Google-Smtp-Source: AGHT+IEAJxJYH65UAOp0CGVbMLP+IaF4gPQ3JhAlGuol2lCyWHsYGBw+wUyT3+khfALaMw3q5iEsltZ+ywYBL7uUP44=
X-Received: by 2002:a05:6402:50d2:b0:53d:f09a:4eef with SMTP id
 h18-20020a05640250d200b0053df09a4eefmr1994810edb.41.1697822736950; Fri, 20
 Oct 2023 10:25:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABWYdi1kiu1g1mAq6DpQWczg78tMzaVFnytNMemZATFHqYSqYw@mail.gmail.com>
 <20231020104728.2060-1-hdanton@sina.com>
In-Reply-To: <20231020104728.2060-1-hdanton@sina.com>
From: Ivan Babrou <ivan@cloudflare.com>
Date: Fri, 20 Oct 2023 10:25:25 -0700
Message-ID: <CABWYdi0N7uvDex5CdKD60hNQ6UFuqoB=Ss52yQu6UoMJm0MFPw@mail.gmail.com>
Subject: Re: wait_for_unix_gc can cause CPU overload for well behaved programs
To: Hillf Danton <hdanton@sina.com>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 3:47=E2=80=AFAM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Thu, 19 Oct 2023 15:35:01 -0700 Ivan Babrou <ivan@cloudflare.com>
> > Hello,
> >
> > We have observed this issue twice (2019 and 2023): a well behaved
> > service that doesn't pass any file descriptors around starts to spend
> > a ton of CPU time in wait_for_unix_gc.
>
> See if the diff below works for you, which prevents concurrent spinning
> of unix_gc_lock, a variant of spin_trylock().
>
> Hillf
> --- x/net/unix/garbage.c
> +++ y/net/unix/garbage.c
> @@ -211,15 +211,10 @@ void unix_gc(void)
>         struct list_head cursor;
>         LIST_HEAD(not_cycle_list);
>
> +       if (test_and_set_bit(0, &gc_in_progress))
> +               return;
>         spin_lock(&unix_gc_lock);
>
> -       /* Avoid a recursive GC. */
> -       if (gc_in_progress)
> -               goto out;
> -
> -       /* Paired with READ_ONCE() in wait_for_unix_gc(). */
> -       WRITE_ONCE(gc_in_progress, true);
> -
>         /* First, select candidates for garbage collection.  Only
>          * in-flight sockets are considered, and from those only ones
>          * which don't have any external reference.
> --

This could solve wait_for_unix_gc spinning, but it wouldn't affect
unix_gc itself, from what I understand. There would always be one
socket writer or destroyer punished by running the gc still. My linked
repro code exercises that path rather than the waiting spinlock
(there's a single writer thread), so it's something you can see for
yourself.

Your patch doesn't build, so I wasn't able to try it out:

#26 154.3 /build/linux-source/net/unix/garbage.c: In function 'unix_gc':
#26 154.3 /build/linux-source/net/unix/garbage.c:214:33: error:
passing argument 2 of 'test_and_set_bit' from incompatible pointer
type [-Werror=3Dincompatible-pointer-types]
#26 154.3   214 |         if (test_and_set_bit(0, &gc_in_progress))
#26 154.3       |                                 ^~~~~~~~~~~~~~~
#26 154.3       |                                 |
#26 154.3       |                                 bool * {aka _Bool *}
#26 154.3 In file included from
/build/linux-source/include/asm-generic/bitops/atomic.h:68,
#26 154.3                  from
/build/linux-source/arch/arm64/include/asm/bitops.h:25,
#26 154.3                  from /build/linux-source/include/linux/bitops.h:=
68,
#26 154.3                  from /build/linux-source/include/linux/kernel.h:=
22,
#26 154.3                  from /build/linux-source/net/unix/garbage.c:66:
#26 154.3 /build/linux-source/include/asm-generic/bitops/instrumented-atomi=
c.h:68:79:
note: expected 'volatile long unsigned int *' but argument is of type
'bool *' {aka '_Bool *'}
#26 154.3    68 | static __always_inline bool test_and_set_bit(long
nr, volatile unsigned long *addr)
#26 154.3       |
 ~~~~~~~~~~~~~~~~~~~~~~~~^~~~
#26 154.3 /build/linux-source/net/unix/garbage.c:328:2: error: label
'out' defined but not used [-Werror=3Dunused-label]
#26 154.3   328 |  out:
#26 154.3       |  ^~~
#26 154.3 cc1: all warnings being treated as errors

