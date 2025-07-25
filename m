Return-Path: <netdev+bounces-210222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59656B126C9
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 00:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1076517E5BF
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 22:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4893B25A334;
	Fri, 25 Jul 2025 22:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqWRSD8u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207C4258CE8;
	Fri, 25 Jul 2025 22:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481846; cv=none; b=GAgy5hlFgQbmBkkJ26bj8iyiQ6SGI7tMQBwxPsxJA2b46ANxKtaCuuNx+XBh/wKxcBNw2qu/4DjyKtw3hEVdzIVKe2q7KcnzRWpHxkRQKSjtJz9GEIdDszI5sCEoLaktIel6mp+sKRo1O1Kq7txRRgzVmvMnX66UtOp4rbZoNOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481846; c=relaxed/simple;
	bh=VYMoYS/1iT5rgF+lhb8IwNeZqybszJXxamR5pK1LyxU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N8aGXv/3QU3ToHiYLQw9ohA8VWb6e1d6ADyyw4wnATD6NZ3HQTVjLnxDV0RSRAQreKhuUccfU3YNt/rFSUfcwYasfJMcwYhieoovJBOGjWniLS0jZbIy1G1+brEG3S8wIIdD/Sx805ukAd2ds4nzhVRl20sj1IeLE1XdxMJZWJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqWRSD8u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7C8C4CEEF;
	Fri, 25 Jul 2025 22:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753481846;
	bh=VYMoYS/1iT5rgF+lhb8IwNeZqybszJXxamR5pK1LyxU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KqWRSD8uTeZX5rwzQS36rpIedd0gaY/RDQAffDqWK5WVaN1BjiG9p11MTFLCtJY/h
	 0rtUl4Ur87XuH5fuDecMuabeOG6Gh4j9xh8G8mGBYqCZ8Gu9CwukUNZKo1utjS3zGn
	 vgANeaUsBjNAba6wdFgChh5yGz7vdTpeYWlRxjJvpHInyXHWPWxQeU1wCGwKI57nTn
	 cI/un3DP2dBpOabZ8uVw/I4cXvgxoAO/sHnLYvF1F2rVJKgwcC96uoTisOS5w6JqkT
	 Pd3fxv+k3reFqfGVEXFZXSiOmFlBqrsflnqFv8fKwrBSBBqUGtXWYNPJ33agOS97LB
	 jYMnyENwcE7/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCC3383BF5B;
	Fri, 25 Jul 2025 22:17:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/5] netconsole: reuse netpoll_parse_ip_addr
 in
 configfs helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175348186324.3265195.8269858440980471423.git-patchwork-notify@kernel.org>
Date: Fri, 25 Jul 2025 22:17:43 +0000
References: <20250723-netconsole_ref-v3-0-8be9b24e4a99@debian.org>
In-Reply-To: <20250723-netconsole_ref-v3-0-8be9b24e4a99@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Jul 2025 10:20:28 -0700 you wrote:
> This patchset refactors the IP address parsing logic in the netconsole
> driver to eliminate code duplication and improve maintainability. The
> changes centralize IPv4 and IPv6 address parsing into a single function
> (netpoll_parse_ip_addr). For that, it needs to teach
> netpoll_parse_ip_addr() to handle strings with newlines, which is the
> type of string coming from configfs.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/5] netpoll: Remove unused fields from inet_addr union
    https://git.kernel.org/netdev/net-next/c/33360f2508e0
  - [net-next,v3,2/5] netconsole: move netpoll_parse_ip_addr() earlier for reuse
    (no matching commit)
  - [net-next,v3,3/5] netconsole: add support for strings with new line in netpoll_parse_ip_addr
    (no matching commit)
  - [net-next,v3,4/5] netconsole: use netpoll_parse_ip_addr in local_ip_store
    (no matching commit)
  - [net-next,v3,5/5] netconsole: use netpoll_parse_ip_addr in local_ip_store
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



