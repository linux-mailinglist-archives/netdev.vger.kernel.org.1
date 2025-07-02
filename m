Return-Path: <netdev+bounces-203532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5E1AF64D5
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 00:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D401C43E63
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 22:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937D3243371;
	Wed,  2 Jul 2025 22:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isB7Ti9N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CC01F76A5;
	Wed,  2 Jul 2025 22:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751494194; cv=none; b=VUcVcoOl9q1TC4OPaB3EPgY9WXfrRqthphUwUeyx9Zhap90fq2TAFP7sRAcvcN+453TIyMA9acKe7iA1gXk0eZWTlgJdx+lS2sx4WczUbEyTVIqqwOLXLYKASFB29nfzDqH43WZUyGo9qqhWIb6BXoqggMp9n52kA5mX5JiZEF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751494194; c=relaxed/simple;
	bh=S+mVh0bj4xRGO/SKkld2QAdLfGU7FAOgEqQ3/sOe1VE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TwP4KCeXIbueGIHkIwocAgia5siNuonLMTKzZcUvZGKvG/pEzh8fhWyMxm1nw12rvnR5gh4yeDyDJHuZ5A6Ev/f08qM4IZA2sxnPvOaRmwPDrrAhP0J1vFEAy64/kG1HhB0DyQv7VVQmWabqrlcprmTrlPl6OrCmCClTNyQxwRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isB7Ti9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45ED3C4CEE7;
	Wed,  2 Jul 2025 22:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751494194;
	bh=S+mVh0bj4xRGO/SKkld2QAdLfGU7FAOgEqQ3/sOe1VE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=isB7Ti9NPoLARYVTCcNjHqXt8FVSiChiTjmZ7v6EDU0S/aSvzMhndChWzv6EiGo8/
	 D/q9bmhPkZ0vuuV2j9lC2GEXQScOhC3N0qnG+Z86OFx0ixuGXhy/JY7/4jvxW1nSin
	 Vm6GiKKzkdEMuFwpHX0FooPzUyW2yca6MYMjqgXslUMi1zCT3pS6go/jHUqbloTEg4
	 llyf9GhuFVpNJkGBpchrvQ1aTvsTapUU5S/qOAEgTIn/nmZWUnYam7/jheM18XIIEq
	 /mHpgIN6U1w8nsikmGoAFAdhB6+8O7FDMUuwB8P/S4lSPa4+toOgTrW4fcRvB/ueUi
	 RTKGjIEGMReMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEFD383B273;
	Wed,  2 Jul 2025 22:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/2] vsock/test: check for null-ptr-deref when
 transport changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175149421852.880958.2267233099494206987.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 22:10:18 +0000
References: <20250630-test_vsock-v5-0-2492e141e80b@redhat.com>
In-Reply-To: <20250630-test_vsock-v5-0-2492e141e80b@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: sgarzare@redhat.com, mhal@rbox.co, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, v4bel@theori.io

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Jun 2025 18:33:02 +0200 you wrote:
> This series introduces a new test that checks for a null pointer
> dereference that may happen when there is a transport change[1]. This
> bug was fixed in [2].
> 
> Note that this test *cannot* fail, it hangs if it triggers a kernel
> oops. The intended use-case is to run it and then check if there is any
> oops in the dmesg.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] vsock/test: Add macros to identify transports
    https://git.kernel.org/netdev/net-next/c/e84b20b25d37
  - [net-next,v5,2/2] vsock/test: Add test for null ptr deref when transport changes
    https://git.kernel.org/netdev/net-next/c/3a764d93385c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



