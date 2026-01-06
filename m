Return-Path: <netdev+bounces-247234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4038CF6151
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 01:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85BA930D6113
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 00:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321051DD0EF;
	Tue,  6 Jan 2026 00:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPGxrEzo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE111A3166
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 00:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767659019; cv=none; b=qysw2rvafwqx7kHSJDta3oIpm/Z26tb0PvYIWMKtyUF46KMcopt5QC/31eZmrym58GHdAwU8wxiT7Lkw3FxZwTxExj30TNktgB46gEV6Or2v3Df4TD1vKsN3aQvCwuXmgPuB43em2QsttgF+IctO2XnT8OVOeEY+3e4mQHmC6pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767659019; c=relaxed/simple;
	bh=ezkq3Cz8iyemwN+sKPDhVN+v+x0zzkd+tLkYtqS1g/U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hZV4ijt/Wk5pX9QyI9s8ZHeonveaJvZsHVuBwXwqc+cU8BNrwCm0HjvJ8v+2vjum5CLtDUGEsUsP+Xpwrd47IsERUOptnX9A73c1UiVJwelPJmGoxev5fe6tk5sWR3L//q0aJ+TxvHzbBy1cVWL2RkSigSSCR6PzH5W7SQ/k+0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPGxrEzo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D68AC116D0;
	Tue,  6 Jan 2026 00:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767659018;
	bh=ezkq3Cz8iyemwN+sKPDhVN+v+x0zzkd+tLkYtqS1g/U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZPGxrEzofItNdFaQmaf1CMY5TX16r2+p0wvAJQuCVUwazH/InWx5uBqraR39qyxI4
	 /cOsBTXeDAZqTe1Pabn7kS73vrqIFjF5JF70wyDoFM2ZCH4iRycNhCk/FoSXN0fypC
	 dDm7BAwyrWRp2HVTUQ71RQAb+86Mu5XBhhc/KAXT4y2ZwMXC8ta6rzWItHVC5t5dt1
	 69iaX6xMgN6Jyi1/80sGS4ps0cN+H3spK6ie6LB8bn2YG/zYcuUBo5BRs2LgEGQzlL
	 bRAOTt43m+7ScSJNAFjiW1zsOrUSmlXIuVYMhugPRd/tBVkiEpRMR+t7aoO+kZNqy7
	 YZDgSjLP9JadQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2EA9380A966;
	Tue,  6 Jan 2026 00:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: marvell: prestera: correct return type of
 prestera_ldr_wait_buf()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176765881652.1339098.373042162030671733.git-patchwork-notify@kernel.org>
Date: Tue, 06 Jan 2026 00:20:16 +0000
References: <20260103174313.1172197-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20260103174313.1172197-1-alok.a.tiwari@oracle.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: vadym.kochan@plvision.eu, oleksandr.mazur@plvision.eu,
 andrew+netdev@lunn.ch, taras.chornyi@plvision.eu, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, alok.a.tiwarilinux@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  3 Jan 2026 09:43:10 -0800 you wrote:
> prestera_ldr_wait_buf() returns the result of readl_poll_timeout(),
> which is 0 on success or -ETIMEDOUT on failure. Its current return
> type is u32.
> 
> Assigning this u32 value to an int variable works today because the
> bit pattern of (u32)-ETIMEDOUT (0xffffff92) is correctly interpreted
> as -ETIMEDOUT when stored in an int. However, keeping the function
> return type as u32 is misleading and fragile.
> 
> [...]

Here is the summary with links:
  - [net-next] net: marvell: prestera: correct return type of prestera_ldr_wait_buf()
    https://git.kernel.org/netdev/net-next/c/32291cb0369a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



