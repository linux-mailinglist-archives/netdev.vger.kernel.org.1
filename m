Return-Path: <netdev+bounces-166172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0961A34D37
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 19:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9FA816E45E
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 18:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2281242913;
	Thu, 13 Feb 2025 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACp17O3x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872A924168F;
	Thu, 13 Feb 2025 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470206; cv=none; b=kIJWcf84qdXq0FzCqDnb2q02jpyt43DPvi1riRujXuyRMf22LWnBE0nWrhwKFLqNg2EdZDRuJTu2YClS7vg/PCueOcxsHyx7/R+eB7YPw4T+wg9vntgEleVw72m8RI4M77xFIfpTHFmO34rJRQ031LLWyBT9iTK2378+a9DEiVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470206; c=relaxed/simple;
	bh=PMWLdbIdcvDZfOdkXVXUnGoikbYlW7a1W2uScQ1qO8I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s1orayqSkKpssVRci3DF4wNMdYj3TU1fm8sMCZxC20mBg/L4cdQB8eYD0AGovrMvT32HgG/3tH3RvPD2qxS74SfLCeOLVQMk+l3ec6mKQ8FqIODo94UV/rzvLPoxcG0nAp6zxwaktMLAZ0oHDsjVdVSUQwevcqYar29JIW2RWFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACp17O3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EEFC4CED1;
	Thu, 13 Feb 2025 18:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739470206;
	bh=PMWLdbIdcvDZfOdkXVXUnGoikbYlW7a1W2uScQ1qO8I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ACp17O3x89P3HP1FTNAeu262Sc3xEIjVJY/ELXWk2wIlFbxlKGhpGTpCMRRQY7n1S
	 PIRhv4JbpraHQDczgSxAqStpM5PunW4sQhhJKyZixMNM3YTWS6MMXYEmIq0DmG0nke
	 Ab4xnWNAcdywZbGVlz9VeNYGKLZZho31LVhmlsoOmMCTLoGxfdD2q6dG86uZeqLlNh
	 i+gMfKJQpQwODkpTbMZlyCoGK4QDeNfuIGW1Qgdb6wtvBVifa28CXKYIUAE8a8gPJm
	 fax35872XBQVrkb8ULFwZJsMNYj2iJBgcU5jw1VTf6fEIJh6z+d9fnsU6jGoptijA5
	 40E84vzJwNoHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71907380CEEF;
	Thu, 13 Feb 2025 18:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-02-13
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173947023533.1322759.1575617814949046507.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 18:10:35 +0000
References: <20250213162446.617632-1-luiz.dentz@gmail.com>
In-Reply-To: <20250213162446.617632-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Feb 2025 11:24:46 -0500 you wrote:
> The following changes since commit 0469b410c888414c3505d8d2b5814eb372404638:
> 
>   Merge branch 'net-ethernet-ti-am65-cpsw-xdp-fixes' (2025-02-12 20:12:59 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-02-13
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-02-13
    https://git.kernel.org/netdev/net/c/82c260c8806b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



