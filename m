Return-Path: <netdev+bounces-93155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8F68BA4F7
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 03:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 460AAB22A8A
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 01:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8992FF510;
	Fri,  3 May 2024 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duJJby7t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6211AD29E;
	Fri,  3 May 2024 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714700429; cv=none; b=OOTXapVbD0CmlMG5VOEkw6xstDBv9lHnYgAaWwAtpOrTsMA+MZJ/Cvz0xPwNJj/M2VEUhX/4/MOy6X6d2xZHzJouyNKxlI/b3uobs83ZhoweM818Jxxvq2h8Jn4gS8IPwux0VUfBTS/m6h70nHu5AdH4vfGj9eBGGqRML/RvrcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714700429; c=relaxed/simple;
	bh=jmkpeTsQ1AuKMN10QrNEHUyqRMYWoWGfbAdE9WTU3ec=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HbFg+f2LsspgLmHx3IKVnutrVOHc4aRNg1iKPaZtGK8AaftULtCGViugRFLLy4zFGtcyoyvLAv39K7SaN1ST9xac1tVa1e4sPQaZN2s2LqA9F84Lh9Zn3vX2v8XGnDzp0vY8sEeE+X+i6ICxxzfRt4CwF5PnDCp1cEMisohcMgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duJJby7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04061C4AF19;
	Fri,  3 May 2024 01:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714700429;
	bh=jmkpeTsQ1AuKMN10QrNEHUyqRMYWoWGfbAdE9WTU3ec=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=duJJby7tY00OjVBrJiEO8/m7ZI8/27n9s+m/vm97KvSAmym/clvgpF8sCqOk6HOev
	 WDe280ZHFgXP4WHpHCF434IYARNi5OSQjhjN6NPmqhehVdIQ9EnwsU9cYZWGJLfDcX
	 eSkBRgOWDJBHBOliKj8e6IlLcKfVXGpeLq1iGGwDb+w4GcxEaaEFBHuLkiQAwRCROm
	 KJjJxvfpGlf7PNar7J6Adhg2DMUUKRXN0SzfAohg01GGe70xYSKVII6t9mzc+dHqMs
	 dCALAYLy+gbCcDMTchaX2YMkUF41KT12FKGA47Gtwqp2yhPXIaSyDD8M5ppBuuWv/k
	 cRim+51QFRsWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E388EC43337;
	Fri,  3 May 2024 01:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net/mlx5e: flower: check for unsupported control
 flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171470042892.13840.5919764123089779271.git-patchwork-notify@kernel.org>
Date: Fri, 03 May 2024 01:40:28 +0000
References: <20240422152728.175677-1-ast@fiberby.net>
In-Reply-To: <20240422152728.175677-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@codeaurora.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com,
 tariqt@nvidia.com, leon@kernel.org, jianbol@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Apr 2024 15:27:27 +0000 you wrote:
> Use flow_rule_is_supp_control_flags() to reject filters
> with unsupported control flags.
> 
> In case any unsupported control flags are masked,
> flow_rule_is_supp_control_flags() sets a NL extended
> error message, and we return -EOPNOTSUPP.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net/mlx5e: flower: check for unsupported control flags
    https://git.kernel.org/netdev/net-next/c/3d549c382297

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



