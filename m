Return-Path: <netdev+bounces-167986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4C1A3D015
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 04:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A777C18924DA
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 03:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142E91DE885;
	Thu, 20 Feb 2025 03:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzosxarw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BCC2AEF5
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 03:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740022201; cv=none; b=ZF6xQK7bgYB1xyO7N9c1NPzQMNqTdECT5nALmEZHCmD21epm3NaUI4zRLWP0fEeVEwpFAwqxDCEXnSdapGEETrhh8e+k+vuptk3B0G9yd8qmL5jzHzwgQWclKdHrJjKjMp+oAwpkoI/W9iujEi0kCZqC0SQaI+XLRFQ49YOYkDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740022201; c=relaxed/simple;
	bh=8RRQ9pCK1IMRDRrdi49iFqV4nssiRtTK/Wdg7yEvYrM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Nb055lW1f+eVsTmEAeZP8dysoscwqT0jaQLWphEFkrdRqRBpxR8NCL9BfsEfhYxPXpq5adrcUbGCAwbj0cYdLZ2OHXTzJ4iE+ohN4AMzkUpKJLWYJecvIMPDrartBHjQ0dFrQ57Z93GVWKYT4ILsNwwnrbZjEdnhby9lWQlpO8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzosxarw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB73C4CED1;
	Thu, 20 Feb 2025 03:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740022200;
	bh=8RRQ9pCK1IMRDRrdi49iFqV4nssiRtTK/Wdg7yEvYrM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tzosxarwqVQ7vhbHu2/IdyWcx3jOawwWiZxH86CV+Gz/JRdLqvQv2XzRqSZOCP/4v
	 xYnW1M9u93lq8u/PChwLSrH24waWui2tvB8eyN6xOC9i8+sKtbva4yQ+Fk70ifsETx
	 rxfV89JLYFeVyv2Iz7WGSVkPslcsgu9s/Sm8gy7PVaLxmASAy+CtaFu+Sl2rxG/sKy
	 cigCCydS62I52CNGasIBCs6aAa/8IQABgY0lhX6LphhoAlyK/fjdEF/zyQPCez4K3t
	 Fhow1SJpFdLdKPYC6MV0Rf4Rd5XFlYBmFLhhJNAbolrcDV5osA6NEJWmOJi5uWNnyq
	 htd9s14AzI2yw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D77380AAEC;
	Thu, 20 Feb 2025 03:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/4] selftests: drv-net: add a simple TSO test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174002223100.830506.13522479369749861704.git-patchwork-notify@kernel.org>
Date: Thu, 20 Feb 2025 03:30:31 +0000
References: <20250218225426.77726-1-kuba@kernel.org>
In-Reply-To: <20250218225426.77726-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 willemdebruijn.kernel@gmail.com, petrm@nvidia.com, gal@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Feb 2025 14:54:22 -0800 you wrote:
> Add a simple test for exercising TSO over tunnels.
> 
> Similarly to csum test we want to iterate over ip versions.
> Rework how addresses are stored in env to make this easier.
> 
> v4:
>  - [patch 3] fix f-strings on Python < 3.12
>  - [patch 4] fix v4/v6 test naming
>  - [patch 4] correctly select the inner vs outer protocol version
>  - [patch 4] enable mangleid if tunnel is supported via GSO partial
> v3: https://lore.kernel.org/20250217194200.3011136-1-kuba@kernel.org
>  - [patch 3] new patch
>  - [patch 4] rework after new patch added
> v2: https://lore.kernel.org/20250214234631.2308900-1-kuba@kernel.org
>  - [patch 1] check for IP being on multiple ifcs
>  - [patch 4] lower max noise
>  - [patch 4] mention header overhead in the comment
>  - [patch 4] fix the basic v4 TSO feature name
>  - [patch 4] also run a stream with just GSO partial for tunnels
> v1: https://lore.kernel.org/20250213003454.1333711-1-kuba@kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/4] selftests: drv-net: resolve remote interface name
    https://git.kernel.org/netdev/net-next/c/2217bcb49149
  - [net-next,v4,2/4] selftests: drv-net: get detailed interface info
    https://git.kernel.org/netdev/net-next/c/2aefca8e1fa8
  - [net-next,v4,3/4] selftests: drv-net: store addresses in dict indexed by ipver
    https://git.kernel.org/netdev/net-next/c/de94e8697405
  - [net-next,v4,4/4] selftests: drv-net: add a simple TSO test
    https://git.kernel.org/netdev/net-next/c/0d0f4174f6c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



