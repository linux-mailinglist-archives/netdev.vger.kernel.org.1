Return-Path: <netdev+bounces-184812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E7CA97472
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 20:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91F8E4420A3
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 18:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F8328F951;
	Tue, 22 Apr 2025 18:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8roIy1r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05895A59;
	Tue, 22 Apr 2025 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745346155; cv=none; b=jHhYSuOR1z3SvEpIVWyo+R9MObz/2fuLVFQIQaHbWLMULC41NwsMG7dBAdY+AUcYBSNN9Kk4nfsvB/6VGbuTZacpAevGjwzR+1ZJalvNno6l5XrXUdXY2NqmZwQLlh4dfziRgHuBlOaSxwNsgHqm2mtU0cvfam0VqJMVrXdqB+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745346155; c=relaxed/simple;
	bh=/6sathbH+7Jnbu9E149HuRG6rgSEuyc64VSGjuU8MWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDXz/eMddwrZpO/gweD1WwGHJ7rZi1BbS8H9Ev/LAEjlHCmVZwqJJ2CdaJP61rSxqMpJYkalqXXOkFrhOCD1ZmXq0JSNoI/i2ETN7SvLh+7fkMk5BPut3NNvclhWiDWtE27Q+hRehhUl7Y2+F48xQRrxnLGDhiuVukakArkhDHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8roIy1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101F9C4CEE9;
	Tue, 22 Apr 2025 18:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745346154;
	bh=/6sathbH+7Jnbu9E149HuRG6rgSEuyc64VSGjuU8MWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T8roIy1rX0xwCewCA2r4BONAjYm1LP5vatify1W7MnN3e4fWvB63tXJJWw6wcx7M/
	 CNaIxICJ3oIZl0Wlfp1QDQzFdoejE9iF1g8CFUQanPVpmdsznhUgGaGXh2ycbp3e5N
	 AkQEltIkUgrKXrvwmchbWbmekyA7NQla8eFl4OcP3cQg+cgwDFSpockBues3RX7xDs
	 o0qWUZRYfNs6rj1gEmrkqhw+NDr+xDIRkyntJzjBN1J4w2lfIjqPw3E0rx03BLADCD
	 B5HGcpahcylTXXaZeIsQ/3J3UQNex/zRwXlY4eyJN+U+T5Q5l98WOcSG2vtXpu8keN
	 WKCVbg2vMLeXQ==
Date: Tue, 22 Apr 2025 19:22:29 +0100
From: Simon Horman <horms@kernel.org>
To: linux@treblig.org
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	corbet@lwn.net, linux-afs@lists.infradead.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] rxrpc: Remove deadcode
Message-ID: <20250422182229.GM2843373@horms.kernel.org>
References: <20250417153232.32139-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417153232.32139-1-linux@treblig.org>

On Thu, Apr 17, 2025 at 04:32:32PM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> Remove three functions that are no longer used.
> 
> rxrpc_get_txbuf() last use was removed by 2020's
> commit 5e6ef4f1017c ("rxrpc: Make the I/O thread take over the call and
> local processor work")
> 
> rxrpc_kernel_get_epoch() last use was removed by 2020's
> commit 44746355ccb1 ("afs: Don't get epoch from a server because it may be
> ambiguous")
> 
> rxrpc_kernel_set_max_life() last use was removed by 2023's
> commit db099c625b13 ("rxrpc: Fix timeout of a call that hasn't yet been
> granted a channel")
> 
> Both of the rxrpc_kernel_* functions were documented.  Remove that
> documentation as well as the code.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Hi David,

This patch doesn't apply to net-next.  Probably because of commit
23738cc80483 ("rxrpc: Pull out certain app callback funcs into an ops
table"). So please rebase and repost.

But other than that, this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

-- 
pw-bot: changes-requested

