Return-Path: <netdev+bounces-225372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4504FB92F60
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 21:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10CE33A3E2B
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 19:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0463531194D;
	Mon, 22 Sep 2025 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvYJd7FS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8942F3C11;
	Mon, 22 Sep 2025 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570010; cv=none; b=Z7UKwr1ARe/xUWeYod170ETYM4qxpiC024wrFeZCugzylpLsJf4PBsfXW+y/FHsYerRc9LL+gvbzyZCG6zUDkHOIcLxhJAPBRst3f/Ur42PG751CGXBlfvuZCekqNFooaV9Tm+zS7I/shnsVawHlK40UNTSU6uc62p4RIGMy1gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570010; c=relaxed/simple;
	bh=ho+IwALF0gKhPwPUSOnx7JnC8hrhIFLzdtjRZDsDZ7E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P045Q1S0PRwsC5vmKeT8WjrjIwNz77Y9aGeUuo1CyWNqsh0K9vyHpAEN91VkNaR7hZMh2Ko2MFI0b3uUP3OWPZl8PVUY9Ne042pMTUljoz/Btqm0oE7K9JDnCp2jhmH5NwvsiIQ/dQ+B2q5A+3vAAm6modZs008Cl1CGMUEXTKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvYJd7FS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A647DC4CEF5;
	Mon, 22 Sep 2025 19:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758570010;
	bh=ho+IwALF0gKhPwPUSOnx7JnC8hrhIFLzdtjRZDsDZ7E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OvYJd7FS+FLr5rVtRBF4gZaoP4mF1IBGmisB0G4GYLbf5eVoedyYFY7vm65u447eM
	 sMAu9cB6IiRYfc1D0B4YOuwXbTlZgJBJqAbAIFc9jdqcDduvJor7sJOl1Knt15tPlG
	 Q9iiWOiMiG0SaUlmALER4lye+A7uYf5TLApLqdA5UWKlc6cygbgZSK7kJf4NS6avjr
	 NwM9iDkX6DWbn8CIwFXV0KA2dMpmlp7UA4exw614iS77l7tREEW3+LURZP8yvSKsNB
	 CJbNFcfmv6ATPmGO692xLDpBtkJzrrLLR/HD/70FJ/ME4X/8dwfE55VCughXs257m4
	 /7O9jS7B5G5pQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CC839D0C20;
	Mon, 22 Sep 2025 19:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-09-22
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175857000825.1134327.4421591891628924314.git-patchwork-notify@kernel.org>
Date: Mon, 22 Sep 2025 19:40:08 +0000
References: <20250922143315.3007176-1-luiz.dentz@gmail.com>
In-Reply-To: <20250922143315.3007176-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Sep 2025 10:33:15 -0400 you wrote:
> The following changes since commit b65678cacc030efd53c38c089fb9b741a2ee34c8:
> 
>   ethernet: rvu-af: Remove slash from the driver name (2025-09-19 17:00:53 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-09-22
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-09-22
    https://git.kernel.org/netdev/net/c/3491bb7dae5c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



