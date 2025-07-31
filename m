Return-Path: <netdev+bounces-211247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE003B175E4
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 19:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A92E1C24D19
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 18:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56991D799D;
	Thu, 31 Jul 2025 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ol+HRFuw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12CB101EE
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753984792; cv=none; b=A+lhAZLDsF057Zt5PzQ4igRS1x8UPt4fVEekjRB7OegyTbFchio9Ii4cAkitxO3jUqUs8LvubSuEU/kpX04Q95JzSWBCC9GIO9yh0fH2EQzzRtoaXeHV3Ut8Jh2vtyWCpWt8aYeI9CudOqTENqCTSDIvDLRzOSuDi1KrnihXelM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753984792; c=relaxed/simple;
	bh=TW+7gn5UMtH6UQwbYIUcNe/IlAkYX/xro6rFsRDleXs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kUUxiADUarZmwvBsq8t+en8E4ghnN+lwECziR4XMWfwFxMBs4jEFd4eCIOeTjRD+RwIGK3LrclE9HhBUdPWuLUVgMyBTQKnshnXmksIBFyNaAr9fWzUNgcNIfRNqwD6FewufB6efhaM63W5Zd/KETvMeTNUDvso74KOUjO4E64g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ol+HRFuw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8F3C4CEEF;
	Thu, 31 Jul 2025 17:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753984792;
	bh=TW+7gn5UMtH6UQwbYIUcNe/IlAkYX/xro6rFsRDleXs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ol+HRFuwrTfm2gjt8hpMJt6DB7XpJMsCruv4MxhU0ipIzfjueEfKxK1uBFja1nM2P
	 cc3OVT7INW42+ndXbviI06zCClpDS/NW9ZJXuvTr57sjqU3ydWZUSgeIGcKRLLxKwd
	 zE1Q7LPzS/LdFJ9T+7yxO7IUKAUcy6lEmo6VFVibGPpheyq1bxEJVig8NcY5AAJXfe
	 JydkOC2nNR7iKx45ghJLSfV+g3bbXWWVMpAVCS7VTgr5d3MHpkHITVbqxNvolQ105W
	 +Lgn88s/vfoJCKbPYLRQBZwtMdK/b98FsFI85fIisdGjSQPALKbHvsWh0oV+4RVElF
	 OH4TZMqP/RFyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5AF21383BF51;
	Thu, 31 Jul 2025 18:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netlink: specs: ethtool: fix module EEPROM
 input/output
 arguments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175398480826.3234382.15856806798473352595.git-patchwork-notify@kernel.org>
Date: Thu, 31 Jul 2025 18:00:08 +0000
References: <20250730172137.1322351-1-kuba@kernel.org>
In-Reply-To: <20250730172137.1322351-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, duo@meta.com,
 andrew@lunn.ch, donald.hunter@gmail.com, kory.maincent@bootlin.com,
 sdf@fomichev.me

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Jul 2025 10:21:37 -0700 you wrote:
> Module (SFP) eeprom GET has a lot of input params, they are all
> mistakenly listed as output in the spec. Looks like kernel doesn't
> output them at all. Correct what are the inputs and what the outputs.
> 
> Reported-by: Duo Yi <duo@meta.com>
> Fixes: a353318ebf24 ("tools: ynl: populate most of the ethtool spec")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] netlink: specs: ethtool: fix module EEPROM input/output arguments
    https://git.kernel.org/netdev/net/c/010510128873

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



