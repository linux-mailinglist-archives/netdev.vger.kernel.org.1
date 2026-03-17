Return-Path: <netdev+bounces-268529-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLIKLj4ouWkAtAEAu9opvQ
	(envelope-from <netdev+bounces-268529-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:09:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32ACC2A7919
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45EDA30996BC
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689A43A4F3A;
	Tue, 17 Mar 2026 10:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p0Bg2Nmm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B4B39FCD1
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773741867; cv=pass; b=DKrf/pT6kg372QgRXNSQ0EqAyVGIPhbGXUEBinjmF821kKjDWfsAWMuuTrg3dzT3z39so9l8CPBoFmKPPQjFASrg0rD/tB3xFPBjJsiBnwlZkvVrSSQZIvnxgOqRaV8Bw5FoJJpSPrYSE5Ig/qjGeOkxDFhJIb2QLn9w/SFF5vY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773741867; c=relaxed/simple;
	bh=VMcaJiK0n+Mh3FmYhue0PD5uIx7SxJhXZnJ+mVJvuvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVbfSBx65VnspuPmZ22rfeVWXZPhpE2f3W9qJfe9aSBC9HpBp6ZS+D6BJoMpJx13/dfF7YGeFTC06upERMEvFpXAPLyOSSiQi2tlHEanUW8AUEzcd/TLba2Cm1o/wk1dJzFsiOGZkDkyHa6MCamwtDs3zpeok7VwA9Pe8to0J7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p0Bg2Nmm; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64ad9238d8fso6318898d50.3
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 03:04:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773741863; cv=none;
        d=google.com; s=arc-20240605;
        b=HCXdKhoOeWIznYOa55rGI7b5lK/cgOCEsR+ZciB/KXfM5GlBP8uScfimO32lRk+ULt
         wTYUMbLEyPefLc7ojPCTzZgzZMEisZ8aChlkeHVSrAyS9tdpsCWDoPW6TQ9v1JdnBwrr
         Ch1KnwcB+/76obT/FhTOUIjn9CwKmf0Zi7O92NMePQZyDP4LeG7/bkz8zqAwRFSO4V3T
         A399SQUbbjnPuyRjJP2uElEMQYgYluC7AQSsNIYXQ+mLjN4RZp09SwS4Itqh860BodNo
         JxUNPFN+hvz95WCHwWr6JGNeOh1vT2WF+rrApVgBYLgZUsdWQdVusQhGKsOU/OmD9FTi
         VbfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sJ1Pc/1QKu2lLSHomCR6iKHtySw3Kp4fd1PA2wd2pgs=;
        fh=zZg/bfcT5dS6qOa3hPpz1fP8NyVhMSILl4qyZVgg5QE=;
        b=TAi2fp3iY8kQ+8KdCNhf5/ISE5nRxOkaJNQONXlJBhg/pryTqQh6DY4quzW8p1krUA
         XjWGsr1XEhDukIxw/3bk3Mucgv6CpLWaZYxYpcCSmuhiElS6SyxVgWwgS0hg1ghhbDmu
         WKhLlxIq9reA2tL159DoPLxQUR0VnvXfICQqpQtGEuUnp8e3CLQrBGSUoLNy8/IfuDt9
         IJtVDCKkOblpAW7hxOXrgUKR5SmWI4OE50FcSi4eoIs9Siq1cgvl4zOAl13gr90XkUcL
         JCSp2SPZ4/cHu442UFmo18GnNCuHj4t5QZoRdkazUoUoCjO/H9LyixPWyInXOeaYjAfa
         odHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773741863; x=1774346663; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sJ1Pc/1QKu2lLSHomCR6iKHtySw3Kp4fd1PA2wd2pgs=;
        b=p0Bg2NmmIKyboHpUMRTohcqtKsgqmTRvZ6VESwm3wzUXCUZTLvpR4pW87SLwEVZAXO
         a715hwTYDcQ66YJ5E6tCxRSczk0n8vIUf+XWJF99Dw0Ou63ItdoeBlBpZY0K+PSMqeuT
         GzR92G1MbpDNpHNgsm2UAbxHCeLxx4Cxo8oiKu80ohZ2DTt38SO3zx4YzoW9OR3xksI7
         wfFP74KJwfNquWCf2cF485aw5B6/Ex2p61WNpIjLwwoBDNyvmTYf29QePQQH5Kyrv1xN
         vnGdCFk3u5Vu7dOuyf6cZtxL8AQOaDbDMpOq4/2KoD8pDV36foKhVoAo5kuh1OaCqZAC
         +kAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773741863; x=1774346663;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJ1Pc/1QKu2lLSHomCR6iKHtySw3Kp4fd1PA2wd2pgs=;
        b=WB380lsDvp+4hdIDBwEzyQboiRDaNeRGeYYWBxz2uUHyCrXo5AzkJWZ8b0F/Rhkm09
         03SZ/4gOYf4ToHfvrFfmcmU2HQpGNwg4hlvaYI8xEWjosrZkimZMf9Jjht78VTWlbjzb
         enxP/O3Y7mQUDbKxgW0EuUsPexCrpgL5g7OlS1piw3lVx2ibJ0e7t0r/qyYCeHvmFjRy
         AZ8fMIsTtF59udhZneWw5IK9wEypeCMdpGgD8bWB37MCr/g+dHaxU4XrunM21hQp1NRl
         QhFo4NIhDN+A+aoXAAbBYdWv1hh+SN1ixY5lTxSL4cM1zgHTvAVtdvYFlBIjvIfprQJ3
         Cq9g==
X-Forwarded-Encrypted: i=1; AJvYcCU3K+ywChygWHqrmLVmYAYKNCcZi+wxzdRExI/yqIXEqm6qZIDdI1nJvI1S8Ci3tpzdxdDhWMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYZparUlJEIyB6V+Mvy6x7JPJ0JSmEIc+82r6IaOWZz9CQqtla
	NlPsl+Xs749YH61z36TxX+qoeyMnql0ba7yquPzlgSgqwpXraCh5gCLQR7KxzNGWcuP05RKt2HV
	8qCdhNn+DtgdV9EgVgPHCQcsfECdlaF32S1uKD9fkGg==
X-Gm-Gg: ATEYQzznehNP+mjmTqNjtnJ19z0US1qNjcjMPtOhNt3Hph90db+GQ98bIWazkqBQyEj
	xG6Znh/VtXwrVA+EKBnoxN6R5QK3BUqsQHYfhiKkJr8/o6eoDk6+EYTJ6EAY+/t5eFAaVKB3YbO
	gTBoZGKVqRX6z7na5La4QQsJw6BZ6835/LouqAcvK0aBK1DmDon6peoBAGRlHfn4Bzz00yHAyKq
	Dg8D1YWhiDFivpNmoR83aqU8Ug6TCF4r/9O79FxMN2ofsgv+5GV90Yf9OtDMS2R9HG/isUymCvs
	EhuOmzV8RFi9exxsXhheT/XuzlRo+6c2LKrRsWQu95G73QmykJin5dhiIlMAzgFBeQTGqVhmDdU
	sTYcQqb5fmDpVIYlNYZt4mMvVo8aXJYenZzfw01Kvhwg7CE2JNeFVZQ9wJyZ6KjS3EtjDUe4JWV
	Eqe6unXADIRqv2Kv7sylgiTIwuEGqKtD5Mlcym97342bRAIt4prZej7MntG9uivvJ0uwQ67/ZRI
	HCA7AR8y4apzQQaOJqAPFFZhuDOzhT98TCjhP0fiMASZPYYR16z586fCzHj805r9qNDfU8kvLqr
	BrkypGB1U2O4RpxjBePZV8g6ugahy+LwbfT5b5IBzNIY
X-Received: by 2002:a53:df4f:0:b0:64c:ea3d:a895 with SMTP id
 956f58d0204a3-64e6306d33fmr11868511d50.61.1773741863199; Tue, 17 Mar 2026
 03:04:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316222901.GA59948@system.software.com> <20260316223113.20097-1-byungchul@sk.com>
 <ebd00055-d4aa-4612-8bf3-ef0a308512f8@kernel.org>
In-Reply-To: <ebd00055-d4aa-4612-8bf3-ef0a308512f8@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 17 Mar 2026 12:03:47 +0200
X-Gm-Features: AaiRm50_gMBZxX2vRtFxvpOCPSPD6sNew1gAwSuCX31B_IpupUaMwz2w2jjcEa0
Message-ID: <CAC_iWjKXvfJuVn_uGgj4SsPsZnvMMepd7BesZcXgRYDPm9yUhg@mail.gmail.com>
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
	sfr@canb.auug.org.au, dw@davidwei.uk, ap420073@gmail.com, dtatulea@nvidia.com
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
	TAGGED_FROM(0.00)[bounces-268529-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[47];
	FREEMAIL_CC(0.00)[sk.com,kvack.org,linux-foundation.org,vger.kernel.org,kernel.org,google.com,redhat.com,skhynix.com,oracle.com,iogearbox.net,davemloft.net,gmail.com,fomichev.me,nvidia.com,lunn.ch,suse.cz,suse.com,cmpxchg.org,infradead.org,linux.alibaba.com,canb.auug.org.au,davidwei.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilias.apalodimas@linaro.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 32ACC2A7919
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jesper,

On Tue, 17 Mar 2026 at 11:20, Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>
>
>
>
> On 16/03/2026 23.31, Byungchul Park wrote:
> > Currently, the condition 'page->pp_magic == PP_SIGNATURE' is used to
> > determine if a page belongs to a page pool.  However, with the planned
> > removal of @pp_magic, we should instead leverage the page_type in struct
> > page, such as PGTY_netpp, for this purpose.
> >
> > Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(),
> > and __ClearPageNetpp() instead, and remove the existing APIs accessing
> > @pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
> > netmem_clear_pp_magic().
> >
> > Plus, add @page_type to struct net_iov at the same offset as struct page
> > so as to use the page_type APIs for struct net_iov as well.  While at it,
> > reorder @type and @owner in struct net_iov to avoid a hole and
> > increasing the struct size.
> >
> > This work was inspired by the following link:
> >
> >    https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/
> >
> > While at it, move the sanity check for page pool to on the free path.
> >
> [...]
> see below
>
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 9f2fe46ff69a1..ee81f5c67c18f 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1044,7 +1044,6 @@ static inline bool page_expected_state(struct page *page,
> >   #ifdef CONFIG_MEMCG
> >                       page->memcg_data |
> >   #endif
> > -                     page_pool_page_is_pp(page) |
> >                       (page->flags.f & check_flags)))
> >               return false;
> >
> > @@ -1071,8 +1070,6 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
> >       if (unlikely(page->memcg_data))
> >               bad_reason = "page still charged to cgroup";
> >   #endif
> > -     if (unlikely(page_pool_page_is_pp(page)))
> > -             bad_reason = "page_pool leak";
> >       return bad_reason;
> >   }
> >
> > @@ -1381,9 +1378,17 @@ __always_inline bool __free_pages_prepare(struct page *page,
> >               mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
> >               folio->mapping = NULL;
> >       }
> > -     if (unlikely(page_has_type(page)))
> > +     if (unlikely(page_has_type(page))) {
> > +             /* networking expects to clear its page type before releasing */
> > +             if (is_check_pages_enabled()) {
> > +                     if (unlikely(PageNetpp(page))) {
> > +                             bad_page(page, "page_pool leak");
> > +                             return false;
> > +                     }
> > +             }
> >               /* Reset the page_type (which overlays _mapcount) */
> >               page->page_type = UINT_MAX;
> > +     }
>
> I need some opinions here.  When CONFIG_DEBUG_VM is enabled we get help
> finding (hard to find) page_pool leaks and mark the page as bad.
>

You mean we get debug messages about the leak right? Nothing is
silently freed with that config enabled.

> When CONFIG_DEBUG_VM is disabled we silently "allow" leaking.
> Should we handle this more gracefully here? (release pp resources)
>
> Allowing the page to be reused at this point, when a page_pool instance
> is known to track life-time and (likely) have the page DMA mapped, seems
> problematic to me.  Code only clears page->page_type, but IIRC Toke
> added DMA tracking in other fields (plus xarray internally).

If we can reliably track and release the pages, I think we should do
this regardless of CONFIG_DEBUG_VM being enabled or not. But the
question is how did that leak happen? Is it a misuse of the API from
the driver?

Thanks
/Ilias
>
> I was going to suggest to simply re-export page_pool_release_page() that
> was hidden by 535b9c61bdef ("net: page_pool: hide
> page_pool_release_page()"), but that functionality was lost in
> 07e0c7d3179d ("net: page_pool: merge page_pool_release_page() with
> page_pool_return_page()"). (Cc Jakub/Kuba for that choice).
> Simply page_pool_release_page(page->pp, page).
>
> Opinions?
>
> --Jesper

