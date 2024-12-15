Return-Path: <netdev+bounces-152034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3968F9F2669
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 23:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ABDD1651F2
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 22:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6401C54B6;
	Sun, 15 Dec 2024 22:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6jxE5Ze"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129AB1BCA1B;
	Sun, 15 Dec 2024 22:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734300016; cv=none; b=lNm54YA+qmF0SHt+r8fRXT03Puh475WPrR7ICWYtb2mpJ38H4Dfh4hyAg/Gd1bm5UGKerAgxo3r+yyfQK+zmhS128fGvY4/zMj5c1076c1ALY6ujy17TGmr5MXMdZwn+buQ4kwczKUOeeeftUXSpfauI/OYJC+6J1OKwZYaa7FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734300016; c=relaxed/simple;
	bh=FmclbdDjJ7uS1L59HpwGcSVYM6UH/bu3sc9AyNYWC5M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eAXFGu0JG7oaqaySez4AkZOH2oLEfAci417nzfEyd+5DCFr0b/599Es/AAOnpSWPlWB8PVsHBLi+6Vsohl86vZSbPDEvP04xg6FvLIuS0o6bOp0MdQ/Yi25TAGG6Wj8T6t71TeLRoD9upLqbutb/qLbvkmgbMN8WPy8CnARL4bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6jxE5Ze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917DCC4CED4;
	Sun, 15 Dec 2024 22:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734300015;
	bh=FmclbdDjJ7uS1L59HpwGcSVYM6UH/bu3sc9AyNYWC5M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f6jxE5ZecAlX0QlfjDYRVso7Y0Td4qcrL7qEIerx9/BRE24g1+/6Sn/i0b8tp10nH
	 HrykjQQjV9uzftAP5gGx8Yf/Z1YVtKd5wvhDwWpqsttU5qoMOELvJaIZhTsH0FfUYM
	 OQ23XK4D2R36m6x1PXDE8wfkuN1PbX9OX8MC3HKPy1yvEVKYtHgGidA2x/WY+vbY5i
	 r6Qa+LZnN60DG+1r67GnogMq9SwYo95Rcs1wLBzMYw8uvnY6nIrLLg3N2l9GjxQLpA
	 RB1xcnn57PWrVCHJvBovzL3wD0gYmfgxn2g5RQCpT2SezG87MPA3QSnIgmC9VkHGqw
	 8hy9WJIpOF8iA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE03C3806656;
	Sun, 15 Dec 2024 22:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] octeontx2-af: fix build regression without
 CONFIG_DCB
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173430003225.3589621.13879594848073437493.git-patchwork-notify@kernel.org>
Date: Sun, 15 Dec 2024 22:00:32 +0000
References: <20241213083228.2645757-1-arnd@kernel.org>
In-Reply-To: <20241213083228.2645757-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 arnd@arndb.de, horms@kernel.org, alexious@zju.edu.cn, kdipendra88@gmail.com,
 rkannoth@marvell.com, saikrishnag@marvell.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Dec 2024 09:32:18 +0100 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When DCB is disabled, the pfc_en struct member cannot be accessed:
> 
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c: In function 'otx2_is_pfc_enabled':
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:22:48: error: 'struct otx2_nic' has no member named 'pfc_en'
>    22 |         return IS_ENABLED(CONFIG_DCB) && !!pfvf->pfc_en;
>       |                                                ^~
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c: In function 'otx2_nix_config_bp':
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:1755:33: error: 'IEEE_8021QAZ_MAX_TCS' undeclared (first use in this function)
>  1755 |                 req->chan_cnt = IEEE_8021QAZ_MAX_TCS;
>       |                                 ^~~~~~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-af: fix build regression without CONFIG_DCB
    https://git.kernel.org/netdev/net-next/c/410cd938511f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



