Return-Path: <netdev+bounces-182015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B277EA87596
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 03:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17E7E188DE36
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 01:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C2018A6DF;
	Mon, 14 Apr 2025 01:52:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53C2187858
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 01:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744595548; cv=none; b=bSQHkFSLkFmB4OBRxQMquKxpWlKpMK1PpZB2E/aS7s8EP5iP4+wbt2CcFtWQs9cF8xPDYgsKMBaWmQh/DB5RDYN6jMuc+E7xo5uHwD143mslcVmBU68O+oRAvZ4SFG5aZ2ufwFrqMgB9FFgA/2e0xp8j+loc9zoHBxDFoF11f7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744595548; c=relaxed/simple;
	bh=Oe6NZjtKZD68dNscv8mZ7E9v5svXwEafeQPxBAfzBQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ML//M7oE8a6xBS2vfc+Xyessd3Ah4bIZD1/yS4+fCI20tk6SBb2lWBBeonBogYUe3+XOB3f/FPcuFztHmv++j2OerEX/gTtsfW0sYK81TmKvcVkCavuwwM1b1jD1GfKul9irkQljRzN+DsgJWdxoHf53PQBZdoVY16hzGmiBLjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-a5-67fc6a4caab5
Date: Mon, 14 Apr 2025 10:52:07 +0900
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org, ilias.apalodimas@linaro.org,
	almasrymina@google.com
Cc: kernel_team@skhynix.com, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
	hawk@kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC] shrinking struct page (part of page pool)
Message-ID: <20250414015207.GA50437@system.software.com>
References: <20250414013627.GA9161@system.software.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414013627.GA9161@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsXC9ZZnoa5P1p90gxdTdSwm9hhYrP5RYbGn
	fTuzRW/Lb2aLe2v+s1ocWyBm8fvHHDYHdo+ds+6yeyzYVOqxeYWWx6ZVnWwemz5NYve4c20P
	m8fnTXIB7FFcNimpOZllqUX6dglcGW/uXWQvOM9f8X3CbcYGxm6eLkZODgkBE4kXv78yw9h9
	jzsYQWwWAVWJs2+PsYLYbALqEjdu/ASrERHwk2idcpwFxGYWyJdounIMrF5YwEZi+4+5YPW8
	AhYSk26uBasREjCXWLL9DwtEXFDi5MwnUL1aEjf+vWTqYuQAsqUllv/jAAlzArVum7McrERU
	QFniwLbjQCVcQKetYZN4e+8cI8SdkhIHV9xgmcAoMAvJ2FlIxs5CGLuAkXkVo1BmXlluYmaO
	iV5GZV5mhV5yfu4mRmCQL6v9E72D8dOF4EOMAhyMSjy8CYd/pwuxJpYVV+YeYpTgYFYS4eVy
	/pUuxJuSWFmVWpQfX1Sak1p8iFGag0VJnNfoW3mKkEB6YklqdmpqQWoRTJaJg1OqgXGpd8U2
	J514WTmrTZ7ZXx8caTxT/1Gx7dJW5ii/J4lCZx+pHDnwkTNgV5XaYpu4x52OP8Kq3n+aZpnJ
	fqTYoZn/uMOSW3f7k/P1Jrq9sYzdrfRtF4vPnkvXshI2LoiwWHTl1eLmSbar2H+IC3p4/ef7
	rxl5eI/RpWq27QFr+xJVXTrNPvR2nlJiKc5INNRiLipOBADI4TmGbgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsXC5WfdrOuT9Sfd4PAHBYuJPQYWq39UWOxp
	385s0dvym9ni8NyTrBb31vxntTi2QMzi9485bA4cHjtn3WX3WLCp1GPzCi2PTas62Tw2fZrE
	7nHn2h42j8UvPjB5fN4kF8ARxWWTkpqTWZZapG+XwJXx5t5F9oLz/BXfJ9xmbGDs5uli5OSQ
	EDCR6HvcwQhiswioSpx9e4wVxGYTUJe4ceMnM4gtIuAn0TrlOAuIzSyQL9F05RhYvbCAjcT2
	H3PB6nkFLCQm3VwLViMkYC6xZPsfFoi4oMTJmU+gerUkbvx7ydTFyAFkS0ss/8cBEuYEat02
	ZzlYiaiAssSBbceZJjDyzkLSPQtJ9yyE7gWMzKsYRTLzynITM3NM9YqzMyrzMiv0kvNzNzEC
	Q3ZZ7Z+JOxi/XHY/xCjAwajEw5tw+He6EGtiWXFl7iFGCQ5mJRFeLudf6UK8KYmVValF+fFF
	pTmpxYcYpTlYlMR5vcJTE4QE0hNLUrNTUwtSi2CyTBycUg2MHsX2uh3Tgt4ds5hcsk3H3neW
	3Q59+Vlrmz4y2iWuf5J2+M+M+ivX1dQqjoV8+bDbrnHKsTKP5COK4WU8rEtiSlXuM2dy99d0
	PNgdxt24j6Gh5kPpRqUlYgt7n2Zs+7hEvO3dtPzwAzm5biwzNn6/vbn9dOsliWs/av1mKbUw
	bN22e56mbsUrJZbijERDLeai4kQAJw1ECFUCAAA=
X-CFilter-Loop: Reflected

On Mon, Apr 14, 2025 at 10:36:27AM +0900, Byungchul Park wrote:
> Hi guys,

+cc hawk@kernel.org
+cc netdev@vger.kernel.org

	Byungchul

> I'm looking at network's page pool code to help 'shrinking struct page'
> project by Matthew Wilcox.  See the following link:
> 
>    https://kernelnewbies.org/MatthewWilcox/Memdescs/Path
> 
> My first goal is to remove fields for page pool from struct page like:
> 
>    struct {	/* page_pool used by netstack */
> 	/**
> 	 * @pp_magic: magic value to avoid recycling non
> 	 * page_pool allocated pages.
> 	 */
> 	unsigned long pp_magic;
> 	struct page_pool *pp;
> 	unsigned long _pp_mapping_pad;
> 	unsigned long dma_addr;
> 	atomic_long_t pp_ref_count;
>    };
> 
> Fortunately, many prerequisite works have been done by Mina but I guess
> he or she has done it for other purpose than 'shrinking struct page'.
> 
> I'd like to just finalize the work so that the fields above can be
> removed from struct page.  However, I need to resolve a curiousity
> before starting.
> 
>    Network guys already introduced a sperate strcut, struct net_iov,
>    to overlay the interesting fields.  However, another separate struct
>    for system memory might be also needed e.g. struct bump so that
>    struct net_iov and struct bump can be overlayed depending on the
>    source:
> 
>    struct bump {
> 	unsigned long _page_flags;
> 	unsigned long bump_magic;
> 	struct page_pool *bump_pp;
> 	unsigned long _pp_mapping_pad;
> 	unsigned long dma_addr;
> 	atomic_long_t bump_ref_count;
> 	unsigned int _page_type;
> 	atomic_t _refcount;
>    };
> 
> To netwrok guys, any thoughts on it?
> To Willy, do I understand correctly your direction?
> 
> Plus, it's a quite another issue but I'm curious, that is, what do you
> guys think about moving the bump allocator(= page pool) code from
> network to mm?  I'd like to start on the work once gathering opinion
> from both Willy and network guys.
> 
> 	Byungchul

