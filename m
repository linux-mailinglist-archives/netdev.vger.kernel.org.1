Return-Path: <netdev+bounces-61409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D424E823A05
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 02:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63E23B24DB5
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 01:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F525681;
	Thu,  4 Jan 2024 01:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCvKiipD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA83522A
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 01:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0062C433CA;
	Thu,  4 Jan 2024 01:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704330035;
	bh=Tw6kb7zQw4gcU0M0F9ozRrodLI3TuJn+QnBaUWCb2fM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RCvKiipDEfw6I15XYVxI5Ks75jT/i0wnN2UwvJm3AbzpZHPEk1ZpOfDqYEYcAgaVx
	 C1lpuhEIfY8MfFLARdCDePheJB6xQVmpJKl91mB4DADjuzx9qjOgY7FDyOkH6Wj+K9
	 hlZ/irX4C41/nP5Wyv/s6DoWU+KKgeIFwsY9pfz1/KAcAn6ERJvLPnqQMq7kyep1Fx
	 FgpllqxyVMV8fSrHSbj3X+qFik3mfQ6bEHmACkOD0Emond13SqDh1Ao8AesfEGIeir
	 vSrhg0rwsSyodOXbpbfA4oEgUsBWB6+uMWqeAI4ASPhfIpa5nvnuZrgwRVbmIa9wHG
	 vC6bdvwPiUN5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA248C395C5;
	Thu,  4 Jan 2024 01:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] fib: remove unnecessary input parameters in
 fib_default_rule_add
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170433003582.5757.16916533211391952461.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 01:00:35 +0000
References: <20240102071519.3781384-1-shaozhengchao@huawei.com>
In-Reply-To: <20240102071519.3781384-1-shaozhengchao@huawei.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 weiyongjun1@huawei.com, yuehaibing@huawei.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 2 Jan 2024 15:15:19 +0800 you wrote:
> When fib_default_rule_add is invoked, the value of the input parameter
> 'flags' is always 0. Rules uses kzalloc to allocate memory, so 'flags' has
> been initialized to 0. Therefore, remove the input parameter 'flags' in
> fib_default_rule_add.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net-next] fib: remove unnecessary input parameters in fib_default_rule_add
    https://git.kernel.org/netdev/net-next/c/b4c1d4d9734c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



