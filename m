Return-Path: <netdev+bounces-249277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E77CD1678B
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 04:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B9923031A33
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 03:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E9B305968;
	Tue, 13 Jan 2026 03:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pO8eJiMa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA972F12C9;
	Tue, 13 Jan 2026 03:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768274614; cv=none; b=F3bTqN1tbj7FWNcHLf33VDK0ZJVu/bu8X9JbjwsJGbyGCsj8CvTcug9udRzkUCl/R5dJzn4cSCVkOFdQPRoaN4p8eilaf3wJJk9A+MpKqlY6AZrGhxnPUl8Kz87c5ALM62BN0UU+WPhJvDl2r2r1eC7NHPR2X+0M5Wa7mQKjZ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768274614; c=relaxed/simple;
	bh=AH+DpXBr7U60NJlcyjT/ElKt1g2jAD5EfrI1qnS/vWY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ChgxocYYXSRZLu7SQ9/0dYQO3NFE10Y4D0h/3C/36Bx4rCeExbTE69GWlgDG4DVL8MpivsyZd+IT+x3z2GwexUxjqBT9gmNgyNr7VKwplZd8bAzYWim9S4ECwIET7jEjUbOcT6FHW1HX3aBjuCxkGesmjWjjVHUeSF/vu0lOv7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pO8eJiMa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7E3C116D0;
	Tue, 13 Jan 2026 03:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768274614;
	bh=AH+DpXBr7U60NJlcyjT/ElKt1g2jAD5EfrI1qnS/vWY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pO8eJiMa0nFYQT0xOBklFyEAGyVYSriJduglk52fsVsk2u+hl2r+9UAHOKUjLmSmE
	 +zzjYlHqbkb9SFFS2/ytD6hUltm2uBFYO0O0cVnk6+S94tbuoVOSDxIj9DQFMEgzI/
	 GXWbDUvOXcwHQ8uwMjIJUG+PSoKjgDQWAdGoW+fHxF2bJMkJh31f7Y75Em1bivre+q
	 z3l5QFcK4etBf4QigkDJpECIblTD+3VEw+pwnyD9cpJAoWK/vXVoX9jCg5ci/pCZPj
	 h7Leb6arap8Rgw2aR0nzUsC+pcHjDQP5gtH82CayNfMu08XU95l6A7WGAZOS+L6g4w
	 GBUx2UOaKpnMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78AEB380CFE0;
	Tue, 13 Jan 2026 03:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: ipconfig: Remove outdated comment and
 indent
 code block
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176827440828.1656603.11973087780237617552.git-patchwork-notify@kernel.org>
Date: Tue, 13 Jan 2026 03:20:08 +0000
References: <20260109121128.170020-2-thorsten.blum@linux.dev>
In-Reply-To: <20260109121128.170020-2-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  9 Jan 2026 13:11:29 +0100 you wrote:
> The comment has been around ever since commit 1da177e4c3f4
> ("Linux-2.6.12-rc2") and can be removed. Remove it and indent the code
> block accordingly.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Move const definition to the top (Paolo)
> - Format ternary expression
> - Link to v1: https://lore.kernel.org/lkml/20251220130335.77220-1-thorsten.blum@linux.dev/
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: ipconfig: Remove outdated comment and indent code block
    https://git.kernel.org/netdev/net-next/c/e405b3c9d4aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



