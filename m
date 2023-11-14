Return-Path: <netdev+bounces-47603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DD97EA9E6
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 06:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA6E281017
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 05:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB80BBE66;
	Tue, 14 Nov 2023 05:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujliQ8O9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD472BE5D
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 05:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34C88C433C7;
	Tue, 14 Nov 2023 05:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699938025;
	bh=Mpe/XJM2p/8moJmeZAIpe8YtSZYyFy7SDrrVMk2OG2k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ujliQ8O9f03w36CY0xPf2ZqvDGNdT7KNNcrU1y/tl5jKBbNBjHDRk99iKNcwKDDrX
	 Vbaj0kjmlZZ/lYa23Z48sYdl4Snl3gQPPDMs1AA8PnoxJm/DgYJ5taXIpShfKjBts+
	 YlqYJgQzEHK8RIIlBUiMCJSqDYTEsVpRlUldMDFTahVOYS1/9MTtgFXeJZSfYad+MD
	 vOHEyvSDeeuLCeWrNz92XhkhGtMTm3bZ8ke3kGz3FIGav5GehxVQqcva4yAOPa+i1V
	 MRFWBMhnTPmqIcTyFy1IQlwQSb8q/SKIguzYmot9XowvTptCVkmYdeppAWDYgCPHSz
	 dfGWkuIfDIhQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16C92E1F674;
	Tue, 14 Nov 2023 05:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bonding: stop the device in bond_setup_by_slave()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169993802509.31854.16280617174199384750.git-patchwork-notify@kernel.org>
Date: Tue, 14 Nov 2023 05:00:25 +0000
References: <20231109180102.4085183-1-edumazet@google.com>
In-Reply-To: <20231109180102.4085183-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 j.vosburgh@gmail.com, andy@greyhouse.net, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Nov 2023 18:01:02 +0000 you wrote:
> Commit 9eed321cde22 ("net: lapbether: only support ethernet devices")
> has been able to keep syzbot away from net/lapb, until today.
> 
> In the following splat [1], the issue is that a lapbether device has
> been created on a bonding device without members. Then adding a non
> ARPHRD_ETHER member forced the bonding master to change its type.
> 
> [...]

Here is the summary with links:
  - [net] bonding: stop the device in bond_setup_by_slave()
    https://git.kernel.org/netdev/net/c/3cffa2ddc4d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



