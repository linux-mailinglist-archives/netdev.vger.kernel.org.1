Return-Path: <netdev+bounces-34546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C4D7A4912
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 14:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145C21C20D4D
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 12:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4551C1CA9F;
	Mon, 18 Sep 2023 12:00:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9513214010
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 12:00:46 +0000 (UTC)
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC258133
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 04:59:55 -0700 (PDT)
Received: from [78.30.34.192] (port=34322 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1qiCuq-009r2A-JV; Mon, 18 Sep 2023 13:59:50 +0200
Date: Mon, 18 Sep 2023 13:59:47 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Alexander Aring <aahringo@redhat.com>,
	Network Development <netdev@vger.kernel.org>, kadlec@netfilter.org,
	fw@strlen.de, gfs2@lists.linux.dev,
	David Teigland <teigland@redhat.com>, tgraf@suug.ch
Subject: Re: nft_rhash_walk, rhashtable and resize event
Message-ID: <ZQg7s8MtByk4kfzP@calendula>
References: <CAK-6q+ghZRxrWQg3k0x1-SofoxfVfObJMg8wZ3UUMM4CU2oiWg@mail.gmail.com>
 <ZQUjD0liUnH+ykKY@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZQUjD0liUnH+ykKY@gondor.apana.org.au>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Herbert,

On Sat, Sep 16, 2023 at 11:37:51AM +0800, Herbert Xu wrote:
> On Fri, Sep 15, 2023 at 10:05:06AM -0400, Alexander Aring wrote:
> >
> > My question is here? Is that allowed to do because a resize event may
> > change the order how to iterate over a rhashtable.
> 
> Walking over an rhashtable should be a last resort.  There is
> no guarantee of stability.
> 
> If you skip entries after a resize then you may miss entries.

One more question: this walk might miss entries but may it also
duplicate the same entries?

> If you want a stable walk, allocate an extra 8 bytes and use
> a linked list.

I will work on a patch to update netfilter clients for this code to
use a rcu linked list.

Thanks.

