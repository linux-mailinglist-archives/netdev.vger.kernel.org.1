Return-Path: <netdev+bounces-73038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8320F85AACC
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 19:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3538C282C64
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5D4481CF;
	Mon, 19 Feb 2024 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUQumPey"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87BC446A2
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366826; cv=none; b=UitRBakwvE4DPbu5q3kBIUoNRsb8MGhgxbqvBqq82wFnEkA1n7kimqxU9DIX0TzePI8nna3G9sfIpca3wA7aPEnBAWv3TA4qqRN3cjSRjjJ48PI90CKXKIWqqsxrClsIUi+ampmNcq8NxZqOtNw7GCevOUSwD9Xh6ecdS4ILyyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366826; c=relaxed/simple;
	bh=udhNB8nut/7SToFpa49ehaC8RCbqUfPjqoVNPWjtGK0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JLH/GPgWDYSUmfSg2WRYrhdGwiWcfQs60nIeMA+CjoT1Caa1aTDdmp9TvZKCIEzQ/ffU664OtqxUy4dr4UiRH5lkS+iQGEAcGpW0mhKKjPsOViLtN0uGblagG+Szg/8ZIB2WVk9HJojphKwY3nZ2B/QnemUOfcYaalYsW5NBZrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUQumPey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65B93C43390;
	Mon, 19 Feb 2024 18:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708366826;
	bh=udhNB8nut/7SToFpa49ehaC8RCbqUfPjqoVNPWjtGK0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TUQumPeySZ5Xv6nX/Gfq1TVq/gFVXU+WJTrNac1rTpiUdtCBK+qBdnLgYEQXUCx68
	 UsjXTBrV+daVtXn41wsaY+3xYfDYmRYIDoksZP2qxki1QSVQLawBz/m5/epc1oO7vW
	 b8PfOg7q9tjVC00dQ32c/qxboDWDIwge3knrDedE/2Du99vwRNW6F95PMhrZrAn+Db
	 12FxkIeKXSF6OdIyTSr6VvmCxJK+yYdkhSqz7hZr3HkFDy5paqJtyD0BGT1Zu5rkHK
	 +TT3MRcTobAsjSulWnUoWi2ty6IbifF09erfJ1JgSLt2ByYdtH648yDs2ctW7ui3SI
	 Q62mLTIinz5LA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C8A5D990D8;
	Mon, 19 Feb 2024 18:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] tc: Change of json format in tc-fw
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170836682631.11627.4370662603597022266.git-patchwork-notify@kernel.org>
Date: Mon, 19 Feb 2024 18:20:26 +0000
References: <0106018d95d12587-2a5518e8-5e89-4d5c-b7d5-93455429cb1d-000000@ap-northeast-1.amazonses.com>
In-Reply-To: <0106018d95d12587-2a5518e8-5e89-4d5c-b7d5-93455429cb1d-000000@ap-northeast-1.amazonses.com>
To: Takanori Hirano <me@hrntknr.net>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sun, 11 Feb 2024 01:38:48 +0000 you wrote:
> In the case of a process such as mapping a json to a structure,
> it can be difficult if the keys have the same name but different types.
> Since handle is used in hex string, change it to fw.
> 
> Signed-off-by: Takanori Hirano <me@hrntknr.net>
> ---
> Changes in v2:
>  - Modified to use print_nl.
>  - Modified to use print_0xhex from print_hex.
> 
> [...]

Here is the summary with links:
  - [v2] tc: Change of json format in tc-fw
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=bc5468c5ebc5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



