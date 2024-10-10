Return-Path: <netdev+bounces-133988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0B59979FF
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 03:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38F51B20FE5
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 01:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BB8224CF;
	Thu, 10 Oct 2024 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsRzIAHF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD791E4AF;
	Thu, 10 Oct 2024 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728522628; cv=none; b=GHToK0YARy2+RTgpJyvUMCaYBqhMDfhB2ccnewpe5v5COELAtPKTpMiRxfu7dfdtB0tn5ISMVZ23+x12/UMC1JhWIvz75sn+ZpmhtIMsPifIjjrnsq6335PcjjaRFPW3NVC+5toO4TFDBlltqwJyKhdnZBqUQ9RI9VI5XrbswAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728522628; c=relaxed/simple;
	bh=xhKT5vLVg/yu/vw1Ps/dpbK/Y6TaP32n38dOgdh7MOE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lCjIYU18l/Nwm19xcDm1JLxZUg8lVzpMUVMsEShi1QpHrW7t+1/DeRDyiS6+x6lE1tVADSJPGqFxFu8nGw/xpnSK8qjGL/fGObd6zBxqA2fKj+f6T7KBGbq12A6DpbZOfDqIRkSpptObMvMpBzBEZ2Yn+IeRJBTsyPfcM5HkI9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsRzIAHF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6D7C4CECE;
	Thu, 10 Oct 2024 01:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728522627;
	bh=xhKT5vLVg/yu/vw1Ps/dpbK/Y6TaP32n38dOgdh7MOE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BsRzIAHFrIIH0MApQS3e64qrmGBQAJmvlTahMW6QMFsxk9YSBaJCXRJFe2mrF5hT1
	 SqrJ/C1sDPzh5s3bG1e1twt+ztfMUK03tJGRCzg+Dft58lyQW/SQ7ZkexjNqOLk1bS
	 8SvaKjU9ZXmT1wIUp/xYZ01H8T1nhAJYQcK6kPI1o1OcHjSEjyQbr8ioUyfAAbLtu1
	 fwXrg/p1tWZROAP1LKqynlXWYrii+z4BzTzXDpc4lRoK03NMv/ziNfeDr2KAPK5FEM
	 CvfF5sIHPEYfB+Egi438vcAvKiqIBCjD4CEOLOrc8cvV6Ge6AIZEhmHR5EjFcBPOlE
	 hfZiYk42hsR5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB40A3812FDB;
	Thu, 10 Oct 2024 01:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2 net-next] qca_spi: Improvements to QCA7000 sync
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172852263176.1528050.13430064371202830414.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 01:10:31 +0000
References: <20241007113312.38728-1-wahrenst@gmx.net>
In-Reply-To: <20241007113312.38728-1-wahrenst@gmx.net>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 mhei@heimpold.de, chf.fritz@googlemail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Oct 2024 13:33:10 +0200 you wrote:
> This series contains patches which improve the QCA7000 sync behavior.
> 
> Stefan Wahren (2):
>   qca_spi: Count unexpected WRBUF_SPC_AVA after reset
>   qca_spi: Improve reset mechanism
> 
>  drivers/net/ethernet/qualcomm/qca_debug.c |  4 +--
>  drivers/net/ethernet/qualcomm/qca_spi.c   | 30 ++++++++++++++---------
>  drivers/net/ethernet/qualcomm/qca_spi.h   |  2 +-
>  3 files changed, 21 insertions(+), 15 deletions(-)
> 
> [...]

Here is the summary with links:
  - [1/2,net-next] qca_spi: Count unexpected WRBUF_SPC_AVA after reset
    https://git.kernel.org/netdev/net-next/c/234b526896a9
  - [2/2,net-next] qca_spi: Improve reset mechanism
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



