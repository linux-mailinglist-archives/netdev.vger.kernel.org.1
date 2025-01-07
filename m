Return-Path: <netdev+bounces-155836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64559A04032
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877AA18865C3
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 13:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DF51F03FF;
	Tue,  7 Jan 2025 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ID79jsEM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785761EBFE4
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254814; cv=none; b=RTe0xQLUh4VP2f5e0CfGg5iyLtrtjl6ohTCVY/BHJkB4PkkLhRGX2zN0Q98/9gbhQeXQStjuQ5Vt2+fkpf7DHmRnsyittPsz9kfJOGnUJD7bqzA9BboUVCjx3m5irjMz5JlpjDCGZWKrl/jHUGda/Pa/xeKVSWvtg8ZCUT9y5uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254814; c=relaxed/simple;
	bh=a5wjFIMwWn81YhTQOmIDYDiQTEULQO9n4sq+/WTvU2Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jMAnThbBhLuzmmLSjn8TUmkcs9mSbOwPVDoxkkyRlEhvLtiwwa/WVKSIwR43ApLu1n3HJ6Ow41fsUmnQaNtNilPa4QA+6knRrq2MGEbz24cnvD/oNGqwSQO4h7egDyjyb66bstw1Ywm1VpHKv92X88zfeLSM25WNf4gecV2ROdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ID79jsEM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D6EC4CEE1;
	Tue,  7 Jan 2025 13:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736254814;
	bh=a5wjFIMwWn81YhTQOmIDYDiQTEULQO9n4sq+/WTvU2Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ID79jsEMe76HXvBnxjjsJhxULFx0Dxwnmey18axwt3RM5uiQqyR3ZK/QN/3RxgqSl
	 fQFbdlpVTjw1RPFEAjRAh7vNyNzRWeoTvbRZ2L2kuQZilBgeWjkMTe1k268SZ9Wbpt
	 cXKJMl4uvliZ5waS5PzFMgisn1EBARW7UxgN+8/3AsjLQasSF90Ea1wdykgRjdFTfV
	 m+B+quMQRQhS9lCfsiWnvk5Kqe7307ucGqGk7Lvck/sZBIkh/InCupUWjaBh/RAM6d
	 gKwL0HUhR4BwGwn37xpw8VE0eS1NI6kXZTBkcegryfRubZPjakrOyiIUxG7Xzipv6V
	 hTmKr5BJJwuEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F9E380A97E;
	Tue,  7 Jan 2025 13:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 1/2] rtnetlink: Add rtnl_net_lock_killable().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173625483527.4147227.17799564662817026241.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jan 2025 13:00:35 +0000
References: <20250104082149.48493-2-kuniyu@amazon.com>
In-Reply-To: <20250104082149.48493-2-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 4 Jan 2025 17:21:48 +0900 you wrote:
> rtnl_lock_killable() is used only in register_netdev()
> and will be converted to per-netns RTNL.
> 
> Let's unexport it and add the corresponding helper.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> [...]

Here is the summary with links:
  - [v1,net-next,1/2] rtnetlink: Add rtnl_net_lock_killable().
    https://git.kernel.org/netdev/net-next/c/7bd72a4aa226
  - [v1,net-next,2/2] dev: Hold per-netns RTNL in (un)?register_netdev().
    https://git.kernel.org/netdev/net-next/c/00fb9823939e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



