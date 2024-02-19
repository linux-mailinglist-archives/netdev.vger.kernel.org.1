Return-Path: <netdev+bounces-72902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F241385A129
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 11:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92B8AB21097
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 10:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E647F22F13;
	Mon, 19 Feb 2024 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YK0vd+Zh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86C6286AE
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708339224; cv=none; b=vCk1g8ZLt8cmCXh48t4E8/fpNTjefhABRK+Dva067cINGzx9qLSbxTa8TqjzXRDCx5BQq2hC8l+BjVQGIZi2ouyYTfwu8x85YEbsJ6eI2RF5WRfNHsd4keq0k+rXaGWXJ2JZlWAvDwNdRkhEWvbc0d5qvOKMO7vQLM98fbtOQlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708339224; c=relaxed/simple;
	bh=Hi+p9NmtYD5SOQJsrIJgJ/I6D+OeM00/uZoucxt916Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uy0h4A5EogfcsbtYG7x25EK/b4IcSzw75XuK5Q3dcqYYLWrB1ndM/mbRmxL6uDaDiWIq01mJ6ww137qwQ34F20UvDXvmTNTgG/RvA8AFgz462uHvKjzYar1mMeB4LzyIkhaorPzqgrLhLvxkkvIQ+ESoMdWX7YcdmGNDEjzJUNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YK0vd+Zh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35392C43390;
	Mon, 19 Feb 2024 10:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708339224;
	bh=Hi+p9NmtYD5SOQJsrIJgJ/I6D+OeM00/uZoucxt916Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YK0vd+ZhVBl317TS6BpVKP0iDnlvA5VIIYBQK9TK1xbI8P8JyGKtGZ8GqFZ8zQRbl
	 owYl1PGQYsQByJCq1Xj+hfiwfXCw6JlwqTYK/h8LHVX6zSXbiB/0jxZcW8J5q1mM58
	 1JjWLeKv6PNcs2H+fkLpGrDFraKwo6J78HNpi0q/NlmoxUlOzz6SuRFDGhtNBcJswJ
	 1iwoY6/g0pquDH6K5LhsKz7IKJB57Kd5W5rl/qNe0tT7IFfBxXmFIjCT3MbYm7YOyo
	 oMWN86V1sulcQtUY4eN+V2PFQeedlq5cgYgYL3zumqsnwmQlFp3BvlApv9247mcvbv
	 b3a5xo2imzcyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1DD56D990D8;
	Mon, 19 Feb 2024 10:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ionic: use pci_is_enabled not open code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170833922411.7770.16018685958374209983.git-patchwork-notify@kernel.org>
Date: Mon, 19 Feb 2024 10:40:24 +0000
References: <20240216225259.72875-1-shannon.nelson@amd.com>
In-Reply-To: <20240216225259.72875-1-shannon.nelson@amd.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, brett.creeley@amd.com,
 drivers@pensando.io

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 16 Feb 2024 14:52:59 -0800 you wrote:
> Since there is a utility available for this, use
> the API rather than open code.
> 
> Fixes: 13943d6c8273 ("ionic: prevent pci disable of already disabled device")
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> 
> [...]

Here is the summary with links:
  - [net] ionic: use pci_is_enabled not open code
    https://git.kernel.org/netdev/net/c/121e4dcba370

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



