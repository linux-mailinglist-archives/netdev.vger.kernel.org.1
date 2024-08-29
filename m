Return-Path: <netdev+bounces-123039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C7D963824
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 04:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3041284EE2
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 02:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8FD3FB9F;
	Thu, 29 Aug 2024 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWZ/fpXE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367463D55D;
	Thu, 29 Aug 2024 02:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724898030; cv=none; b=fWQ8DgDTRNP+GCC+tN6iZLAkiod4HhG4O4ScqLRfj7xZIRc2rldkC0tv06vRP74AzX0aPcTMiUBybvVVJCGhDmX3AqVQlqKIS4e3MzHhOqdYelyq8BGA35Uu6WuT7IFXRFgY7zWlAI6TvUANBlLMrOrvPD/xAHCgrVmhRCXPkDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724898030; c=relaxed/simple;
	bh=9mMY2Z0Y4vJGpOwB+b72EhCB8E0QbLUDGokDTeOKhE0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XHpl0850Wzx3smedAsQ/wC3WBYCzAY+SejToOMTmoR3j30iXzvaA505yT4npacAeqZFnuO88kAZyKRWAjYUi8t3vMOMq8M88/+OTSS+ciLKdvP8OtpsNPp7vfOCbxvcSoRrDe/fmv1+m7AaTyAi/NHPZVceddNMuvHadzz8PhMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWZ/fpXE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AF9C4CEC6;
	Thu, 29 Aug 2024 02:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724898029;
	bh=9mMY2Z0Y4vJGpOwB+b72EhCB8E0QbLUDGokDTeOKhE0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CWZ/fpXEw7QJZD5cXwy6lBcryLeNf0X4Bwh6fUl35IW4S4NociuWAonElJLQ5bA6n
	 bQD9JHA24GP/TBJz6JxQLqCmoVdVQZZPrxwdugGkRLOCPs+OAUnQ0E3lDTPix940Yq
	 VR5culcKZW/2M7gBW/rtrQ184SG8Rki8BMPqsKN+QWe9I28MiB+51zYPESWbbnRhXM
	 ++45rHJG7X3Esuko2Xjy3aTL4isyoP4YfsZ2KfkybAtQB9OLMB65i+hXbjOR0J1jbG
	 6Ua508c3kjTzINXEb02k6M6GyyZPMuzNZ8UNEvp1HN1i4TBrhzPFr+CumTAHyF5dXJ
	 hNvHWCpPFUIuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33ECE3809A80;
	Thu, 29 Aug 2024 02:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next RESEND 0/3] net: hisilicon: minor fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172489802976.1497345.3877992477714321807.git-patchwork-notify@kernel.org>
Date: Thu, 29 Aug 2024 02:20:29 +0000
References: <20240827144421.52852-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240827144421.52852-1-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Aug 2024 16:44:18 +0200 you wrote:
> Minor fixes for hisilicon ethernet driver which look too trivial to be
> considered for current RC.
> 
> Best regards,
> Krzysztof
> 
> Krzysztof Kozlowski (3):
>   net: hisilicon: hip04: fix OF node leak in probe()
>   net: hisilicon: hns_dsaf_mac: fix OF node leak in hns_mac_get_info()
>   net: hisilicon: hns_mdio: fix OF node leak in probe()
> 
> [...]

Here is the summary with links:
  - [net-next,RESEND,1/3] net: hisilicon: hip04: fix OF node leak in probe()
    https://git.kernel.org/netdev/net-next/c/17555297dbd5
  - [net-next,RESEND,2/3] net: hisilicon: hns_dsaf_mac: fix OF node leak in hns_mac_get_info()
    https://git.kernel.org/netdev/net-next/c/5680cf8d34e1
  - [net-next,RESEND,3/3] net: hisilicon: hns_mdio: fix OF node leak in probe()
    https://git.kernel.org/netdev/net-next/c/e62beddc45f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



