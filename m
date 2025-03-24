Return-Path: <netdev+bounces-177186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DDFA6E389
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 20:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A58793AB925
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 19:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9D6199FAB;
	Mon, 24 Mar 2025 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmS9/pr/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923FD2E3381;
	Mon, 24 Mar 2025 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742844599; cv=none; b=K3UK11bC5wRTcZDTk1SWV3Pbbk2l87v4khqOBuCgbchVvU6oRdE+HCmoSJYQRNiVw50Id00MNMBP08YmKkdRcV48AKxcmbLUSD25lzY9h7PDEItwbSnRqmmqL+5+FN9KcDLA+EE/eQAdB/7XtIbRXQ8QguI91r+ETxqailynf9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742844599; c=relaxed/simple;
	bh=K3ZPwimm9uQDOq2Wn0kNP++Woe199Uk9nvlB/z6pfUI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dbkjc3gbGr27M4y6mCJ8SMbdR8k5cqHVq1s7xq/Gbq4FfdCXwukGSI4BZ9SoyCmKoth4B2kZOg/X0Y14wwIxLtI52D24WTQTvvmXczozRrMZpesQ3kuE6aRRR1oM4QSEQEeK0zI6Zoo5Cx+5sGsxkYVwQi6gFffLA9I6CK2aVSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmS9/pr/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02644C4CEDD;
	Mon, 24 Mar 2025 19:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742844599;
	bh=K3ZPwimm9uQDOq2Wn0kNP++Woe199Uk9nvlB/z6pfUI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EmS9/pr/WVKx3HhJ0exGPyJUNXILPi7lqWUapIeben0AQbMr+jqFQgL129eZyEZ0a
	 AWgac6dES5D93dsI3ZmrfAahae7G6uGqTrK9ljETRG6uY/7DgWfLGu1WrLpg/20l53
	 PZRUC0oAFaoOkH4XTqI1teabP2k5LJtTP0weKWbGn80VYKNbl7cuDz8aoaamLzXpQx
	 PybijwSlcXTLzHpLa4bz61HjtUB7l3UOFQhJkO6pe4MXcl1SyghjvsJ+cSPABk8yal
	 idUh0BURgqyd/kr8yRhcyfbQJf+5fNhYysPwwN+2nV9exmZHLKQLa9xwp+Cf0UaYsV
	 vcq0C9fj2skew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712AA380664D;
	Mon, 24 Mar 2025 19:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] r8169: enable more devices ASPM support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174284463526.4144910.10638299332464041712.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 19:30:35 +0000
References: <20250318083721.4127-1-hau@realtek.com>
In-Reply-To: <20250318083721.4127-1-hau@realtek.com>
To: ChunHao Lin <hau@realtek.com>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Mar 2025 16:37:19 +0800 you wrote:
> This series of patches will enable more devices ASPM support.
> It also fix a RTL8126 cannot enter L1 substate issue when ASPM is
> enabled.
> 
> 
> V2 -> V3: Fix code format issue.
> V1 -> V2: Add name for pcie extended config space 0x890 and bit 0.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] r8169: enable RTL8168H/RTL8168EP/RTL8168FP ASPM support
    https://git.kernel.org/netdev/net-next/c/3d9b8ac53412
  - [net-next,v3,2/2] r8169: disable RTL8126 ZRX-DC timeout
    https://git.kernel.org/netdev/net-next/c/b48688ea3c9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



