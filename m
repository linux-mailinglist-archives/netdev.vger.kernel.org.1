Return-Path: <netdev+bounces-154097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FCA9FB412
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 19:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F7316504A
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 18:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B691C3C17;
	Mon, 23 Dec 2024 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsueVNQo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06A51C3C11
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734979229; cv=none; b=JRNiIBmTnxGcvYZPF7ynmsFObes6a6Ad+9uwsm/jx2BePIWc+VQ6/KPKnCsijVdGNGbQeoOxzzePUjPPr/AzRzHDgI7mXBeqXrIbVOjMClLjyHxtlizuvLVgmTay6h75Ay+6WxU0ncAUzATochgqM4QCkB1vZNGnGGt0uaFwob8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734979229; c=relaxed/simple;
	bh=fRG6rIrxY5qDDgr8BXM0VsAZZVasNtQxBKb9zZJm0SM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dvmBenlHa/tUzF8OrqDzQEFe5xicFhcmif7padFhmpHzbFrAwn9RcWbYFKi0CGAEyoN+KDvyT+OFROcsayd/JGYylqDy/DOg3wVXGCqhsAK3TAXVUc8nK5FPyfWGvWw67S8TTVadgNg0Sar8OYZvlYB/2N4DCXgBq0Za1ubw0E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsueVNQo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85522C4CED3;
	Mon, 23 Dec 2024 18:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734979229;
	bh=fRG6rIrxY5qDDgr8BXM0VsAZZVasNtQxBKb9zZJm0SM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dsueVNQoU4VagtSyabQfXrXZVivPD2Jbh/zjlL1fHbhAErrnUPYegrVvuUYLsaH2J
	 pAxJJd7MzoKL8XGhe9GSAqWSH5wxCg4+ypiDzPjY/E30Cpr8RlCPiZIgqey2bYfHnO
	 pAj+TQV7NhdUU9xyoP4AIWYX9S3oeAc4IjPxwsubMraMOHwKbwIGkBkVELAV5UolMI
	 nvKoMEZ0IT93BvRYHIu08SUrQW40Kb6Q6lgsVnPAPPwfAwbT7jSaWaShe6zRsFm+KC
	 tLSZyhK/3qo7dZ7YBa4kYhziJiEb7YOBoZYdRti6SRMzoRBjiySbhFjhU5tPlh8Y5h
	 9Rc5qxtXemhdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D4B3805DB2;
	Mon, 23 Dec 2024 18:40:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/7] vsock/test: Tests for memory leaks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173497924774.3927205.11350873328678184166.git-patchwork-notify@kernel.org>
Date: Mon, 23 Dec 2024 18:40:47 +0000
References: <20241219-test-vsock-leaks-v4-0-a416e554d9d7@rbox.co>
In-Reply-To: <20241219-test-vsock-leaks-v4-0-a416e554d9d7@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: sgarzare@redhat.com, netdev@vger.kernel.org, leonardi@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Dec 2024 10:49:27 +0100 you wrote:
> Series adds tests for recently fixed memory leaks[1]:
> 
> commit d7b0ff5a8667 ("virtio/vsock: Fix accept_queue memory leak")
> commit fbf7085b3ad1 ("vsock: Fix sk_error_queue memory leak")
> commit 60cf6206a1f5 ("virtio/vsock: Improve MSG_ZEROCOPY error handling")
> 
> Patch 1 is a non-functional preparatory cleanup.
> Patch 2 is a test suite extension for picking specific tests.
> Patch 3 explains the need of kmemleak scans.
> Patch 4 adapts utility functions to handle MSG_ZEROCOPY.
> Patches 5-6-7 add the tests.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/7] vsock/test: Use NSEC_PER_SEC
    https://git.kernel.org/netdev/net-next/c/f3af3ba10838
  - [net-next,v4,2/7] vsock/test: Introduce option to select tests
    https://git.kernel.org/netdev/net-next/c/ef8bd18f475e
  - [net-next,v4,3/7] vsock/test: Add README blurb about kmemleak usage
    https://git.kernel.org/netdev/net-next/c/50f9434463a0
  - [net-next,v4,4/7] vsock/test: Adapt send_byte()/recv_byte() to handle MSG_ZEROCOPY
    https://git.kernel.org/netdev/net-next/c/f52e7f593b49
  - [net-next,v4,5/7] vsock/test: Add test for accept_queue memory leak
    https://git.kernel.org/netdev/net-next/c/f66ef469a72d
  - [net-next,v4,6/7] vsock/test: Add test for sk_error_queue memory leak
    https://git.kernel.org/netdev/net-next/c/ec50efee8cf8
  - [net-next,v4,7/7] vsock/test: Add test for MSG_ZEROCOPY completion memory leak
    https://git.kernel.org/netdev/net-next/c/d127ac8b1d4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



