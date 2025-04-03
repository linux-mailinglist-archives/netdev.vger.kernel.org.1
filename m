Return-Path: <netdev+bounces-179202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B52A7B1FB
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 00:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92581789B3
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 22:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C851DB34E;
	Thu,  3 Apr 2025 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAUQ7gN7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE551DB125
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743718799; cv=none; b=EjMqcry9UR0eGzEUNHPR/TzvMfF2UrPr2MOTJNN9gAeIVcJACUNN3NAsOJbaGAxXGuGVmQhdbZ/EHg315vXR4zZ64hH6YPnHr9LqPbRVnkbAuJKjgcGbe5dQ2/zLm1W6h6s5Cy/E2iV894eUV8vyY3XJDPnMRZvrJ0Hg9Ny03xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743718799; c=relaxed/simple;
	bh=QYb70mdEa2df+TAp8vzViGz2YL3hcQZlpH3e7RnsemE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E3TTOjqB4N8cgVZsJJyiYA3ccgKqGpCgITOOO/AZrp/X95t6cP5V5qLFRa8c3oZJCr9kTDMf2+CGS6Q5Mft0wG8R6K1Kyzhw9MBi13GsTlxyPnFCK03fNob04lilf83YusPAz5WUkiJPwhvvjgWT9+kjCvuvUQRkQNWWJ+u1glY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAUQ7gN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037F6C4CEE3;
	Thu,  3 Apr 2025 22:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743718799;
	bh=QYb70mdEa2df+TAp8vzViGz2YL3hcQZlpH3e7RnsemE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YAUQ7gN7Sfd7cXkGU7M0EuaStgkJYr/eIXkKNbhFlT5zVoQ+gx2eImRsswBqSp4wU
	 9qdHqTT2eKPqr0AsAhc7gDNRvdwQbLd/738NoVWOxREDU11vyqfg1hcM+FmzREHHQ6
	 ShHMkR5kn9POMIoppw2zTFAQXXF+auS8rDwcQuXbE8IAIzXwKPNwycbOm/VYNxUPV3
	 elPwMjyfi8QXqnk+T9Cdezq78TY6dIOYvD50swwKSGtJsRzgACeVVEVJOQNuM1tBSC
	 pe+OwkzXtn6P/JlEIR5th9kpQivmCAtRSICZueqkcCpdzvZrVjgdxxm6y0iJHZ3f0c
	 uOcokHTI5Yzgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C11380664C;
	Thu,  3 Apr 2025 22:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sfc: fix NULL dereferences in
 ef100_process_design_param()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174371883599.2702664.9943078333506248625.git-patchwork-notify@kernel.org>
Date: Thu, 03 Apr 2025 22:20:35 +0000
References: <20250401225439.2401047-1-edward.cree@amd.com>
In-Reply-To: <20250401225439.2401047-1-edward.cree@amd.com>
To:  <edward.cree@amd.com>
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, ecree.xilinx@gmail.com, netdev@vger.kernel.org,
 bookyungwook@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 1 Apr 2025 23:54:39 +0100 you wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Since cited commit, ef100_probe_main() and hence also
>  ef100_check_design_params() run before efx->net_dev is created;
>  consequently, we cannot netif_set_tso_max_size() or _segs() at this
>  point.
> Move those netif calls to ef100_probe_netdev(), and also replace
>  netif_err within the design params code with pci_err.
> 
> [...]

Here is the summary with links:
  - [net] sfc: fix NULL dereferences in ef100_process_design_param()
    https://git.kernel.org/netdev/net/c/8241ecec1cdc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



