Return-Path: <netdev+bounces-18300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED04756586
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 15:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A822812E8
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 13:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EA6BA50;
	Mon, 17 Jul 2023 13:53:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5B5BA2E
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 13:53:47 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A106BBD;
	Mon, 17 Jul 2023 06:53:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2D363218F8;
	Mon, 17 Jul 2023 13:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1689602024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NGhBJDzK/BM5omhjtk3XcApjj6iCqwWj80Nq511FRfU=;
	b=j6+qAp97kIaAGQsttxpdrwu3ZJ39DYBPXdkxVXGAbJvQxZlDIvouAicJ0RXcm3EF+W6uXi
	eCSn+RLmYx06Xc50yJSMbreOfzcXN3VM8ZI0gTlnIFrfGMiX7Vf3IKpImVUO4af6jiLcux
	A+8LO4/0x2RcIy0/JeEeDnkv/3J6KfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1689602024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NGhBJDzK/BM5omhjtk3XcApjj6iCqwWj80Nq511FRfU=;
	b=hLy0WTYyo0GTK85US7wgooIs0L1s1HNxXLN6pkogTg9FgDNeGZdTjwi3lQOqBfmlEcWakj
	Ui+IIMCp0Rf4tFDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9DA17138F8;
	Mon, 17 Jul 2023 13:53:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id pM++JOdHtWQ+WwAAMHmgww
	(envelope-from <vbabka@suse.cz>); Mon, 17 Jul 2023 13:53:43 +0000
Message-ID: <fe395b67-6cf8-7351-872c-a01c898a3798@suse.cz>
Date: Mon, 17 Jul 2023 15:53:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Fwd: mm/page_alloc.c:4453 with cfg80211_wiphy_work [cfg80211]
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Rudi Heitbaum <rudi@heitbaum.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Linux Networking <netdev@vger.kernel.org>,
 Linux Wireless <linux-wireless@vger.kernel.org>
References: <51e53417-cfad-542c-54ee-0fb9e26c4a38@gmail.com>
 <ZLPUXlR30DjNaWqO@casper.infradead.org>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZLPUXlR30DjNaWqO@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/16/23 13:28, Matthew Wilcox wrote:
> On Sun, Jul 16, 2023 at 06:10:44PM +0700, Bagas Sanjaya wrote:
>> Hi,
>> 
>> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
> Maybe you could try doing some work on this bug before just spamming
> people with it?
> 
>         if (WARN_ON_ONCE_GFP(order > MAX_ORDER, gfp))
>                 return NULL;
> 
> This is the page allocator telling the caller that they've asked for an
> unreasonably large allocation.
> 
> Now, this bug is actually interesting to the MM because the caller
> called kmalloc() with a ridiculous size.  Arguable kmalloc should
> protect callers from themselves (alloc_pages() is more low level
> and can presume its users know what they're doing).
> 
> Vlastimil, what do you think?  Something like ...

Hmm should be more robust to check size > KMALLOC_MAX_SIZE before even doing
get_order(size). Ultimately it checks the same limit.
But I'm unsure about just returning NULL. I think warn_on_once might be
useful even there - in case a bug is introduced/exposed, even a
inexperienced user will be easily able to report sufficient information wich
a WARN and its stacktrace, even if the callsite's alloc check doesn't
provide it in an obvious way?

> +++ b/mm/slab_common.c
> @@ -1119,6 +1119,8 @@ static void *__kmalloc_large_node(size_t size, gfp_t flags, int node)
>         void *ptr = NULL;
>         unsigned int order = get_order(size);
> 
> +       if (order > MAX_ORDER)
> +               return NULL;
>         if (unlikely(flags & GFP_SLAB_BUG_MASK))
>                 flags = kmalloc_fix_flags(flags);
> 
> 
> 


