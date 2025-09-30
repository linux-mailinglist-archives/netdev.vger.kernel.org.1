Return-Path: <netdev+bounces-227263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27845BAAEB1
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 03:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BA724E1D17
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 01:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057BF1E520C;
	Tue, 30 Sep 2025 01:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gY17t0f9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55D71E1E04
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 01:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759197015; cv=none; b=UsksHSBHti8EC5ssGIfYle/WbWamj28WosQYxvuDtxSqgbK2zJ+r8+QsIBieGI/SNxVOUjaSMrDTFQrpSZP0vaRA3e6UPVPjz9IKjtmqMUF4alKxhFqE4+AV9hfDqZWaXlG9NqtmdmPonpj+0up29hPeNUn1cAAFWWWX94gbGYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759197015; c=relaxed/simple;
	bh=IJI1QL+00ntzMkATQk9UyR5EI0HFuB+nKUIYAiiQDCM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YYzb5tmLDhhG3TvjP5YI7J5teGa0p/vJwWCdXaFwZvkLNqC7aCI9R0AES1n7maSZAYvNyRzb8kKT4a0+OlOAyhLh9Sd2j4ca2tGXeuTNYxgTV3Bs6luVaJWfge9NAzkYFj1wuDlM2v0AO/1Xx/L0+f6iV2T3nm8nt8sm/EV0StI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gY17t0f9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500B8C4CEF7;
	Tue, 30 Sep 2025 01:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759197015;
	bh=IJI1QL+00ntzMkATQk9UyR5EI0HFuB+nKUIYAiiQDCM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gY17t0f9snk/kTpGD0iDS8ZlnosMXG1wYoUULo8yQDXKwYmB5MeL3yeN2PRUsxU28
	 e7KlCq7Z2fKCNdJvqaTOuA6PgBrIJXWBuulcAjIocj8scILzIdEvkHXn+NN/3XNj3y
	 EannbU86+r0isabbaVH+1qGEAzLwBk1T2xCQ3qpYpk2nPYoMdRaiGWZ4Bbewd8wIPc
	 fRLNZvL4e3h3TjsEHzKw/oF7xJEK/mZep643qhUnMyg1Kl2e7HtQyEVopTWrJVrPex
	 lRJgL7ZpU5/IakNwEWj8NGbIfljNKa1uT4tr2d5MxmSoE7ZYDlkOGMbxogEeWed+s6
	 YZICyHLj7bOfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E7F7639D0C1A;
	Tue, 30 Sep 2025 01:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] nfp: fix RSS hash key size when RSS is not
 supported
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175919700849.1783832.14561991737696929534.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 01:50:08 +0000
References: <20250929054230.68120-1-enjuk@amazon.com>
In-Reply-To: <20250929054230.68120-1-enjuk@amazon.com>
To: Kohei Enju <enjuk@amazon.com>
Cc: oss-drivers@corigine.com, netdev@vger.kernel.org, kuba@kernel.org,
 horms@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, louis.peens@corigine.com,
 kohei.enju@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Sep 2025 14:42:15 +0900 you wrote:
> The nfp_net_get_rxfh_key_size() function returns -EOPNOTSUPP when
> devices don't support RSS, and callers treat the negative value as a
> large positive value since the return type is u32.
> 
> Return 0 when devices don't support RSS, aligning with the ethtool
> interface .get_rxfh_key_size() that requires returning 0 in such cases.
> 
> [...]

Here is the summary with links:
  - [net,v1] nfp: fix RSS hash key size when RSS is not supported
    https://git.kernel.org/netdev/net/c/8425161ac120

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



