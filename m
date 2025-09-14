Return-Path: <netdev+bounces-222883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B19AB56C29
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 22:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C84E91899353
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 20:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95773221703;
	Sun, 14 Sep 2025 20:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9zQOcxW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714B72E1F01
	for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 20:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757881807; cv=none; b=ApVxWS9meuUUUrFH4/2FzbhwVZLvgSbE5rTbBORBd2ZvetNKkiw2KGUg9ToNpRMldgLYeLqAfj7Wl8Fz1wm48FBlJyq9KBH506PdM3pnSyYZBSeC1W/zhui78CtO7ysQlrFPpvjM/qbKx7F7zc69QWb4K2tkyuMbcQ8mj8l+H0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757881807; c=relaxed/simple;
	bh=rk7iKkNFOM1STSTQVk+yXWHhk08sA90tRf2ZthEtzM4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R6uEwO9dvADMqzXxu0yZXSnT79nDXixfztJdL59/G+DWGfRSgbxXmIB7bb1rmTZvFedP/zGqbl9CRDtKevKCRFFcz+zrlnakaPDg7sObE9IfKdvAXoclPtT+ofWIz6QW8HVDWoWfqfL9wfMy8JtsMYkEuD2i30KJLX4AwXylil0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9zQOcxW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46AE5C4CEF0;
	Sun, 14 Sep 2025 20:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757881807;
	bh=rk7iKkNFOM1STSTQVk+yXWHhk08sA90tRf2ZthEtzM4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j9zQOcxWlyseGHrtdELRZ0lAR7Q35dVtyxkxIwulsObXgzPgFnAQ35JddQ0N4gfYy
	 ClbOLidMDajfLVdgEFxFd6DYoRizOEZWJ8TxJUjp8pXpu+5uubupxSADUh+2iE+pRb
	 1ig5psQij/2IRHHG13nF0+3zNpmwP8ledpSVgwQBsutMsXMcLQWhC7b7q32xSR4erh
	 L1weYpcpV/KuPz6LiNGaj3BVXsTyxlNiIOSDFY/J6N3vIKco8ifeqIuK2QKpiIT75o
	 1fNfCOGLzra61oqOAKkF08Kx5mhQtHUF+SUngLgXghv5/HoSqQ7DZa2yL6DvuYl41k
	 tckmDcWs2eTBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3454C39B167D;
	Sun, 14 Sep 2025 20:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] ionic: use int type for err in
 ionic_get_module_eeprom_by_page
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175788180899.3545575.3619965399412943664.git-patchwork-notify@kernel.org>
Date: Sun, 14 Sep 2025 20:30:08 +0000
References: <20250912141426.3922545-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250912141426.3922545-1-alok.a.tiwari@oracle.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: sln@onemain.com, brett.creeley@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Sep 2025 07:14:24 -0700 you wrote:
> The variable 'err' is declared as u32, but it is used to store
> negative error codes such as -EINVAL.
> 
> Changing the type of 'err' to int ensures proper representation of
> negative error codes and aligns with standard kernel error handling
> conventions.
> 
> [...]

Here is the summary with links:
  - [v2,net] ionic: use int type for err in ionic_get_module_eeprom_by_page
    https://git.kernel.org/netdev/net-next/c/d586676a2714

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



