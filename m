Return-Path: <netdev+bounces-184026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 256F6A92F89
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 03:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A0D1B80123
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 01:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A3825E81B;
	Fri, 18 Apr 2025 01:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJe60b81"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C1E25E467
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 01:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744941023; cv=none; b=GaAmyGcbiJLJ9bywIQeuOTwFfdKsNAAMJBhyYv+UZRPPWy/wMWBUIsRXLjMYvWw3NXKLHRUshwvEbxW/oq3mRhvxnVze6zbZ8MSZkGhLVdBVh3CaEDrIg2owZ1t8J1IBeDQUqfLzASzcRmryhnpgT/xU3DpU+/AVuY0hoyjqh+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744941023; c=relaxed/simple;
	bh=wKWIRjtZiIp2dYPfNuInsRse4yrpGeHdMIp8K1s1/44=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GHaaxDL79xtfgayfC7OyM5mn3hpYmSs0yDHk764fDitV02wXDpUpyJnmR1Qgq8uePCaDclA7WLImIJ4vmecwlNMYt15v4vIEUvjaPudnvq4PNNaDP4WuwxdVoFa2wZRvulHS8VyckuJR4xHCdTBKkfUOFwFPykfJq41uQcsqQC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJe60b81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54473C4CEE4;
	Fri, 18 Apr 2025 01:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744941022;
	bh=wKWIRjtZiIp2dYPfNuInsRse4yrpGeHdMIp8K1s1/44=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gJe60b81PP1FgE4576vkpnbDOeRCatZLVN5j2Ml/gta/LqvIQ8l6g0DtNJzAPluUo
	 A+w/YEoLXxhOxaFrv9QWBag4ibQGBkOmvSAURcGp9QMj3719ZzGEjmCb7skRdsGECh
	 ELpJFUhdd5ljhU/1BWQ3780VgsSQPdpqflX+j3syHRzp9KZiDP1qD+fqxRW9BgGeeM
	 cVrJKVhkOp+8EIwMTjTmZLcnx1nnvuj1o02zPSXNNJkoclILrTmfKr/vwKfy17XXc1
	 o+dY5TxTwxjcrHRf+kpSxvjw9ECLX7c2V7guuZ2lxC5szrB17zL2es4jcXKL5zCFSU
	 HSOrt72Pht6XQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC31380AAEB;
	Fri, 18 Apr 2025 01:51:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: refactor chip version detection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174494106035.75375.9501447925343563838.git-patchwork-notify@kernel.org>
Date: Fri, 18 Apr 2025 01:51:00 +0000
References: <1fea533a-dd5a-4198-a9e2-895e11083947@gmail.com>
In-Reply-To: <1fea533a-dd5a-4198-a9e2-895e11083947@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Apr 2025 21:29:34 +0200 you wrote:
> Refactor chip version detection and merge both configuration tables.
> Apart from reducing the code by a third, this paves the way for
> merging chip version handling if only difference is the firmware.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 325 +++++++++-------------
>  1 file changed, 128 insertions(+), 197 deletions(-)

Here is the summary with links:
  - [net-next] r8169: refactor chip version detection
    https://git.kernel.org/netdev/net-next/c/2b065c098c37

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



