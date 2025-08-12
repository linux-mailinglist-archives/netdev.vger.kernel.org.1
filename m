Return-Path: <netdev+bounces-212891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C494DB226EE
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 14:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F20505800
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3479F1E500C;
	Tue, 12 Aug 2025 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBtZY1al"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110241DF725
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 12:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755001903; cv=none; b=Gasxw1094Nok2fMidOa5qeeHCqEGmxgt110vHfRmb6QMLUwEjt3VmF+GlykVtM8yydgmCy+5oqM3CKMLNWGXvN4qmqBFvjWhpoay3LXtdJEmMtvQSPhOZw/1tX8EgrQCMephW2BnxlpbMUdgUs14+luYQAkoy+6o++hO/cQ7WJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755001903; c=relaxed/simple;
	bh=7kyVkRNivLxUXzpsxh0LXYhFyzXVW7F7dQFDfdiw1WQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TIyrKa3/DrQsBVRZBHwmymvYu3poTQo/beK3xmmxmnN969sbMcITlgydsHyIIKxCOlkfUIGSR0PKlxRfZM/wvujAyOjpHeCl4VtHadZRm4lESCE5IbPoL68+O1w0HOS++iBEGFTUtIlSrPOZB0ut0+orDLJsxHoj7vKDvlNKoKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBtZY1al; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93590C4CEF0;
	Tue, 12 Aug 2025 12:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755001902;
	bh=7kyVkRNivLxUXzpsxh0LXYhFyzXVW7F7dQFDfdiw1WQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BBtZY1al0j7O6aBtjQxEhh0zecxolwfljRXyrvnHoaUb+Ax2pKw+rCsSw9Vez1I1y
	 r+NZ+G6w6hw3CcciETSTDAY1bN7xfHei/OqV10/pOb0cV999ymlBb59DuPhNoqbAXX
	 ycozO9vR+kYH90k/Mcnmbn7YI+qX5PSJ/F1U4JLFNlReWaTFW4D0BkB3GS82S4NZzV
	 kIhBfCuo41xViCU2mCxxrqfqjLlDOBo5R1IWgD6Zpm+PpfmXlh0QWfziqW+aHlwuRX
	 i3kSND0xDCIuXpgm/Bw3zGuuej/+xlroF6l0K9Pptpv9MgspidZPSRBzk7wrs1E67n
	 ADu5rt+rLq/VQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADA3383BF51;
	Tue, 12 Aug 2025 12:31:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] docs: Fix name for net.ipv4.udp_child_hash_entries
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175500191475.2536290.3779497233548344974.git-patchwork-notify@kernel.org>
Date: Tue, 12 Aug 2025 12:31:54 +0000
References: <20250808185800.1189042-1-jordan@jrife.io>
In-Reply-To: <20250808185800.1189042-1-jordan@jrife.io>
To: Jordan Rife <jordan@jrife.io>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, kuniyu@google.com, corbet@lwn.net

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  8 Aug 2025 11:57:56 -0700 you wrote:
> udp_child_ehash_entries -> udp_child_hash_entries
> 
> v1 -> v2: Target net instead of net-next (Kuniyuki)
> 
> Fixes: 9804985bf27f ("udp: Introduce optional per-netns hash table.")
> Signed-off-by: Jordan Rife <jordan@jrife.io>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> 
> [...]

Here is the summary with links:
  - [v2,net] docs: Fix name for net.ipv4.udp_child_hash_entries
    https://git.kernel.org/netdev/net/c/e93f7af14822

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



