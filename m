Return-Path: <netdev+bounces-109180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37313927413
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 12:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68AA11C21813
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 10:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16AA1A0AEA;
	Thu,  4 Jul 2024 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pbm2slpJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9161D696
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720089029; cv=none; b=LWwHFeGUYj6dNDASVCgjxAyAhhXohix3seRnVNu3V9qQqFNJU9PGI8sES34W8iU2BXqL48VCL6v0M4LNIZzrfgEY5AEaiPsndg24C43pVKUL+kJQiHBEWKKHDMQFwEn+RI13uZrx9v2T+pmHef0eOeyGunc+MMvxBvSFgQHXSKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720089029; c=relaxed/simple;
	bh=CET3sWaZQexn4QPdCuliU2XqHB7GdEGqL7gZHBWIMhY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=esymjllge+fjWkd8XHlEG4UStHRCFuSwTxoXm+u/wgBpMXus3eMGDrTPy4vhvK/lEYQG5tQ7UY5liOv1lBb0vkSd+Bt7d1acHXHfJimqta7vA0ik236MQKbywD0C3AZ3F7y7nL2Ty1lrxF2/K3yA/k5rttgxWKysETLNKkzx4Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pbm2slpJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B0B8C4AF0A;
	Thu,  4 Jul 2024 10:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720089029;
	bh=CET3sWaZQexn4QPdCuliU2XqHB7GdEGqL7gZHBWIMhY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Pbm2slpJbsQZe+S2AjY/2NTlYablrFmDi75ec2RzUv1yfbxtORhTLXrX8qJetBnlp
	 8xHh7GneTmagAFeRAFIvXeoFIVV7hiW6fTypPe2qs4sQeM+U9JE59d3/fw902iDTKx
	 IZaqubEsUBRpzTYgwiCpKw5s5wxPbBJ9uQnJQKb2QKuIJdE7Yw1scSBd/iDk5SA9C5
	 AyxJ2fow9RUabvXrCqvMgs5YG0+/4a2ABDmesBUrZKZI6xU2Pnc9Uz8g79H9GhZdQl
	 t8Hgupko1kw31p+b3wYCuPgBOesgMMfbbW0FdEEkM8astTj+MyfbLbgumjI3+CLxil
	 +aYCm1UgLmv2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 219EEC43446;
	Thu,  4 Jul 2024 10:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] tcp: Don't flag tcp_sk(sk)->rx_opt.saw_unknown for TCP
 AO.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172008902913.22684.433848898987679005.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jul 2024 10:30:29 +0000
References: <20240703033508.6321-1-kuniyu@amazon.com>
In-Reply-To: <20240703033508.6321-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, 0x7f454c46@gmail.com,
 kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 2 Jul 2024 20:35:08 -0700 you wrote:
> When we process segments with TCP AO, we don't check it in
> tcp_parse_options().  Thus, opt_rx->saw_unknown is set to 1,
> which unconditionally triggers the BPF TCP option parser.
> 
> Let's avoid the unnecessary BPF invocation.
> 
> Fixes: 0a3a809089eb ("net/tcp: Verify inbound TCP-AO signed segments")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> [...]

Here is the summary with links:
  - [v1,net] tcp: Don't flag tcp_sk(sk)->rx_opt.saw_unknown for TCP AO.
    https://git.kernel.org/netdev/net/c/4b74726c01b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



