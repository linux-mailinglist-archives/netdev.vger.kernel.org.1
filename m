Return-Path: <netdev+bounces-34465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF077A44B4
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 10:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084F4281A67
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 08:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2D514AAA;
	Mon, 18 Sep 2023 08:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1971C29D
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 08:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D161C433C9;
	Mon, 18 Sep 2023 08:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695025823;
	bh=nYEwcsqesLVefW1+brLmyPPhiOSmlhFlo6JNpZLcXto=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q6Oda7a+wbSZJ/dboLhYGuYLZr0ourU4FvbV436jPWr6zCCOHGtdv5aw1R0r18JZt
	 /MPbOdriba4mq/PfHFOvvOlKx7AMHmUKZtIwC65ZQVh42IPtcZsmvDcVW2jlm64wFS
	 FiL8njb/eZb+cNqK5Lukuxy2nCygbdJonfUJx7G1Fvzo05OBDkTUwMddkMTArcQelf
	 oio7Sk3dgMbgRjNGimVg6urd0hsPfDGYZ9cPZVt/ottHMlwSQiS0TOh2cLlkUg2BYe
	 w+EbzZG69nWchruhPKZxJ2iJZkSujBD9dUcrDqu8RGkzNfYnbV2gLONYeKYbNmUOKB
	 3A2q98oFWjZUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02B5EE11F42;
	Mon, 18 Sep 2023 08:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] pds_core: add PCI reset handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169502582300.30956.3151200877346667647.git-patchwork-notify@kernel.org>
Date: Mon, 18 Sep 2023 08:30:23 +0000
References: <20230914223200.65533-1-shannon.nelson@amd.com>
In-Reply-To: <20230914223200.65533-1-shannon.nelson@amd.com>
To: Nelson@codeaurora.org, Shannon <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 14 Sep 2023 15:31:56 -0700 you wrote:
> Make sure pds_core can handle and recover from PCI function resets and
> similar PCI bus issues: add detection and handlers for PCI problems.
> 
> Shannon Nelson (4):
>   pds_core: check health in devcmd wait
>   pds_core: keep viftypes table across reset
>   pds_core: implement pci reset handlers
>   pds_core: add attempts to fix broken PCI
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] pds_core: check health in devcmd wait
    https://git.kernel.org/netdev/net-next/c/f7b5bd725b73
  - [net-next,2/4] pds_core: keep viftypes table across reset
    https://git.kernel.org/netdev/net-next/c/d557c094e740
  - [net-next,3/4] pds_core: implement pci reset handlers
    https://git.kernel.org/netdev/net-next/c/ffa55858330f
  - [net-next,4/4] pds_core: add attempts to fix broken PCI
    https://git.kernel.org/netdev/net-next/c/1e18ec3e9d46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



