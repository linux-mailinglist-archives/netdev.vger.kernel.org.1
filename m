Return-Path: <netdev+bounces-198582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43274ADCC32
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C06176A68
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BC32E92A3;
	Tue, 17 Jun 2025 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGxXPfKk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13902E88A6
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 13:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750165203; cv=none; b=HpKMvO6kZ7G4s9skpDbrP8LzKU5tps56813k8tLVx2jZfv1t7BCGxvjV5VvRdr+uCM3PM23Yc+5bmie+tEHoOT9a0cGQz77CTgC3zvDYDLSS5oFI9y2IaHLXSCQohYO+N+mo1bMhBHch2t6GkntURG96gBOA/Vh/yi6UXXGA8us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750165203; c=relaxed/simple;
	bh=eT+6iMe08FtWZDyH7cA+xUYK6FAcCmLwft3U1b/65Xc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KLkryZBZ0E46syX1Gj/1vhggmVkiU0cPehAqX22/IL/TKt7QW2/PqcHSxy6uYHOTtqFfXnmmCMD9RqnYh9ICc5nl8G/BPQVzb7oCzwMWBszBqPGQrnhd2PhIJ0aS+jyDXWd50Lc+bgcecHYbozfDD5egSmdmmM+V9BekFTWCaO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGxXPfKk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23314C4CEF0;
	Tue, 17 Jun 2025 13:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750165202;
	bh=eT+6iMe08FtWZDyH7cA+xUYK6FAcCmLwft3U1b/65Xc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eGxXPfKkYzTcYC/qlDIKAmXEFpbAxRbdJbkSNh4RfzrOdOOTpzOo5O1hbnUh4VLgF
	 yVuaFr0O8Dbm+7m++OBKn3tk18o7t65X9R2QFmzV+Q+/Yy8SncCoBmQtsD8HuPiQWK
	 cVfr62dsWwK4msbQArzHRLMMWdoostROyfkF/VF0PjgkvdyCu4zIGN/kD2CIayj5Pd
	 XkcWGAjFEJB9io9HSJ5yeW/Ecn0kzoO0bn9l+F6mLMr4U5HQmKrVWHeIdqDm6gTYyg
	 W86s0mfr138p7gBVnUTungHVnS+MvCCKDIK/7HENnD4ze1AF4oYI5FVboo3fRcfAzW
	 JAWiBLjknV7aA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB721380DBF0;
	Tue, 17 Jun 2025 13:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] openvswitch: Allocate struct ovs_pcpu_storage
 dynamically
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175016523077.3113934.3649305675066595449.git-patchwork-notify@kernel.org>
Date: Tue, 17 Jun 2025 13:00:30 +0000
References: <20250613123629.-XSoQTCu@linutronix.de>
In-Reply-To: <20250613123629.-XSoQTCu@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, davem@davemloft.net,
 aconole@redhat.com, echaudro@redhat.com, edumazet@google.com, gal@nvidia.com,
 i.maximets@ovn.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 13 Jun 2025 14:36:29 +0200 you wrote:
> PERCPU_MODULE_RESERVE defines the maximum size that can by used for the
> per-CPU data size used by modules. This is 8KiB.
> 
> Commit 035fcdc4d240c ("openvswitch: Merge three per-CPU structures into
> one") restructured the per-CPU memory allocation for the module and
> moved the separate alloc_percpu() invocations at module init time to a
> static per-CPU variable which is allocated by the module loader.
> 
> [...]

Here is the summary with links:
  - [net] openvswitch: Allocate struct ovs_pcpu_storage dynamically
    https://git.kernel.org/netdev/net/c/7b4ac12cc929

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



