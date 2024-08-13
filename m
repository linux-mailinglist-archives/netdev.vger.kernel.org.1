Return-Path: <netdev+bounces-117975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA05695022F
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 12:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 906C6B2628B
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 10:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479561802AB;
	Tue, 13 Aug 2024 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxo2EL21"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0821607B9;
	Tue, 13 Aug 2024 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723543948; cv=none; b=BJtfPDZuY+GmJ80jXlDCKEdY32zKf1sf9Cwbr5jEl/yelVOkWSg3xOigiDgE7LSE4NKZr7hs7dn0jUspy+UvAte67v26uqEUgzIuMWVN68VYxjWTaMtCy5y1PvFN18N8vkuQKc8OSUIJvlvtdjgo/bBs0lN9PueDjj09LAn4q6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723543948; c=relaxed/simple;
	bh=gJk2zxl9y+T2Gr9Kt6QbJ7lnzo6GswvaSixeqUBdUnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtscBqgjaH3kZZXBusiemnQciz5nKpdAlS2eAYBAQf5Wd4YyZcNncR+6Y5SEgNCcNhJIvjOA8vj1iAqVvG+It2v2ydbA1hX0yUDb6Ta28pikFEjNqKpzv54saUtrwRP4RqQVKlbCmudMJpxCxJEfH9R+9mbvGgR6nilYYPE0Ao0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxo2EL21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470B0C4AF0B;
	Tue, 13 Aug 2024 10:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723543947;
	bh=gJk2zxl9y+T2Gr9Kt6QbJ7lnzo6GswvaSixeqUBdUnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gxo2EL21ZKJBcFQAyodLqSZNg23eQxj06yVWO0Yt4rG7KVgYf15g5HiVEjmHMgnXA
	 2gOCieWVm1SyqXvJSkYHseQBSedVn7FnzgdLYaiPbxGv0pvZEgpFT80MHKhFeU8nHw
	 IjeTHdXVpNTA9RW4b6EEXaCFWa2zroh0HBZs0D3i6v8aocXN5tE8Wa/TNz35/9G/Fr
	 Pa2RbhniU7B+xJSqD4bW/d3/woydJQm9TgrQzB6tDxBEGzAEBzYHnFOgOwm048CgFJ
	 CdwAGHzbtONSW3HfSXm70kd7I8+AfTA4X7SwW2+CD/XFZeDzQQs2QAdX6fVJTdFpVG
	 TCQOlSCDjOi6A==
Date: Tue, 13 Aug 2024 11:12:22 +0100
From: Simon Horman <horms@kernel.org>
To: Jing-Ping Jan <zoo868e@gmail.com>
Cc: corbet@lwn.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, skhan@linuxfoundation.org
Subject: Re: [PATCH v2] Documentation: networking: correct spelling
Message-ID: <20240813101222.GA5183@kernel.org>
References: <20240811134453.GJ1951@kernel.org>
 <20240812170910.5760-1-zoo868e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812170910.5760-1-zoo868e@gmail.com>

On Tue, Aug 13, 2024 at 01:09:10AM +0800, Jing-Ping Jan wrote:
> Correct spelling problems for Documentation/networking/ as reported
> by ispell.
> 
> Signed-off-by: Jing-Ping Jan <zoo868e@gmail.com>
> ---
> Thank you Simon, for the review.
> Changes in v2: corrected the grammer and added the missing spaces before
> each '('.

Thanks,

I agree that these changes improve the document.

Reviewed-by: Simon Horman <horms@kernel.org>


