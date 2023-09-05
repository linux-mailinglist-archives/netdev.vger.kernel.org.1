Return-Path: <netdev+bounces-32081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 793717922B2
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 14:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AA2A1C203A8
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 12:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C40A94A;
	Tue,  5 Sep 2023 12:34:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582952FAE
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 12:34:25 +0000 (UTC)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEBC1A8
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 05:34:23 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-414c54b2551so429901cf.1
        for <netdev@vger.kernel.org>; Tue, 05 Sep 2023 05:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693917263; x=1694522063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8BzvQbB4tFjUYASLDgFKcDVTYztgZfiqPU/fmG9/sI=;
        b=mwJ+CHBxKPwbSJu5/oMd4cdjcH0ifdEA+cmjThOp6mrdSrA+7eM1gUOkKotYb1J3f7
         A8B1LLfIQ+M2/dC79KVajUSimqppN+WeijNiHN2/tDCxmEwWwPV2PfJWCdYJVq6Gx78L
         ODXMNOZJk8xyR1tDlQJNX8eV+vbmCMAVxhMqA8xdK6jj8FSmuZJJB/woXVhOCbeRzEaP
         NrhAllJsQWQipTRIx6MaaBqoYxt3SxHHNmik7jrx1IcEFhz/pO1uFjHP53lwP/0UWEvE
         SDJeum12NwIA5kdcux369mVH+IOfZ7VjpmOOpJ7Jjfa5r1T+z/JxUwnvanwDisW3lfmu
         nm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693917263; x=1694522063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8BzvQbB4tFjUYASLDgFKcDVTYztgZfiqPU/fmG9/sI=;
        b=b4IOkXCntUy6oYbrLc3BFISvVt38mMMGz7fLtPM1sRWiaY99SWmowZ14ryS/x9uSBY
         7DmwkMTwHszRZSq/1rqmjLOJZppKm++q1mdnsqWaHIZUdHXUWl0wcz3/kYWJqrBTfh/E
         uA+ULy3F4on8/87dQ25peQRzNQjWpox9Map+lG4q3PMrIqxKZJ3Ps9kG64AVz506rei+
         nSMVPpkJH/EUgTtcSqZnNCdBtMGUm9oat9ffEozcGnV3gUfIW3zeEhgrrQg8s7s/XgF7
         xLOFwQALcAQy8zN0/x3atF8bxFL2Xjsrvg1skNyUljDEkQe0ADvQlfZcuwLAyDV62yz3
         8qKA==
X-Gm-Message-State: AOJu0YzGT9IPL+KwBZjk75/yu+pkCaanhVmFgRU9fX8r36EHtBbvopZn
	wgnOqA4OI3BGivx2fQ3DhoOgwTDChk2x311e17TKBg==
X-Google-Smtp-Source: AGHT+IHOG0XWsTKcJ6r3ybjm+tKuzjktHYYqJIhqxBoDCL24O46IHlDgwAcuSRZN/0OA8GYi7H3AltGHK0q0UV0XNCw=
X-Received: by 2002:ac8:5993:0:b0:410:653f:90ea with SMTP id
 e19-20020ac85993000000b00410653f90eamr552896qte.1.1693917262647; Tue, 05 Sep
 2023 05:34:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230831183750.2952307-1-edumazet@google.com> <d273628df80f45428e739274ab9ecb72@AcuMS.aculab.com>
 <CANn89iJY4=Q0edL-mf2JrRiz8Ld7bQcogOrc4ozLEVD8qz8o2A@mail.gmail.com>
 <837a03d12d8345bfa7e9874c1e7d9156@AcuMS.aculab.com> <ZPZtBWm06f321Tp/@westworld>
 <CANn89iJDsm-xE4K2_BWngOQeuhOFmOhwVfk5=sszf0E+3UcH=g@mail.gmail.com>
 <0669d0d3fefb44aaa3f8021872751693@AcuMS.aculab.com> <CANn89iJtwNuLA2=dY-ZgLVtUrjt-K3K2gNv9XSt5Hyd2tV6+eQ@mail.gmail.com>
In-Reply-To: <CANn89iJtwNuLA2=dY-ZgLVtUrjt-K3K2gNv9XSt5Hyd2tV6+eQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 Sep 2023 14:34:11 +0200
Message-ID: <CANn89iKL9-3RTBhtyg5gxOLfXZVyJoCK0A_K9ui5Ew-KdNtFhw@mail.gmail.com>
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
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 5, 2023 at 2:27=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Tue, Sep 5, 2023 at 10:36=E2=80=AFAM David Laight <David.Laight@aculab=
.com> wrote:
> >
> > From: Eric Dumazet
> > > Sent: 05 September 2023 04:42
> > ...
> > > Again, I do not want this patch, I want to fix the root cause(s).
> > >
> > > It makes no sense to allow dev->mtu to be as big as 0x7fffffff and
> > > ultimately allow size to be bigger than 0x80000000
> >
> > kmem_alloc_reserve() also needs fixing.
>
> Yes, this is what I said. Please provide a patch ?

Oops, I thought you were speaking about kmalloc_size_roundup()

kmalloc_reserve() is fine, all overflows must be taken care of before
reaching it.

