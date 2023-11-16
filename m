Return-Path: <netdev+bounces-48409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0D87EE3F0
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 16:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB1D1C2084D
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 15:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6207034552;
	Thu, 16 Nov 2023 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kth70fqq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4591D3212
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 15:11:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF6ECC433C8;
	Thu, 16 Nov 2023 15:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700147467;
	bh=ffrPBCOuILG3hwhhVFCby0OZzf3IVeLDmbneh6GNuaE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Kth70fqqxyE2tc8z0tIf31YwzG9/PSvlcbxU5+esQyf/AbaH6Htpi7rT9ekshewLE
	 85xL+aOs//pKF4PT3laK+HR795irg1Av5VmTJstxHWwHcyVmFQtYlOOetZFBaGDPjU
	 9MjJhNLuOTC8US5s6xptAMPNzWSke/jQwukr3dS/Wpn0WG2Xzl6yBnwkcwGJSyAMGG
	 e74MdLTIP6XLkwUavBrzs/eI7jWF3CnAIz1nvGGjBjeNJLcfIG0uz61GCnzdRulg/C
	 YOAAz0cLP+20sld/uW/CqSQhuZ/PfiD7c9909BrmuPTYtH5R4eTVRtiEoMyHq0fRzm
	 /5rlSfXLs30sg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 981A3E00090;
	Thu, 16 Nov 2023 15:11:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] Networking for v6.7-rc2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170014746761.31706.13445108016681047980.git-patchwork-notify@kernel.org>
Date: Thu, 16 Nov 2023 15:11:07 +0000
References: <20231116122140.28033-1-pabeni@redhat.com>
In-Reply-To: <20231116122140.28033-1-pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Thu, 16 Nov 2023 13:21:40 +0100 you wrote:
> Hi Linus!
> 
> Notably this includes the fix for the eBPF regression you have been
> notified of.
> 
> The following changes since commit 89cdf9d556016a54ff6ddd62324aa5ec790c05cc:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] Networking for v6.7-rc2
    https://git.kernel.org/netdev/net/c/7475e51b8796

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



