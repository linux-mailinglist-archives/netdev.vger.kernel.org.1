Return-Path: <netdev+bounces-146079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8D89D1E8A
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 04:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BAB6282FB7
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 03:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22CD1494A5;
	Tue, 19 Nov 2024 03:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srp7Ooay"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEDB2E3EB
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 03:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731985230; cv=none; b=nqVvDEm+k7do1PUiw440cbzHKq0wvLzxFS/DO3AJ64ueqVKZ04gT3U6vMgLxv21ESMnrexDovtCxNqE7std+sMD56q5Y1L+AyclKFAmOJNNJujIub/P6m+QneJR+WhCbb+OtE02iGxuI6xAjotSqoQavwWWdE2y2GDW6YCu+XhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731985230; c=relaxed/simple;
	bh=RayADMSqs7iGLNEwJjb190zgbyV6YSTJVmozP64trmU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cVfvFLdl5VVymcwJG50+JCbtOFoS3JDCxSQBHTsh8zFDv9I7DAwinDBqVy7s5d1bmyg6mHeUZY1TGH71wFBc6D3m+klw15+U/R1lq6jt2JLCWaUFmKuCldGxJSj7VTCzrqA8gsUkWbf/4ywnzw59shvk7t+ANwxaH3PqQuB96AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srp7Ooay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12149C4CED0;
	Tue, 19 Nov 2024 03:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731985230;
	bh=RayADMSqs7iGLNEwJjb190zgbyV6YSTJVmozP64trmU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=srp7Ooay2rWGwAGVz0pxPKJb4rx8Mz75qNIF9nGOELcymHsbmzOakgMm2+igBTZOR
	 5o+oYy07E2dz9oqslFJbqE7wvsO0WJCswbZZGkMRsB/FL7zz3qiK2rwERLW9iWfRzT
	 MLYuKtXlvBBs7nHT8/4+1Zo4gh4Gp9cgOnksrnBDA9a1Y/tnxF9STG8KzvqGK731ml
	 VNIeSVObxiRtqVrAj2pfCoqMVVkxNgNtpj5IWO+/aE/+5jQF7WRL5t1CKn3yaTv0LU
	 1D4njcu+wv9Ex8NVgAUAlwvdExQ1N3V3dZGTKE7vQ9j5gVNGrdpbbXORQzsfvfSTzJ
	 A55WUm+L6nPjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B0C873809A80;
	Tue, 19 Nov 2024 03:00:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] eth: fbnic: cleanup and add a few stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173198524124.84991.409726253828950179.git-patchwork-notify@kernel.org>
Date: Tue, 19 Nov 2024 03:00:41 +0000
References: <20241115015344.757567-1-kuba@kernel.org>
In-Reply-To: <20241115015344.757567-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, alexanderduyck@fb.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 Nov 2024 17:53:39 -0800 you wrote:
> Cleanup trival problems with fbnic and add the PCIe and RPC (Rx parser)
> stats.
> 
> All stats are read under rtnl_lock for now, so the code is pretty
> trivial. We'll need to add more locking when we start gathering
> drops used by .ndo_get_stats64.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] eth: fbnic: add missing SPDX headers
    https://git.kernel.org/netdev/net-next/c/e1a897ef4e9e
  - [net-next,2/5] eth: fbnic: add missing header guards
    https://git.kernel.org/netdev/net-next/c/2a0d6c1705c4
  - [net-next,3/5] eth: fbnic: add basic debugfs structure
    https://git.kernel.org/netdev/net-next/c/08606cb528be
  - [net-next,4/5] eth: fbnic: add PCIe hardware statistics
    https://git.kernel.org/netdev/net-next/c/25ba596d137d
  - [net-next,5/5] eth: fbnic: add RPC hardware statistics
    https://git.kernel.org/netdev/net-next/c/79da2aaa08ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



