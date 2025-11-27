Return-Path: <netdev+bounces-242117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25908C8C812
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 02:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9E4D1347DBA
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 01:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DE42BDC26;
	Thu, 27 Nov 2025 01:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBd6Ea76"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADE62BD5A7;
	Thu, 27 Nov 2025 01:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764205845; cv=none; b=LwVx5DVd9rTMgoZXA57U9U/4tew7fzgCex5jsgeEN6SSl25YYrMM+uif1IkBm0EWcA4Dg+Or0iniQNXrr9jn/Cwq3eSRB0K69yWBXcW55IjkuzNnq54U+n3CtGAFWtJ1OrYDy7wxZtLBf5cIdC6q/m+ZyCwFIMq42vyCFfNt9Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764205845; c=relaxed/simple;
	bh=x9eSrkvo9HWqJO0a8D9GatWYlj+5gHaUacsd3qhNlVQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Yz6mxC3issYcLfoYoPDNvEaSlEYUGlN6YSg7K9G8G16mGG1l8rBZvnaX4PGoeUc4teuCh88e+WoLl4tpPD4XDHgqpw6JYzapwSdLRlCcdYREQE0azJ5GotQGsBWrEW9wGaaImcFHe0JXqTwG7qXcTbUOPUjem2GeufghHyHZ5Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBd6Ea76; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D93C4CEF7;
	Thu, 27 Nov 2025 01:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764205844;
	bh=x9eSrkvo9HWqJO0a8D9GatWYlj+5gHaUacsd3qhNlVQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oBd6Ea76WA/BLUbwTvv/dgbAlqYpeCwlN1IOZiAWHQvVj3yu3wzCIRlZ70CWWet4o
	 bQfMw4SgTLNove280Kx+YHRYfGeJcVmr+gVfEegQNNudUa4OE+GyTGtB2pXAv/dFff
	 vbc59xoXfwLDGYdjqJH2AnM96oWc0/pi9AymXZ5L/taY2SKq+3uEL0LhDqH8MJiE4k
	 Z+r6mTgJxQE8FPWRejnzPybRpLfB3ABETDzJor9w3ahrUt/9NabBbvXQoSHaYidbPP
	 uebY+fmbrH3p2j5q4BAvIFZCzNqu4hygWoBOo2IToNcGdu0rgc8vP0y9EyAbriyF2v
	 trT1BQHWnLvYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFAD380CEF8;
	Thu, 27 Nov 2025 01:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: wwan: mhi: Keep modem name match with Foxconn
 T99W640
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176420580652.1907207.5420921012362760513.git-patchwork-notify@kernel.org>
Date: Thu, 27 Nov 2025 01:10:06 +0000
References: <20251125070900.33324-1-slark_xiao@163.com>
In-Reply-To: <20251125070900.33324-1-slark_xiao@163.com>
To: Slark Xiao <slark_xiao@163.com>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, mani@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Nov 2025 15:09:00 +0800 you wrote:
> Correct it since M.2 device T99W640 has updated from T99W515.
> We need to align it with MHI side otherwise this modem can't
> get the network.
> 
> Fixes: ae5a34264354 ("bus: mhi: host: pci_generic: Fix the modem name of Foxconn T99W640")
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: wwan: mhi: Keep modem name match with Foxconn T99W640
    https://git.kernel.org/netdev/net/c/4fcb8ab4a09b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



