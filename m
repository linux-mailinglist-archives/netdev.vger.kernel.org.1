Return-Path: <netdev+bounces-60798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE5D821890
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 09:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3EE81F2208B
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 08:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4225382;
	Tue,  2 Jan 2024 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBJzMRbe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4277E746B
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 08:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA93C433C8;
	Tue,  2 Jan 2024 08:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704185472;
	bh=AgMf0xXAqW6cRjyxRVHkwzC+qiwAbIJfo1EWkAWNThk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZBJzMRbehIvvUZiBHGELdUDl16Za42ItDKnYHN5dbORqGXleV1u4O0q+MzAK1e2xy
	 KFE7sWQEp96G/B2HqRtQIIPB6Zmb0zkT+BD9M1EZyF5PwwA3IWblhT5Xvub+TT+WhI
	 BcL7UX73osfDwQExmXl7AW4NHulkSufsap451RIA2yLmZNTeATGUtCzreqibJQZx70
	 BYnjsBoVASwvmgr4cj6TQOkFmoqKCr1ds4N5TAobcL5mgE65C9JCCGAMxgX+wVWehY
	 3RwMqpa7/dqwjPE2TFIEohaR/l53Ypu6M5Bsa5RgZD/uteYojp+h+MgJtfkE1K0YQV
	 g4JhLFte4ehUA==
Date: Tue, 2 Jan 2024 10:51:08 +0200
From: Leon Romanovsky <leon@kernel.org>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
	idok@mellanox.com
Subject: Re: [PATCH iproute2] rdma: use print_XXX instead of COLOR_NONE
Message-ID: <20240102085108.GC6361@unreal>
References: <20240101185028.30229-1-stephen@networkplumber.org>
 <170413622454.12705.16311353183841924815.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170413622454.12705.16311353183841924815.git-patchwork-notify@kernel.org>

On Mon, Jan 01, 2024 at 07:10:24PM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This patch was applied to iproute2/iproute2.git (main)
> by Stephen Hemminger <stephen@networkplumber.org>:
> 
> On Mon,  1 Jan 2024 10:50:00 -0800 you wrote:
> > The rdma utility should be using same code pattern as rest of
> > iproute2. When printing, color should only be requested when
> > desired; if no color wanted, use the simpler print_XXX instead.
> > 
> > Fixes: b0a688a542cd ("rdma: Rewrite custom JSON and prints logic to use common API")
> > 

Extra line, should be removed.

> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > 
> > [...]
> 
> Here is the summary with links:
>   - [iproute2] rdma: use print_XXX instead of COLOR_NONE
>     https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=9b578bbaded6

It was fast.

> 
> You are awesome, thank you!
> -- 
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
> 
> 
> 

