Return-Path: <netdev+bounces-165639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E5BA32E9D
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 19:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037081882551
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 18:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B4E260A31;
	Wed, 12 Feb 2025 18:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E68pyxbe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C77425EFAA
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 18:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739384616; cv=none; b=iGuQcnFjBLaVrX83fEdaCnDCr9QWDFwqy+DOC6RFY98NtofwknJiJlTAtqDxh4W7oqPD7+zzjLLzVAsBKDqQYKwdNsOAP0dczOzh90/9CKa5Re4gV0iREy/iF1s8MaOcjsuHw6ek2HsSxU4fc4KcfKkzUW8UAa0gktLwpPHoCnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739384616; c=relaxed/simple;
	bh=5GRUY1gAOC6jdm9O7BRC/Rtpl31iAKQKGJ3yXqWrjgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWM8Dkho0MtDyI2KRNmu7aI4RGIV2RkfDw5ahDmfnqzXn3lY8RZs5As7BwZlGdJ32+s5zy8WDo1L+SHXk4NFuszIisSjAqxFg62M9QQVRl3sE6Ps4JY48kyuL9OtlD2xAmDVRVpOarOyxxPl9Vk1Xx+gfC6LgnbqwwXWhvcsUEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E68pyxbe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2043C4CEDF;
	Wed, 12 Feb 2025 18:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739384614;
	bh=5GRUY1gAOC6jdm9O7BRC/Rtpl31iAKQKGJ3yXqWrjgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E68pyxbeTmBCMHBIJrmAt4KRego71BENJX2cVFn/+QaxDL9120oZickYy6g3qHxWM
	 e4eYxD5BGga2n+MnkjIGnfTRyDayrFsknTPkNR9QYKc9ns5xr5+eUWd34vDgSshSrB
	 ReKayBOUFGnD3FokfBw+glpqJ0WmiSrAG4rj7RHY9+2vXcmhLIO9o9AiTp/ew06Fbw
	 FVdRI5BaThGefGUaGqo3AmKgyM2xpOdvCgSwG9Gl8F3/fAceUrELyGGlfJ+KRNIZZc
	 y5cAPqR/yF0f3IDdnm/KwAEpBIc9o+TCE8UHv3Ff5tE0Or+j99AcSEvPaTwHeX4K7R
	 bJ+mzBwmhy/kA==
Date: Wed, 12 Feb 2025 18:23:30 +0000
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next] checkpatch: Discourage a new use of
 rtnl_lock() variants.
Message-ID: <20250212182330.GI1615191@kernel.org>
References: <20250211070447.25001-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211070447.25001-1-kuniyu@amazon.com>

On Tue, Feb 11, 2025 at 04:04:47PM +0900, Kuniyuki Iwashima wrote:
> rtnl_lock() is a "Big Kernel Lock" in the networking slow path
> and still serialises most of RTM_(NEW|DEL|SET)* rtnetlink requests.
> 
> Commit 76aed95319da ("rtnetlink: Add per-netns RTNL.") started a
> very large, in-progress, effort to make the RTNL lock scope per
> network namespace.
> 
> However, there are still some patches that newly use rtnl_lock(),
> which is now discouraged, and we need to revisit it later.
> 
> Let's warn about the case by checkpatch.
> 
> The target functions are as follows:
> 
>   * rtnl_lock()
>   * rtnl_trylock()
>   * rtnl_lock_interruptible()
>   * rtnl_lock_killable()
> 
> and the warning will be like:
> 
>   WARNING: A new use of rtnl_lock() variants is discouraged, try to use rtnl_net_lock(net) variants
>   #18: FILE: net/core/rtnetlink.c:79:
>   +	rtnl_lock();
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> It would be nice if this patch goes through net-next.git to catch
> new rtnl_lock() users by netdev CI.

Reviewed-by: Simon Horman <horms@kernel.org>


