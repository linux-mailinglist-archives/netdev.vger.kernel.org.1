Return-Path: <netdev+bounces-40916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE49F7C91C4
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 02:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EA84B20A97
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 00:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64AC36B;
	Sat, 14 Oct 2023 00:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ifr/MwTx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAD810F2
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 00:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A0CDC433C8;
	Sat, 14 Oct 2023 00:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697243425;
	bh=XZMOD5vnW+mQkNK21vhFVlWiCU0lLa2pLsyNjm+MdlU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ifr/MwTx8Js3DkPnrVE6lbw6mwPDBv/dBrq7BsQiRb4onQvYkic5aJCS+pTuVsfx4
	 g8X+UnVWC+92KzXP/E8J9QrHHVCRqihI4kLa6o90hihsMuwEqiqwDnIczYukqwnpCZ
	 uq5bKcq2eEx4+iEn3NtSFI9v3dYIRvGB1Q9Iupv2QLq8wexdUxrdJzEsJvGP2EmHYp
	 gdzwNnxsqIgeIjZAs2RAYBpN1HRxRSFqF8zQOgLL82Sz/Wh+DsrMK+ANeu7LWi8Uzb
	 nLS837jw8MZllpj0Wk0755i1Zqtdfj5tKQgoIWYjnNGVpUVoZvfnCiZfRF4bhAko0I
	 msPY3RcR/d7bA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F3A4EC73FEA;
	Sat, 14 Oct 2023 00:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net] netlink: specs: devlink: fix reply command values
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169724342499.24435.14540231141700742716.git-patchwork-notify@kernel.org>
Date: Sat, 14 Oct 2023 00:30:24 +0000
References: <20231012115811.298129-1-jiri@resnulli.us>
In-Reply-To: <20231012115811.298129-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Oct 2023 13:58:11 +0200 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Make sure that the command values used for replies are correct. This is
> only affecting generated userspace helpers, no change on kernel code.
> 
> Fixes: 7199c86247e9 ("netlink: specs: devlink: add commands that do per-instance dump")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net] netlink: specs: devlink: fix reply command values
    https://git.kernel.org/netdev/net/c/0f4d44f6ee04

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



