Return-Path: <netdev+bounces-243072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7971AC99329
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 22:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8BC3A49FB
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 21:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE433286D72;
	Mon,  1 Dec 2025 21:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlDN3t1X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9719925C704;
	Mon,  1 Dec 2025 21:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764625097; cv=none; b=W3LMPvkIitdJY0gRt9X8j+1umL7rmPts/ybJwzwZgQyle60XrKY/vnOxFbUWyMCC/5vllaSWSiYufy91iIqwYSeQiPS3jqLMv3pDI31soIZkvVqRuRvT5K+t+ozeL/XBlr4fWLaaOhRM0MM0e9kYekKbrL8T6xPTak7cAuDSUH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764625097; c=relaxed/simple;
	bh=mNcDLWjc+oxbvXHe24wo13tjzmBZeYhKNt6x7kfgJwo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EB7HrfX5JdsdvnSfe/eM3KvnmEWuyQu689yizP/A0nwp39XDlq9wJKVBIKQ6wFMFR+yYu1DjJrfRUFtiNlevVPpw4D6UBpYY4GqrPwV0NQHHZbfzjZPdzTEjfX6e1jj1qWYr8KjsCPoPoVzI0DLpdg0W+MNL8zOQywY2Q1S8GtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlDN3t1X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13720C116D0;
	Mon,  1 Dec 2025 21:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764625096;
	bh=mNcDLWjc+oxbvXHe24wo13tjzmBZeYhKNt6x7kfgJwo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DlDN3t1Xnll9vPrr0gFTpaOhE3zefS19h5m9fWcukA20iOPREVBau3lqZMP0rsWEG
	 fXNUjkvEP2kLl4nSfnJQa6tvk8OlNF7Jlicbv2iH3wEWWthJZX3J9oYKudvi71WE24
	 lJ8jwqnd7nZkZ3n4Dw5jWZf3q+/IMeLabmFODdIIh3je2U4JqbAi/AKG2MakQv3AtV
	 fDdFs9d/GsCX0BEJ+ZZkxDI8JsMjAjlrnBYk0t2pRl1MROFoXq7pFL06N6Lcg2mOu6
	 3E5WRkh9kdph6lF7H5u+HrLWokaV7FZ0mYyzhg326cJ8GF1z4aQ5YJpTeMDegpTsw9
	 BQQkafEDSYFpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B7C6381196A;
	Mon,  1 Dec 2025 21:35:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-11-21
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176462491577.2545331.12425544788991358472.git-patchwork-notify@kernel.org>
Date: Mon, 01 Dec 2025 21:35:15 +0000
References: <20251121145332.177015-1-luiz.dentz@gmail.com>
In-Reply-To: <20251121145332.177015-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Nov 2025 09:53:32 -0500 you wrote:
> The following changes since commit 8e621c9a337555c914cf1664605edfaa6f839774:
> 
>   Merge tag 'net-6.18-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-11-20 08:52:07 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-11-21
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-11-21
    https://git.kernel.org/bluetooth/bluetooth-next/c/8a4dfa8fa6b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



