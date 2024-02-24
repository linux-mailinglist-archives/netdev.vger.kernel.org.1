Return-Path: <netdev+bounces-74664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 252E3862272
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 04:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1601F25167
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 03:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C7712B7C;
	Sat, 24 Feb 2024 03:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3ePU+bF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61630D2E0
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 03:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708744233; cv=none; b=NIEap4za1YLPxKLBIlHGVBbYBQn5G8xK6KGXAQDO7xRfyA5nssP4z6Hy0uKRJmVF032UXHBRWYEM8xH6b68X8A9cIiDCopPv7fKB1HuZH1QHwnWQwFAmIm4IPlTLbzHJv2Zv2pDN07Vc+k1iPsk0dP2n8Hh4+npA06eg9s8btQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708744233; c=relaxed/simple;
	bh=irp9l0BrAcrYQFgGWnbVuIAbly+++0JkIQ4rEUdaas4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QPRkC6Aq1D80Kchy8MM6P7KQVTbP9t0tTj1n/8yOZt/uqZj6iIIbcKkWyMWpf1fmrUt2jeuMGuPCg2/0YRTpp/yOWAXMiw5oFXBruO8OoZ+mg60UicwWxMzCo71/+XmR50mNP6URanQW6//4DcOaYYGndfFXKWWqaWYDsEAPyNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3ePU+bF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2C36C43390;
	Sat, 24 Feb 2024 03:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708744233;
	bh=irp9l0BrAcrYQFgGWnbVuIAbly+++0JkIQ4rEUdaas4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z3ePU+bF08uwKLNkvlSzXjIdCS7eHpfS1o8D+IU6r8AxGA1DhMpW1iWY+vm8GcNMw
	 JXN5B8M/bUgPNOHolncNNTAzMog7dxLPI8KLGPnoR4+aboBhYnLuIJFXU6wlUbtsvf
	 u7nDzlLgYkkXYQar66OuPoGkrAW2fejs4m5wAJTHzKzo6ciu9RTn2bjHl9bsgzfU1H
	 u22tMzX6051zSRdAY6h9zLmyFfguGm37Xauw57zJ9Qc+K2YNvzj22FX2Rw310f/YRe
	 PMD2fqG6tvsbK7P/528xTe3/z8FDMbSO9QwvvLWJDXh2MdhlnN7opSdwH9LyUHRoJM
	 ca2QTmD2UJ0qg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CABE6C59A4C;
	Sat, 24 Feb 2024 03:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl: fix header guards
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170874423282.898.14966256484950846700.git-patchwork-notify@kernel.org>
Date: Sat, 24 Feb 2024 03:10:32 +0000
References: <20240222234831.179181-1-kuba@kernel.org>
In-Reply-To: <20240222234831.179181-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, nicolas.dichtel@6wind.com, chuck.lever@oracle.com,
 jiri@resnulli.us

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Feb 2024 15:48:31 -0800 you wrote:
> devlink and ethtool have a trailing _ in the header guard. I must have
> copy/pasted it into new guards, assuming it's a headers_install artifact.
> 
> This fixes build if system headers are old.
> 
> Fixes: 8f109e91b852 ("tools: ynl: include dpll and mptcp_pm in C codegen")
> Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl: fix header guards
    https://git.kernel.org/netdev/net-next/c/d662c5b3ce6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



