Return-Path: <netdev+bounces-34855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E398F7A57DA
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 05:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB441C20A64
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 03:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607323418E;
	Tue, 19 Sep 2023 03:24:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A4510F2
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 03:24:39 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1BB95
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:24:38 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1qiRLi-00Fmxi-TJ; Tue, 19 Sep 2023 11:24:31 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 19 Sep 2023 11:24:33 +0800
Date: Tue, 19 Sep 2023 11:24:33 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Alexander Aring <aahringo@redhat.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Network Development <netdev@vger.kernel.org>, kadlec@netfilter.org,
	fw@strlen.de, gfs2@lists.linux.dev,
	David Teigland <teigland@redhat.com>, tgraf@suug.ch
Subject: Re: nft_rhash_walk, rhashtable and resize event
Message-ID: <ZQkUcXtwSLtC/OLV@gondor.apana.org.au>
References: <CAK-6q+ghZRxrWQg3k0x1-SofoxfVfObJMg8wZ3UUMM4CU2oiWg@mail.gmail.com>
 <ZQUjD0liUnH+ykKY@gondor.apana.org.au>
 <ZQg7s8MtByk4kfzP@calendula>
 <ZQhButkhI8K6cduD@gondor.apana.org.au>
 <CAK-6q+jLe_WnsMrkASv_AB722YARP=f7j=Je2VZYOKjfYUKcuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK-6q+jLe_WnsMrkASv_AB722YARP=f7j=Je2VZYOKjfYUKcuA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 08:38:09AM -0400, Alexander Aring wrote:
>
> To confirm this, redo the whole walk means starting at
> rhashtable_walk_start() again?

According to the documentation:

 * Returns -EAGAIN if resize event occurred.  Note that the iterator
 * will rewind back to the beginning and you may use it immediately
 * by calling rhashtable_walk_next.

So you shouldn't have to do anything other than keep on
iterating (if you wish to).

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

