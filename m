Return-Path: <netdev+bounces-199242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83978ADF89B
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 23:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF411BC26F5
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 21:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4718B27C869;
	Wed, 18 Jun 2025 21:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgMmNOBF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2510927BF6C
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 21:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750281586; cv=none; b=MEFQeHNQC19eK50+AU/DmCguocWRAz0th7LTZ/h28Xw3tNer9a8ICvWeqkI3SxyImeCcmvKOFzebcqUhErfknW1WaA42PZi6+Ey0mRa3LisQ7I5WABm3mgq6MVfso562w3tcLRCSu+9J9t5ZwxzJ9+EpQ208+/ZA00LOtImcU8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750281586; c=relaxed/simple;
	bh=Q6F0/gstujOBR2H+GRqMb8Rdlx2nqtOKJA8vOSO/c70=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EmHksl51AzZgU1zokPzii2UOcwT32fYb3j6uIB60lCqWAaaQg3F1yFvvZTc3W1++VUgUw+V1MbtYbPhnqAznW43UpuQUVu7mBC9by81tqdUqE+Ymw3eLZzpapU2Lg7dd0b4exanLB1ppZPzJ+ojH63vkq7fQLajsLLJJhZTlxx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgMmNOBF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC614C4CEED;
	Wed, 18 Jun 2025 21:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750281586;
	bh=Q6F0/gstujOBR2H+GRqMb8Rdlx2nqtOKJA8vOSO/c70=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MgMmNOBF3B+bKZPYYvkdaFALq2KQz8EWRWA0fHucI2Uje7EdlwOHJU8yb/o414xoC
	 3rF+gRqm420aaYByDmCAHADjEZXkHHOBCPhAIfCMwUhkyXwG8asmoXKz66KSXiQWjN
	 d/956RD2+1jNeim2tpiZYHdMOTORyxOHYvdZqgHqGBYLypSb/eKhqt1oTQt9fPPnHJ
	 vQYTuNSHQLHMIdIq1FaIOfxlJdBhF6cvYvkrH/XG0k/oN6YJ1+SvLm/D81orgO1Jgr
	 1lG51pKeaojl9FGRspb3ljNfXr4H+MJk2zsL9JfLhsY1z98JfMjBmnLVjqZMxzjmXb
	 VbdbDsRZQTRmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DAC3806649;
	Wed, 18 Jun 2025 21:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethtool: remove duplicate defines for family
 info
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175028161423.259999.16892783191350498992.git-patchwork-notify@kernel.org>
Date: Wed, 18 Jun 2025 21:20:14 +0000
References: <20250617202240.811179-1-kuba@kernel.org>
In-Reply-To: <20250617202240.811179-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
 donald.hunter@gmail.com, kory.maincent@bootlin.com, sdf@fomichev.me

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Jun 2025 13:22:40 -0700 you wrote:
> Commit under fixes switched to uAPI generation from the YAML
> spec. A number of custom defines were left behind, mostly
> for commands very hard to express in YAML spec.
> 
> Among what was left behind was the name and version of
> the generic netlink family. Problem is that the codegen
> always outputs those values so we ended up with a duplicated,
> differently named set of defines.
> 
> [...]

Here is the summary with links:
  - [net] net: ethtool: remove duplicate defines for family info
    https://git.kernel.org/netdev/net/c/c6d732c38f93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



