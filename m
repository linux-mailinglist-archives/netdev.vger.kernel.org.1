Return-Path: <netdev+bounces-151350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38BB9EE4E0
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 12:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBAE82808BC
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 11:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0180D20E028;
	Thu, 12 Dec 2024 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZD7IDtEb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13BE1C5497
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734002415; cv=none; b=BWNmGbrsy0LpQIdpHgUwc9HU0/ePvlZaZvEylnKJ8UeRG6YlkgMstF1+V4NGlapmJblqR6dyLGMod3Tyyog77TfMThQCmRb7WrPsPISOlhOg5e42zu3IULTxFBHGrqF3+1YZcXQzxzIyaLffVbT3FQ5cuISMZjrZ4o+5mA2B5PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734002415; c=relaxed/simple;
	bh=pBNjYNLG87wfF5ZBAgZCbrsjcrlSTwN3kMC9/pb6JAM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LYcC7PfeVJEsxjJw/KgilVhr2V0a+U19mDAaGnYw+c9kK8LNfc0PZ5t+ffaIebWSFrH1p/5hLF8KqY1GGG5GwtNxDVc13doj+ov6wzpFuww64fR2fa7/bk4FcdVDT1vXTtFLKpxdc+FOm5wE/eX+uPCQ/L+pW6RdjX1m7YAeXZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZD7IDtEb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C14C4CECE;
	Thu, 12 Dec 2024 11:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734002415;
	bh=pBNjYNLG87wfF5ZBAgZCbrsjcrlSTwN3kMC9/pb6JAM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZD7IDtEbQX95sP5mXKjCpWDJzKaAIlniBkq69DOBPv85242hQe9ff+OYZcA6O7otq
	 evoTpLLxYEuVO6SePF5Kq/o7DxA5A3dwLQSrbfOWvM85b3auwrYI8LIfVZ2dGpBrEf
	 m9hZ90USMKWS98YQ0RymhG31bDbS52ChG9dNwbBmbx3JncsFfz+drr4CKWxoayiNZ8
	 ZWQpPWPfGjJS36MXIw6Q6Vlhk18wYNz1QijL7HxSCH48cJaZ9eJnkpu9JLSX4+BylU
	 kQwY7dQbjwXkLvi7pEqmYQDjw3lb8aE+7yorqC5vA+UCuxqRvBkPjufG6sl55DQ2sg
	 LHU2di2CvcxdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0FC380A959;
	Thu, 12 Dec 2024 11:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] ionic: minor code updates
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173400243150.2263704.13209593856094716019.git-patchwork-notify@kernel.org>
Date: Thu, 12 Dec 2024 11:20:31 +0000
References: <20241210183045.67878-1-shannon.nelson@amd.com>
In-Reply-To: <20241210183045.67878-1-shannon.nelson@amd.com>
To: Nelson@codeaurora.org, Shannon <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 jacob.e.keller@intel.com, brett.creeley@amd.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 10 Dec 2024 10:30:40 -0800 you wrote:
> These are a few updates to the ionic driver, mostly for handling
> newer/faster QSFP connectors.
> 
> Brett Creeley (2):
>   ionic: Use VLAN_ETH_HLEN when possible
>   ionic: Translate IONIC_RC_ENOSUPP to EOPNOTSUPP
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] ionic: add asic codes to firmware interface file
    https://git.kernel.org/netdev/net-next/c/4aa567b1df8b
  - [net-next,2/5] ionic: Use VLAN_ETH_HLEN when possible
    https://git.kernel.org/netdev/net-next/c/33ce1d41c133
  - [net-next,3/5] ionic: Translate IONIC_RC_ENOSUPP to EOPNOTSUPP
    https://git.kernel.org/netdev/net-next/c/7c372bac12b2
  - [net-next,4/5] ionic: add speed defines for 200G and 400G
    https://git.kernel.org/netdev/net-next/c/a8b05dd3389f
  - [net-next,5/5] ionic: add support for QSFP_PLUS_CMIS
    https://git.kernel.org/netdev/net-next/c/a857c841e7ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



