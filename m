Return-Path: <netdev+bounces-18114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D15754E73
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 13:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7652F1C20946
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 11:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1106D24;
	Sun, 16 Jul 2023 11:29:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB4F28F5
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 11:29:02 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7BBE52;
	Sun, 16 Jul 2023 04:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GOnYVx5YAK+ziErge/1x9HGyqYnguAw6jCerx1KHHb4=; b=lHQYkapWUxpmBZVezHRrXRy+HR
	pn1BNgG2r6jVTEqLOhK18KRo/D9WG3nPHWJJUhuaHWR1UEdc+maI+AavFMkzfcxfxQQjaZBUxHuLq
	GLCOKkIR1vYeBxwttP8yMFvjmqeRUnycRgiTXtIqdfVPVdAR+EdHxfk9md6cuwjM5SwdcOKGtan+I
	+dtzOgPYIRQyjwKNoehOszgu8B8yAz+KV2UdNTjQJFaKw7/ok3MBVm3/e/32AId35uBuoAf/IplkL
	RVKkjbrrSKBeBjdvhra+giB+TlkPxIf3AbrPi8VgM+Tob9QXq1K7BLnJytzo64UmqyLLwCcFnzPil
	mIKAGnQw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qKzvS-0032Ta-B6; Sun, 16 Jul 2023 11:28:30 +0000
Date: Sun, 16 Jul 2023 12:28:30 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Rudi Heitbaum <rudi@heitbaum.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Linux Wireless <linux-wireless@vger.kernel.org>
Subject: Re: Fwd: mm/page_alloc.c:4453 with cfg80211_wiphy_work [cfg80211]
Message-ID: <ZLPUXlR30DjNaWqO@casper.infradead.org>
References: <51e53417-cfad-542c-54ee-0fb9e26c4a38@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51e53417-cfad-542c-54ee-0fb9e26c4a38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jul 16, 2023 at 06:10:44PM +0700, Bagas Sanjaya wrote:
> Hi,
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:

Maybe you could try doing some work on this bug before just spamming
people with it?

        if (WARN_ON_ONCE_GFP(order > MAX_ORDER, gfp))
                return NULL;

This is the page allocator telling the caller that they've asked for an
unreasonably large allocation.

Now, this bug is actually interesting to the MM because the caller
called kmalloc() with a ridiculous size.  Arguable kmalloc should
protect callers from themselves (alloc_pages() is more low level
and can presume its users know what they're doing).

Vlastimil, what do you think?  Something like ...

+++ b/mm/slab_common.c
@@ -1119,6 +1119,8 @@ static void *__kmalloc_large_node(size_t size, gfp_t flags, int node)
        void *ptr = NULL;
        unsigned int order = get_order(size);

+       if (order > MAX_ORDER)
+               return NULL;
        if (unlikely(flags & GFP_SLAB_BUG_MASK))
                flags = kmalloc_fix_flags(flags);



