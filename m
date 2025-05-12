Return-Path: <netdev+bounces-189762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8A8AB3952
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 15:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04FB51883E66
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 13:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FB5267B0C;
	Mon, 12 May 2025 13:29:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DCF20322;
	Mon, 12 May 2025 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747056594; cv=none; b=Y+S19+rWghRO2GEt3xmS3wpk5Z5O8hiz8BxY6eFYc7tkXw3ub+l8xc+6O+7KQhq9ecOcjsopBpiCDFlpdGcRL3g4XNIwjC08aLwDuxVRSk9v0+8fnYbZ+RYa5UfTAIB6/NaatMs0xvnf8F36XI7ax0UQykOhLfUVO63cHQy4bKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747056594; c=relaxed/simple;
	bh=byepti5UQ63v7PpKk9HYWAoCZGYgtmgW8EBYQy2YrbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcPFAjnzd2mtRw/IWocorp8noOSRYIvSva0jSdCdit7T5UxPKvjYNuX4bJq1QYNitYIS4m5BXF4buh0Qk1BEy5veGOVIE8Q2Q0Zy/qBEmAKSztagidg4cwymjPazvJSWun9xl3UMJhSQj809KuOM4m14b9gthxHCWzFxxp4ZFcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-8c-6821f7c86e83
Date: Mon, 12 May 2025 22:29:39 +0900
From: Byungchul Park <byungchul@sk.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, john.fastabend@gmail.com,
	andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
	vishal.moola@gmail.com
Subject: Re: [RFC 01/19] netmem: rename struct net_iov to struct netmem_desc
Message-ID: <20250512132939.GF45370@system.software.com>
References: <20250509115126.63190-1-byungchul@sk.com>
 <20250509115126.63190-2-byungchul@sk.com>
 <ea4f2f83-e9e4-4512-b4be-af91b3d6b050@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea4f2f83-e9e4-4512-b4be-af91b3d6b050@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsXC9ZZnoe7J74oZBo8WMlvMWb+GzWL1jwqL
	5Q92sFrMWbWN0eLLz9vsFosXfgNKnm9hsXh67BG7xf1lz1gs9rRvZ7bobfnNbNG0YwWTxYVt
	fawWl3fNYbO4t+Y/q8WxBWIW306/YbRYv+8Gq8XvH3PYHIQ9tqy8yeSxc9Zddo8Fm0o9Nq/Q
	8ui6cYnZY9OqTjaPTZ8msXvcubaHzePEjN8sHjt3fGby+Pj0FovH+31X2Tw+b5IL4I3isklJ
	zcksSy3St0vgyuibalUwj7vi6YR9bA2Mezi6GDk5JARMJN5v3soCY0+9OYUNxGYRUJV4eHgq
	M4jNJqAucePGTzBbREBb4vX1Q+xdjFwczAJ7mCUun53OCJIQFvCRuPDyPjuIzStgIXG79Ssr
	SJGQwBRGiXt3pjFBJAQlTs58AraNWUBL4sa/l0BxDiBbWmL5P7CDOAVsJZrab4GViAooSxzY
	dpwJ4rhd7BJr72lA2JISB1fcYJnAKDALydRZSKbOQpi6gJF5FaNQZl5ZbmJmjoleRmVeZoVe
	cn7uJkZgbC6r/RO9g/HTheBDjAIcjEo8vCdeKmYIsSaWFVfmHmKU4GBWEuFt3A4U4k1JrKxK
	LcqPLyrNSS0+xCjNwaIkzmv0rTxFSCA9sSQ1OzW1ILUIJsvEwSnVwBhx7ZrPRIfUCcvaO/bU
	r3m0wH5fbunsOpfolUFKnkK3ec8bfZj08HPISUtpvtsZ96XktWZxvnjNcNm5wuZixeo5mWVu
	jdteuS03FNw1Y2ZS7LecPoPolvZrHZETN7xie6Oif6yqzP3CwYkPf9kp8M3nKX+g7H13sofa
	f6GnlR3S/XVc8968q1ViKc5INNRiLipOBACxD/V2yQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsXC5WfdrHviu2KGwYM2DYs569ewWaz+UWGx
	/MEOVos5q7YxWnz5eZvdYvHCb8wWc863sFg8PfaI3eL+smcsFnvatzNb9Lb8ZrZo2rGCyeLw
	3JOsFhe29bFaXN41h83i3pr/rBbHFohZfDv9htFi/b4brBa/f8xhcxDx2LLyJpPHzll32T0W
	bCr12LxCy6PrxiVmj02rOtk8Nn2axO5x59oeNo8TM36zeOzc8ZnJ4+PTWywe7/ddZfNY/OID
	k8fnTXIBfFFcNimpOZllqUX6dglcGX1TrQrmcVc8nbCPrYFxD0cXIyeHhICJxNSbU9hAbBYB
	VYmHh6cyg9hsAuoSN278BLNFBLQlXl8/xN7FyMXBLLCHWeLy2emMIAlhAR+JCy/vs4PYvAIW
	Erdbv7KCFAkJTGGUuHdnGhNEQlDi5MwnLCA2s4CWxI1/L4HiHEC2tMTyf2BHcArYSjS13wIr
	ERVQljiw7TjTBEbeWUi6ZyHpnoXQvYCReRWjSGZeWW5iZo6pXnF2RmVeZoVecn7uJkZgrC2r
	/TNxB+OXy+6HGAU4GJV4eE+8VMwQYk0sK67MPcQowcGsJMLbuB0oxJuSWFmVWpQfX1Sak1p8
	iFGag0VJnNcrPDVBSCA9sSQ1OzW1ILUIJsvEwSnVwGhrk2QgNtu2JvFk4uoUrz7Lfa8flM3p
	fDbF/qT7SaYFMzTF/79Qvn0g/7rOUfkp0v9vztPM3XOPy5Rvf1XB4ipJP9fM/V3C4UrbK+VX
	3rs78cw32bR/M8+nMb9vuiFUKch3mjFFP+0rd016oOKE9y+tvqzYV2zg3mVZZn5TYrUoh9CP
	A/VRm5RYijMSDbWYi4oTATJ+qB6xAgAA
X-CFilter-Loop: Reflected

On Mon, May 12, 2025 at 02:11:13PM +0100, Pavel Begunkov wrote:
> On 5/9/25 12:51, Byungchul Park wrote:
> > To simplify struct page, the page pool members of struct page should be
> > moved to other, allowing these members to be removed from struct page.
> > 
> > Reuse struct net_iov for also system memory, that already mirrored the
> > page pool members.
> > 
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >   include/linux/skbuff.h                  |  4 +--
> >   include/net/netmem.h                    | 20 ++++++------
> >   include/net/page_pool/memory_provider.h |  6 ++--
> >   io_uring/zcrx.c                         | 42 ++++++++++++-------------
> 
> You're unnecessarily complicating it for yourself. It'll certainly
> conflict with changes in the io_uring tree, and hence it can't
> be taken normally through the net tree.
> 
> Why are you renaming it in the first place? If there are good

It's because the struct should be used for not only io vetor things but
also system memory.  Current network code uses struct page as system
memory descriptor but struct page fields for page pool will be gone.

So I had to reuse struct net_iov and I thought renaming it made more
sense.  It'd be welcome if you have better idea.

	Byungchul

> reasons, maybe you can try adding a temporary alias of the struct
> and patch io_uring later separately.
> 
> -- 
> Pavel Begunkov
> 

