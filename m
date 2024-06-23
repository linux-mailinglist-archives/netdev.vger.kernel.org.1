Return-Path: <netdev+bounces-105952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AA6913D89
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 20:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC061F21E5C
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 18:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5D01836E3;
	Sun, 23 Jun 2024 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwQnrRF4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF9B2AD22;
	Sun, 23 Jun 2024 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719166228; cv=none; b=tvge8J4kUPo1TuOrICtiilYBXErGn55dO3HD1v9E0G/rXT9okyT+q6TjJNWST44oeR146N9laKQ9L9IwTAbT5zqpLS745VtsWF/6gSTKTf8Um8FM59kZcVm/NWAIxZ0/rk+01LfrybvQmoaeivDHNh4+PwUV4kNyJzew3ks6L24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719166228; c=relaxed/simple;
	bh=50ecyUID+IcgYhdJqxEnwEQsRz1NsA8uh3n7Nc5SddM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H9zAgGFVg0R00Ko1+n58nR60WQKxJPtvLKsrR4ASoALrxtNlf+m8KSE/WMGqmdwsyyHHiarM+dn8Ww/is+8pbN/ZZ1WHPKD/f09EKPJckHGI9QS71vdcCe7P/p389DUYV4dr8dEE/hjVAEabYWnk9kBSiKjkDXrVbnBuc0j95Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwQnrRF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAD50C32786;
	Sun, 23 Jun 2024 18:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719166228;
	bh=50ecyUID+IcgYhdJqxEnwEQsRz1NsA8uh3n7Nc5SddM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QwQnrRF4wsephOL6j9IXivwAzIfBKUQtLOUq29/uYquld9ij3nQ82DcXkJG2BYvqH
	 5AP3eMxBLtxwhK0CW0D1HSgFYZNlRR899RHTVLGCdmiaChNbk1VlUrNjXDOnY9oe1n
	 6vOZpIjmce67zBmTlIfHWB+fc78u37WtwBr6Q3eGAi1mXa6T3DV0OPQXSC7DfdzoKM
	 i+u3fMa8vlYl2FkvwSvT4A1hWIzoCuqplmnu5L3AHAv4fvHT+s1UxuelbRopyIBZHZ
	 LQYwdITWzvSdZxMGdZVMkmfhit1wqreUxhYsosCmz+cc677VGqLNr0vGaZhf1HscLG
	 h1xCpULwKLHTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D29A4CF3B80;
	Sun, 23 Jun 2024 18:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH] octeontx2-pf: Fix coverity and klockwork issues in octeon
 PF driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171916622785.24104.1126101038206521333.git-patchwork-notify@kernel.org>
Date: Sun, 23 Jun 2024 18:10:27 +0000
References: <20240622064437.2919946-1-sumang@marvell.com>
In-Reply-To: <20240622064437.2919946-1-sumang@marvell.com>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lcherian@marvell.com, jerinj@marvell.com,
 rkannoth@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 22 Jun 2024 12:14:37 +0530 you wrote:
> From: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> Fix unintended sign extension and klockwork issues. These are not real
> issue but for sanity checks.
> 
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-pf: Fix coverity and klockwork issues in octeon PF driver
    https://git.kernel.org/netdev/net/c/02ea312055da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



