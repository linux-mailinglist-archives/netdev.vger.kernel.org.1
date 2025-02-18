Return-Path: <netdev+bounces-167154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A70A39050
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 02:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A533B3D9E
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 01:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F128B537F8;
	Tue, 18 Feb 2025 01:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjoqj/we"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6876FBF
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 01:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739841625; cv=none; b=Ri2PZfb5sXTH5Jx2g96r7vQXsE4bDmgHWHmWBprQJu6zwSEqboLVzXNh4PiGB83ab3kogjjL7eSExChIwB4dlubhC7ckHLQdsO2fGHAj4cpGVufvodNQQjJGL3EOjccgk0kUAaEkn5hb2Cf4YNKDGApOQhBV3Y5WRYvSpXGyEq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739841625; c=relaxed/simple;
	bh=+4wCPV5iokwKUNzmFLhMxzWogqab8c4P10h8NS9unbY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tR7IKsVg4x6xObp0GisUvAOQB6m1qxphJFXChxowQfYXg1X5ZZFBrxyO0pyGkL6sVvPcCvm0aebzE6deffMpQrSGzSBww42ayRPVoTusn6cOySIU7tkh5H7drJJRzeCuH12Gzz1h19lhhO3OUnj55QtjnjQe7QkO0CQx1PHXRfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjoqj/we; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49383C4CEEC;
	Tue, 18 Feb 2025 01:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739841624;
	bh=+4wCPV5iokwKUNzmFLhMxzWogqab8c4P10h8NS9unbY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jjoqj/we8OCiSIaZrFi/wl8dA1SW7ZPsqmBtoG6TouvGvJhYHKX5auZZJEepEIbHV
	 TSqa7/Jt44UM+HmDfYicMlJIigSDCoAo48ayup1B71XoR0NjwcTrUoCUBVQNPKkdHH
	 Q9KKu1WYkhg1KBX/LUYXn0Dk0wiOoYEgF+z/V9lFAf8GnmtLJkwOSP4fckuX+OKkqG
	 Phls9ACWoi3alwvfNUXvnnAyk9ycZwKXqmQYR+mC1TfhIljuSdzcrJaIb4luQY7xL3
	 vaYkaaDhfNWLf7ZQtzkgFPTi4V7X9p3ebgcFWHOsg+aZ7k0VFZkUwq+zDleTnWW4ue
	 kdR15tG7kwaDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD5F380AAD5;
	Tue, 18 Feb 2025 01:20:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: move stale comment about ntuple validation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173984165424.3591662.15553260390867715289.git-patchwork-notify@kernel.org>
Date: Tue, 18 Feb 2025 01:20:54 +0000
References: <20250214224340.2268691-1-kuba@kernel.org>
In-Reply-To: <20250214224340.2268691-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, gal@nvidia.com,
 andrew@lunn.ch, ecree.xilinx@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Feb 2025 14:43:40 -0800 you wrote:
> Gal points out that the comment now belongs further down, since
> the original if condition was split into two in
> commit de7f7582dff2 ("net: ethtool: prevent flow steering to RSS contexts which don't exist")
> 
> Link: https://lore.kernel.org/de4a2a8a-1eb9-4fa8-af87-7526e58218e9@nvidia.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: move stale comment about ntuple validation
    https://git.kernel.org/netdev/net-next/c/637026e591fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



