Return-Path: <netdev+bounces-248179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A56D052E3
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 18:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E1363328E2A
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 16:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BEB2F28FC;
	Thu,  8 Jan 2026 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Grpgfaio"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10D52E9EAE
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767891227; cv=none; b=ES3GzWpR9R6oC7hXmjabVR4upEBuArJBJCCRALJYFKL+rXISSqZZWMMlKx5hF597TXECeSa4j+t80WkxWMxjiBxRsUbQ18UU9i2BdZl6dKiY9qgONy/vC6QH41io2jsC0uPLRPwYH7ND1sx6hd2ZA8+td/s4wXYkFVPa+WfOEIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767891227; c=relaxed/simple;
	bh=Jzf8zaj/18RluhRNfs3E+iGvbGzsUJq52CgdDRVw5SA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ewMDGQOtyMwG+OBJ9piIVdS9+t8VF0p+GoxwKfoJhy07191vuyZekg2igh1PrwOnommCNKa6u46hV2MVqBJjOKiyLGuDDgnzagq+AaJp0GVfQemYXRPXVQEohhzFaeOxfI0Nzijmm7n9pxk6jbv0vgx4Z7t4ULgEkgDuDigNBqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Grpgfaio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA6FC16AAE;
	Thu,  8 Jan 2026 16:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767891227;
	bh=Jzf8zaj/18RluhRNfs3E+iGvbGzsUJq52CgdDRVw5SA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Grpgfaio2k77LqpVwEjw0kjvqOC+dtKvSs1XHfohOt0/jvI6R2wi+rTGlHQk80poO
	 b4yct/g0Sgt3bvHA/4jiVyt7+pPfGso+khUceCrVtciwK6yt1aON+UfVJvy/XpZ0DM
	 Lr2hkzcnVu6Mye5N8MnfzO5eQL8UVmBCkPVGR4ww/IX3vGmHu60StGjRfiOZV7XVug
	 iRoBzJ8qgbmyv2QEpa638gc935LPmyIAWDlwybf10Izqod/kjiv5vk91sphOOPK76E
	 rWvgsqPwPRj/ehJ65wP6kbZGH8sG+AjTZ7Jc0FtoTaIZTWItpYFHKKbKCAv/t17OeB
	 8kbsHLn6NEXqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3C2D03A54A3D;
	Thu,  8 Jan 2026 16:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tools: ynl: don't install tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176789102402.3716059.16341235372896443735.git-patchwork-notify@kernel.org>
Date: Thu, 08 Jan 2026 16:50:24 +0000
References: <20260106163426.1468943-1-kuba@kernel.org>
In-Reply-To: <20260106163426.1468943-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, jstancek@redhat.com, liuhangbin@gmail.com,
 matttbe@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Jan 2026 08:34:26 -0800 you wrote:
> make's install target is meant for installing the production
> artifacts, AFAIU. Don't install test_ynl_cli and test_ynl_ethtool
> from under the main YNL install target. The install target
> under tests/ is retained in case someone wants the tests
> to be installed.
> 
> Fixes: 308b7dee3e5c ("tools: ynl: add YNL test framework")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] tools: ynl: don't install tests
    https://git.kernel.org/netdev/net/c/790792ebc960

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



