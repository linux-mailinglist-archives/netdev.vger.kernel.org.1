Return-Path: <netdev+bounces-133691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C87996B35
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73471288C6F
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 13:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7131D07A7;
	Wed,  9 Oct 2024 12:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYeC2CCU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B571A265B;
	Wed,  9 Oct 2024 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478698; cv=none; b=qI3xLsEJyP1DnovFV44QfW1xCN5VfuWw4K9bpX3M62wFUFaz7y334IFVhTwCKFq5TazVQxRRhCIa6DJJXZ7RQXqlcArO7hPRGZi25uORMkH89lfmha29Z/dRbqinBEOxB8hAQjF25/3rA8tm0kLhYwjX572TDTej7nG7H6NqAMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478698; c=relaxed/simple;
	bh=PKJRa/2nMr/9RBbLZD7fUNaqRfRCiKftAEhp+oj5gZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnqgX5ZCzpIryKCa6jkFIEuNxXpTgiYZMjRSZr4KGmTiyuXdojBvvXszD9nCNT4kkxgCKWtDjZnm1uOJ1V3my04xdJQldsZCCqO5ZNu+ghcMbFZ0jVr2b1uH0JWR4oV7trjzavzmU/tWwwxck/245vLXlDoSWT2CK84QNraRRvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYeC2CCU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFACC4CEC5;
	Wed,  9 Oct 2024 12:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728478697;
	bh=PKJRa/2nMr/9RBbLZD7fUNaqRfRCiKftAEhp+oj5gZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nYeC2CCUKat+ZsY6+7msJHOp8HmlNtVPPdsmzKcHyV91Kd2LgBaWgzXoC2+8lE0PX
	 uEtSkSQRIsNu8yjQBjO8js6OtfuAu/Sw0cCLS2PzG3MZCjIPCgHU7hfUGzhq0vRh4s
	 AjBkTWYn4edjMzoQ5bqGx5DU8NaCubT1WsMxqt7DM7+qAjS1cE8t4pWYV6VYUQlGZd
	 rSFQ/TjweiGsGPvQaCjeNqvO+Gj0HQRGvuFNWs8R7potEAtc8Kzk+rxvSYRZmTlTKf
	 dVpN88yHG77no5aizNGEzZbFWv+kTjlpJNEsajOG2Pycddp6Uq0ksaHxJeiDZ3w4ua
	 uoDkpcaq8uEeA==
Date: Wed, 9 Oct 2024 13:58:13 +0100
From: Simon Horman <horms@kernel.org>
To: linux@treblig.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: liquidio: Remove unused
 cn23xx_dump_pf_initialized_regs
Message-ID: <20241009125813.GW99782@kernel.org>
References: <20241009003841.254853-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009003841.254853-1-linux@treblig.org>

On Wed, Oct 09, 2024 at 01:38:41AM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> cn23xx_dump_pf_initialized_regs() was added in 2016's commit
> 72c0091293c0 ("liquidio: CN23XX device init and sriov config")
> 
> but hasn't been used.
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Simon Horman <horms@kernel.org>


