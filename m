Return-Path: <netdev+bounces-103004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644E2905EF7
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 01:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC110B22401
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 23:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD67112C819;
	Wed, 12 Jun 2024 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRnCU4cj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961A74597A;
	Wed, 12 Jun 2024 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718233844; cv=none; b=oPK/JwZaMt61ts4qVUrleCHs94aBG275MCvREMU52GYGz6VoagKPcOZODPzV8fFSNarB54fqQM9GeNEjcXAZ+nlOfGwVdF5pVhxbWW+2cRL0rY1ShmB6reMED/grUbfrv/ZIf1lm+Az96lBl5zmU7NUHZ0CL8y+X8gY7V9v/oJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718233844; c=relaxed/simple;
	bh=7O9hS8SZ1m9W6Ge9OVT1ZjAtj4M7EvpT4X35ACqANtM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=el63i7MBa/jM4xqxEoX/bndPtGLa4aPHXCoKvfBMW+HL8sGhCvnpFYuPdMSmF3OQuuUCfiXZbY+i7jbXVIgjQJKC6vvayEaw4kej/jfXZMhebEuHMrXKs9AkmazMHKDS58PW+60nw0fzLdzMEbGihPpmBl9+//kbr9bmdKsAxro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRnCU4cj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35E22C4AF1C;
	Wed, 12 Jun 2024 23:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718233844;
	bh=7O9hS8SZ1m9W6Ge9OVT1ZjAtj4M7EvpT4X35ACqANtM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eRnCU4cjcN2eURWVIPVaZji/UPFo1ZkR4lh5zfitUWAjiYFr+gbGPPOL/bTGn5dO1
	 VxGmTxiBzcAvz2Lwpvt0kGvf2ONpWibWkQ12prroX5YpqM3nMZ2iC2vHYX7GzEuu50
	 +QG59xun/F3PFA1jkDYaaZ7OvdUX3kVp6hknKeh+ZSLes5O6FLDBl3o90Eto7vWZTr
	 rxWDY2YSWE09AXcEc9fYMi58KzCBZq73QO+rkzP6yyoyWEv3ez5pNGOcMS00CTwYJn
	 PIwh5Ivg5WpRiQZA01db0+T8OCyMsIeR/FV3c/anbhdQrOacCNahuRcqDsPb8OzsG2
	 r4QCZr7nhLRZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1E28EC43619;
	Wed, 12 Jun 2024 23:10:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: xilinx: axienet: Use NL_SET_ERR_MSG instead
 of netdev_err
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171823384411.4751.4325990307048449401.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jun 2024 23:10:44 +0000
References: <20240611154116.2643662-1-sean.anderson@linux.dev>
In-Reply-To: <20240611154116.2643662-1-sean.anderson@linux.dev>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: radhey.shyam.pandey@amd.com, andrew@lunn.ch, netdev@vger.kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
 michal.simek@amd.com, pabeni@redhat.com, edumazet@google.com,
 davem@davemloft.net, linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Jun 2024 11:41:16 -0400 you wrote:
> This error message can be triggered by userspace. Use NL_SET_ERR_MSG so
> the message is returned to the user and to avoid polluting the kernel
> logs. Additionally, change the return value from EFAULT to EBUSY to
> better reflect the error (which has nothing to do with addressing).
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: xilinx: axienet: Use NL_SET_ERR_MSG instead of netdev_err
    https://git.kernel.org/netdev/net-next/c/32b06603f879

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



