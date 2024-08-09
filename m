Return-Path: <netdev+bounces-117059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1122394C8B7
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 05:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91A19283C21
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 03:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D5E1803D;
	Fri,  9 Aug 2024 03:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMbl5bY/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1081517C8D
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 03:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723172438; cv=none; b=JhSKterS1ghzOhFbIlWXu33UqHFCXQLElDw4wQg70Uub2qXHJY/FTfk+oroS/wFq0ih6ENbmvC7iJREOb3Szwr8LM7rf+k9cD1t4mPDuDGi8VLvjGDGhvzwqSI/Aqylm3pJZj0izHvkyJP1Fem26O6RDZhBV4vSqqaVyd3BpJTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723172438; c=relaxed/simple;
	bh=uziS3fKqNyoM2q4c421Gn6vUPSNyMAa7OaVWMLLX7y8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f8cPWNlmOsTlojKlCmepzqV18SPDYL0dcFN6HDcj4Q9NF7wWCJQ92wSIHM8ylSoEJbdWIA3fFYf/rYsAsUst9byMdJrw91ivviwPCjIvy5QfG6Yh5Jipb2ZWxS+YGg/alt1pZG7rGUELtq3njXMGAEUQssQkgN0a/HcT8hpn53Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMbl5bY/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D01BC32782;
	Fri,  9 Aug 2024 03:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723172437;
	bh=uziS3fKqNyoM2q4c421Gn6vUPSNyMAa7OaVWMLLX7y8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qMbl5bY/iKY1iSwB7WbvdtRp/5PE17x4dVzZBFtqLi2XcfqMOvdmeBf1e9YOzjees
	 iOU/4e9uKlNRs4lLbOEiE01EAQgeVxGsCe1mx0Jt/pPOujisZFusK31gHlX9Lrxv31
	 iBENObIoWW//YUfqRqDlyc/QWjfbakmLVQdCDf1GNd47mAg1AOyHU42seYSe5AfVad
	 KMt3uNe+9mLY4dQKcKDfyMTGVCfiqQBBeJplXyW6UtYBhb4lbhK2dGKNsWpOO9/zsq
	 ouXCswQf/IJv83oP28v1FG99EGyZc8NsqIkZ63YLwMeBlN/oRythuJZxqie3NRv/lX
	 KCjMOjUpI+vbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE51B3810938;
	Fri,  9 Aug 2024 03:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: atlantic: use ethtool_sprintf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172317243649.3366602.84167247884144563.git-patchwork-notify@kernel.org>
Date: Fri, 09 Aug 2024 03:00:36 +0000
References: <20240807190303.6143-1-rosenp@gmail.com>
In-Reply-To: <20240807190303.6143-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Aug 2024 12:02:53 -0700 you wrote:
> Allows simplifying get_strings and avoids manual pointer manipulation.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  .../ethernet/aquantia/atlantic/aq_ethtool.c   | 21 +++++++------------
>  1 file changed, 7 insertions(+), 14 deletions(-)

Here is the summary with links:
  - net: atlantic: use ethtool_sprintf
    https://git.kernel.org/netdev/net-next/c/df665ab188cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



