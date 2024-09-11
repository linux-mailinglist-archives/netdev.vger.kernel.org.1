Return-Path: <netdev+bounces-127183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6269F97480C
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 04:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2037F1F26B36
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 02:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329D6224FA;
	Wed, 11 Sep 2024 02:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsVjixUa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E48B38DC0
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726020633; cv=none; b=AYNnKLG33YEVqO7gmrXeaotHQWTUij88QSnbTjYo0dbG7pI2ViDRvQOQpa0Kf5NR21bLybqiwSN0qgMsJu1/ZQ64z/jwX89UU2qb+M/JGzqmozOsWzGkbW2uxUmEoU7jbM/HfFB7B9+KS1mgQS1awF58hebWUF0jUCdUdGt2LXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726020633; c=relaxed/simple;
	bh=9Ky1jeHihpHupaOAIWIK04AbgDyPvDlzLVgr/G4qd7Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZjWeBAIxLqTH6/ZBYZorWyxCnNT7o7RIIA1BImxBP6+yfrchf0WWoTq82s25smjrnkh5YqcklQR2gLTUUVUdjQUVkoxvnGTOnGfixQz6Ui4dfvRtNKpVGUQEYnX5PUxokBcJ+KRx0gYkGITSDwUpXWKqAmHFYEoQ6eI4MsZX7kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsVjixUa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746B5C4CEC3;
	Wed, 11 Sep 2024 02:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726020631;
	bh=9Ky1jeHihpHupaOAIWIK04AbgDyPvDlzLVgr/G4qd7Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bsVjixUaNpLk3cjP2xJjPTJ8r3ttBfPTYC6ZwpW7Rnx85EiE882ScoP6sn/BLwZ19
	 BBZOXyKZGYvsRbqNoRfsca8dVPbLLyn8Lkm6HY2j1V3tvN3aq+K3tit3Ib/25zaYLm
	 ImN0GrBewDfuN6Rz1mzhX1NX0fWfK7PfLwvLxTXJQ5Ov1cIjw1AVz7G21ugQEI7nS5
	 9qfxMc98GvCFAhximOjsaO67D6cTN8T9/xqrNLdbqHJJLzCJWwNEllnbIZ/0ZmfNd7
	 0fTKZcOK0mc8Cxraax+MFZewiHyOYqQjWdl5dWRgsWIVOpW3FNu9u9nhM3QkZsU2c3
	 u7p92ytE43CfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF4D83822FA4;
	Wed, 11 Sep 2024 02:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] bnxt_en: MSIX improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172602063252.461532.15452708830999969284.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 02:10:32 +0000
References: <20240909202737.93852-1-michael.chan@broadcom.com>
In-Reply-To: <20240909202737.93852-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com,
 selvin.xavier@broadcom.com, pavan.chebbi@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Sep 2024 13:27:34 -0700 you wrote:
> This patchset makes some improvements related to MSIX.  The first
> patch adjusts the default MSIX vectors assigned for RoCE.  On the
> PF, the number of MSIX is increased to 64 from the current 9.  The
> second patch allocates additional MSIX vectors ahead of time when
> changing ethtool channels if dynamic MSIX is supported.  The 3rd
> patch makes sure that the IRQ name is not truncated.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] bnxt_en: Increase the number of MSIX vectors for RoCE device
    https://git.kernel.org/netdev/net-next/c/f775cb1bbfd5
  - [net-next,2/3] bnxt_en: Add MSIX check in bnxt_check_rings()
    https://git.kernel.org/netdev/net-next/c/2d51eb0bd81c
  - [net-next,3/3] bnxt_en: resize bnxt_irq name field to fit format string
    https://git.kernel.org/netdev/net-next/c/f77cdee5db06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



