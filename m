Return-Path: <netdev+bounces-15884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A4174A480
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 21:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FFD82813CD
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 19:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8940C140;
	Thu,  6 Jul 2023 19:43:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4BCA944
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 19:43:36 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B671E1BD3
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 12:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4FxSIbYrqwQxuZKhHl5TiHUpsay/lSpwH3EFuL4Hxng=; b=cBS9578/bJwre+Jg/R5FHD16RN
	6ZbDW9XMNHkXhc15FC4HVt+YBW8ic9AXsVRmsZTrk/WQDrez4nlZbF4T9j920/krOjnQkE6Q3mTxm
	XED7NgFYNUjvMDVGNAeJYt3nbtNi0/RJ3U8Td7PuPVuVU/H9GhHJ90JMEViLD5fyPEk6z86gYu5g0
	wqfapPQtQH73gLHAxEOfJXmApf9xwKRviOWTZP7KqixAUmlS41pU9//GWm3pABuhTSVQZ/VB0ImIS
	aNmRvWUnDqqNWgCDEV815vEqllAizMHyFStQo64hjXjkh7NB8AwhCjTY5h7VfiOGCNKAAR6IF+pBO
	NezsgvCg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qHUt2-00BLmG-4y; Thu, 06 Jul 2023 19:43:32 +0000
Date: Thu, 6 Jul 2023 20:43:32 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Arjun Roy <arjunroy.kdev@gmail.com>
Cc: netdev@vger.kernel.org, arjunroy@google.com, edumazet@google.com,
	soheil@google.com, kuba@kernel.org, akpm@linux-foundation.org,
	dsahern@kernel.org, davem@davemloft.net, linux-mm@kvack.org,
	pabeni@redhat.com
Subject: Re: [net-next,v2] tcp: Use per-vma locking for receive zerocopy
Message-ID: <ZKcZZPB7jaDlasdR@casper.infradead.org>
References: <20230616193427.3908429-1-arjunroy.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616193427.3908429-1-arjunroy.kdev@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 16, 2023 at 12:34:27PM -0700, Arjun Roy wrote:
> However, with per-vma locking, both of these problems can be avoided.

I appreciate your enthusiasm for this.  However, applying this patch
completely wrecks my patch series to push per-vma locking down for
file-backed mappings.  It would be helpful if we can back this out
for now and then apply it after that patch series.

Would it make life hard for this patch to go through the mm tree?


