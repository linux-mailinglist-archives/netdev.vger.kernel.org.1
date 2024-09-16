Return-Path: <netdev+bounces-128597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A968397A822
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 22:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BAF91F22811
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 20:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08D316087B;
	Mon, 16 Sep 2024 20:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2I/J1tE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EC015EFA0;
	Mon, 16 Sep 2024 20:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726517430; cv=none; b=Q3orE2txitf/XV8082ln9967lkNXP1CgZowPPr5APiAmKfbI4MN7QUkBWsWC0jrfpGUbmVAz5qBNSlhaQfuSp89s/yPirRHbUisp3okEdFC5dqcjf680jD1B3zcpTrks9e6/7OfsRCADUI2j7p6BUnHSHDtM+QLo8cA3CinXJ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726517430; c=relaxed/simple;
	bh=TWaoST9YqXw/APpJJuJ57H+mU+KLsgnQjE2tpUzI7DI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uubKzSYRmGUpylhfpSXIs/QLJVQy+vDGKxbUQlOxeiI5MV/un4/UCrgmbNjquq9BA0Fb3yaZsn84xaF6Uj0Vb6Hkm/gcNnZof5CNk9kMKzFLvdHzLMQzqtpuMya+/DvtHcsXy3VVWUZyH4YQA8N95v+aANpFOpy3gBkuY53einI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2I/J1tE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DBFC4CED5;
	Mon, 16 Sep 2024 20:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726517430;
	bh=TWaoST9YqXw/APpJJuJ57H+mU+KLsgnQjE2tpUzI7DI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S2I/J1tEU5CGIZHHE1NMyQ44XxO9toOQgU1M4SRq2ZU+zQfFzBN8eQwtadk6MBwiH
	 Jp/hligHnvsufMiDT6umKY8dVdkj0HpZc6aDZZ8GW6FaBrtKYUVgvnUHcu6kWQ+K7p
	 wJ1Pa4fIi2+Qz0cZ3pBDEkUV+HZCAwi3wqp3H2lP5vru2Hm+VaADQhaxdeYzflAniI
	 /XA58abz77Mw8o05f6B9mhbskCDzo9JFWQtrrSqrG220I6u4m03LUa1F/gEw2CyGPz
	 EmM8wBIsnRIGxQJzP8/btsxeSazXnKK+X7qbgTPR2N+GUZE2L2coNtKpT010TpIf3c
	 gnJJa2TyT8/gw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C6F3806644;
	Mon, 16 Sep 2024 20:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH ethtool-next v2] ethtool: Add missing clause 33 PSE manual
 description
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172651743176.3804981.2392553287465994474.git-patchwork-notify@kernel.org>
Date: Mon, 16 Sep 2024 20:10:31 +0000
References: <20240911-fix_missing_doc-v2-1-e2eade6886b9@bootlin.com>
In-Reply-To: <20240911-fix_missing_doc-v2-1-e2eade6886b9@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: o.rempel@pengutronix.de, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, mkubecek@suse.cz,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to ethtool/ethtool.git (master)
by Michal Kubecek <mkubecek@suse.cz>:

On Wed, 11 Sep 2024 14:22:04 +0200 you wrote:
> Add missing descriptions for clause 33 options and return values for
> the show-pse and set-pse commands.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> Changes in v2:
> - Rebase on top of ethtool-next
> - Link to v1: https://lore.kernel.org/r/20240520-fix_missing_doc-v1-1-965c7debfc0e@bootlin.com
> 
> [...]

Here is the summary with links:
  - [ethtool-next,v2] ethtool: Add missing clause 33 PSE manual description
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=feea0011ff04

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



