Return-Path: <netdev+bounces-20436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CE075F8FC
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 15:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C864D1C20B85
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 13:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DAD8C1B;
	Mon, 24 Jul 2023 13:55:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA628C0F
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 13:55:40 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9491FCC
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 06:55:35 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so6544799e87.0
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 06:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1690206933; x=1690811733;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cLuBTJcHgRw5Dz5uIr7zOsQg7JkLL64F6mhAMmK/Urg=;
        b=gvHlyPxpUKDXveeruAvPPnL2uwW7r0Lm6j/W1meQaI6mI9bctOF+FA+qn05a9Sgtx6
         YLUJNCG7B6Bg6YnKGdq4BjFBF218V2BzeuKMNMBnLqM1NwslZsz/em1+PzKJfEko3N5D
         Ki+Xww/RrchuUj/d3YykuEcicj0QjNcfotE4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690206933; x=1690811733;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cLuBTJcHgRw5Dz5uIr7zOsQg7JkLL64F6mhAMmK/Urg=;
        b=Eh6nCpS7LAIb7GUVHgWGNWk0Sxf2/1XbcMEuk0q2P+4Z9G0hOz25TIJL6ZXueYaBgk
         q8PkG8Id7la65+/o0qLQUyj7uQ1pnck5ccp2A2PLW4YeQqhqHNVMZwLzcSnf7+55a4X1
         WJFtzzS2nwDnZqi7gM9r2wmOlvWEp+YP5p7Ntk2IaRVgOBiWzN4u2PXHXu7DEyOHr1o3
         lz+JZUv91zVBzTZ6sMrXZ3Ea9LEeCqrn0QFkBqmn2idpu3/y6prQOnYjyaZykRQR5MIH
         xpf9Kl5JTdtyhzw3ehMOo2nEQTjY1b+bM1Z5jsjLfagVhpp8c9na2db1gan1bpqGy6FR
         gAwg==
X-Gm-Message-State: ABy/qLYwSRjTjq0b5hhXVlLkTzkrFQvf6Tx4D7nJ82KD/T7J898nKdI+
	hKbbrCGu9YWQ9E8GI033CPy352BsFdPwCljcSye9GQ==
X-Google-Smtp-Source: APBJJlFFevIadl9sawEPFI9I5OR2dPQnGvYtXsyb59paj5UKaXjSUkFCIk1mA0a3cy0sEARUqP5jmS4qlpHJ1cAJBSw=
X-Received: by 2002:a05:6512:234c:b0:4fa:5255:4fa3 with SMTP id
 p12-20020a056512234c00b004fa52554fa3mr6246134lfu.5.1690206933287; Mon, 24 Jul
 2023 06:55:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230629155433.4170837-1-dhowells@redhat.com> <20230629155433.4170837-2-dhowells@redhat.com>
 <CAJfpegsJuvXJDcXpo9T19Gw0tDuvyOJdv44Y2bt04MEf1JLxGg@mail.gmail.com>
 <c634a18e-9f2b-4746-bd8f-aa1d41e6ddf7@mattwhitlock.name> <CAJfpegvq4M_Go7fHiWVBBkrK6h4ChLqQTd0+EOKbRWZDcVerWA@mail.gmail.com>
 <ZLg9HbhOVnLk1ogA@casper.infradead.org> <CAHk-=wiq95bWiWLyz96ombPfpy=PNrc2KKyzJ2d+WMrxi6=OVA@mail.gmail.com>
 <63041.1690191864@warthog.procyon.org.uk>
In-Reply-To: <63041.1690191864@warthog.procyon.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Jul 2023 15:55:21 +0200
Message-ID: <CAJfpegstr2CwC2ZL4-y_bAjS3hqF_vta5e4XQneJYmxz9rhVpA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] splice: Fix corruption of spliced data after
 splice() returns
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Matt Whitlock <kernel@mattwhitlock.name>, netdev@vger.kernel.org, 
	Dave Chinner <david@fromorbit.com>, Jens Axboe <axboe@kernel.dk>, linux-fsdevel@kvack.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 24 Jul 2023 at 11:44, David Howells <dhowells@redhat.com> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > > So what's the API that provides the semantics of _copying_?
> >
> > It's called "read()" and "write()".
>
> What about copy_file_range()?  That seems to fall back to splicing if not
> directly implemented by the filesystem.  It looks like the manpage for that
> needs updating too - or should that actually copy?

Both source and destination of copy_file_range() are regular files and
do_splice_direct() is basically equivalent to write(dest, mmap of
source), no refd buffers remain beyond the end of the syscall.  What
is it that should be updated in the manpage?

Thanks,
Miklos

