Return-Path: <netdev+bounces-62557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BA0827D4F
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 04:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98CC1F241B5
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 03:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3566D6CE;
	Tue,  9 Jan 2024 03:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsZJnOF6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C8B257B
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 03:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6D30C433C7;
	Tue,  9 Jan 2024 03:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704770424;
	bh=F59cwRdWlizTojxE0CXCUbHxlkmnPNkgk6VUhWXvz5A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TsZJnOF6IBABD1E6gM7kD6sl35oR+PBWFRT04V7mGGgU81siSTdmnnJGoGMwdSuVr
	 dhuDcNrwXVFTHOG8N3Cl5HBCi4JOHbUS4jP9jpPTEEQHt9NWRZoIK/Kki9HXT7t1xD
	 kMFIf8cVwn3prUVLRMrNgVPhVMfc2+dc81mdcbvjfaW7rEgxIV/NA6XnH1gykiQcUz
	 C12G0A6W/ptsL4yyguJvjXfTXRpFBUfsD86vHjU19i11sHqejEgdlj0RsaxY/99++9
	 ZbB+/1MMS0aqo0urbruDM0oNEJzICkAXg+3QcRCYM7ZSIkNmKIqk7fOf4XkmOvMdYu
	 MTjWsar3Qdjhw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A7716DFC690;
	Tue,  9 Jan 2024 03:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: Revert no longer abort SYN_SENT when receiving
 some ICMP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170477042468.7389.10437753587986940246.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jan 2024 03:20:24 +0000
References: <14459261ea9f9c7d7dfb28eb004ce8734fa83ade.1704185904.git.leonro@nvidia.com>
In-Reply-To: <14459261ea9f9c7d7dfb28eb004ce8734fa83ade.1704185904.git.leonro@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, skagan@nvidia.com,
 netdev@vger.kernel.org, bagasdotme@gmail.com, regressions@leemhuis.info

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Jan 2024 11:00:57 +0200 you wrote:
> From: Shachar Kagan <skagan@nvidia.com>
> 
> This reverts commit 0a8de364ff7a14558e9676f424283148110384d6.
> 
> Shachar reported that Vagrant (https://www.vagrantup.com/), which is
> very popular tool to manage fleet of VMs stopped to work after commit
> citied in Fixes line.
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: Revert no longer abort SYN_SENT when receiving some ICMP
    https://git.kernel.org/netdev/net-next/c/b59db45d7eba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



