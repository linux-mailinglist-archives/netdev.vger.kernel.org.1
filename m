Return-Path: <netdev+bounces-109822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B90C92A05A
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 12:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A3DFB221F5
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 10:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A657A73466;
	Mon,  8 Jul 2024 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sP6eNBHd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824421DA303
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720435238; cv=none; b=pjHFCIqkBe3ljd4Ll9cf90JeEajSVy7Ai0RAtutE3Bht/eeH9JSbaC9L28/DVLRlkBLuro2zBXPOwS6AeN69GlMJfpOZqA5JfTzbh7vPTLP5P2jh2rekdL0x1rZoqsIVBQH0T4pcP0P+Xw2STbhrkKpY+a/mYCALNpoyxiJxcWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720435238; c=relaxed/simple;
	bh=TwyqGEbEah6wr693P/eeV8pbj6nP7SA4+c1vYBhPLKM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jmdXwObPtz+zrfkwcIZ0WpuORVEtuA+To7ayD9JiIH9M6G0E97ncgQjV5t3kDBJpb8nOS/puOzRAHAG/w960H0uKewRLjR03/Ej8uy0DcwWMX8q1AhNPwiCyvPGmUPkYrojdhpxF5PWjotiYn+q3IGaXAtsRPJfnIdeq5xv3QLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sP6eNBHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03A81C4AF0C;
	Mon,  8 Jul 2024 10:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720435238;
	bh=TwyqGEbEah6wr693P/eeV8pbj6nP7SA4+c1vYBhPLKM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sP6eNBHdIfUNDPKM87T2jp7UC9JlIKIegMzzzLqxoPVGqY9gktGGv/9tAqXliqZI0
	 2DuRXmlgAhib4BqWEZp5OJrdZCF31ETt7mk+VYsB3ipmFTQMCZBarZLDz4GMwI0sqt
	 664Vq9FccViWWKkRpZbxdf/MPHXZwTcyqfeyRTDExTfOT9ZA/n9i9+K4kGkIsxartb
	 doiKIE2AVskRKzX1sutdyr0c8AToL6C9b3crpojOA2eaDv4MidJ7ZNQd9i6/xgM/AO
	 YDxBgDdGzF4Ge/Z5aovjq7IoUoO6ERxv7RVcS9cBB5Isl8Q+jrtRZFAVuqUy2HGytQ
	 4xLdW7GfezpFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5AC8C433E9;
	Mon,  8 Jul 2024 10:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] act_ct: prepare for stolen verdict coming from
 conntrack and nat engine
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172043523793.15535.16260128007636220181.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jul 2024 10:40:37 +0000
References: <20240704112925.10975-1-fw@strlen.de>
In-Reply-To: <20240704112925.10975-1-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jhs@mojatatu.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  4 Jul 2024 13:29:20 +0200 you wrote:
> At this time, conntrack either returns NF_ACCEPT or NF_DROP.
> To improve debuging it would be nice to be able to replace NF_DROP verdict
> with NF_DROP_REASON() helper,
> 
> This helper releases the skb instantly (so drop_monitor can pinpoint
> exact location) and returns NF_STOLEN.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] act_ct: prepare for stolen verdict coming from conntrack and nat engine
    https://git.kernel.org/netdev/net-next/c/3abbd7ed8b76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



