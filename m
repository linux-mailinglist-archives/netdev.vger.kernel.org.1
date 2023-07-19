Return-Path: <netdev+bounces-18944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC99759295
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 12:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B752816D0
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 10:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3957125DE;
	Wed, 19 Jul 2023 10:18:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F8911CB4
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 10:18:08 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B95D1FC0
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 03:18:04 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-992f6d7c7fbso937849866b.3
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 03:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1689761883; x=1692353883;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3NsOzwLbyHagOj0RUJh6oS60oUKmYlB8RPkDGxAGY18=;
        b=O2pnEuPln44glMdeg60thEUz2OpSqZ/q0d5NCNBMcNGZ3PPVNAri3R+01Ku599baiT
         iW+V/lvASTxjNqKmCemBNSYN1Dhb+8BVv36AOBGTTn+bUHhTq8tfW0SW4HfF55T1cxR9
         hVVjk7uLRDQdZ14Tg9GhicKs6HPVRmQjK3hE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689761883; x=1692353883;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NsOzwLbyHagOj0RUJh6oS60oUKmYlB8RPkDGxAGY18=;
        b=B1q6zLBD0l4Masm80H/U5F/10dXv72fST9kgztDRzhlAjZUYbKdpcCErEaXcjb6sod
         tscz2gg9tRloTb/ecM8DzlxW+3Nsaq8EshjXZO9kHPTqiWGX8IcMsxBrf7eqH+2jLJt/
         ksRNmwtyIvHn16rpJi8yGk2BzKw8jssvTYA1Py7ePLpAOqjZJITV0bY7daxwyW+UIfLB
         n6xGZZk5xMyeYa6Ev1pti1VsW0xQNE62sxMVe3+MpR8V57evLqCLFuKhMuuxRJ8shNmz
         bT2nvaSOGFN7NeJurZzgU2TxWy8qmOZebgC8KsG6yOR6CKiIel1L2l5yU9t3Lw0XDGny
         0A/A==
X-Gm-Message-State: ABy/qLYIfO+Mo/Nvfz7mxFtD6kq8XYGiVwB3SRoFuI+zXPzI7R2pGcQD
	CPYpU1SA9pIS1q63Aye1wDsIOh3a6FGYsgUgl7b9gw==
X-Google-Smtp-Source: APBJJlGoD/VxR3BbFv+ImtFMoe6c5kQO9wv+u3g62HEJx8HqwwhtWvu3lLeGD/sLRyF77FLO7GXKEdXGcjmXqyU+fkQ=
X-Received: by 2002:a17:906:2213:b0:974:1ef1:81ad with SMTP id
 s19-20020a170906221300b009741ef181admr2102985ejs.4.1689761883028; Wed, 19 Jul
 2023 03:18:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230629155433.4170837-1-dhowells@redhat.com> <20230629155433.4170837-2-dhowells@redhat.com>
In-Reply-To: <20230629155433.4170837-2-dhowells@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 19 Jul 2023 12:17:51 +0200
Message-ID: <CAJfpegsJuvXJDcXpo9T19Gw0tDuvyOJdv44Y2bt04MEf1JLxGg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] splice: Fix corruption of spliced data after
 splice() returns
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, 
	Dave Chinner <david@fromorbit.com>, Matt Whitlock <kernel@mattwhitlock.name>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, linux-fsdevel@kvack.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 29 Jun 2023 at 17:56, David Howells <dhowells@redhat.com> wrote:
>
> Splicing data from, say, a file into a pipe currently leaves the source
> pages in the pipe after splice() returns - but this means that those pages
> can be subsequently modified by shared-writable mmap(), write(),
> fallocate(), etc. before they're consumed.

What is this trying to fix?   The above behavior is well known, so
it's not likely to be a problem.

Besides, removing spliced pages from the cache is basically guaranteed
to result in a performance regression for any application using
splice.

Thanks,
Miklos

