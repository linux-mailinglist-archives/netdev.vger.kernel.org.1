Return-Path: <netdev+bounces-135226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BD699D035
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11BA1F23D06
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764A21AD3E5;
	Mon, 14 Oct 2024 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFPpBzHv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EAA1CA8D
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918024; cv=none; b=Zl6MBH2amI/8kM8TgQO1rroOqjixNAZHxeSb9nRpNuJZcDAiIVkok//bSWl91s7FFysNtsYnOuGpmsq3JT0bgEyU6P8u9o7YDPYY0Rq5Xn6CQMJSaZ2SquGF7zlaR/jph7R9gQT6XPihpUR9ONpc1WB6qU422DH6uP5rL7HFbhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918024; c=relaxed/simple;
	bh=ZpHhHBjSLLBBuW3ueaSWWEbCTzCVC9HiNFsuOspmGS4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l+tDBszB0vb2osRX6IWVNr6yYoXh9jXdAg3dXs9sSPzfICauLf0GjtGb/t5DiA9ubOZNdRWPeQ0ksjhQYFf+BWrf7d6w264aN+NTGiu3QyF6YpjkwbO2O1rG5W95eZgBuZjklwZgLsCIFAb9UFoonqxv+3tNM5Dwjiq4NnGG5/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFPpBzHv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF634C4CEC3;
	Mon, 14 Oct 2024 15:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728918023;
	bh=ZpHhHBjSLLBBuW3ueaSWWEbCTzCVC9HiNFsuOspmGS4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lFPpBzHvaxXkuRUgt1b9UlkPi//JLa71HL/92kuxOX/p4jgfBulQe0nrxDMsy6fIb
	 Cygz1sMg+OvsJzhD5VZbcV5fTmuD5xflAMyiXonIRHD+C9j7DlXEBAO9L7JNjoUBrT
	 uS0A32JzbU6Q1Ab1ATDDDY4TtMISZc7mFAFC3cNyL2/3EIRDHqfzMqqSzZTPz4RUQI
	 TMSeA+xmEg5How7+mucU+ysnBwOpzLp7RKAtx0fdJbsrBEqfT2FniVSbbYJP624UE0
	 M2sQ2TucDp4ETfNyhVdzbWVbb5BJFmyzgPPESsoNxIn7sjyE1tqk5MvxV/bGX1DJUf
	 3npr/d3ttLOiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B433822E4C;
	Mon, 14 Oct 2024 15:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: add Andrew Lunn as a co-maintainer of all
 networking drivers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172891802903.542696.11691345521100512317.git-patchwork-notify@kernel.org>
Date: Mon, 14 Oct 2024 15:00:29 +0000
References: <20241011193303.2461769-1-kuba@kernel.org>
In-Reply-To: <20241011193303.2461769-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Oct 2024 12:33:03 -0700 you wrote:
> Andrew has been a pillar of the community for as long as I remember.
> Focusing on embedded networking, co-maintaining Ethernet PHYs and
> DSA code, but also actively reviewing MAC and integrated NIC drivers.
> Elevate Andrew to the status of co-maintainer of all netdev drivers.
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: add Andrew Lunn as a co-maintainer of all networking drivers
    https://git.kernel.org/netdev/net/c/0b84db5d8f25

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



