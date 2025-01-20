Return-Path: <netdev+bounces-159846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C31EA17258
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 18:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDABC1887F28
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 17:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7424A1F12FA;
	Mon, 20 Jan 2025 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iijg6LJG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE4A1F12F3;
	Mon, 20 Jan 2025 17:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737395149; cv=none; b=MK47f7cxeyCBfJpWi/DSvPYSJfzpjyx36PxfBJDwrGtKl3aDc10WqYCbL2SfP8zR80eu5vE7EwIYsN7NftGqIkHJIamswsMs41mYSr9rHGdwi7BntjIacZsofrL5ezFpbhiHpr8FVX/bSYy+ia2RRhaJz2QERxod+Q4i5vSsFIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737395149; c=relaxed/simple;
	bh=e1wuvN1zIIrla3YrLD0s565hpxyjgyUOMYzsCjx1/3U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tygOlqSeU3nA6peIC6aPKs82yDat8bkLiE9OhLl030iMNUTKYM92ec9ga3IjtFEKJbHax+4QOQ3zdYEVg5QY5VQgJJcfy153NhZaJJzzcLR39Njpt8G2iVgnM/+u4XA+KhixGHrXqoH+FnylCGB+hZROu76d4F8ksU8tlij2eTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iijg6LJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720F2C4CEE3;
	Mon, 20 Jan 2025 17:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737395148;
	bh=e1wuvN1zIIrla3YrLD0s565hpxyjgyUOMYzsCjx1/3U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Iijg6LJG3EPncSYJQJ/R/uoT47mPLTIA86Gd2ctKCD0FABKmCNOYX9qfhw6di9Gk+
	 eAQbch6SKOmSxKxtzA8y4VfqkU33MPKKOEBbO8602p2UWvv9Qzqwx8sSbGWtEUXpyc
	 4NKpvMI5wCwHr2/CK0qaJHfm3SlNUlehwweqJ1iKwOAof5Ts8axJQWFtnkDk0Eeuvj
	 mcfmHn68giDIOKLilsIf7iqL9GN1qW5ERDlWbj2DCfp+eEqO6FSBFwxV/Quabpes2t
	 KM8j2yULT5gpeBKxyTnUOUM1kHeb4Yj2tbXQnby1eaWzNIklZSmMq1SIR35hciZYf7
	 BJlHLoAAYsZxw==
Date: Mon, 20 Jan 2025 09:45:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: torvalds@linux-foundation.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 Guo Weikang <guoweikang.kernel@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Networking for v6.13-rc7
Message-ID: <20250120094547.202f4718@kernel.org>
In-Reply-To: <Z45i4YT1YRccf4dH@arm.com>
References: <20250109182953.2752717-1-kuba@kernel.org>
	<173646486752.1541533.15419405499323104668.pr-tracker-bot@kernel.org>
	<20250116193821.2e12e728@kernel.org>
	<Z4uwbqAwKvR4_24t@arm.com>
	<Z45i4YT1YRccf4dH@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jan 2025 14:51:13 +0000 Catalin Marinas wrote:
> > +#include <linux/kmemleak.h>
> >  #include <linux/memblock.h>
> >  #include <linux/printk.h>
> >  #include <linux/numa.h>
> > @@ -23,6 +24,9 @@ void __init alloc_node_data(int nid)
> >  		      nd_size, nid);
> >  	nd = __va(nd_pa);
> >  
> > +	/* needed to track related allocation stored in node_data[] */
> > +	kmemleak_alloc(nd, nd_size, 0, 0);
> > +
> >  	/* report and initialize */
> >  	pr_info("NODE_DATA(%d) allocated [mem %#010Lx-%#010Lx]\n", nid,
> >  		nd_pa, nd_pa + nd_size - 1);  
> 
> Hmm, I don't think this would make any difference as kmemleak does scan
> the memblock allocations as long as they have a correspondent VA in the
> linear map.
> 
> BTW, is NUMA enabled or disabled in your .config?

It's pretty much kernel/configs/debug.config, with virtme-ng, booted
with 4 CPUs. LMK if you can't repro with that, I can provide exact
cmdline.

