Return-Path: <netdev+bounces-102622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3552903FC1
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 17:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2B4281B90
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 15:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BEC1BF3F;
	Tue, 11 Jun 2024 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzkAy2Y8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBB718E1E
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118632; cv=none; b=HcjCwkBif/czt8DCMar2LKE6WQrdr1KI/hjSxqeKFhBMvW42ozn+AntdimGXBzGDmtm+tJAgLSdmO5ii4Kxe8cv8rnaRYssJdj1Hpk9AN2u66Q1G95o9wY4falySgKpashYh/qlYnC/Mlr56YhsHH5ikZzmiZGhdyjwwDm8MC2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118632; c=relaxed/simple;
	bh=wqIFt+mpXUx+IU7EuQ16BfptP0tZQdMptznsD0cHK3Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k1+uoWIRt7VkUi9jOU1551PRuEAdNts6SFgF7Zw/flyVEUlhAc1NirH0iVcGDdIZtJ6JqsgWU9IcJbrK7jtp9XvJT8lyR+q4qVo7XWyRA5BkPWMt/5il5eX+DwbtVZRGEHcAcTPvsfjrMvNzcWa9ij8E4GVMwS9bL1yQ5olnInA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzkAy2Y8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BC51C4AF1C;
	Tue, 11 Jun 2024 15:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718118630;
	bh=wqIFt+mpXUx+IU7EuQ16BfptP0tZQdMptznsD0cHK3Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CzkAy2Y8lxYuGKl4inl1qnlLZKUrevp38DPkUeA5Ni3KB4dcQdK1Q/tmg3qpRgAmC
	 aUSVk8kntoqUZGWt8z9vVTQ+r1pHhv3xaJcCdWr6qacsEDfp6WG9zHEk3/XRj03ZnH
	 ov0GFYZODZhmGa5J9jM+MvQtgL5aAn9tEcriasbVKtn1/JIW/SX5UNnk5he+pJ46No
	 m01NGYr2nGeXcMwEpz+MNi8Xp/eyJj1DGxO/6ue9QS9CBLV6c7bRcK250IjrHJKa+t
	 aCCdIHdo4L8kZqpOK2JWbNS/Stz7/2/fo9SYsHLAS4EkIuN1jVDuSDaOR2ElGATcIb
	 2EocKKs/P/9/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 87733C4332D;
	Tue, 11 Jun 2024 15:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [iproute2-net] devlink: trivial: fix err format on max_io_eqs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171811863055.7300.13084711627656143572.git-patchwork-notify@kernel.org>
Date: Tue, 11 Jun 2024 15:10:30 +0000
References: <20240610192451.58033-1-witu@nvidia.com>
In-Reply-To: <20240610192451.58033-1-witu@nvidia.com>
To: William Tu <witu@nvidia.com>
Cc: netdev@vger.kernel.org, parav@nvidia.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon, 10 Jun 2024 22:24:51 +0300 you wrote:
> Add missing ']'.
> 
> Signed-off-by: William Tu <witu@nvidia.com>
> Fixes: e8add23c59b7 ("devlink: Support setting max_io_eqs")
> ---
>  devlink/devlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [iproute2-net] devlink: trivial: fix err format on max_io_eqs
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=459ddd094d80

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



