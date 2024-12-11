Return-Path: <netdev+bounces-150934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7E29EC21C
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4801918888C6
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 02:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A54364BA;
	Wed, 11 Dec 2024 02:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYb8W5i2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8E1C148;
	Wed, 11 Dec 2024 02:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733884221; cv=none; b=EQ8lxF5puvpi61h/xfgejxaTbzG1D3iJJBZzbN2fMmDqWOpMVqikvN/MBL0/JOHukhMR/5P9roxHJ11Obx5Fcu5MuH+Mqmo4PKC9dXJE26jCepy1QlBDjELazCowhNeZfOulsaIgtXqMcCQC7bKrDkxmLalB+YHsPKEL2v5f290=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733884221; c=relaxed/simple;
	bh=jqMkqPT+FfVoCSEPhuUr13xW70aeAREe5Eb1o2/107s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NBYAaa3fE1gtsfwN92LeWu2u42rKlqr30IllSYYxqpZvKJ8PtTghhhPw0iuKsBADaXODgcPrnTk6ivJkLHQe90l52+huRYyknstYuOr23rjl25mxlnS5YM/in4LMxggE7WzVTRhO1RvJmtjVdnQ9IKRNm5T/nGwvbcNgd/leJRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYb8W5i2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5B2C4CED6;
	Wed, 11 Dec 2024 02:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733884220;
	bh=jqMkqPT+FfVoCSEPhuUr13xW70aeAREe5Eb1o2/107s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MYb8W5i2EUxjpIq8+MhZ9MZRELwgEplXgeigkt358Uiry4cyFjh3fs154RPJ3JBHp
	 VQZWLDdsrFXP7rhPopS+gx+OehPk4qb6ZFlohSHrqYg8fgub9y7s6np8UYcpiQOEuG
	 YNSFZl99DG7YPpwSwgJHxfNxNd1PScmSjcLnaHM6KhN4gfi3MzXVyk3Ibp1mOSGBhI
	 8NM9nQXflJPB82L09Fj0mYf9XIRVZl27GSbP2AWRNq4yeW9SUti0NDNqfo8Wq08R06
	 CiuXjdLMRR/ghCbi/dtyAiMYl/V3ZWRpHnWCxUAWYWX8IegKVCDp4vWTDIwKaJ6itv
	 K+QDh4XJFSoVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ECCBA380A954;
	Wed, 11 Dec 2024 02:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] dsa: mv88e6xxx: Refactor statistics ready for RMU
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173388423676.1090195.10913853121851789480.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 02:30:36 +0000
References: <20241207-v6-13-rc1-net-next-mv88e6xxx-stats-refactor-v1-0-b9960f839846@lunn.ch>
In-Reply-To: <20241207-v6-13-rc1-net-next-mv88e6xxx-stats-refactor-v1-0-b9960f839846@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 07 Dec 2024 15:18:43 -0600 you wrote:
> Marvell Ethernet switches support sending commands to the switch
> inside Ethernet frames, which the Remote Management Unit, RMU,
> handles. One such command retries all the RMON statistics. The
> switches however have other statistics which cannot be retried by this
> bulk method, so need to be gathered individually.
> 
> This patch series refactors the existing statistics code into a
> structure that will allow RMU integration in a future patchset.
> 
> [...]

Here is the summary with links:
  - [1/2] dsa: mv88e6xxx: Move available stats into info structure
    https://git.kernel.org/netdev/net-next/c/5595e3613ea7
  - [2/2] dsa: mv88e6xxx: Centralise common statistics check
    https://git.kernel.org/netdev/net-next/c/9a4eef6bf2be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



