Return-Path: <netdev+bounces-270509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEfGOq4wwWm7RQQAu9opvQ
	(envelope-from <netdev+bounces-270509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:23:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4142F1DD2
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 141D8306BE0A
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8444739D6F8;
	Mon, 23 Mar 2026 12:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oXG3VfAC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09FB39D6D6
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 12:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774268220; cv=pass; b=kmoKEm9JzRI5Tgta271fx2HREZSNXbAcYfjnzETnPZ0LtgWFqx60cDfqazHSGB+ZHey3ANubiKhuXI3m0KNwZs5p8JHi5fCS75CBz7YQaOp8K4bNb1aB11ntPbYF5sq0+GDRo92xiqqNn3L77bOscevmstqC7u+h9Y1barIY1Fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774268220; c=relaxed/simple;
	bh=8RXOKVdkvBzCAmtN9XWtZUMFoXBo6XNuhmfrV+73dck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avDJLovIcw7dQFDLEV5sT2vfbX/m1xTwN3Atg53KvXRS3QaopDygYqN+5yABaJPLr/9fsVl5IGtqtwZMvr9UBJ7MViaGxCJeweqgbwTA9PpfmexUHMoW1iLecWXJT+oqgoFqHZjBn7t7Oj5vdIWde8HdRa/FLkfam7Cps8otNhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oXG3VfAC; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79853c0f5b9so22071607b3.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 05:16:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774268218; cv=none;
        d=google.com; s=arc-20240605;
        b=Al9+ArdL4ujj8JeNd4QBsxbYdGfgO0w++XlajJx2EXtTiX7ibVIB1wJEHDZEyLnYVU
         irr5VwpmGrOI5FmDq78/KG+VLPcMLOQCkc998aMfwIg82uY5hEbuDFtfLjHXOPOMvYrf
         vSvYp2io+owGJmn9BGRlRXUtIffJw0JmxYVg2XZFKHfCvYAplbC7J5bu8DXlsePi58oQ
         go+hS/a5cfcpiHLBMzlYid0KlPsfxg0GMWJNsjnBArhbcNvS4dKnt9WTDqR7Vp7PfDmj
         xARv9ScfVsrqy04oOLNhmd5+ms1cc5BVS+1k4Iuxb+QYvHFrZt4UZkBV/G5fG0XwZ1sv
         UHLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MWkmFbrIVsjT8V/hemxMRS0whR7xwhOiVNLmrbQRIkQ=;
        fh=49eTWkrrQu0iJz+Y/u8RgY5AE9M0LkFu+tRfYIx+Rvo=;
        b=HdNY87czpXoXa+hxqUwGI68LqSAhAxgRmyOROZy3IcJz+lXWPt9SFyD8qgyb6pW1OM
         ZF6HQ37KJvHnIQP4giQUWSCyrKBc0JufDijfDLbVX8GEXm11Mk8+CkgrRYkwLlb4/PRr
         DXqhZfkjn8n+QtMn25kiZ4EAg+FwQw5ALLD4KIdj5aBLrEQEqd4zZUtKwSYPbVMB5n9F
         X+67hyo3onQVZh3Zu6D4w3Gmc9ixbZQ/qtdMjJD+gvrF3czdsWMr6G6y720J6jR6G4BX
         CYmzu9z05GyyzyRTLb7Lhx+yOZ6e9jsjuXB0iWp075JLv2fkgVHOSWrNfYXzH6p5/Aq4
         nsXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774268218; x=1774873018; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MWkmFbrIVsjT8V/hemxMRS0whR7xwhOiVNLmrbQRIkQ=;
        b=oXG3VfAC4LKCyEAzdDhO6NpewxX2S3tvKQa/0F8umwy7BPUIzxHKByL4SJ+/NuvwtN
         01s1JM6LQERBKh2I1SCO0TeaGP8MPTwpgC0sZQr9fwnZ1TFtUojLEx6xYHZQY/1F59zK
         X/xr12CzWDsstfe0dkvHHwceUlmTWqeRvxdO5jtiABTjr/hurLVzIGm3dZJSRL8wbU8I
         6qAeDrPUv4CpPIc7Pd6SutsTygeBMiWJ2mVKzQadbhGpye02XlsIjNzqXBzXFD7xXxky
         eJ1cJw+UEouuY5YWaIZ136g2Rs6mhxqLXhXnKOTxZsmDgHAOih7AkiSeYCYjdMDak7sp
         hgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774268218; x=1774873018;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWkmFbrIVsjT8V/hemxMRS0whR7xwhOiVNLmrbQRIkQ=;
        b=eLqSwyO9Kl1u7fJNKmLICfMvWnKB3dmBXJ+/xkZZM6yY63TXxO6PonwQNsY3S1eRhH
         F61ETEK+fvp2tLbDHaOOo+b6jCz90zUNvR7ciXwlbvgH+UGckZMicdnNfWhTogU4/KVX
         24durJSygCpjFc31/8PjvrYA8kRaFST4Go4zFqzEZg5ZH4J/6i7RZlpcHHg6RxPboZIv
         uiuKYq2mvZpxLWmXK14aYLjD+dZaRmE/dfh6mFH9BaTHAXWXEbXLjtvTd/LR/D+asRkb
         dR36A6WnVs+N/EFINzxMi9HdPa5KHVlD511L3x7H/WDr6kN5Y6qEPF/f7CLhsvlsfCMk
         6iVA==
X-Forwarded-Encrypted: i=1; AJvYcCUUI8Bedq+6kJZI/z0T+AbdXR7H8oehYgEvmwy9pofDmlsPbo0gcp62G6zxDYBEmQ354YmV+6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnW4GoN+r3LUiM+BO9r7gQuFa04kpnAlb1lTt4RvYhkPoj6kb1
	Xi9gPwqPvv/BhpDHIBo+q5HxyZ3nH88IyPPK4b1tJSgCO+Ivbi96ZgT1/Es+1uZ4WTBMR8eSug5
	4yQOI2Lc4ze9oSfyeWL0UB8us244/Xzs341terBu1Bw==
X-Gm-Gg: ATEYQzytn5T9npI+fCrdD9wrmQoIURCwke7UFNMmweP2cPSlIq9H15Lq+OVSBaf3IDV
	nSVRcMuM66xwJzHZ9n+5nb5SwTA5V58G1qweKVn/BwJvKwkltWi8oHf8gU4yrP6ap6ERjlcW/aV
	991qtgv4e07eGyK57hvOL7qiKCWKCiDD7eF0fVUJVQ8O82W+WSO5gkDEN49TrY9WHQt4ZV1nBxi
	9Ek56pWgLNF+fB0QDYodxBxsNJBdiU+EVHcnjxoMVbk7eQhPC4goOGRPUXjfVfGijnxJzPH71HD
	dSRN5jYUyEFLYq7sEw/MSNv7l4d90WuA8S04r+AxOkQPOB6WHqnzIeDlgsUnpKxg0wi88UPebDR
	nSlSBV2pGwB3vE/LdTRehpdanZgoA1kXIGJ73mX9wSv8jgNqAWdY74HHoWof0bkUYtjRK+zQevb
	YVRhRt1h9LGAofLafUfRtwpqDqWFUeKycTKqLugm08rZp0x67Kwb/wbg2+j7f/57HJOX1nnykXk
	w0+gZrOOxq3m3xARI7LFQf6j56cqiRfuhAfItE6dQehctNoQ9eEL4YacM98NqPVSnBDZLr1a6NQ
	JEWEiHvZh/gP5nCOIq15MlGTFx3FkvuuHy2CURveoVr/S8H1p2bMU0Q=
X-Received: by 2002:a05:690c:1b:b0:79a:bb8b:e9d8 with SMTP id
 00721157ae682-79abb8c0ddcmr16991927b3.50.1774268217399; Mon, 23 Mar 2026
 05:16:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316222901.GA59948@system.software.com> <20260316223113.20097-1-byungchul@sk.com>
 <ebd00055-d4aa-4612-8bf3-ef0a308512f8@kernel.org> <20260318020223.GA69943@system.software.com>
 <b48275da-a3cb-4621-82fa-c2a83f1e24b5@kernel.org>
In-Reply-To: <b48275da-a3cb-4621-82fa-c2a83f1e24b5@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 23 Mar 2026 14:16:20 +0200
X-Gm-Features: AaiRm50BWIH2-tUvBrhcp6LVf1TFjq6A8vCDpCMci7VezVPJXkSVFBGlyHvsvAw
Message-ID: <CAC_iWjL4RhuK16pDM7bQhrkOgHa54R_6S0zGgwSdc_n+yKCcUg@mail.gmail.com>
Subject: Re: [PATCH v5] mm: introduce a new page type for page pool in page type
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org, akpm@linux-foundation.org, 
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Toke Hoiland Jorgensen <toke@redhat.com>, linux-kernel@vger.kernel.org, 
	kernel_team@skhynix.com, harry.yoo@oracle.com, ast@kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, john.fastabend@gmail.com, 
	sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, 
	mbloch@nvidia.com, andrew+netdev@lunn.ch, edumazet@google.com, 
	pabeni@redhat.com, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org, 
	ziy@nvidia.com, willy@infradead.org, brauner@kernel.org, kas@kernel.org, 
	yuzhao@google.com, usamaarif642@gmail.com, baolin.wang@linux.alibaba.com, 
	asml.silence@gmail.com, bpf@vger.kernel.org, linux-rdma@vger.kernel.org, 
	sfr@canb.auug.org.au, dw@davidwei.uk, ap420073@gmail.com, dtatulea@nvidia.com, 
	Daniel Dao <dqminh@cloudflare.com>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270509-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	FREEMAIL_CC(0.00)[sk.com,kvack.org,linux-foundation.org,vger.kernel.org,kernel.org,google.com,redhat.com,skhynix.com,oracle.com,iogearbox.net,davemloft.net,gmail.com,fomichev.me,nvidia.com,lunn.ch,suse.cz,suse.com,cmpxchg.org,infradead.org,linux.alibaba.com,canb.auug.org.au,davidwei.uk,cloudflare.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilias.apalodimas@linaro.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:dkim,linaro.org:email,netdevconf.info:url]
X-Rspamd-Queue-Id: 2E4142F1DD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 20 Mar 2026 at 13:44, Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>
>
>
> On 18/03/2026 03.02, Byungchul Park wrote:
> > On Tue, Mar 17, 2026 at 10:20:08AM +0100, Jesper Dangaard Brouer wrote:
> >> On 16/03/2026 23.31, Byungchul Park wrote:
> >>> Currently, the condition 'page->pp_magic == PP_SIGNATURE' is used to
> >>> determine if a page belongs to a page pool.  However, with the planned
> >>> removal of @pp_magic, we should instead leverage the page_type in struct
> >>> page, such as PGTY_netpp, for this purpose.
> >>>
> >>> Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(),
> >>> and __ClearPageNetpp() instead, and remove the existing APIs accessing
> >>> @pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
> >>> netmem_clear_pp_magic().
> >>>
> >>> Plus, add @page_type to struct net_iov at the same offset as struct page
> >>> so as to use the page_type APIs for struct net_iov as well.  While at it,
> >>> reorder @type and @owner in struct net_iov to avoid a hole and
> >>> increasing the struct size.
> >>>
> >>> This work was inspired by the following link:
> >>>
> >>>     https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/
> >>>
> >>> While at it, move the sanity check for page pool to on the free path.
> >>>
> >> [...]
> >> see below
> >>
> >>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >>> index 9f2fe46ff69a1..ee81f5c67c18f 100644
> >>> --- a/mm/page_alloc.c
> >>> +++ b/mm/page_alloc.c
> >>> @@ -1044,7 +1044,6 @@ static inline bool page_expected_state(struct page *page,
> >>>    #ifdef CONFIG_MEMCG
> >>>                        page->memcg_data |
> >>>    #endif
> >>> -                     page_pool_page_is_pp(page) |
> >>>                        (page->flags.f & check_flags)))
> >>>                return false;
> >>>
> >>> @@ -1071,8 +1070,6 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
> >>>        if (unlikely(page->memcg_data))
> >>>                bad_reason = "page still charged to cgroup";
> >>>    #endif
> >>> -     if (unlikely(page_pool_page_is_pp(page)))
> >>> -             bad_reason = "page_pool leak";
> >>>        return bad_reason;
> >>>    }
> >>>
> >>> @@ -1381,9 +1378,17 @@ __always_inline bool __free_pages_prepare(struct page *page,
> >>>                mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
> >>>                folio->mapping = NULL;
> >>>        }
> >>> -     if (unlikely(page_has_type(page)))
> >>> +     if (unlikely(page_has_type(page))) {
> >>> +             /* networking expects to clear its page type before releasing */
> >>> +             if (is_check_pages_enabled()) {
> >>> +                     if (unlikely(PageNetpp(page))) {
> >>> +                             bad_page(page, "page_pool leak");
> >>> +                             return false;
> >>> +                     }
> >>> +             }
> >>>                /* Reset the page_type (which overlays _mapcount) */
> >>>                page->page_type = UINT_MAX;
> >>> +     }
> >>
> >> I need some opinions here.  When CONFIG_DEBUG_VM is enabled we get help
> >> finding (hard to find) page_pool leaks and mark the page as bad.
> >>
> >> When CONFIG_DEBUG_VM is disabled we silently "allow" leaking.
> >> Should we handle this more gracefully here? (release pp resources)
> >>
> >> Allowing the page to be reused at this point, when a page_pool instance
> >> is known to track life-time and (likely) have the page DMA mapped, seems
> >> problematic to me.  Code only clears page->page_type, but IIRC Toke
> >> added DMA tracking in other fields (plus xarray internally).
> >>
> >> I was going to suggest to simply re-export page_pool_release_page() that
> >> was hidden by 535b9c61bdef ("net: page_pool: hide
> >> page_pool_release_page()"), but that functionality was lost in
> >> 07e0c7d3179d ("net: page_pool: merge page_pool_release_page() with
> >> page_pool_return_page()"). (Cc Jakub/Kuba for that choice).
> >> Simply page_pool_release_page(page->pp, page).
> >>
> >> Opinions?
> >
> > This is not an issue related to this patch but it's worth discussing. :)
> >
>
> Yes, looking at existing code, you are actually keeping the same
> problematic semantics of freeing a page that is still tracked by a
> page_pool (DMA-mapped and life-time tracked), unless CONFIG_DEBUG_VM is
> enabled.  You code change just makes this more clear that this is the case.
>
> In that sense this patch is correct and can be applied.
> Let me clearly ACK this patch.
>
> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
>
> > Not only page pool state but any bad states checks are also skipped with
> > is_check_pages_enabled() off, which means they are going to be
> > suppressed with the off.
> >
>
> Sadly yes. I'm mostly familiar with the page_pool, and I can say that
> this isn't a good situation.  Like Dragos said [1] it would be better to
> just leak to it.  Dragos gave a talk[2] on how to find these leaked
> pages, if we let them stay leaked.
>
>
>   [1] https://lore.kernel.org/all/20260319163109.58511b70@kernel.org/
>   [2]
> https://netdevconf.info/0x19/sessions/tutorial/diagnosing-page-pool-leaks.html
>
>
> > It is necessary to first clarify whether the action was intentional or
> > not.  According to the answer, we can discuss what to do better. :)
> >
> Acking this patch, as this discussion is a problem for "us" (netdev
> people) to figure out.  Lets land this patch and then we can followup.
>
> --Jesper
>
>
>
>

