Return-Path: <netdev+bounces-116296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818C4949DE3
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 04:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B40928773A
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 02:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884F41917E6;
	Wed,  7 Aug 2024 02:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1x1djYm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600FE2119;
	Wed,  7 Aug 2024 02:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722998432; cv=none; b=e+XfZ+tD1TVVEY3EHtlHMn8YJMq5msZN6VxxUBaEJEAjTVLBnr2OXQZb8w9jOvX/LXKPQ/s0ICa4Wsrwm9oTbwbe3tbEqXZkqfJFycpNtQmUkKDh7F3P3gsJuEj1+9mwoypuuiA2vbknaJN/LY50r1p0s2aJr3L+Ve2xRdsuxi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722998432; c=relaxed/simple;
	bh=NTgfRIau2ZQG9tFbAhvcI5gOL2WMypnniKmYyvnOkCo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oiTId57JpHgYJwu/JLKN0AyFUnrVkEBQFRU8HZXSRbh7X630yt9Dbc8tubKr0RvT2Bw/fsABr7NT/95DiubLAJ8suYdHI7dEBXkWsG+tyaHdzdQdyRNcvpUeuLK/h/qtTRP97X7umRi95X3gvp0EJFapyIcMxGj9k25oJXvb+FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1x1djYm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5EFC32786;
	Wed,  7 Aug 2024 02:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722998432;
	bh=NTgfRIau2ZQG9tFbAhvcI5gOL2WMypnniKmYyvnOkCo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z1x1djYmKRt16W95cmPm2eCs2xKsa8m4oR3yvOTZ/KVZ1k0ut40obnaLC7K/kCpdc
	 1m8lcWrI/b2bOblhmBkEyiWH/rIHJaqUajAOxcbayneigICLDGwpJlocOkzG7URYYe
	 35Ta1ih5e8AuB2+KbbwHw/rekzfLmWmUbAFMj7nvHFvp1AoYRURskak26EpEyvSZVO
	 xkse6PL869WvrC4k+vU09Lq7rZER/bKe4b/LeG135Y2jOE5Is3LEOqv6RRiFHe5mfX
	 UqOXcNeBK2SmDN4uH+FijYukwlVRRpP7/L1SG19het60BYkNzjEeH2/D346oh+T7lX
	 rAxFBCgbkdwpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF7D39EFA73;
	Wed,  7 Aug 2024 02:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net/chelsio/libcxgb: Add __percpu annotations to
 libcxgb_ppm.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172299843049.1823320.2522056756746926480.git-patchwork-notify@kernel.org>
Date: Wed, 07 Aug 2024 02:40:30 +0000
References: <20240804154635.4249-1-ubizjak@gmail.com>
In-Reply-To: <20240804154635.4249-1-ubizjak@gmail.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  4 Aug 2024 17:46:09 +0200 you wrote:
> Compiling libcxgb_ppm.c results in several sparse warnings:
> 
> libcxgb_ppm.c:368:15: warning: incorrect type in assignment (different address spaces)
> libcxgb_ppm.c:368:15:    expected struct cxgbi_ppm_pool *pools
> libcxgb_ppm.c:368:15:    got void [noderef] __percpu *_res
> libcxgb_ppm.c:374:48: warning: incorrect type in initializer (different address spaces)
> libcxgb_ppm.c:374:48:    expected void const [noderef] __percpu *__vpp_verify
> libcxgb_ppm.c:374:48:    got struct cxgbi_ppm_pool *
> libcxgb_ppm.c:484:19: warning: incorrect type in assignment (different address spaces)
> libcxgb_ppm.c:484:19:    expected struct cxgbi_ppm_pool [noderef] __percpu *pool
> libcxgb_ppm.c:484:19:    got struct cxgbi_ppm_pool *[assigned] pool
> libcxgb_ppm.c:511:21: warning: incorrect type in argument 1 (different address spaces)
> libcxgb_ppm.c:511:21:    expected void [noderef] __percpu *__pdata
> libcxgb_ppm.c:511:21:    got struct cxgbi_ppm_pool *[assigned] pool
> 
> [...]

Here is the summary with links:
  - [v2] net/chelsio/libcxgb: Add __percpu annotations to libcxgb_ppm.c
    https://git.kernel.org/netdev/net-next/c/acd221a6507c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



