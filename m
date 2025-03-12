Return-Path: <netdev+bounces-174320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 536EFA5E467
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 20:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259481888B57
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 19:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7112586E7;
	Wed, 12 Mar 2025 19:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5GgQ2Kf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A5D23CF12;
	Wed, 12 Mar 2025 19:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741807797; cv=none; b=qX131rVHooFqbMnu3hctym6I2v0uga2unMnVWuLU+aVvB7bhJlqj34s9zNbMRFszaU2mRa3FTZ8+qrASY6okPAw0ZfaHWaWhvDacm/PSXYtFo2gZ4RzcgxnXjdrmLRwDoNPxmD1Ux2ZpYAZOIgve3zFI7l5cDsatlfd5R8fwDmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741807797; c=relaxed/simple;
	bh=w665CGxolMF8oTptBUTJRmpjyGCsr9dHJNKmP6rI5G0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XpfyaMD/lPZSlgW1Tcjr5UPGp7JgLRL+9V4xr/805Q7jmTmiHEVdtQcwrf5L3Hm3RZy6GL12MY7hmMaLhUsAHZ5OtYo5S16oaOF8cM9vnGBw6ye5Lb6NatJnqYWmrnY2F3a8h/hyRhEoX81OOxpxctgnFzo5gFPbsMe3U4MvYEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5GgQ2Kf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F8FC4CEDD;
	Wed, 12 Mar 2025 19:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741807797;
	bh=w665CGxolMF8oTptBUTJRmpjyGCsr9dHJNKmP6rI5G0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A5GgQ2Kf9ooXPuQEPfnwn6ac8IOtTn28zLhJGU3DEbTJks0iIYvUDgBBf6jTtpomP
	 bSJLBREI38Zi2QamwoGh6hcHVc4O4CYZgdkw76VX7Dz/vPUuJaVnsx0zcIulnEIQvx
	 w0OIF6PV7Aigc3Sd4yRi3Qmp4TV9WqsJNCx8JXYViLBYlIyh+iVrdJYYb1lQHISZGQ
	 xjW+mBy1k/o2P1769odTY2JittnYil9HxAiSFYXN45ZSahtgVyl3914TwHmZnhoWKs
	 AexV1Jum88NUJ4nuvSe94RrR1rG01rgNVUViqWhAB13Cl2uCJtY0U1LjL/M7UAcZqN
	 4Wx+6lCN4iF5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC83380DBDF;
	Wed, 12 Mar 2025 19:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: HCI: Fix value of
 HCI_ERROR_UNSUPPORTED_REMOTE_FEATURE
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174180783150.904159.8994265489515508641.git-patchwork-notify@kernel.org>
Date: Wed, 12 Mar 2025 19:30:31 +0000
References: <20250312083847.7364-1-sy2239101@buaa.edu.cn>
In-Reply-To: <20250312083847.7364-1-sy2239101@buaa.edu.cn>
To: Si-Jie Bai <sy2239101@buaa.edu.cn>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org, johan.hedberg@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, cuijianw@buaa.edu.cn, sunyv@buaa.edu.cn,
 baijiaju@buaa.edu.cn

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 12 Mar 2025 16:38:47 +0800 you wrote:
> HCI_ERROR_UNSUPPORTED_REMOTE_FEATURE is actually 0x1a not 0x1e:
> 
> BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 1, Part F
> page 371:
> 
>   0x1A  Unsupported Remote Feature
> 
> [...]

Here is the summary with links:
  - Bluetooth: HCI: Fix value of HCI_ERROR_UNSUPPORTED_REMOTE_FEATURE
    https://git.kernel.org/bluetooth/bluetooth-next/c/8d35126f69f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



