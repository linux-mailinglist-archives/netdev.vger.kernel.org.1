Return-Path: <netdev+bounces-174347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5E1A5E59D
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 21:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6207C7AC0F0
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 20:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30CC1E98EF;
	Wed, 12 Mar 2025 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYNCiVZT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF920FBF6
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812598; cv=none; b=JrLd907PpeyRfRUHJ/iaG0lA5NCFmtQDCm9HNQq4bRBO1h/+tmLTz708f+Q2pe5ASZGEtzzOhxdckgek441O9UNgxF3wXZAcM/Wfb+p1hoPQK88cM018wSrnyLB3N2j9Z1XrpgyJLGswTyNsItiJT4xXdg1CZ6c/k2FLqrfO1AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812598; c=relaxed/simple;
	bh=5wyfw4VhfETHoZ5hldQrwNSXmPiOw4bQ7rmIQHBlRUM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VPFLmyY+CeD8e7lyiY7GTiMYysKfwvX4EjTyPahaSdxyfNAYJmiXPEqpK+/WwAshy2kBei1RVjer9TeSCSNwgDKBDKRhq5APMYSovaIFxSCuZA98qMrA38PfhVFb5YapltDwtuBcB1KevuOF7j7m2m8HkP8t8cTRXc0u6MbBwXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYNCiVZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F10C4CEDD;
	Wed, 12 Mar 2025 20:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741812598;
	bh=5wyfw4VhfETHoZ5hldQrwNSXmPiOw4bQ7rmIQHBlRUM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JYNCiVZTHKjdymBoAjgb8bwNDzfgiyD8cObwh5Obfa7MuQxLL9dRtB0BrdxwZW5Ta
	 VAyUzzv/6TU/DlAB4RWGR6V6Y5IylhoVE/640MISERyNE/t9YulnMoKeEK6sF5tXVT
	 6DifL/5ltmhKVODTEnoUwDdkbnvsbYcUuFq3GzyMcpZAeO6wgCwUjobrUmXEBZe2j0
	 F6lJTNrjbeyfarTUg3yZc4XJ7IsxtMk//7Ibesk2Ph1ct+uYqxmPWl9ZWUoKyrkVqf
	 YjpBp9Wa0LzWGEQ/o0VHj8UaO4+dT+m02lle7H+8WbQPXhnbiwEoBJv445o+bbechg
	 QrY048uGD+KtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC12380DBDF;
	Wed, 12 Mar 2025 20:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netdevsim: 'support' multi-buf XDP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174181263275.928071.11336171899744809969.git-patchwork-notify@kernel.org>
Date: Wed, 12 Mar 2025 20:50:32 +0000
References: <20250311092820.542148-1-kuba@kernel.org>
In-Reply-To: <20250311092820.542148-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Mar 2025 10:28:20 +0100 you wrote:
> Don't error out on large MTU if XDP is multi-buf.
> The ping test now tests ping with XDP and high MTU.
> netdevsim doesn't actually run the prog (yet?) so
> it doesn't matter if the prog was multi-buf..
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] netdevsim: 'support' multi-buf XDP
    https://git.kernel.org/netdev/net-next/c/e016cf5f39e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



