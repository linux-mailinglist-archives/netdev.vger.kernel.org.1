Return-Path: <netdev+bounces-181484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27301A85209
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 05:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817C819E81DE
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 03:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDDC27CB13;
	Fri, 11 Apr 2025 03:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0PM1ryl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F4927CB0F
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 03:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744342201; cv=none; b=Y0NAjEHUGe1bt6NoDAWsNZ54zVHrsKefRDxt9jhCCK7e5HGxvCC2UUoyMT1a0YqabPBnTK2mUifw+AP7F9O+AOVAr34IL/qOWQXSiJyGv5vGZ/vKRLWzeiucjnZrLgzBCfcwFttuDOaNFekT/MKV60CyNziF9HXAXtDmmConcss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744342201; c=relaxed/simple;
	bh=lz6Hj6kg0WUb4jkDyBhkQ/SB+4L0KFrtG9B1MacIlUs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lF5mX03/W1H6F2xYInol0fk5Gl8QMCgnksgRi47fPyirrBia2mDSdP78CQpe+UeJGt5mU0TNRPfkF+/BZqJhKWNat47/gzKY2/b817V9nIkbyLnzM+1RHrIvOPRAKWn/EqTnzM/T18wyS7nPCAoOYn5MOMEj1uVHOM5FObwLJqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0PM1ryl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E510CC4CEE2;
	Fri, 11 Apr 2025 03:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744342201;
	bh=lz6Hj6kg0WUb4jkDyBhkQ/SB+4L0KFrtG9B1MacIlUs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q0PM1rylgXpirbF8rJdqVi/ldQrgMfNZTTKtyUe3WbYplPO+j26zG5ZgU/i7+Dh+4
	 K86jdyrJQZe88LQ7C1J4v1SmAIhsDbJn2tL5ZLmIUly2/dm4iDE+IRSYXzNKjbbiuU
	 JfwWQ9jgYuTbOhoNbAw6/qXPhI0KMoeS3rG4uY8bGyDrnQCgKpmO8wb6DnmH3TKmqV
	 JUJdL1LEYr2KnLlVOAXmpTT7IiWYguT5CPpOB182BWZrM8yA8RiC6oI7n/h0O+VI3E
	 yKyBarRotq1jbXKIu3YL7mTVgpcxjyeON4dWSf44BExUTNP2xV15QD381CQSC7yqYz
	 nJN/WD/nVZcKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF221380CEF4;
	Fri, 11 Apr 2025 03:30:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: add helper rtl_csi_mod for accessing extended
 config space
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174434223826.3945310.15387011074147423969.git-patchwork-notify@kernel.org>
Date: Fri, 11 Apr 2025 03:30:38 +0000
References: <b368fd91-57d7-4cb5-9342-98b4d8fe9aea@gmail.com>
In-Reply-To: <b368fd91-57d7-4cb5-9342-98b4d8fe9aea@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 9 Apr 2025 21:05:37 +0200 you wrote:
> Add a helper for the Realtek-specific mechanism for accessing extended
> config space if native access isn't possible.
> This avoids code duplication.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 26 ++++++++++++++---------
>  1 file changed, 16 insertions(+), 10 deletions(-)

Here is the summary with links:
  - [net-next] r8169: add helper rtl_csi_mod for accessing extended config space
    https://git.kernel.org/netdev/net-next/c/8c40d99e5f43

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



