Return-Path: <netdev+bounces-193956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06AFAC69DA
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 14:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338323B26DC
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 12:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D35127AC56;
	Wed, 28 May 2025 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgxFJfZ+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ECA214211
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 12:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748436907; cv=none; b=kueMjb0EJ7iNz0H+miKcZcuiKn9mzBLVbXFIxbMk+CJlR1T9BGBi2wthqFp6fAHmJWQoPpBbjEnD4SI76GKLnnqqXPy7DaM7jekVE0Z+6CrH5LE9XbF7q/fx7GxXZl1fbYuZL8SBA2WXUYMikqmzZMtKCTSXsKxVGG24u4l8K2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748436907; c=relaxed/simple;
	bh=rW02u5eYMtZ2rHNKzMHgrAysc3B/pqpvLy9DVQlE5X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0GImLScNydSJIAO/EgK35ZcRTI+wxOmhOUdmnMgnRAMcz2CEYG5TtttonxF3WeDja0fm8d6gKMv/v96qFPmGsdccgTfCjYf3fcZgK1LltCcbxhkp6M/zXLxHIX74nvvR5lWuU1QWYd0i6S3jXuiqTEmn/lPZiX7XZd3ZTulnNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgxFJfZ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DC4C4CEE7;
	Wed, 28 May 2025 12:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748436906;
	bh=rW02u5eYMtZ2rHNKzMHgrAysc3B/pqpvLy9DVQlE5X0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZgxFJfZ+R+PL4f1ZxOSSq7ynFZzwBbjmSe8rLqILLQ1P+y2h/WscvFq7bws8hM/cR
	 HldvupBaQnYY7grW9TwtV6p2aZLyAkk7ra413KLffLwojv7dTEbrT+OK8+QFKq+RMB
	 k2CoI+EXOP4FIZKc/2J3KoixKIKNBrhM7Xdz8GMovGUlykDlT4lMeQtywZ81nhRfA1
	 XPj8OiS8+h30tvc0dFhNtDavAwIWy5bvi7eGtaKf5bEWxK/ChvgqjE2UW25JJGPK/Z
	 ntzX88Zt3AFIFJ2tVn0DdE8mwjy72BU99Mbtm8K55WKhXewiu19+IBpEYgn1yE5QDl
	 rUz7031V73fyg==
Date: Wed, 28 May 2025 13:55:01 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, saikrishnag@marvell.com,
	gakula@marvell.com, hkelam@marvell.com, sgoutham@marvell.com,
	lcherian@marvell.com, bbhushan2@marvell.com, jerinj@marvell.com,
	netdev@vger.kernel.org
Subject: Re: [net v2 PATCH] octeontx2-pf: Avoid typecasts by simplifying
 otx2_atomic64_add macro
Message-ID: <20250528125501.GC365796@horms.kernel.org>
References: <1748340180-32124-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1748340180-32124-1-git-send-email-sbhatta@marvell.com>

On Tue, May 27, 2025 at 03:33:00PM +0530, Subbaraya Sundeep wrote:
> Just because otx2_atomic64_add is using u64 pointer as argument
> all callers has to typecast __iomem void pointers which inturn
> causing sparse warnings. Fix those by changing otx2_atomic64_add
> argument to void pointer.

I'm wondering if you considered changing the type of the 2nd parameter
of otx2_atomic64_add to u64 __iomem * and, correspondingly, the type
of the local variables updated by this patch. Perhaps that isn't so
clean for some reason. But if it can be done cleanly it does seem slightly
nicer to me.

> 
> Fixes: caa2da34fd25 ("octeontx2-pf: Initialize and config queues")

I do appreciate this change. But I wonder if it is more of a
clean-up for net-next (once it re-opens, no Fixes tag) than
a fix.

> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> ---
> v2:
>  Fixed x86 build error of void pointer dereference reported by
>  kernel test robot

...

