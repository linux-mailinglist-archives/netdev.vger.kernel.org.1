Return-Path: <netdev+bounces-71234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2764852C3A
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 10:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE48284678
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 09:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA482208B;
	Tue, 13 Feb 2024 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/GVy0dQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870011C68E
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707816627; cv=none; b=p49DOI6jCHuRzcujChMEq3BQJPEa6n1kMMOuNbjOqfPLd8zDwWRzOgfNFpLWyWry/tbTM7cYwubFdDqjz99EpW0SCTOZI0PNJWeDbtfq6DoYpuQ1wt/Kel8hOrgVRqVBU4C4RImXyDoZ9cuhfohnsvUohMemdP/8mtrSFkq0yNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707816627; c=relaxed/simple;
	bh=6R1CJ0dGx75FGRWFH3QoOEfdCto9Yy4a+qw6NC+I+1s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dLaVw/cmLfj1fiP9gc53rowMgJcS8tm9TgGtnmdp0TGxT+d3kI2bxUfmbzruxOZaA53S1BzS5/1Y9kaxHsJECgWQh56svAY/IsTD74dZPOJZWBJ8F2b9lfFMVT7hT3mITGTMAicu0S7bqu6tbbF9SIvgTSfCHYJ8DWyFRAuB24g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/GVy0dQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F121DC433F1;
	Tue, 13 Feb 2024 09:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707816627;
	bh=6R1CJ0dGx75FGRWFH3QoOEfdCto9Yy4a+qw6NC+I+1s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D/GVy0dQLe8DdnFbnjmOsXsBs7rnBLZeSRc15GthUhA91B1+0axJuyzr8hqT2zYML
	 6yNYRVfYvZfDVOKvZohl/SomS4cGE22kZNoRu7suPVNi3jw+dO3P4tl+Px3YubeJKf
	 vuA2/EmZ9Tr3GqQ+RSnZ57Z1xWeinEixLPLuNHjjmyDKUy/urLnYBWhEJtzJU2JbAg
	 zDS+OU4ltQJh5jOjjHJ983h8JiX/5XpKOQKrY43RXrpyAg8cwcrBmaYIhuNYoY2AjP
	 Ie0XvfVus6AcLHxRaHXR+QseMJKk6vq3xPHOcmq62R27o/64JH/RrVlcLE8CwFvCAE
	 Zf3QPI63Tk0eQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C32B4C1614E;
	Tue, 13 Feb 2024 09:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: Simplify mtl IRQ status checking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170781662679.26596.16174122173623372072.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 09:30:26 +0000
References: <20240208-stmmac_irq-v1-1-8bab236026d4@linutronix.de>
In-Reply-To: <20240208-stmmac_irq-v1-1-8bab236026d4@linutronix.de>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, yannick.vignon@nxp.com, bigeasy@linutronix.de,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 08 Feb 2024 11:35:25 +0100 you wrote:
> Commit 8a7cb245cf28 ("net: stmmac: Do not enable RX FIFO overflow
> interrupts") disabled the RX FIFO overflow interrupts. However, it left the
> status variable around, but never checks it.
> 
> As stmmac_host_mtl_irq_status() returns only 0 now, the code can be
> simplified.
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: Simplify mtl IRQ status checking
    https://git.kernel.org/netdev/net-next/c/6256fbfd651c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



