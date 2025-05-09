Return-Path: <netdev+bounces-189117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5427AB0790
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 03:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89D469E1412
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 01:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787331547F5;
	Fri,  9 May 2025 01:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qi/Wu+bM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D447145FE0;
	Fri,  9 May 2025 01:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746755394; cv=none; b=e3GH55pPpdXdyZdeIFWEbAGeRQbedRPkbZr3DxafdU5HK9XelOowtWgCa5y73rajdJhO+v687Kd77dG3a+an3F11uQesIurgp3qOzFDLmsi3qdNIFAmitwnTtcU0hj1u335lqtcH1mFw/vDQOis/G5rr7e8xDMP3SSgX0qlzDaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746755394; c=relaxed/simple;
	bh=bNe3PWOhezlLQpVjDvwr37Wk4UyMK2cGxjI+lpuW+wY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tMn63RSosFNb6p4Kiet7rtACiNP/un93fmKoYpB+Qevx9ohiPhm6KWsh0NcYY+k/kZ7XWB5dTvzux7q5NclNP+ViZHwHjhQIvwkHJZdZh+Y3EP2R1WQ3Vl/OFutxtVf8O8mEsME8InqQ9+GOWoH48ylr3EdK4VYlCNAgmBvHB48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qi/Wu+bM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1607C4CEED;
	Fri,  9 May 2025 01:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746755393;
	bh=bNe3PWOhezlLQpVjDvwr37Wk4UyMK2cGxjI+lpuW+wY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qi/Wu+bMJJXJmf3OtzTlS2gwN2CCyCRIu/KsEyelGggk3dzxTvfPMzbtDJEAOF9ju
	 v2Tk0H8s6DTHWI9c6TL7W3t2GrBhJWCGmcsfhHMR/GaeJZONRPECk0S9D1YT8/+eaC
	 fNZAXwosErQhHomhmSk7TmOpsqQ2tAOWCJ38ErcAo3NDyF34aJIDhmHaXRaPxGTi0d
	 sY0H17JpTFS39pb7vSX65TTGjyC4M5h8dcHHKOEkB0ZZtOs80KCxq986iU41434q5U
	 wdi1qxD//Ww1hFG69wLAJHsxPsX4eeuOrqlJUflHZdkuOPcgX4g82AiCo+YX0p9iug
	 EwvfYKlUrERTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE28380AA7D;
	Fri,  9 May 2025 01:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-05-08
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174675543250.3097595.8572509299736152827.git-patchwork-notify@kernel.org>
Date: Fri, 09 May 2025 01:50:32 +0000
References: <20250508150927.385675-1-luiz.dentz@gmail.com>
In-Reply-To: <20250508150927.385675-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 May 2025 11:09:27 -0400 you wrote:
> The following changes since commit 9540984da649d46f699c47f28c68bbd3c9d99e4c:
> 
>   Merge tag 'wireless-2025-05-06' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless (2025-05-06 19:06:50 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-05-08
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-05-08
    https://git.kernel.org/netdev/net/c/ea9a83d7f371

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



