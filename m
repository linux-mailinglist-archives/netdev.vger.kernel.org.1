Return-Path: <netdev+bounces-19195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2881F759ECE
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E79D281A63
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 19:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC791BB46;
	Wed, 19 Jul 2023 19:36:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F010C138
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 19:36:46 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A23C1FD8
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 12:36:20 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso14442351fa.1
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 12:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1689795345; x=1692387345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtl6gXXMYsoBnIpPYfSTqQ6nm1s8Hn5GW+fEct1ALRE=;
        b=Zhw4JJ4K/38BOlZM21pHWDopKnx38TCDNfnXcKZHpT7uRqEqXE9WONINOAv9x6yiUj
         z+XUsIZz2aKcBKEiQPUdSZ4hejspiaLEcEvoQjmfzw/3G5HXTxgK4A9mvFZ//TIcP2A6
         YyRF2CDGgYyMaztEqeHFfJfxRmV3g4oGKIn6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689795345; x=1692387345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtl6gXXMYsoBnIpPYfSTqQ6nm1s8Hn5GW+fEct1ALRE=;
        b=QcPSwCtgu7sTOf4Q9e8IueE6izo8vY71iq8o6AAMEw97G+hBzvN/cl0GBIb4OF5otj
         EiDbA3qjnU421KuGnIIHmVxUKkd+3czy5Dr5V3fj0z734HDgHC5NE6K8VcZHcjA54RzD
         li6qarOoytMD8ifXZYXdIYuFjz5pfXIv2iFezI0lNNaDz3denJF/QAmGYCFHKkNbnB4J
         eNbIgTVovsAXEZs8oN+hKKQAp/dZ4IP93zFfVowymd3lS3pgRS73tTuRmHtMZpv9e3C1
         HqkM6Q6KtYwaQSmqHqtSwW0JatefgZkyR3LotQgLc3PnmRGbipIMKw1u46gS692pMIKH
         SWYg==
X-Gm-Message-State: ABy/qLZfJJFaBKEghPTCueS+aQ3ubLgl3eYU8XWOdVGx4JKoDO+wKfsa
	TVK2XxXZE7OQl9f1vo+8rqGzAFOZcNXlZob1qFiYGg==
X-Google-Smtp-Source: APBJJlF263loCbf4G/vbjQ8OkGORJrA6h2pTRLBd08SnNbJHsNdGQLjuleOM0+lhq7ys4UZ/gSu7iS5raBbyA9YXqQA=
X-Received: by 2002:a2e:9584:0:b0:2b6:e2c1:980f with SMTP id
 w4-20020a2e9584000000b002b6e2c1980fmr643994ljh.36.1689795345357; Wed, 19 Jul
 2023 12:35:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230629155433.4170837-1-dhowells@redhat.com> <20230629155433.4170837-2-dhowells@redhat.com>
 <CAJfpegsJuvXJDcXpo9T19Gw0tDuvyOJdv44Y2bt04MEf1JLxGg@mail.gmail.com> <c634a18e-9f2b-4746-bd8f-aa1d41e6ddf7@mattwhitlock.name>
In-Reply-To: <c634a18e-9f2b-4746-bd8f-aa1d41e6ddf7@mattwhitlock.name>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 19 Jul 2023 21:35:33 +0200
Message-ID: <CAJfpegvq4M_Go7fHiWVBBkrK6h4ChLqQTd0+EOKbRWZDcVerWA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] splice: Fix corruption of spliced data after
 splice() returns
To: Matt Whitlock <kernel@mattwhitlock.name>
Cc: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Dave Chinner <david@fromorbit.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, linux-fsdevel@kvack.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 19 Jul 2023 at 19:59, Matt Whitlock <kernel@mattwhitlock.name> wrot=
e:
>
> On Wednesday, 19 July 2023 06:17:51 EDT, Miklos Szeredi wrote:
> > On Thu, 29 Jun 2023 at 17:56, David Howells <dhowells@redhat.com> wrote=
:
> >>
> >> Splicing data from, say, a file into a pipe currently leaves the sourc=
e
> >> pages in the pipe after splice() returns - but this means that those p=
ages
> >> can be subsequently modified by shared-writable mmap(), write(),
> >> fallocate(), etc. before they're consumed.
> >
> > What is this trying to fix?   The above behavior is well known, so
> > it's not likely to be a problem.
>
> Respectfully, it's not well-known, as it's not documented. If the splice(=
2)
> man page had mentioned that pages can be mutated after they're already
> ostensibly at rest in the output pipe buffer, then my nightly backups
> wouldn't have been incurring corruption silently for many months.

splice(2):

       Though we talk of copying, actual copies are generally avoided.
The kernel does this by implementing a pipe buffer as a set  of
refer=E2=80=90
       ence-counted  pointers  to  pages  of kernel memory.  The
kernel creates "copies" of pages in a buffer by creating new pointers
(for the
       output buffer) referring to the pages, and increasing the
reference counts for the pages: only pointers are copied, not the
pages of the
       buffer.

While not explicitly stating that the contents of the pages can change
after being spliced, this can easily be inferred from the above
semantics.

Thanks,
Miklos

