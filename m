Return-Path: <netdev+bounces-50607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E66E7F649D
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 18:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2E26B20BE3
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 17:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF923FB2F;
	Thu, 23 Nov 2023 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrrtA6Va"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4ED3FB25
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 17:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AE0AC433CC;
	Thu, 23 Nov 2023 17:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700758826;
	bh=jU3yjjK+C7uoQo0aJ1vlyqflWtgIM68+Dlw/1RQZqcs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TrrtA6VaE/iO5ppEqJV+qatGb2mb1/Lngcxac+MleUei52yF0bOLTuzrg8tIWO11l
	 YlPRxyPZZyfubFaDcrihBM42sXP4SDXbvDwSuij9KOQ66li39HlMUn9dDkgeXgw2FI
	 jzmW86UovRB0gSMI/a2dS9xBT/8P/dDzVx3jNyXttqKtqvtqkEhJ/kOg4qVv+7B7C4
	 m3AI8i8biwq3oVJLlC4Zsj0Ihg6STCWuDfGhzrjUHEBk4sFf60yKy3VrE1/+sjIyYl
	 eHY8allaHyX0FIiq8EsPsE1L5/qubfOoBNxVvjLAjaD8JuBoUbid8qznzefGKhUTr4
	 DsJhAhbKLHSmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7BAD2E19E39;
	Thu, 23 Nov 2023 17:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tools: ynl: fix header path for nfsd
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170075882650.541.8577826919663134661.git-patchwork-notify@kernel.org>
Date: Thu, 23 Nov 2023 17:00:26 +0000
References: <20231123030624.1611925-1-kuba@kernel.org>
In-Reply-To: <20231123030624.1611925-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, chuck.lever@oracle.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Nov 2023 19:06:24 -0800 you wrote:
> The makefile dependency is trying to include the wrong header:
> 
> <command-line>: fatal error: ../../../../include/uapi//linux/nfsd.h: No such file or directory
> 
> The guard also looks wrong.
> 
> Fixes: f14122b2c2ac ("tools: ynl: Add source files for nfsd netlink protocol")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] tools: ynl: fix header path for nfsd
    https://git.kernel.org/netdev/net/c/2be35a619482

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



