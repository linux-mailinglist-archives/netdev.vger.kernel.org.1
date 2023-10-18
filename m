Return-Path: <netdev+bounces-42085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6057CD18C
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 03:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4D7281AD1
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 01:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA8964A;
	Wed, 18 Oct 2023 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCSGIUs6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28581FC6
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 01:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F325C433CB;
	Wed, 18 Oct 2023 01:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697590830;
	bh=RcVrNNKQZ3a+4BjgNXJqk9Y8/Umzr96AWRDNxw4x3BI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eCSGIUs6GnI379P9vf/EPaZ+nRZO2Jel0JXBDeyo3zuxBxUArPuF+qYQPdEH+iMt7
	 uVEKADVZ/m8BywmFtXQijV+ZT1udeEOL54paDdS/FY0sg8RmwPe4gaw/1yxhSwGE8n
	 v14nQsEVX6Avyfk87eyRnPMh4WjKCaPUbrGLz+GdwO8LBMII8kAZRLxf9riUEtMoHn
	 piIAFwieeVHmEOEsTBLHTZrwgViYGsa+MqxIyLruTd2WPKHUzCLwarchaZ0UzwGk5l
	 MJ1mmCYz5R7z4/JUzgCrkcPEozb7Dx4XyphWnNKo9cWACfDvBB88pEfjNXwbgy9ed4
	 jetTydkTMCURA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77EC9C0C40E;
	Wed, 18 Oct 2023 01:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] eth: bnxt: fix backward compatibility with older
 devices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169759083048.18882.16117585741275274572.git-patchwork-notify@kernel.org>
Date: Wed, 18 Oct 2023 01:00:30 +0000
References: <20231016171640.1481493-1-kuba@kernel.org>
In-Reply-To: <20231016171640.1481493-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, michael.chan@broadcom.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Oct 2023 10:16:40 -0700 you wrote:
> Recent FW interface update bumped the size of struct hwrm_func_cfg_input
> above 128B which is the max some devices support.
> 
> Probe on Stratus (BCM957452) with FW 20.8.3.11 fails with:
> 
>    bnxt_en ...: Unable to reserve tx rings
>    bnxt_en ...: 2nd rings reservation failed.
>    bnxt_en ...: Not enough rings available.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] eth: bnxt: fix backward compatibility with older devices
    https://git.kernel.org/netdev/net-next/c/73b24e7ce8f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



