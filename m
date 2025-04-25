Return-Path: <netdev+bounces-185791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07BEA9BBB7
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 02:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A5C4A7D2C
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 00:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B5E14A8B;
	Fri, 25 Apr 2025 00:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUJirLWb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1155DC8FE;
	Fri, 25 Apr 2025 00:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745540394; cv=none; b=cY09Wc2NYhgv6UQYxDMlecUZeteQdNxOPtZg7AQ6A/9XoRG9bwvZpAJw0w9neksrArwTIPbnmqdObb3qdgJ8hEGuppdc4U/Yjdb11yZIHcJgbjVbBJ/uiIBBaLztFsykSjnoGQb16BMXB23BHuaK13ZBynhZVKjj1kAno6BvjAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745540394; c=relaxed/simple;
	bh=ac8x7jkX0BjM2iwPsN7ixl0j6n0NJyqvNDlHqX/BaZ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dbnv3DpWuVLtSLZbKtIoIwMpP3VmWZ8VlE1Xh7MhTNQQc2dnrPQKhe3TxEBOAoE7L2xByPvZoPuaETgeAjTULnyPUhZU7LpM4SfCgHkIN3G9qHSRkSGC/1qAmjRi1uHHJQHxAA8N+m9RCsfHCmtewDRyBIoJ4sr0oFJnw3HE5Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUJirLWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61437C4CEE8;
	Fri, 25 Apr 2025 00:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745540392;
	bh=ac8x7jkX0BjM2iwPsN7ixl0j6n0NJyqvNDlHqX/BaZ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RUJirLWb1pNkefWinD8nasDDcMFcka0HVa4z6Lxc46IwvgjL7+/nU4Gm9Aruqdgsp
	 JZt1celwo99cuVMk8jfDDvvLToozsa024fInvBNGsLDEMeMK6Ft8bTBcqny9PsWjNL
	 RrF1ZCzTSi0gKMqoGoUvG7q6IhumGqXssoh9EB7vymmk4dSyrVJyfgxuNPF/jLn5Qi
	 JcThstHFEoTN9VExELoJ3y46MlXV+ef53HQbtU2pMnWd0amZHSLQYzsnN6arfTWoTX
	 dPi/yi331pqtfJ7tPzTm1evVu1EuT9XgnhyhT81n7nQQHGKeTM+K/E6ob6JVyG5/Op
	 YmNt7I66p9+pA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A7C380CFD9;
	Fri, 25 Apr 2025 00:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf] xsk: Fix offset calculation in unaligned mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174554043100.3528880.9997407032455176951.git-patchwork-notify@kernel.org>
Date: Fri, 25 Apr 2025 00:20:31 +0000
References: <20250416112925.7501-1-e.kubanski@partner.samsung.com>
In-Reply-To: <20250416112925.7501-1-e.kubanski@partner.samsung.com>
To: e.kubanski <e.kubanski@partner.samsung.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Apr 2025 13:29:25 +0200 you wrote:
> Bring back previous offset calculation behaviour
> in AF_XDP unaligned umem mode.
> 
> In unaligned mode, upper 16 bits should contain
> data offset, lower 48 bits should contain
> only specific chunk location without offset.
> 
> [...]

Here is the summary with links:
  - [v2,bpf] xsk: Fix offset calculation in unaligned mode
    https://git.kernel.org/netdev/net/c/bf20af079099

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



