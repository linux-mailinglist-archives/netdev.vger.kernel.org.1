Return-Path: <netdev+bounces-178933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A90CFA7996F
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 02:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86EFD3B4A59
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 00:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CB88635D;
	Thu,  3 Apr 2025 00:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8z+eXd2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3364086324
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 00:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743640201; cv=none; b=SOL3jN2zlNWZ/bKcpq9w7eT0BbXGDoD1PTPKHGP1XrrT0cjzudNuFeFHlZeuCD9XLMc9+V2Td82lGn3miwB+cPmtYkmwBa95PcFyA3srzjrijjKIQvMAW2B0il9jKcxkTesUCwhT3Y/ZB/JwekkHf1+ZNGOHBcbuEPSquwi2pg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743640201; c=relaxed/simple;
	bh=0rpRRm+wudgp9j5gCeJjoFbQd23fyrfAGsiG0Cto4JI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AcbPT0vKkCSX34gM7cBMVzBftmaruhfij3ebnl/2KnuuYNSSbUJacJAe4lt6LmwB50/GL7kfDGEfEM/gO1YPZHUmOWrDr7hLlzYmz6s6U5D89lqVZB1Vz6BZKzy8YD9sLhQxUrjanUmnEmQ3j6/1pGIf97p9NXdOxB6SA0d7zBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8z+eXd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05C5C4CEDD;
	Thu,  3 Apr 2025 00:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743640200;
	bh=0rpRRm+wudgp9j5gCeJjoFbQd23fyrfAGsiG0Cto4JI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N8z+eXd2+xrvkCaPjigWKrumPeLwUg06RGYU0Nz0iuURs6xsA8DVDE3ml9mHckJNN
	 oQdKkx3sDTO6u+y1k7KY9JhW74mjfBPJCvS89mjgiM2QANDWlAhrguhYDJr/0M5uEQ
	 XD2vwWV6rOX3ukpsGlI8naXsUfIJkZ4t1brakspw5hxf6L/7YrcZMhH6V5i2TBul/u
	 urZ2edGIkbg1I8JEBGpEGLDss1fZiis3LSK/s41LxYQBKeIv60NlP1cVqvSKnC7Lvc
	 JJny1C1kGfrqFdodPT38tWExJpSLZX2ygKm+XfzOpe1cmlirnfhwhj1p+K7yjYaVVS
	 3l7LziD70ggig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFCB380CEE3;
	Thu,  3 Apr 2025 00:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] rtnetlink: Use register_pernet_subsys() in
 rtnl_net_debug_init().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174364023736.1731187.14723563439031304220.git-patchwork-notify@kernel.org>
Date: Thu, 03 Apr 2025 00:30:37 +0000
References: <20250401190716.70437-1-kuniyu@amazon.com>
In-Reply-To: <20250401190716.70437-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 1 Apr 2025 12:07:08 -0700 you wrote:
> rtnl_net_debug_init() registers rtnl_net_debug_net_ops by
> register_pernet_device() but calls unregister_pernet_subsys()
> in case register_netdevice_notifier() fails.
> 
> It corrupts pernet_list because first_device is updated in
> register_pernet_device() but not unregister_pernet_subsys().
> 
> [...]

Here is the summary with links:
  - [v2,net] rtnetlink: Use register_pernet_subsys() in rtnl_net_debug_init().
    https://git.kernel.org/netdev/net/c/1b7fdc702c03

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



