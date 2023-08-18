Return-Path: <netdev+bounces-28980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8507378155E
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 00:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA868281AF5
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 22:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4ED1C28A;
	Fri, 18 Aug 2023 22:20:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E299A2C9A
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 22:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A1D4C433C8;
	Fri, 18 Aug 2023 22:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692397225;
	bh=B84Ed/Eub/ZxXe98rGhtXzjES0xyVZVz+SiunbmFd10=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eQcIuavP2adT6lEqWoQ080wisukuG78x9KnSNCvSi/ALgsgVfCl+eGQKFjHqN5C28
	 dufNidF5i47IPAC08UsVNba6SDqe52Q0W6o/uAq7C+6uSErbl9UvdkbCb2QEU6un0q
	 CtgQR7jJxdmXEQbOkFayhYbg4U+f0+9gWn4Tlipo7IY/UgwbTQRGWWnaJFhVnOFiv1
	 opOtaDTkNeAM64wsaAvb5Vr0cxpp9JQRDH7XgcU4tUjQbYpgKuPvuGDuiX+3x+2jxx
	 /R64QrZg7PCRFTKiJT4G4JFDjbUSwbVEPWyMEUN1HQZD4ix7ri/WxcwutC7A3eiFYa
	 0Zb4OsgoAJkVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1BF83C395DC;
	Fri, 18 Aug 2023 22:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/5] batman-adv: Trigger events for auto adjusted MTU
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169239722510.24641.8619081876432561940.git-patchwork-notify@kernel.org>
Date: Fri, 18 Aug 2023 22:20:25 +0000
References: <20230816163318.189996-2-sw@simonwunderlich.de>
In-Reply-To: <20230816163318.189996-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Wed, 16 Aug 2023 18:33:14 +0200 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> If an interface changes the MTU, it is expected that an NETDEV_PRECHANGEMTU
> and NETDEV_CHANGEMTU notification events is triggered. This worked fine for
> .ndo_change_mtu based changes because core networking code took care of it.
> But for auto-adjustments after hard-interfaces changes, these events were
> simply missing.
> 
> [...]

Here is the summary with links:
  - [1/5] batman-adv: Trigger events for auto adjusted MTU
    https://git.kernel.org/netdev/net/c/c6a953cce8d0
  - [2/5] batman-adv: Don't increase MTU when set by user
    https://git.kernel.org/netdev/net/c/d8e42a2b0add
  - [3/5] batman-adv: Do not get eth header before batadv_check_management_packet
    https://git.kernel.org/netdev/net/c/eac27a41ab64
  - [4/5] batman-adv: Fix TT global entry leak when client roamed back
    https://git.kernel.org/netdev/net/c/d25ddb7e788d
  - [5/5] batman-adv: Fix batadv_v_ogm_aggr_send memory leak
    https://git.kernel.org/netdev/net/c/421d467dc2d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



