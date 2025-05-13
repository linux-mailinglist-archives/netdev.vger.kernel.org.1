Return-Path: <netdev+bounces-189942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0C4AB48E2
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 03:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B032D188F68C
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 01:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0A118D65E;
	Tue, 13 May 2025 01:42:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE53A923;
	Tue, 13 May 2025 01:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747100534; cv=none; b=S68MUuuKhruhs3w/DFO58vulbKV/ZJoY9Fofrx4EH2opalJYDyiDYb7Obhuq4AqbHBqwQ48CYIyd2Qn8NIJd7CJCz7/T9uHRTy6yKTrGPlm0d06YkOklPPaDDHqAkGst8BSXIzryKzN2OdYFHmRUDA91lMsI3GiZgtQqIZ9gCAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747100534; c=relaxed/simple;
	bh=rYDxXy9y3PLlV7ocDiHDrUaSVSn/oVTrMP9BcBY02Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHptrz3u4ApSws6qazwbExDHlIAoFzY8co3/mIrp20ZXM1IVY5dnhGr+ZAtjxkEXAjliwVhS9DDK/HIrvTNwuMQ64oa4gEnrupwlGavWqv1wHwf6CtBUg0udCMsFb1RdPqT0NkW/L7TSwv+pN1wCknj3Xg781eycAy7f7Iidd+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-f3-6822a36d9452
Date: Tue, 13 May 2025 10:42:00 +0900
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
Message-ID: <20250513014200.GA577@system.software.com>
References: <20250509115126.63190-1-byungchul@sk.com>
 <20250509115126.63190-20-byungchul@sk.com>
 <aB5DNqwP_LFV_ULL@casper.infradead.org>
 <20250512125103.GC45370@system.software.com>
 <aCII7vd3C2gB0oi_@casper.infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCII7vd3C2gB0oi_@casper.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsXC9ZZnoW7uYqUMg6lP9C3mrF/DZrH6R4XF
	8gc7WC2+/LzNbrF44TdmiznnW1gsnh57xG5xf9kzFos97duZLXpbfjNbNO1YwWRxYVsfq8Xl
	XXPYLO6t+c9qcWyBmMW3028YLdbvu8Fq8fvHHDYHIY8tK28yeeycdZfdY8GmUo/NK7Q8um5c
	YvbYtKqTzWPTp0nsHneu7WHzODHjN4vHzh2fmTw+Pr3F4vF+31U2j8+b5AJ4o7hsUlJzMstS
	i/TtErgyHny6yV5wRqTi1cITrA2MB/m7GDk5JARMJPrX7GSBsRfcf88MYrMIqEq0z2tmArHZ
	BNQlbtz4CRTn4BAR0JB4s8UIJMwssJRZYvpUYRBbWCBIYvLjh+wgNq+AmcSJY9eARnJxCAk8
	ZZT42P6NCSIhKHFy5hMWiGYtiRv/XjKBzGQWkJZY/o8DJMwJdMKOaSfAThAVUJY4sO04E8gc
	CYFt7BKde3cyQtwpKXFwxQ2WCYwCs5CMnYVk7CyEsQsYmVcxCmXmleUmZuaY6GVU5mVW6CXn
	525iBEbksto/0TsYP10IPsQowMGoxMN74qVihhBrYllxZe4hRgkOZiUR3sbtQCHelMTKqtSi
	/Pii0pzU4kOM0hwsSuK8Rt/KU4QE0hNLUrNTUwtSi2CyTBycUg2M2QcWRbIJv3lW+Yhjylvm
	rG86i6auFZVzP/HJxS+vXbpP5usbWVO/a7mtPjEChhrap0QytBZ7rmFcxnQjOyfrx2SGpb+P
	O3u8Eo5+tkDk7/tXrlNe8acEGkyxP10mOt/EombpjfTzKXvrk47+TPzAH373+q5MJUl5nhny
	F8z9JIyEJJTSz1gpsRRnJBpqMRcVJwIAULd02MQCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsXC5WfdrJu7WCnDYEGbssWc9WvYLFb/qLBY
	/mAHq8WXn7fZLRYv/MZsMed8C4vF02OP2C3uL3vGYrGnfTuzRW/Lb2aLph0rmCwOzz3JanFh
	Wx+rxeVdc9gs7q35z2pxbIGYxbfTbxgt1u+7wWrx+8ccNgdhjy0rbzJ57Jx1l91jwaZSj80r
	tDy6blxi9ti0qpPNY9OnSewed67tYfM4MeM3i8fOHZ+ZPD4+vcXi8X7fVTaPxS8+MHl83iQX
	wBfFZZOSmpNZllqkb5fAlfHg0032gjMiFa8WnmBtYDzI38XIySEhYCKx4P57ZhCbRUBVon1e
	MxOIzSagLnHjxk+gOAeHiICGxJstRiBhZoGlzBLTpwqD2MICQRKTHz9kB7F5BcwkThy7xtLF
	yMUhJPCUUeJj+zcmiISgxMmZT1ggmrUkbvx7yQQyk1lAWmL5Pw6QMCfQCTumnQA7QVRAWeLA
	tuNMExh5ZyHpnoWkexZC9wJG5lWMIpl5ZbmJmTmmesXZGZV5mRV6yfm5mxiB8bWs9s/EHYxf
	LrsfYhTgYFTi4T3xUjFDiDWxrLgy9xCjBAezkghv43agEG9KYmVValF+fFFpTmrxIUZpDhYl
	cV6v8NQEIYH0xJLU7NTUgtQimCwTB6dUA6NGzgHf3cJMzN8q9k98M2dWn2mmKK9jdUdXuuL6
	+PYH67KmFxd+WXFVoCHz9hNBzV75upZTvH676/dPO7hl6l5z6cApgqHTnCfXLFrhe/xf991G
	1ppJtyY+KX22q0nsYFOiQrvzO86+f0tKp+3UvjBbuuzsUbFf/i/MmY2urLTcflNa9VDwwo1K
	LMUZiYZazEXFiQBGBXztqwIAAA==
X-CFilter-Loop: Reflected

On Mon, May 12, 2025 at 03:42:54PM +0100, Matthew Wilcox wrote:
> On Mon, May 12, 2025 at 09:51:03PM +0900, Byungchul Park wrote:
> > On Fri, May 09, 2025 at 07:02:30PM +0100, Matthew Wilcox wrote:
> > > > +		struct __netmem_desc place_holder_1; /* for page pool */
> > > >  		struct {	/* Tail pages of compound page */
> > > >  			unsigned long compound_head;	/* Bit zero is set */
> > > >  		};
> > > 
> > > The include and the place holder aren't needed.
> > 
> > Or netmem_desc overlaying struct page might be conflict with other
> > fields of sturct page e.g. _mapcount, _refcount and the like, once the
> > layout of struct page *extremly changes* in the future before
> > netmem_desc has its own instance.
> 
> That's not how it'll happen.  When the layout of struct page changes,
> it'll shrink substantially (cut in half).  That means that dynamically
> allocating netmem_desc must happen first (along with slab, folio, etc,
> etc).

Just in case, lemme explain what I meant, for *example*:

	struct page {
		unsigned long flags;
		union {
			struct A { /* 24 bytes */ };
			struct B { /* 40 bytes */ };
			struct page_pool { /* 40 bytes */ };
		};
		atomic_t _mapcount;
		atomic_t _refcount;
		unsigend long memcf_data;
		...
	};

	/* overlayed on struct page */
	struct netmem_desc { /* 8 + 40 bytes */ };

After removing page_pool fields:

	struct page {
		unsigned long flags;
		union {
			struct A { /* 24 bytes */ };
			struct B { /* 40 bytes */ };
		};
		atomic_t _mapcount;
		atomic_t _refcount;
		unsigend long memcf_data;
		...
	};

	/* overlayed on struct page */
	struct netmem_desc { /* 8 + 40 bytes */ };

The above still looks okay cuz operating on struct netmem_desc is not
touching _mapcount or _refcount in struct page.

However, either the size of struct B gets reduced to 32 bytes or struct B
gets away out of struct page for some reason, it will look like:

	struct page {
		unsigned long flags;
		union {
			struct A { /* 24 bytes */ };
			struct B { /* 32 bytes */ };
		};
		atomic_t _mapcount;
		atomic_t _refcount;
		unsigend long memcf_data;
		...
	};

	/* overlayed on struct page */
	struct netmem_desc { /* 8 + 40 bytes */ };

In here, operating on struct netmem_desc can smash _mapcount and
_refcount in struct page unexpectedly, even though sizeof(struct
netmem_desc) <= sizeof(struct page).  That's why I think the place holder
is necessary until it completely gets separated so as to have its own
instance.

If you believe it's still okay, I will remove the place holder, I still
concern it tho.

	Byungchul

