Return-Path: <netdev+bounces-133684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5562996AD0
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1FD2899D8
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B8F1D3631;
	Wed,  9 Oct 2024 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lb4Q1xPw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEFC1D31B2;
	Wed,  9 Oct 2024 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478227; cv=none; b=QmlUJirGfEnLvyJWKMQVodhKuFPQ8DDic+QOxlY1dqmPq7fOXvuOQrBQE828t49zMF8drqiOKuZFgsdNFIgjzb6KX+6fVdw86AtEqeLGGZ4bHUzNTxhpJxmGzU10p5JIatf7/DolIOmjg1+OS7UENDD1HzRqMFzWx+fhI05ScF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478227; c=relaxed/simple;
	bh=aDbV8k1iN1rlT/5JLsI8Qq+IXeS8+ozQxJ3lKor2lec=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rKF/zsVtjnetO8p6HrFXXfzi4V3Yv9R1FfqbP2jhnag4Of4SHG0C+D7rnhcqfIrOFpP7JKUGGit3tCDWKE84WZlCqTxVIxnzashxYwHhwrlFnkWQpUfoFmfQdVSw/2D67KCAUhtuT+PgGFBXBp7/J/TUObJH0x4J/1xM2ML/0Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lb4Q1xPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB68C4CEC5;
	Wed,  9 Oct 2024 12:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728478225;
	bh=aDbV8k1iN1rlT/5JLsI8Qq+IXeS8+ozQxJ3lKor2lec=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Lb4Q1xPwTBBjv4NTo4/0K2gBjSw76UfMNuV5Yl9yxOOjR5ULgU1udqada27I2XAkU
	 SNrGHSFI9iZ9bWm/XZPjLaGjDR+TtE8/WdweE+rIRQ6SjesV6jaup+n4a6ov7KAwrG
	 f2Hzm63i5k5M7RXiVY+5AYtaEgwNOL3Vex0rMbfTthIuWdIx6kKY9ouwWHTwpGtnN5
	 cYxtvYDlxUvApqSN9v+ezinnfVqvsT/xL/CIbulfrL2dGZYMPJVoPIxOI1vjGPrkAo
	 13peQrJR2WBQMbEOu7z9NZ9ZUaABOE+8nYYDBYz0DoWjYSOgsOgsoM361nQEdFA/XF
	 RQvMLTjMOLz4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D483806644;
	Wed,  9 Oct 2024 12:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: hns3/hns: Update the maintainer for the HNS3/HNS
 ethernet driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172847823000.1258225.5211095393961502580.git-patchwork-notify@kernel.org>
Date: Wed, 09 Oct 2024 12:50:30 +0000
References: <20241008024836.999848-1-shaojijie@huawei.com>
In-Reply-To: <20241008024836.999848-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shenjian15@huawei.com, salil.mehta@huawei.com,
 liuyonglong@huawei.com, wangpeiyang1@huawei.com, lanhao@huawei.com,
 chenhao418@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 8 Oct 2024 10:48:36 +0800 you wrote:
> Yisen Zhuang has left the company in September.
> Jian Shen will be responsible for maintaining the
> hns3/hns driver's code in the future,
> so add Jian Shen to the hns3/hns driver's matainer list.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net] net: hns3/hns: Update the maintainer for the HNS3/HNS ethernet driver
    https://git.kernel.org/netdev/net/c/983e35ce2e1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



