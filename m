Return-Path: <netdev+bounces-108138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2381391DFE4
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 14:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 549961C2087B
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 12:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A3215A4B7;
	Mon,  1 Jul 2024 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltb46GSr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84290145B09
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719838231; cv=none; b=P4565x0IUtD5N9824deBMBg+b0SSNXXx1wUc6ImxlDjHD936OJdb67OV9vEA4PZeqXsihl10d9PvpLWV2EpEcq3xaTcbWZnec4By8W5+k7OUqFiPtPNXJcSTG1wqSP2vMhLJJ4ANwWQI5l1SmsQ65x7U1vTSWnZ/ZoXwY585Ys8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719838231; c=relaxed/simple;
	bh=dLPgFLX+t8l8xPmZqxBwyjqtRFsouZt41GGM9I9BoAs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bIqnmsFL7j9UJ8ytbVyOcnMuezN6wk+fsvsSxzwMNkFsOpYdyQzsyjF/JrvHJEDvDHZM+dR/WXC1BpRD3lD0X0+y/maPYwk47mpJYA846fLmFaqm9JG8NL9icyl5rHMqkAR3wYX/qMcTNEQp4NopU5Bf5jzH6fO0D9tii58lgA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltb46GSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 491C8C4AF0E;
	Mon,  1 Jul 2024 12:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719838230;
	bh=dLPgFLX+t8l8xPmZqxBwyjqtRFsouZt41GGM9I9BoAs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ltb46GSrzch9r9QDqfUqHY+bhT3AAwbmgvcWKzGruSBD5EL+wx5QKBoICrDaaH/v9
	 XgchiZjybWutyaUQcK7e+drCBNte+FknE85ClWaKEAQelCnb93Th5SOKpAD2cTosF/
	 XSZiHt2NykpnUD9RmZesBA1230ez5QhoIC8jKmw1C6gRb4rUW5AcPGUi86e02MpCo9
	 XkUm3IkhRDeDKI/O/BfVsWWvpSLLFlEc8bJF4rTQgsAtb/y2F8BM3E7f1gQd8g3QEM
	 BUceUvVGlTpXPU/qMzs+ta80lirxbbTSiUOSnhMEH8JKUAUdOZvChnwO7QyjT2wRo/
	 tEoinYjcyDOeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C885C43339;
	Mon,  1 Jul 2024 12:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND net-next] net: ethtool: Fix the panic caused by dev
 being null when dumping coalesce
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171983823024.2563.3703181588792436256.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jul 2024 12:50:30 +0000
References: <20240628044018.73885-1-hengqi@linux.alibaba.com>
In-Reply-To: <20240628044018.73885-1-hengqi@linux.alibaba.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, pabeni@redhat.com, vladimir.oltean@nxp.com,
 jiri@resnulli.us, horms@kernel.org,
 syzbot+e77327e34cdc8c36b7d3@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 28 Jun 2024 12:40:18 +0800 you wrote:
> syzbot reported a general protection fault caused by a null pointer
> dereference in coalesce_fill_reply(). The issue occurs when req_base->dev
> is null, leading to an invalid memory access.
> 
> This panic occurs if dumping coalesce when no device name is specified.
> 
> Fixes: f750dfe825b9 ("ethtool: provide customized dim profile management")
> Reported-by: syzbot+e77327e34cdc8c36b7d3@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e77327e34cdc8c36b7d3
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> 
> [...]

Here is the summary with links:
  - [RESEND,net-next] net: ethtool: Fix the panic caused by dev being null when dumping coalesce
    https://git.kernel.org/netdev/net-next/c/74d6529b78f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



