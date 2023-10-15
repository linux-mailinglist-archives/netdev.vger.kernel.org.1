Return-Path: <netdev+bounces-41093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E097F7C99AF
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 17:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC9B1C20904
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 15:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767187499;
	Sun, 15 Oct 2023 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DezLhnJv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC1C2F53;
	Sun, 15 Oct 2023 15:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6F91C433C8;
	Sun, 15 Oct 2023 15:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697382622;
	bh=xBmMMUeTqGOtCCswkqoAJy4I1gBJ/lCa3dC+0Fr59Ok=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DezLhnJv3oCrxZUHf9nDGv5AnznxqLJTwIERuZQ3RYmbdN0bdzHny5t29MS/CSblO
	 ORqVPF9whdlUKBSVPDeazmStfTKPUomDkwuj/Z3VDxHn5OvbschVYhrnb/+p2mYqGK
	 Td/DkkgFZZ2hTi6mrq091ooPMHp9ihothgR/Wd7SNfaXWYXEEWrOdUGRyyPeGIf2h1
	 L5Kb0IUJnewEHdcIdCjKlaQ/8FDwLfh/0xuCmOVcfrQylEyRodxJ5O2PN64vSJJZy8
	 Qub27xyAj4uJIWtDA+hKJ+IE7vJfNQTOwr3im+nlWfXZSTBh8Gx9TWixKOShJTzCOZ
	 nma3TJ8xUGwYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9BB3EC595D0;
	Sun, 15 Oct 2023 15:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/5] dpll: add phase-offset and phase-adjust
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169738262262.5861.8707654384088164012.git-patchwork-notify@kernel.org>
Date: Sun, 15 Oct 2023 15:10:22 +0000
References: <20231011101236.23160-1-arkadiusz.kubalewski@intel.com>
In-Reply-To: <20231011101236.23160-1-arkadiusz.kubalewski@intel.com>
To: Kubalewski@codeaurora.org,
	Arkadiusz <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, jiri@resnulli.us,
 corbet@lwn.net, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 linux-doc@vger.kernel.org, intel-wired-lan@lists.osuosl.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 11 Oct 2023 12:12:31 +0200 you wrote:
> Improve monitoring and control over dpll devices.
> Allow user to receive measurement of phase difference between signals
> on pin and dpll (phase-offset).
> Allow user to receive and control adjustable value of pin's signal
> phase (phase-adjust).
> 
> v4->v5:
> - rebase series on top of net-next/main, fix conflict - remove redundant
>   attribute type definition in subset definition
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/5] dpll: docs: add support for pin signal phase offset/adjust
    https://git.kernel.org/netdev/net-next/c/27ed30d1f861
  - [net-next,v5,2/5] dpll: spec: add support for pin-dpll signal phase offset/adjust
    https://git.kernel.org/netdev/net-next/c/c3c6ab95c397
  - [net-next,v5,3/5] dpll: netlink/core: add support for pin-dpll signal phase offset/adjust
    https://git.kernel.org/netdev/net-next/c/d7fbc0b7e846
  - [net-next,v5,4/5] ice: dpll: implement phase related callbacks
    https://git.kernel.org/netdev/net-next/c/90e1c90750d7
  - [net-next,v5,5/5] dpll: netlink/core: change pin frequency set behavior
    https://git.kernel.org/netdev/net-next/c/20f6677234d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



