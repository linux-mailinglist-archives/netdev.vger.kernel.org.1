Return-Path: <netdev+bounces-73674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B33C85D846
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 13:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C006C1F237EB
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 12:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E0E6996E;
	Wed, 21 Feb 2024 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWB0S1YR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B610669964
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519828; cv=none; b=rmzfjPFY2mtMcPPCT3BcQ80IfYFRNrxu8ZEHVkp7Q99WU10IkCAb+jOfbxZ4V+EVogvsdW3C9V1Q4VPIt6pnDSRzeeZLVziaUHlwrKOQijVr5wE/Q4CtttDsxwWKtNGRVzmtB1rVhcNry6gTUKtSYX+cSDJ+wN8pXZN8bwPhFkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519828; c=relaxed/simple;
	bh=DOD2XiU1aU0w4S1PkZMnWfhoGnP0BW/dqetAjjeFTFo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dx9tAeTCsXBP9sQqd3Kxz9XNRzZzgbWd0kOWhZUPLDqWVbJaGjN2YYYxSRm0G2fHdQ6Z58a6cCYM3X2NGOOWnJ0XpDeHzmxizC4Z1M8HIPGnwglz6H2wfEcRZR3LeV95zrPSVbLIOzVUHugam5NXQnJVEl2WcNAshKQcsjxO4BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWB0S1YR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70104C43394;
	Wed, 21 Feb 2024 12:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708519828;
	bh=DOD2XiU1aU0w4S1PkZMnWfhoGnP0BW/dqetAjjeFTFo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XWB0S1YRi5LD4lN6Pz0bzRDx3hmM6hu8eg75mmMQyha/CaTSypahCkA1wMH/YTacH
	 jKo1xVlRSQRcCeYTUUfrYNW/ibK7JEmgW9UJppx94LQP03pgP/eMnqD1Gby13lYfQ8
	 4mRttLhshG76XSD6XMzeqqT6j8/AZ8zdRhfg0K+vU0uZyyGgcK9G4dKG30CYWcKXG1
	 C7zXrFsA94te/uipEdkLBuVlCVmQnW5mJrRO6UjqJGqr4u3Hp186f3HmCeuFsz9a79
	 igw7sOn1Z4teY0+4eCFDshr6PzlWANp1B2oohT4Xdqi5Z7ziuL0+6soxzLnPaaA4y6
	 mq+JaR4u5NLZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5BFBBD84BBC;
	Wed, 21 Feb 2024 12:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: wan: framer: remove children from struct
 framer_ops kdoc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170851982837.28838.18333445705347848775.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 12:50:28 +0000
References: <20240219-framer-children-v1-1-169c1deddc70@kernel.org>
In-Reply-To: <20240219-framer-children-v1-1-169c1deddc70@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linus.walleij@linaro.org, christophe.leroy@csgroup.eu,
 herve.codina@bootlin.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 19 Feb 2024 17:45:48 +0000 you wrote:
> Remove documentation of non-existent children field
> from the Kernel doc for struct framer_ops.
> 
> Introduced by 82c944d05b1a ("net: wan: Add framer framework support")
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: wan: framer: remove children from struct framer_ops kdoc
    https://git.kernel.org/netdev/net-next/c/78b88ef392c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



