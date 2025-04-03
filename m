Return-Path: <netdev+bounces-179205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 789F6A7B1FC
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 00:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0A3A189AB2D
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 22:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8001E8351;
	Thu,  3 Apr 2025 22:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CA60vHK7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680F61E7C01
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 22:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743718803; cv=none; b=S5CVFnkoB2+ye7MIFmWq9yfHgrXVy85AVcwojEtQ81M5Ek3Z8hEqLTegNTQy/hxXnKiFX/YcSGNXgfAemSifb6F0f42njTp2c6aBDCaoTNbOXqioyooAhcTg5fzPwzueM9zSGEAiN5cAmHxWJHG3dj2Ea3urq17jEZZPW2H85qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743718803; c=relaxed/simple;
	bh=rSAnTxcjBcLSFN50gW5YrU941og66JkBOAEm0xtRkNg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o/HsPcHCm4ItDRY+29GD+PW0fQ/Tvljur2OkJRn16p8A7DfVppNLBNK0m+DPxGDE/fM2CiUgcRas2Cg0jsM3xVWI06F+taWa/+62DV3ZVo//5Xh4pQi5EhxQGoDQRHdt2D6/mCzHmSjAnw+XdlIgFHMqqe+4InO15vLEfdFu65c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CA60vHK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A788C4CEE3;
	Thu,  3 Apr 2025 22:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743718803;
	bh=rSAnTxcjBcLSFN50gW5YrU941og66JkBOAEm0xtRkNg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CA60vHK7AG3sI1Zb/3r+GAkr2/yQ+MGMyoIuqJ8KabBQwN6ui0ieef/nk4wskWSPX
	 4ksODe+DS0Siyef9TmWZV5NjQXdi5pLCdxlC7j8vVrNWX2JA7ccS+EA8z0PFQnxZrV
	 voBt61KFCSJwv+xNUaQ5OBybLlqCyh0CbWWcziyRoY3FBkfDMfLrNU57/hsCFy74nj
	 Qi3sFmuci0/aFawDAVE401ln0DHDS/GswULDmQsko6U7aavHtbf4cxZ5fB2rG4+oW9
	 dIAg/GOjeNnpxewL8+LL5oMiZRY5qtvfhbTVgQfnWCzA1Dqrg5CKEhxWKbZifNDnIc
	 31DzYkn+6jQWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71771380664C;
	Thu,  3 Apr 2025 22:20:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ipv6: fix omitted netlink attributes when using
 RTEXT_FILTER_SKIP_STATS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174371883999.2702664.13276567361004177734.git-patchwork-notify@kernel.org>
Date: Thu, 03 Apr 2025 22:20:39 +0000
References: <20250402121751.3108-1-ffmancera@riseup.net>
In-Reply-To: <20250402121751.3108-1-ffmancera@riseup.net>
To: Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Apr 2025 14:17:51 +0200 you wrote:
> Using RTEXT_FILTER_SKIP_STATS is incorrectly skipping non-stats IPv6
> netlink attributes on link dump. This causes issues on userspace tools,
> e.g iproute2 is not rendering address generation mode as it should due
> to missing netlink attribute.
> 
> Move the filling of IFLA_INET6_STATS and IFLA_INET6_ICMP6STATS to a
> helper function guarded by a flag check to avoid hitting the same
> situation in the future.
> 
> [...]

Here is the summary with links:
  - [net,v2] ipv6: fix omitted netlink attributes when using RTEXT_FILTER_SKIP_STATS
    https://git.kernel.org/netdev/net/c/7ac6ea4a3e08

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



