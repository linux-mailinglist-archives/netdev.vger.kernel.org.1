Return-Path: <netdev+bounces-111972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7A293453A
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 02:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B963FB21E3D
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 00:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2265726AEA;
	Thu, 18 Jul 2024 00:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZfMOcDU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20CE1B86C1
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 00:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721260833; cv=none; b=Cq7OyWa28KBcU+0iQckUoUtDMA3lcWJKj07RWJaJmQ0Sy34LpfHuQDH9CT2ZOQSf0Z6JxFL8k8WXPk2P8fDD0+nzY6rDXCqTRcbb35CwJKgMX4nXlQFZ8pRQ2CIRImHm+AiQFUBinRp04wLmNDHIuehoe/xS162Oew7xxK0TSTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721260833; c=relaxed/simple;
	bh=y7ghAJE8eoJJa2FJ3+WhdO/k4qH8ERsqm1POaoIg98M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bTkzWf5qVVk8NOfHMUAx3tjREwFfpmV25Z9EeRbjmOwGz8DqeCLeV8ye7QmCRZocby/uqTobvYmiTi5MxejtAxSWMFy2LSkdO/lh1Av6+50mch1PkHJPDqFEvzI0Edo5piqx8L6oIBVUsvmHi9pfRP6AV2itmy7tTeI8WVwjwR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZfMOcDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 989BCC4AF09;
	Thu, 18 Jul 2024 00:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721260832;
	bh=y7ghAJE8eoJJa2FJ3+WhdO/k4qH8ERsqm1POaoIg98M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bZfMOcDUhxiQtjPZvWCmWeCD1u/xyAhYML/ooYY4NEEXHw+mxwP+StUj+GFXzmQ15
	 +1cuWWQ8p0UnfyxxmxZa4Y7YiaM6pFw+0xyzUDUp/RZTs0lqeTaaTADwzR5bCuUh5D
	 VhU/P7EsUylo3JEGT9l/GPqRiAfOAIBxUB86NPABmAi6MdL+wq5SpjdhdfouU72+m5
	 1Qmci5kjoxU/gGZQlqtEL19owF/7NEVdwtebEgVt6KL0AD+ZqfJFZ8rE+wTrXzvE31
	 e9X50CRCQ3pQtdyWK1F7qNUMtNwC2DP2dvtBAL4Jw+bGd7AUz9oI0j1aXgR8uIlgPk
	 Dz++cLywjtE0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85105C4333D;
	Thu, 18 Jul 2024 00:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] f_flower: Remove always zero checks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172126083254.7578.19993245723342659.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jul 2024 00:00:32 +0000
References: <20240707172741.30618-1-maks.mishinFZ@gmail.com>
In-Reply-To: <20240707172741.30618-1-maks.mishinFZ@gmail.com>
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: stephen@networkplumber.org, maks.mishinFZ@gmail.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sun,  7 Jul 2024 20:27:41 +0300 you wrote:
> Expression 'ttl & ~(255 >> 0)' is always zero, because right operand
> has 8 trailing zero bits, which is greater or equal than the size
> of the left operand == 8 bits.
> 
> Found by RASU JSC.
> 
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
> 
> [...]

Here is the summary with links:
  - f_flower: Remove always zero checks
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=b06341a252a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



