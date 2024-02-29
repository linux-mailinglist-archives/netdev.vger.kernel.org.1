Return-Path: <netdev+bounces-76262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E66B886D068
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 18:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20D1285BCD
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 17:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F376CBE8;
	Thu, 29 Feb 2024 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvG+HJKC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17F270ACC;
	Thu, 29 Feb 2024 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227237; cv=none; b=XfjcCfxu6oQxispmr24xeiuBH04hGZiBOxFTrVYFiSFP0ushu0fqUpBCCWGqIJtPZfRfcy81cX9eUV7oR0fc8HV5VOq+d/beaLhSRRVDmHjQYHyF6EmplOQpNLgscniDm2n+kUrndCDYTxvi6XijMxY/eE2Ntz2e+WmEwVdzFHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227237; c=relaxed/simple;
	bh=gvY06Xt+X0dDR328xLTg5RgB1c7LFErbiyB6OInqfV8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oKbfxpDI786jvRTvwb0eho7mO9uKHjiQ0ZGkzQMAftM5BTkEvzgaN4wI2j/feuXOTq7cFi2pQqUDk6oI8rIHR4tPk5kKQicnBKvX+NQwhPrGGQZ9ZDGS+F+s56mVLt7FVNxC8ZyukvnDfCGfv1kg8hDik3DhUt2Rtw3lxBss/s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvG+HJKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AA98C43394;
	Thu, 29 Feb 2024 17:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709227237;
	bh=gvY06Xt+X0dDR328xLTg5RgB1c7LFErbiyB6OInqfV8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AvG+HJKCMbtYMFYO85Dq1Yf8t1sQYo0J/+H/PU4FJXTI6CoLPk9gAKdMv0QlzoXp2
	 tABJyWyQP0Js8ROY+iYvNaAepI7qUACV8AjHi9tfWIifTMNgvsSA/qqyerTOxwUFQg
	 +RIH7sZG+y55k4AvZDuhZa8xr46v6c03OJ7Q8RTonhfUhQt1KtEA+GCmnCf/A6+aC7
	 UPTDAxNDgzmOgRXbxI6xcGZXVgQ8TwTvZRRMSlAeN0d17Da5MBNKKm11GQZ+M+YBnU
	 Xd9poAhFlYsVziKEt7tVPaz4WU8ZsYWzxhL1IUkYaKziy5a8xeR6e60bIA+fjISv/O
	 QVyaP5ivoadUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62328D84BC5;
	Thu, 29 Feb 2024 17:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-02-28
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170922723739.28034.4279902695429673289.git-patchwork-notify@kernel.org>
Date: Thu, 29 Feb 2024 17:20:37 +0000
References: <20240228145644.2269088-1-luiz.dentz@gmail.com>
In-Reply-To: <20240228145644.2269088-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Feb 2024 09:56:43 -0500 you wrote:
> The following changes since commit 4adfc94d4aeca1177e1188ba83c20ed581523fe1:
> 
>   Documentations: correct net_cachelines title for struct inet_sock (2024-02-28 11:25:37 +0000)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-02-28
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-02-28
    https://git.kernel.org/netdev/net/c/244b96c2310e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



