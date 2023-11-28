Return-Path: <netdev+bounces-51507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A426C7FAF0E
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 01:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45A2CB2135F
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 00:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AB337C;
	Tue, 28 Nov 2023 00:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDCZNjjo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F151868;
	Tue, 28 Nov 2023 00:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB978C433C7;
	Tue, 28 Nov 2023 00:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701131425;
	bh=vvlWHcsM4/SnjvyCTszDFZQxVvZewd1+ZaeHoVX7W0I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nDCZNjjoPsJ0GfDQK3qooiKcKPEwU0bCLxFWO1Wh/NZUGtpB8VgipB3VmAPD2L27A
	 fuO0Vmi8kzAOthHPJUBRdDKftgg3o9cpr7JuNbssbNLkDhKc46C78ZwaeRBqJWUS4r
	 2gQAEdNEHRAMDYP406PIpB8+oHESacoPcxBTttncKvpBieAoY+ORUHodKjy1majZxK
	 0jpecfFbn5g8apsUTNPH0U6MYGSGWt7+iZw4VJqBc9/Q4bAK6fPn/U9SVW79cQ6tI9
	 1c3KWRBTHT0Tlfa3ni14Yc1Y3B9dzP6ZTp3qku3NDf6MZ7WyfsQJmSgYHm2ajqY5NW
	 JIsx/D5gsds9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9764E11F68;
	Tue, 28 Nov 2023 00:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] netkit: Reject IFLA_NETKIT_PEER_INFO in
 netkit_change_link
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170113142575.7037.13597155992811223763.git-patchwork-notify@kernel.org>
Date: Tue, 28 Nov 2023 00:30:25 +0000
References: <e86a277a1e8d3b19890312779e42f790b0605ea4.1701115314.git.daniel@iogearbox.net>
In-Reply-To: <e86a277a1e8d3b19890312779e42f790b0605ea4.1701115314.git.daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@linux.dev, razor@blackwall.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, kuba@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 27 Nov 2023 21:05:33 +0100 you wrote:
> The IFLA_NETKIT_PEER_INFO attribute can only be used during device
> creation, but not via changelink callback. Hence reject it there.
> 
> Fixes: 35dfaad7188c ("netkit, bpf: Add bpf programmable net device")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf,v2] netkit: Reject IFLA_NETKIT_PEER_INFO in netkit_change_link
    https://git.kernel.org/bpf/bpf/c/0bad281d0ecd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



