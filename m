Return-Path: <netdev+bounces-202724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D88B6AEEC25
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 03:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 226A41BC0DCC
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 01:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9192F1C3306;
	Tue,  1 Jul 2025 01:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpsM7bOb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7CA1B424F
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 01:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751333987; cv=none; b=VgV7s+x0IfeY9UcLMg/k/qQqHhOrJCqF4ljMi4jOuo8jVNIW7DJsK9SzpJemkPvl4nndXTKwH0RCp9nmj+f/I9URSHRnETepYGSA6kL5Y+JFXOsA4ggtgqN3fwYItFIeUvYcoFnWZcC7WQNEZDQ4+dbuTccHN90i+V7kbvx+W6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751333987; c=relaxed/simple;
	bh=rOzAaERc6uaw0lurIKree2KQw9eZbt/fvqh6Bk5Y7Z0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZsESxaX3RJ6WZsGrFi9T9uxxmxkKBaIeCRo5qwq1trvKWDS40gf7klZak6twHMzta8Mk5DLW+EagKYii2Pk3M21qAno30wviGfsqZ38dpaYL2j7HyGxZHNRPXnueV/gqrEoXdD2x9EDx1TKjMwwe3/Ia3rC+s9tyanwA8U+U8uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpsM7bOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48C2C4CEE3;
	Tue,  1 Jul 2025 01:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751333986;
	bh=rOzAaERc6uaw0lurIKree2KQw9eZbt/fvqh6Bk5Y7Z0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dpsM7bOb8OmTmeEYca3GFltbAYUNX2yXLqjvpv4Xjf//joRu+lyd1sgZ/z8YGlWna
	 TrEjS1Dusw6cjfLLxiuQCvGc9+afQhshnYx32A9oC7357t89EVR0H2oTo5SpZUatH/
	 rSxdkYpaskc7GEVnfG8C+n53k4uZdwzuLCxTo7BWhvGc5M52sk1FJzHijemh973UDg
	 OiZnkYi7n2QO3wFKP5W9pfQoOCiBd3lktUIBwSpV72ssf0S6DW1laIn6W5QEN0fKa0
	 hFnYp2mmlX8HwbGiVW3Y9zkbap+ZzOBZsv4ROHYFtWyyBdGFODM114FgmAcUzwcubb
	 eownhRfyn0o2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33ABE38111CE;
	Tue,  1 Jul 2025 01:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: txgbe: fix the issue of TX failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175133401199.3632945.398099824350258822.git-patchwork-notify@kernel.org>
Date: Tue, 01 Jul 2025 01:40:11 +0000
References: <5BDFB14C57D1C42A+20250626085153.86122-1-jiawenwu@trustnetic.com>
In-Reply-To: <5BDFB14C57D1C42A+20250626085153.86122-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 mengyuanlou@net-swift.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Jun 2025 16:51:53 +0800 you wrote:
> There is a occasional problem that ping is failed between AML devices.
> That is because the manual enablement of the security Tx path on the
> hardware is missing, no matter what its previous state was.
> 
> Fixes: 6f8b4c01a8cd ("net: txgbe: Implement PHYLINK for AML 25G/10G devices")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: txgbe: fix the issue of TX failure
    https://git.kernel.org/netdev/net/c/e39ed71c7a26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



