Return-Path: <netdev+bounces-158570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E167BA12880
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 17:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52CFF3A0879
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 16:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D8260890;
	Wed, 15 Jan 2025 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXWg1oiP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5201E86E;
	Wed, 15 Jan 2025 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736957941; cv=none; b=kqpfUdowGSzefVQcrVnK+ZjyMy38cc+bysvFdb8vzIoNmXxjFiVDUBpVbgGs2CztIxxizBpFLsSckOLFuZWcvBJXJvHOgrYEETOlIgRk/7CB6tiJph1s78AJNWxcLVuQPpfxR8kYUSXhFvjhDX6VqCB1empKm5Sqn9BmtP2+9SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736957941; c=relaxed/simple;
	bh=jdOTKritJzu0PfwNC8QBulC/gQqYTYthIyv8RXVJyPw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=frIw7FMWypMnWliOe4NjWLx1L2xhVenbWftmbDnJJQqwoJ3CmWt9rEswVAxPKNtFEmOZhFAzyP4irtYRI2epVwZZgqtwgI+dflIQgj6HB31Jln5hS8Jg/zS0Y5EGycE76DF302W/YDvpnQnbo/fecM3IMXJOiXkJ6BhAtMdfV3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXWg1oiP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE609C4CED1;
	Wed, 15 Jan 2025 16:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736957940;
	bh=jdOTKritJzu0PfwNC8QBulC/gQqYTYthIyv8RXVJyPw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NXWg1oiPvP5LUJ0Hzi0Ai+1mI0GfUnaoM9xoMU0KDn0/Y8ozPvQlUFSHRGR/UwrZS
	 3HewgULvtpQuz+iZj+qRvrAgdSs+vNeimUZUX5WrFxhV6jqGtt4qQTbCDLuZ7eWNeO
	 HT/qbIzt8TGpxO4cYZ5G4ZGiid9NkXCtSygmnxBvsplnhik6+YLiRDcVAKR4OCmeQ9
	 knXYjAXdpRJ4fj/Q5cGWAWFkh1rg1GcHK6r+83KwfcyRDd32neWGiQNHXyQHOm/ZsZ
	 q6ZDuV7C5ZxvHSsNoj8xLIHum1wMtzsyc5/fjOfZHQdRMs/0vCEOtmezypyugzUKBc
	 PPdUIvp1Pl3/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2EE380AA5F;
	Wed, 15 Jan 2025 16:19:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2025-01-08
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173695796376.759973.9029414775128542075.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jan 2025 16:19:23 +0000
References: <20250108162627.1623760-1-luiz.dentz@gmail.com>
In-Reply-To: <20250108162627.1623760-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 Jan 2025 11:26:27 -0500 you wrote:
> The following changes since commit db78475ba0d3c66d430f7ded2388cc041078a542:
> 
>   eth: gve: use appropriate helper to set xdp_features (2025-01-07 18:07:14 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-01-08
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2025-01-08
    https://git.kernel.org/bluetooth/bluetooth-next/c/6730ee8f083c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



