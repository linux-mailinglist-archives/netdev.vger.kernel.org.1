Return-Path: <netdev+bounces-236163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B336DC390F9
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 05:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A21BA4E8C7E
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 04:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB371A3172;
	Thu,  6 Nov 2025 04:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9xPnK6i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B061FC8;
	Thu,  6 Nov 2025 04:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762402233; cv=none; b=Aqe0+bhE8aQGYUPg8xZbM6L0VMo9H9fMEvvNO8SVW88v3E/quSyfF23jKOebY/C6wMYk2sjZwIkJcwngR70jxQfgH9FGzvyEwtAPM50uVDoJWlf1DQicDTexUQNortdUMgu5NJxXVmS/KFi+N1u4n1uZfyIZscq2OJtGiVoLkgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762402233; c=relaxed/simple;
	bh=ga2+xUKbhjJ9aVsl9gZoDQxUEUxKvLvGmvNzEc+fKkU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XgAL/s0+Xxu7r2PYhOPr1RNNJ1CkbzaUlFU3+IPrkVFTlQnwuw5Hz7XPNCvRUBXbfWbM9/P6MjAxnfqyYjy/cjMmqW9V7b+RQzIa+T88lR/aSIQoB60dEFNAp88zEsQrLI4jbEJesG7dNohiTJD0oRJL9d7YBKyGlzJtI5NuNdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9xPnK6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D1CC4CEF7;
	Thu,  6 Nov 2025 04:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762402232;
	bh=ga2+xUKbhjJ9aVsl9gZoDQxUEUxKvLvGmvNzEc+fKkU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E9xPnK6iIOWWqXaeZLQ6Axcb+QMTAB0PUl9DnNjp08Ws1qUmKO0o5lqbsqxtA51HL
	 BOT5CgBnkT0aJS0c0BSRATJ4BACDlDOEPHi2HPvO7FJ+YJXU2i4PWIpHbTRh9k/ODN
	 xx5VIuwaDOUIMyltazoJJ22Sy5qksENwxNeSo0rb2PmAN/4FuaQ2ryExhcwBtO/zYy
	 SDJ4gJ32pucanKXapaJyQbQTXx8Q0K7REB1ic1z9bQfxsAaxMDIY7urz7GbT/Jpt4X
	 DzvyPk1PhdzJd5/w5Sg7gzOny6ry264kcUic/9poKb6ULHIFU0O+Fm+VfB6TsJ1LXM
	 aDOKCNNN+rq+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE65380AA4A;
	Thu,  6 Nov 2025 04:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] dt-bindings: ethernet: eswin: fix yaml schema
 issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176240220576.3860998.13642711743910484674.git-patchwork-notify@kernel.org>
Date: Thu, 06 Nov 2025 04:10:05 +0000
References: <20251104073305.299-1-weishangjuan@eswincomputing.com>
In-Reply-To: <20251104073305.299-1-weishangjuan@eswincomputing.com>
To: =?utf-8?b?6Z+m5bCa5aifIDx3ZWlzaGFuZ2p1YW5AZXN3aW5jb21wdXRpbmcuY29tPg==?=@codeaurora.org
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ningyu@eswincomputing.com,
 linmin@eswincomputing.com, lizhi2@eswincomputing.com,
 pinkesh.vaghela@einfochips.com, krzysztof.kozlowski@linaro.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  4 Nov 2025 15:33:05 +0800 you wrote:
> From: Shangjuan Wei <weishangjuan@eswincomputing.com>
> 
> eswin,hsp-sp-csr attribute is one phandle with multiple arguments,
> so the syntax should be in the form of:
>  items:
>    - items:
>        - description: ...
>        - description: ...
>        - description: ...
>        - description: ...
> 
> [...]

Here is the summary with links:
  - [net-next,v2] dt-bindings: ethernet: eswin: fix yaml schema issues
    https://git.kernel.org/netdev/net-next/c/0567c84d683d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



