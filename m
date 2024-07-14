Return-Path: <netdev+bounces-111344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E60E930A67
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 16:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79BD21F21915
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 14:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FD9139D05;
	Sun, 14 Jul 2024 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXeCKc9k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAAC13958F
	for <netdev@vger.kernel.org>; Sun, 14 Jul 2024 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720968096; cv=none; b=K98sGtvFtQWPkLkPtMnpkZ9hejRrKdHDT3ONGk/B7C0+36CITktOv+1NtfFx0gdLJuqlZn2ewBF6zLFWD8fcGBc0u8cFfE8WLYUjppcMQgJoI6Y2LJmeQzmQeE4FuKsmHHgQ7xZ8KHS5QS7qAeH/F35+W9yBYsh5bMRomCC3Amw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720968096; c=relaxed/simple;
	bh=D7B95Wreuw2GRcZ64T5fqEzWgKMMTRLtQ/Qz6chH0pE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EZ2BWc8JbmJhl2EJcVRAjGUlqJgcMnhSzWLOMHTb71LU3qs9XVR/10NlhKwN5m+iPa5EnziSBganJ739uhAY8N8xQbe0YcDSjfnrpqLOBzSMEmRojUF+oTdb8vPqwcBxEY+F7aTwZUZU9wLCgGvZ/vdL430FDIFA+17JfUKQXiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXeCKc9k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9013C32782;
	Sun, 14 Jul 2024 14:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720968096;
	bh=D7B95Wreuw2GRcZ64T5fqEzWgKMMTRLtQ/Qz6chH0pE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bXeCKc9kxJ1v6SZWCCFTeKpm7yqlK6DrW8mYbqS37LmRbloTjUxoqR/z6JWPj3MzW
	 DAro/VKqspDnQKR/UZU4yLvjriq1ytKTRA6brJJ3h5UjjM0b+MNVkstUgoeLm78KhX
	 61xUg20/Gz13xEU7rrdLTxSb/LlBxEVKil1MPIBF4htcrbeKEgWypuerARe0cuB0Mv
	 Wxqrx5tDuvWNW6SNH+sPg/EiW5ERlAW15QBNXTeVU7mzIpE6Lh+E2bqcS0QYVDAiG5
	 lnejckamc8nr2krgMicKA9iEGCzY5GWxL8xOIlS7nyclUYXUDDmkWcg/+RyqkfM+TB
	 +Nhd1PQRqhbWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D18C0C43153;
	Sun, 14 Jul 2024 14:41:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: forwarding: devlink_lib: Wait for udev events
 after reloading
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172096809584.533.3773226039519384629.git-patchwork-notify@kernel.org>
Date: Sun, 14 Jul 2024 14:41:35 +0000
References: <89367666e04b38a8993027f1526801ca327ab96a.1720709333.git.petrm@nvidia.com>
In-Reply-To: <89367666e04b38a8993027f1526801ca327ab96a.1720709333.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 amcohen@nvidia.com, shuah@kernel.org, mlxsw@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jul 2024 17:27:02 +0200 you wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> Lately, an additional locking was added by commit c0a40097f0bc
> ("drivers: core: synchronize really_probe() and dev_uevent()"). The
> locking protects dev_uevent() calling. This function is used to send
> messages from the kernel to user space. Uevent messages notify user space
> about changes in device states, such as when a device is added, removed,
> or changed. These messages are used by udev (or other similar user-space
> tools) to apply device-specific rules.
> 
> [...]

Here is the summary with links:
  - [net] selftests: forwarding: devlink_lib: Wait for udev events after reloading
    https://git.kernel.org/netdev/net/c/f67a90a0c8f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



