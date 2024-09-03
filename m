Return-Path: <netdev+bounces-124341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FCB969106
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 03:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 523D51F21DF5
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 01:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B7B1CCECB;
	Tue,  3 Sep 2024 01:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3htvXTh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D294C85
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 01:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725327586; cv=none; b=jkgeh/MBk7azrdbO+n+guPikM4FGw7XlI9D8nHgwBDb9ZiysVIK3wGRnZCOwk33jH9R0t+TwztIoFgP+2ftNFwejQu2vdW+n0qsdZor7TB6ngZPXqc8EC6qvKbDlzVGtlQoNzGVoVnLj1Km+SRdWxM4x3qjAGc5p3JSTXjqzf3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725327586; c=relaxed/simple;
	bh=wWomZan+T+IlnLf1vg/uWgVOVUs3i8cyUXPTCNnSa4o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KzENbdt5gqgjWYAq6AIrfsPDADEdaXve/NWmHG1HZC7OnTdrCSELaIChzfEySswOcSvu838/W4ZfqLAjOoUPvV5g2lnCVGJ9iizvJFu+pRxpy+s/Lva9iztOpYKHWNAJCS9rexFHi3jq70MDzG3n85aCqvIHzu7YdauMdRJqurE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3htvXTh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C548C4CEC2;
	Tue,  3 Sep 2024 01:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725327585;
	bh=wWomZan+T+IlnLf1vg/uWgVOVUs3i8cyUXPTCNnSa4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s3htvXThUIMs/gAMeKO/DlNmP9HFPKu2QBFd8dSeUM9Xrj2kkXuqysYpBGwqPtg0S
	 qzGC+AivFPXUqvF2DGG14cTytVZZXpoQnzLgAFeQ5LcWpHiwL1mTfCE6xNLAixZSQ/
	 hGG9IzZB8mbpykp1NkoX7XpyErEtngxA0OT8S5rrC6uI6Q6JKdtCp8lSb+v7zGTPOV
	 33RtCvjjw/D1E+1fw0jjBHpI/1bYl8qvdXU7i8DGBDPYOyoxoJ15w4aM3jtLzFc7yI
	 Cb65MK1PMSWIs8h/3G8/h7Td5mhF3h9smDdGfiyDIM50c9WYIQIzk63gtEhO3YiFbE
	 KSZNPxcHdTC4A==
Date: Mon, 2 Sep 2024 18:39:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <christophe.jaillet@wanadoo.fr>, <horms@kernel.org>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH -next] netlink: Use the BITS_PER_LONG macro
Message-ID: <20240902183944.6779c0a5@kernel.org>
In-Reply-To: <20240902111052.2686366-1-ruanjinjie@huawei.com>
References: <20240902111052.2686366-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Sep 2024 19:10:52 +0800 Jinjie Ruan wrote:
> sizeof(unsigned long) * 8 is the number of bits in an unsigned long
> variable, replace it with BITS_PER_LONG macro to make it simpler.

Does coccicheck catch such cases?

