Return-Path: <netdev+bounces-16818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D000A74EC81
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 13:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9B31C20D68
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 11:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8778818AFA;
	Tue, 11 Jul 2023 11:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08D418AF8
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 11:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1EF46C433C7;
	Tue, 11 Jul 2023 11:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689074421;
	bh=GYFBjWURXVpCTSxNPurIgg5XIkV1t3+Z846c7cc+7dg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GvP1nq3nt96eYGdYsMnKfwrNmRQ53h1lvnr32J4EvcwJI+IxmIpEkXnA1fVjzIpx3
	 cDSyw5eQXHJG4PNpEsRRnPM9YyCz8ecMGlSmuQqVKv+YKEZi3r85DmFW1eNNiLq3W5
	 a8X73GVt1K6/zqTgAIa3He5bPxU+AiTFX+o/ER6xAxygXBO9UQNCBYZmf92Gh56TpW
	 hAjjiOYhG8u2GDJYhQ0ATPbqPx8ljhfxnim/qi61CqP/LkbtWnQXhxC0CurQDG9HrM
	 rZYR3b0qdLSuLAYZhCvNvMkuAAbEyba8KiHLkELGlxMKKNRjMqzC4rlJDfzMPm3f9z
	 /0hKTmTIuNumg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 043EBE4D010;
	Tue, 11 Jul 2023 11:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH V5] octeontx2-pf: Add additional check for MCAM rules
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168907442101.23063.4848906391252600918.git-patchwork-notify@kernel.org>
Date: Tue, 11 Jul 2023 11:20:21 +0000
References: <20230710103027.2244139-1-sumang@marvell.com>
In-Reply-To: <20230710103027.2244139-1-sumang@marvell.com>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 10 Jul 2023 16:00:27 +0530 you wrote:
> Due to hardware limitation, MCAM drop rule with
> ether_type == 802.1Q and vlan_id == 0 is not supported. Hence rejecting
> such rules.
> 
> Fixes: dce677da57c0 ("octeontx2-pf: Add vlan-etype to ntuple filters")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net,V5] octeontx2-pf: Add additional check for MCAM rules
    https://git.kernel.org/netdev/net/c/8278ee2a2646

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



