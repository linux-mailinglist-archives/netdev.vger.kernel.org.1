Return-Path: <netdev+bounces-230233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C24BE5A4D
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 00:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A4574F43E2
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 22:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79A72E62AC;
	Thu, 16 Oct 2025 22:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvSkq6S2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A280C2E613B
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 22:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760652626; cv=none; b=p2nEu37X91o8ttedj/yUQyq1Pz/AGDcHgQP0UuQhpn8dVhQe1E6nj8ibt0iS//sQf3ioo0Xco2Fo+uAmHjgHBAR84oPom0SPwuQLSALdQ9QM2nWJyB4YAhm1JzjEnqT/qAbpqsFUZYJ/vyan9vALzqx7feMBohmUP8A/olRjuHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760652626; c=relaxed/simple;
	bh=vC1tpnCpg1R6QH2pnvZ7Lj35ec0/HK6jJoVkgbXF7I8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SeglPvrTY5DH8z1I0ajltixS2kk71a4wYwdH2KlXUudp9P+kmJMNnNQx61XFcc9f3B3btAbI8jY/xhrrxYgKhu2Uf/mbzDrJogWS6YwVZxntpyckCOlGSgJu+BGJje6vdu0ezfi5Hsr72SxlUIIk6pjh07G5n7SJHJiXJIFgRl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvSkq6S2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5D2C4CEF1;
	Thu, 16 Oct 2025 22:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760652626;
	bh=vC1tpnCpg1R6QH2pnvZ7Lj35ec0/HK6jJoVkgbXF7I8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tvSkq6S2NxdyPSdpFqMVHZXv63bC6Nqi1M58UMq5DYcu2nzZLKQeRKYoU9o6EDeEn
	 nEt+Tn8w23dGrcr/cclStgDb8uctmkUMqY7mdfYqpYWHLpFIfHEASIOcUP7VgUAzbB
	 ItaxoAhupPIBAL6NsCklWapwwdEw5LmLJ9eOMiV8MejAf73lsNUfvFskzVTlVK/zb8
	 FO7MsmEn3mkQ5NMdIypvYDIfjDV4+FfykCETUh+Y5zImSZZEYuHazNjbdzCTc0VU3a
	 C+SLxsnc3BXxILTh/0ZfDIMWpLCtGeXxy+GLLij93K3tH4isghbXy27Ruvw95zyEHB
	 BOfCECkIaKGuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D2239D0C23;
	Thu, 16 Oct 2025 22:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v4] netshaper: Add netshaper command
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176065261025.1923966.2149555058004457088.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 22:10:10 +0000
References: <1759835174-5981-1-git-send-email-ernis@linux.microsoft.com>
In-Reply-To: <1759835174-5981-1-git-send-email-ernis@linux.microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: stephen@networkplumber.org, dsahern@gmail.com, netdev@vger.kernel.org,
 haiyangz@microsoft.com, shradhagupta@linux.microsoft.com,
 ssengar@microsoft.com, dipayanroy@microsoft.com, ernis@microsoft.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Tue,  7 Oct 2025 04:06:14 -0700 you wrote:
> Add support for the netshaper Generic Netlink family to
> iproute2. Introduce a new command for configuring netshaper
> parameters directly from userspace.
> 
> This interface allows users to set shaping attributes which
> are passed to the kernel to perform the corresponding netshaper
> operation.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v4] netshaper: Add netshaper command
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=8f67f01cdad6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



