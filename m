Return-Path: <netdev+bounces-168719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90955A4044B
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 01:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266163AEE6D
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 00:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EDD46434;
	Sat, 22 Feb 2025 00:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhYOYyZQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFE9273FE;
	Sat, 22 Feb 2025 00:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740184800; cv=none; b=MwxKmXe6jaA+UYWOhmcgmq4W6511QrW0NwS9q9NKsrj7fxyZz7keBbhwpBo7hQliil6YRZKIgQYP11jBbxASyErLSdLaWq2VsqjtMF8Nt6oAkRtWpqM2GrVbuFxBFEwISbFIZwBSuugg3IdLum0/3kzFSXEXyTXZ569+mG1RonE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740184800; c=relaxed/simple;
	bh=MTuCIZ1pcSEXjJnIygM7tsoptpdFWOp4TZReKs3vv0Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KBy2ifdNDLTzzIJ19klbKT5e0coE4nZZSudattEmCPltBt+sK5PsZ0vT20YzhgQaf/+T2zdotyfVEAO96xnQQMX2qduLKgYNuvDVS3YDMiV4SfcpxnmE/lj6LcbfPU9GzG7sVcCnAVuxJ+VDwFkWDuszGA/UVdSopMoG1mH5t9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhYOYyZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0726BC4CED6;
	Sat, 22 Feb 2025 00:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740184800;
	bh=MTuCIZ1pcSEXjJnIygM7tsoptpdFWOp4TZReKs3vv0Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rhYOYyZQpkzoHdpF/X/TMrMo9xaBFLlJUDbeNe03t8nzQB75jOd/HZbG4mWaF041+
	 2k2wR9F2cOMqy/AzzghZ6eer2/KuVYSWwyMmjxmbz3kh4inaqs/H/3l9qwGnXtY5Dj
	 FLBf8GPkq52p/iZff8duJ2L9nRFDIL2GcG9tQfKY+6Bh0A8NaonULkeg1/2f5hn0KI
	 uH9NwNlx2xqSG3EF4YbtzVuVLUOo8Te/arb25oEWefBQL4dh4SOHXg/+rlRK2OjvY+
	 VEy1XbFjSjoRp3XizH6jv+xdnOWlpGDbe1N4DMjdi5/y8gwr9BL5oPxTa6tE85as3T
	 VNZbnrmvuXdXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DC3380CEF6;
	Sat, 22 Feb 2025 00:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: set the minimum for net_hotdata.netdev_budget_usecs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174018483100.2253519.12992918289257470417.git-patchwork-notify@kernel.org>
Date: Sat, 22 Feb 2025 00:40:31 +0000
References: <20250220110752.137639-1-jirislaby@kernel.org>
In-Reply-To: <20250220110752.137639-1-jirislaby@kernel.org>
To: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, zeil@yandex-team.ru, khlebnikov@yandex-team.ru

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Feb 2025 12:07:52 +0100 you wrote:
> Commit 7acf8a1e8a28 ("Replace 2 jiffies with sysctl netdev_budget_usecs
> to enable softirq tuning") added a possibility to set
> net_hotdata.netdev_budget_usecs, but added no lower bound checking.
> 
> Commit a4837980fd9f ("net: revert default NAPI poll timeout to 2 jiffies")
> made the *initial* value HZ-dependent, so the initial value is at least
> 2 jiffies even for lower HZ values (2 ms for 1000 Hz, 8ms for 250 Hz, 20
> ms for 100 Hz).
> 
> [...]

Here is the summary with links:
  - net: set the minimum for net_hotdata.netdev_budget_usecs
    https://git.kernel.org/netdev/net/c/c180188ec022

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



