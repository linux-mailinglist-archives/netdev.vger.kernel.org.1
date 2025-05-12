Return-Path: <netdev+bounces-189749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD81AB37CA
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 14:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61684179AF1
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 12:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C3C293B4D;
	Mon, 12 May 2025 12:51:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0549C28D837;
	Mon, 12 May 2025 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747054278; cv=none; b=GUm3IhPK3RaS2gB0PwzSIKiCIS2CeJ8qstACNo9CdZoGz4nQd5qOZ5O+gfmDN+j4Ussgd4KwBmpc4Z/02g9iyePwvQyjuo872XayIlQuIpNdHRBKu7xArFTYm3dKZhTIvKFjT+Ku2hCGidbJ0SCum7TrrIBXhZzfekGLfceUwcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747054278; c=relaxed/simple;
	bh=Sp+I0pIT/IGYXeehVafNi5wyfUuyAh8yUEaX8aq10PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcmhrcmPzmNWcTThFCQkkYDdGdyN/sPFp4MOGSf4J4q8n7NbObFl846pLjw46Mk9XJlZWj/QKd6L71n7wZ7lUgZgJzLTL6cCR+fHjxxGxPJbeB2fnupzSjh4VlryY5r/ybAWRKOhYrIxnmjogqNuiNtaK2B25S/iIjW3AB/PzC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-f2-6821eebc6fb5
Date: Mon, 12 May 2025 21:51:03 +0900
From: Byungchul Park <byungchul@sk.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org,
	almasrymina@google.com, ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com, hawk@kernel.org, akpm@linux-foundation.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch,
	edumazet@google.com, pabeni@redhat.com, vishal.moola@gmail.com
Subject: Re: [RFC 19/19] mm, netmem: remove the page pool members in struct
 page
Message-ID: <20250512125103.GC45370@system.software.com>
References: <20250509115126.63190-1-byungchul@sk.com>
 <20250509115126.63190-20-byungchul@sk.com>
 <aB5DNqwP_LFV_ULL@casper.infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aB5DNqwP_LFV_ULL@casper.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsXC9ZZnke7ed4oZBv8XclrMWb+GzWL1jwqL
	5Q92sFp8+Xmb3WLxwm/MFnPOt7BYPD32iN3i/rJnLBZ72rczW/S2/Ga2aNqxgsniwrY+VovL
	u+awWdxb85/V4tgCMYtvp98wWqzfd4PV4vePOWwOQh5bVt5k8tg56y67x4JNpR6bV2h5dN24
	xOyxaVUnm8emT5PYPe5c28PmcWLGbxaPnTs+M3l8fHqLxeP9vqtsHp83yQXwRnHZpKTmZJal
	FunbJXBlLLvYw1IwT75ic9dU1gbG/eJdjBwcEgImEqceCnQxcoKZO39dYwOxWQRUJS7ubAGz
	2QTUJW7c+MkMUi4ioCHxZosRSJhZYCmzxPSpwiC2sECQxOTHD9lBbF4BC4m7J7uYuhi5OIQE
	ehglts9rZINICEqcnPmEBaJZS+LGv5dMIDOZBaQllv/jAAlzAp1w+N4KRhBbVEBZ4sC242Bz
	JAS2sUt8OdPKBnGnpMTBFTdYJjAKzEIydhaSsbMQxi5gZF7FKJSZV5abmJljopdRmZdZoZec
	n7uJERiPy2r/RO9g/HQh+BCjAAejEg/viZeKGUKsiWXFlbmHGCU4mJVEeBu3A4V4UxIrq1KL
	8uOLSnNSiw8xSnOwKInzGn0rTxESSE8sSc1OTS1ILYLJMnFwSjUwSsbpt64+s/r+8v2i6xTE
	NQ05Sp3/LM972HjU4P7GOed3b27mdZm3/Mqdp7XJvzOVlANZVrql3eESY/5zuvv+pfryfObb
	7CerGxZ+6z5WwGo3kTf/v7TShGDRxOZfnz1mevRr/+WZ+Cat89k3xaCKtt3Of79/18vd9NPy
	6afa7kldfTFXJmdVKLEUZyQaajEXFScCAGlHrvbDAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsXC5WfdrLvnnWKGwaYXRhZz1q9hs1j9o8Ji
	+YMdrBZfft5mt1i88BuzxZzzLSwWT489Yre4v+wZi8We9u3MFr0tv5ktmnasYLI4PPckq8WF
	bX2sFpd3zWGzuLfmP6vFsQViFt9Ov2G0WL/vBqvF7x9z2ByEPbasvMnksXPWXXaPBZtKPTav
	0PLounGJ2WPTqk42j02fJrF73Lm2h83jxIzfLB47d3xm8vj49BaLx/t9V9k8Fr/4wOTxeZNc
	AF8Ul01Kak5mWWqRvl0CV8ayiz0sBfPkKzZ3TWVtYNwv3sXIySEhYCKx89c1NhCbRUBV4uLO
	FjCbTUBd4saNn8xdjBwcIgIaEm+2GIGEmQWWMktMnyoMYgsLBElMfvyQHcTmFbCQuHuyi6mL
	kYtDSKCHUWL7vEY2iISgxMmZT1ggmrUkbvx7yQQyk1lAWmL5Pw6QMCfQCYfvrWAEsUUFlCUO
	bDvONIGRdxaS7llIumchdC9gZF7FKJKZV5abmJljqlecnVGZl1mhl5yfu4kRGF/Lav9M3MH4
	5bL7IUYBDkYlHt4TLxUzhFgTy4orcw8xSnAwK4nwNm4HCvGmJFZWpRblxxeV5qQWH2KU5mBR
	Euf1Ck9NEBJITyxJzU5NLUgtgskycXBKNTAWfd9YHjj/1q+6Fwt2Vyxb+FVzq91bf6u0ye/v
	WF6a6+TxubyvrlZnny3vFu/PTaqnZ929H32vt0bqe5f+2rtr1Ngdp/AYG05/kfFHJ9BqwSfr
	w1/+s5v+6JPbp/l/ot9U2TVHLpydXdDNo/v/YGhPT+sK65Srp4sVn3SbfohjiTtpceG5X81D
	JZbijERDLeai4kQAuBwu+6sCAAA=
X-CFilter-Loop: Reflected

On Fri, May 09, 2025 at 07:02:30PM +0100, Matthew Wilcox wrote:
> On Fri, May 09, 2025 at 08:51:26PM +0900, Byungchul Park wrote:
> > +++ b/include/linux/mm_types.h
> > @@ -20,6 +20,7 @@
> >  #include <linux/seqlock.h>
> >  #include <linux/percpu_counter.h>
> >  #include <linux/types.h>
> > +#include <net/netmem_type.h> /* for page pool */
> >  
> >  #include <asm/mmu.h>
> >  
> > @@ -118,17 +119,7 @@ struct page {
> >  			 */
> >  			unsigned long private;
> >  		};
> > -		struct {	/* page_pool used by netstack */
> > -			/**
> > -			 * @pp_magic: magic value to avoid recycling non
> > -			 * page_pool allocated pages.
> > -			 */
> > -			unsigned long pp_magic;
> > -			struct page_pool *pp;
> > -			unsigned long _pp_mapping_pad;
> > -			unsigned long dma_addr;
> > -			atomic_long_t pp_ref_count;
> > -		};
> > +		struct __netmem_desc place_holder_1; /* for page pool */
> >  		struct {	/* Tail pages of compound page */
> >  			unsigned long compound_head;	/* Bit zero is set */
> >  		};
> 
> The include and the place holder aren't needed.

Or netmem_desc overlaying struct page might be conflict with other
fields of sturct page e.g. _mapcount, _refcount and the like, once the
layout of struct page *extremly changes* in the future before
netmem_desc has its own instance.

So placing a place holder like this is the safest way, IMO, to prevent
the unextected result.  Am I missing something?

> > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > index 00064e766b889..c414de6c6ab0d 100644
> > --- a/include/net/netmem.h
> > +++ b/include/net/netmem.h
> > @@ -10,6 +10,7 @@
> >  
> >  #include <linux/mm.h>
> >  #include <net/net_debug.h>
> > +#include <net/netmem_type.h>
> 
> ... which I think means you don't need the separate header file.

Agree if I don't use the place holder in mm_types.h.

> >  /* net_iov */
> >  
> > @@ -20,15 +21,6 @@ DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
> >   */
> >  #define NET_IOV 0x01UL
> >  
> > -struct netmem_desc {
> > -	unsigned long __unused_padding;
> > -	unsigned long pp_magic;
> > -	struct page_pool *pp;
> > -	struct net_iov_area *owner;
> > -	unsigned long dma_addr;
> > -	atomic_long_t pp_ref_count;
> > -};
> > -
> >  struct net_iov_area {
> >  	/* Array of net_iovs for this area. */
> >  	struct netmem_desc *niovs;
> > @@ -38,31 +30,6 @@ struct net_iov_area {
> >  	unsigned long base_virtual;
> >  };
> >  
> > -/* These fields in struct page are used by the page_pool and net stack:
> > - *
> > - *        struct {
> > - *                unsigned long pp_magic;
> > - *                struct page_pool *pp;
> > - *                unsigned long _pp_mapping_pad;
> > - *                unsigned long dma_addr;
> > - *                atomic_long_t pp_ref_count;
> > - *        };
> > - *
> > - * We mirror the page_pool fields here so the page_pool can access these fields
> > - * without worrying whether the underlying fields belong to a page or net_iov.
> > - *
> > - * The non-net stack fields of struct page are private to the mm stack and must
> > - * never be mirrored to net_iov.
> > - */
> > -#define NET_IOV_ASSERT_OFFSET(pg, iov)             \
> > -	static_assert(offsetof(struct page, pg) == \
> > -		      offsetof(struct netmem_desc, iov))
> > -NET_IOV_ASSERT_OFFSET(pp_magic, pp_magic);
> > -NET_IOV_ASSERT_OFFSET(pp, pp);
> > -NET_IOV_ASSERT_OFFSET(dma_addr, dma_addr);
> > -NET_IOV_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
> > -#undef NET_IOV_ASSERT_OFFSET
> 
> ... but you do want to keep asserting that netmem_desc and
> net_iov have the same offsets.  And you want to assert that struct page
> is big enough to hold everything in netmem_desc, like we do for slab:
> 
> static_assert(sizeof(struct slab) <= sizeof(struct page));

I will.  However, as I mentioned above, the total size doesn't matter
but the layout change of struct page might matter, I think.

	Byungchul


