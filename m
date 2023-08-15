Return-Path: <netdev+bounces-27540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CD577C5A5
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 04:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ECEB1C20C12
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 02:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4375717F9;
	Tue, 15 Aug 2023 02:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D1D17D8
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 02:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F856C433C8;
	Tue, 15 Aug 2023 02:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692065421;
	bh=tbPg7DsFXPXJCMD127YCWiLf9PqIgRw2qHXwDxEo2Ss=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VfFkcjWd0m2Xo0W8EabIhuRHNMzIMpbw2CiaP4eEzqYvmS7fN4qMVllKu7Xy+pGCF
	 7KsaQ+kdZrI4LZxeJ6bA4K3pK2KdxV5g95ULb6CNRK1blOTjdLNYv6BN5bIZDjmMts
	 o5xi0BcUaUCroDsIToDi3m/6+zqb8E9xvQPWo6yC1NsJT2sHGtDnQqCH3iuDb3Ptec
	 UagDrCGeoWU6ul3b0nbn/corjFzjm+KG5a4D9HsIw0KYzS7uFW1AYBTcaBJJ/r4tfZ
	 4d0HxfJURFyHd3E0De7UFCX/jx8sdNhCSnMtcdPnI434VKkJAF6Q9xiaqntqioHczR
	 37JRCFnObOfWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E080C395F3;
	Tue, 15 Aug 2023 02:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] octeon_ep: fixes for error and remove paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169206542144.7478.11120643947171700041.git-patchwork-notify@kernel.org>
Date: Tue, 15 Aug 2023 02:10:21 +0000
References: <20230810150114.107765-1-mschmidt@redhat.com>
In-Reply-To: <20230810150114.107765-1-mschmidt@redhat.com>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: netdev@vger.kernel.org, vburru@marvell.com, sedara@marvell.com,
 davem@davemloft.net, aayarekar@marvell.com, sburla@marvell.com,
 vimleshk@marvell.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Aug 2023 17:01:10 +0200 you wrote:
> I have an Octeon card that's misconfigured in a way that exposes a
> couple of bugs in the octeon_ep driver's error paths. It can reproduce
> the issues that patches 1 & 4 are fixing. Patches 2 & 3 are a result of
> reviewing the nearby code.
> 
> Michal Schmidt (4):
>   octeon_ep: fix timeout value for waiting on mbox response
>   octeon_ep: cancel tx_timeout_task later in remove sequence
>   octeon_ep: cancel ctrl_mbox_task after intr_poll_task
>   octeon_ep: cancel queued works in probe error path
> 
> [...]

Here is the summary with links:
  - [net,1/4] octeon_ep: fix timeout value for waiting on mbox response
    https://git.kernel.org/netdev/net/c/519b227904f0
  - [net,2/4] octeon_ep: cancel tx_timeout_task later in remove sequence
    https://git.kernel.org/netdev/net/c/28458c80006b
  - [net,3/4] octeon_ep: cancel ctrl_mbox_task after intr_poll_task
    https://git.kernel.org/netdev/net/c/607a7a45cdf3
  - [net,4/4] octeon_ep: cancel queued works in probe error path
    https://git.kernel.org/netdev/net/c/758c91078165

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



