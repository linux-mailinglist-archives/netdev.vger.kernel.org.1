Return-Path: <netdev+bounces-126132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9859F96FEE3
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 03:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE5E1F23BCD
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 01:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3E5168DA;
	Sat,  7 Sep 2024 01:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFm4ds2J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43371CF83;
	Sat,  7 Sep 2024 01:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725671434; cv=none; b=d1b7ZBc1HwwH9dN5J78gUoX4Yr3NB02XL/RsNAK5/wkncWqe5gI7kWNtjgGN0jyKkZYCaAE0DvHS+fpgpKmo2FDCwRGV3bBs/NXYgolkhAJoNb4QGHdXDflLRw396yx6mVbKOxhtvgfq9wt4j5JxMuX4T5D+DcAaOi0gdBpEwGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725671434; c=relaxed/simple;
	bh=GiZztz3WOXElZk8KGkeKQ145fb/w8KsZ6vdRLvoCkDc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mo1VBpd7PEtxn8SgSbgSWOVZ88aYV+4EE5GoD/gMSOyR9Z8WGfyVvxP4vwfT5P8KGDAS3/y3cdhliHru0TaAh/cL/RIiUtNmoCeb4J8la4tiWG4u1iPq3V5hOj5W7g2fUb4m1RVcFfzL38bjPt/uio9zsKjidpu8K4GUk5pCPp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFm4ds2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500C2C4CEC4;
	Sat,  7 Sep 2024 01:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725671434;
	bh=GiZztz3WOXElZk8KGkeKQ145fb/w8KsZ6vdRLvoCkDc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CFm4ds2JVFUPGXSkaEx6S5wCpeqkh3I/Zt2+aH86dpO+NmHwSeyVJ04xFpgqJi/r2
	 kbhbNsyP8xXXI/AzMVED5627BieO1IiS638XU3u6ZLqfA55FmqpqvsSH4G3yc0lxCM
	 +4fA1iVPa09vDV+Ffixi9DvsL032dhF8gado3hiRCNO0vjHlRKUPox9ES1SGxhUo/f
	 xgxeCDUV+Cw7nfvLFSaLR3l5A+ftjFKZmaFP9Co8yPZF701Y72jYeLqejIYMHF9spN
	 mqtEKTX9yzsLM8daK2PRR3GmrsAgxHDEDIwfVxHbP3PxoEcj9ENLilOol1p1d1MGsV
	 dMnAFzcKUEvQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BD73805D82;
	Sat,  7 Sep 2024 01:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sfc/siena: Convert comma to semicolon
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172567143509.2573151.13384461285910953583.git-patchwork-notify@kernel.org>
Date: Sat, 07 Sep 2024 01:10:35 +0000
References: <20240904084034.1353404-1-nichen@iscas.ac.cn>
In-Reply-To: <20240904084034.1353404-1-nichen@iscas.ac.cn>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, vladimir.oltean@nxp.com, shannon.nelson@amd.com,
 wintera@linux.ibm.com, kory.maincent@bootlin.com, alex.austin@amd.com,
 netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Sep 2024 16:40:34 +0800 you wrote:
> Replace comma between expressions with semicolons.
> 
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.
> 
> Found by inspection.
> No functional change intended.
> Compile tested only.
> 
> [...]

Here is the summary with links:
  - [net-next] sfc/siena: Convert comma to semicolon
    https://git.kernel.org/netdev/net-next/c/96487cb211ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



