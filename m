Return-Path: <netdev+bounces-234239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CBEC1E0D7
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 02:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37C3D4E21F0
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 01:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7882D9498;
	Thu, 30 Oct 2025 01:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ohl4oLXA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7213FC2;
	Thu, 30 Oct 2025 01:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761789038; cv=none; b=JkgSkVfnRURsyyPYOzzQVgib4wh0PPOOMsz/mSYhTtuYvEUyUcq80Qz1OKgVHWBu5Jf2uIxAR6q4nBt99s0z+lSJpKWk8PjdJYx1zQlc80rMkFOqFWHvRqbsMKkPbBPSNoPreG3gIHf0qJrhR3Tlr/Pa6GLhgFUrf2gXOFt4bLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761789038; c=relaxed/simple;
	bh=eU7WGgbGrRXL6YcJBO7A6DdWWT6jGoKto2v87FPSkYU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YtltGTpfE8Vd698E487Gsv8lSDvbSG95+Q6qpVM5ThSnyKqGFIlszDnXNwM1yDEATwH9NsaZbUvx1xSuom7xaY206u8Vlyfr1ewTDpmjgbZB8ysgPtq/AaM/PZtt7zLVe16ehJfh9DHnU9mgLbH0Ja5qyquVVSO/KmtA0WntiDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ohl4oLXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B819C4CEF7;
	Thu, 30 Oct 2025 01:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761789038;
	bh=eU7WGgbGrRXL6YcJBO7A6DdWWT6jGoKto2v87FPSkYU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ohl4oLXApQ8qLxTi/pvYORGROOnBGx885NYRhMU05HhXQecSFH+sU4OqJk/hqikX7
	 zfkNVPOCO6D9IzVC3c3n8v33a2gaUP+sueOxi8fFESxk3vHxMcprrFfbDeH625F5pW
	 oAP4LZP7YfcnrifJrF5pwT7DT/8MQwZXc1olhcVNZZkiuutjV+lY3VwAf+YDMurYsx
	 On4lcyjpMb2kwAeFxWiuKCNgTjOSmdbIX2qSgCrJha9QTEXXxeyiWVdz8virMZwqQn
	 bcBPMEMVzxwkotBC/98Sytj92W0Z5U/PmP1pdYkTdMci8dY2DZfNJ8dBfAtq/4JGP0
	 Q9PfO1ZLpZceQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C213A55ED9;
	Thu, 30 Oct 2025 01:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V3 0/3] tls: Introduce and use RX async resync request
 cancel function
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176178901482.3280604.3668884235905347850.git-patchwork-notify@kernel.org>
Date: Thu, 30 Oct 2025 01:50:14 +0000
References: <1761508983-937977-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1761508983-937977-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: sd@queasysnail.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 saeedm@nvidia.com, leon@kernel.org, mbloch@nvidia.com,
 john.fastabend@gmail.com, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, gal@nvidia.com, shshitrit@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 26 Oct 2025 22:03:00 +0200 you wrote:
> Hi,
> 
> This is V3. Find previous one here:
> https://lore.kernel.org/all/1760943954-909301-1-git-send-email-tariqt@nvidia.com/
> 
> This series by Shahar introduces RX async resync request cancel function
> in tls module, and uses it in mlx5e driver.
> 
> [...]

Here is the summary with links:
  - [net,V3,1/3] net: tls: Change async resync helpers argument
    https://git.kernel.org/netdev/net/c/34892cfec0c2
  - [net,V3,2/3] net: tls: Cancel RX async resync request on rcd_delta overflow
    https://git.kernel.org/netdev/net/c/c15d5c62ab31
  - [net,V3,3/3] net/mlx5e: kTLS, Cancel RX async resync request in error flows
    https://git.kernel.org/netdev/net/c/426e9da3b284

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



