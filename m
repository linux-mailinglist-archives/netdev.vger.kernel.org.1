Return-Path: <netdev+bounces-186817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40D5AA1A68
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 20:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C55CE170D06
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 18:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4812255E26;
	Tue, 29 Apr 2025 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxNYUBC+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6332255250;
	Tue, 29 Apr 2025 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950800; cv=none; b=m6IdqDgIUDidZZVJOEhBPkTgy6xw26/siV5tkoe9ZSlHLYRItPmAM+X+AIZwnQM0WwT5rwE/Zb1Ss6IlVw+W9vTGzf6KYZf3NWz7cBZPctzOK7LbJZcsK+2HkIPjtRqjnPRaJu7LDnWT2UNMnTP91Szsed+96r3Ozd5jLuKWu0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950800; c=relaxed/simple;
	bh=snC++eNVEP7uDBKcqQJ5sIawpNGNUnse1Ne2rOAC6yY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tftXBuiE2t8avlvZzMxHAkFSIE0BSmG53y+J89kxTVYoTJk1EbsEKg/poECfOG/PMMgXcRvRnMc0lPGO16bwSMtJXg3yFv4kkd/8TBphXKxCBEtm1v21Ao1Ozd12iunSuUfHqrKZJHmtUy+vZQYXIFUj+S1yi2SLvnjVmwIKDaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxNYUBC+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AD9C4CEE3;
	Tue, 29 Apr 2025 18:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745950800;
	bh=snC++eNVEP7uDBKcqQJ5sIawpNGNUnse1Ne2rOAC6yY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VxNYUBC+kAwqJLIhoXkuu4YzNPLXD1V9j3mP6bKGmj0Ggm0kp8JYnRNS0MtIODMKF
	 bFArvLT3eByG994dxGPEb+vkRky1oPdUD61UcBqUqe71gzIW7UbmIXvgpa6v6YajS3
	 j05qOfaFcYUj1jI3K/VxxydOhkmEuq/9HuIQzFc6lgdRyoRbQlexWIH3He/iBo7xRp
	 wCSj5/3M572QCTzH70dhIhWCUWDzZcOVStAibDr8M554gqTyXCJu5CpnAW8fzSYY8i
	 A1FzTbJ1L6Z0KhZNZqNkkFnop2axuIxMaaIwvRDP0nM5kyjq4yLzOlXwSKknnuYvzf
	 1qoX7dPxhLcVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC843822D4C;
	Tue, 29 Apr 2025 18:20:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] nfp: xsk: Adjust allocation type for nn->dp.xsk_pools
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174595083949.1759531.16825575896247903410.git-patchwork-notify@kernel.org>
Date: Tue, 29 Apr 2025 18:20:39 +0000
References: <20250426060841.work.016-kees@kernel.org>
In-Reply-To: <20250426060841.work.016-kees@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: louis.peens@corigine.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, yinjun.zhang@corigine.com, na.wang@corigine.com,
 oss-drivers@corigine.com, netdev@vger.kernel.org, jacob.e.keller@intel.com,
 tglx@linutronix.de, ruanjinjie@huawei.com, eahariha@linux.microsoft.com,
 mheib@redhat.com, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Apr 2025 23:08:42 -0700 you wrote:
> In preparation for making the kmalloc family of allocators type aware,
> we need to make sure that the returned type from the allocation matches
> the type of the variable being assigned. (Before, the allocator would
> always return "void *", which can be implicitly cast to any pointer type.)
> 
> The assigned type "struct xsk_buff_pool **", but the returned type will be
> "struct xsk_buff_pool ***". These are the same allocation size (pointer
> size), but the types don't match. Adjust the allocation type to match
> the assignment.
> 
> [...]

Here is the summary with links:
  - nfp: xsk: Adjust allocation type for nn->dp.xsk_pools
    https://git.kernel.org/netdev/net-next/c/c636eed60958

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



