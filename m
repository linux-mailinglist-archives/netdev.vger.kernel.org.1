Return-Path: <netdev+bounces-123448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD60964E4D
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 21:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 647AB1C21562
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 19:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633521B9B34;
	Thu, 29 Aug 2024 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeStcrsX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FB91B9B2E;
	Thu, 29 Aug 2024 19:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724958028; cv=none; b=MKFn1fIpfilQ9bgo5GctrkBBJpPPpwbz+A0aRahFIh6qEMqZ5EN24xj9qeJxRBMKzp3ta3k/lRFIzL1biQOBf2uA4Ksc3w/HiwVsSPBYNoDh3BtMqEkigtcX+xIi+niKa54IYCk8cptWZipVvXyYdNXXolu5q9zduFI6kMoWHlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724958028; c=relaxed/simple;
	bh=Vxi1moCRcDmPlhcYoE6UGRkSylWmT2SuQDSl4OP5lxM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uAyx1OkZA85GQlnsGch7cPiB3DhWkErKiU5gPNJ7sGBM7UX7PZfroGK7P/Ui2HvDXiQU7wiyU95Bob2XqKcntmq8w0PM4a253yHrRlXEdmVmFe5Byg5WdubCo7O+oydzFsX1yyFuIYN/oKHF1UaH3kDKussqoRn3Mj/6hs8UqXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeStcrsX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAA8C4CEC2;
	Thu, 29 Aug 2024 19:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724958027;
	bh=Vxi1moCRcDmPlhcYoE6UGRkSylWmT2SuQDSl4OP5lxM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PeStcrsXRJUpZNZRtXXsEv+JyjknYSCgv5HNBL4jjtt3YPUJf7nNMI6twcZ64mh6T
	 MUVQ+bdl30CQ0W+YEPP6SkZYWraB8k8bx7nZBIPM5dntHJYHnh0esVNhAko2VY294q
	 wRLqZJvt7gCAxcRsy3UBwMm/g+IWwYWsfLgqA1MO0q9/ExyUeMxIObe4gZ47ZrbzVR
	 FT69wqK2UwylLCvJeEN0YIi14VgSW1kADiy6YhoLcaI+m0NJpWZQeEZ0U73y7dZInC
	 sxtLRySW+RcXSRedHyEOFzeCA2ro4nGm0s3CtECnOyArVfOieN2O7ZqXN1ZHzuTd/3
	 1E5KB7YMxt8IQ==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 41D633822D6A;
	Thu, 29 Aug 2024 19:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] net: alacritech: Switch to use dev_err_probe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172495802925.2053394.9402137571601121082.git-patchwork-notify@kernel.org>
Date: Thu, 29 Aug 2024 19:00:29 +0000
References: <20240828122650.1324246-1-11162571@vivo.com>
In-Reply-To: <20240828122650.1324246-1-11162571@vivo.com>
To: Yang Ruibin <11162571@vivo.com>
Cc: LinoSanfilippo@gmx.de, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, opensource.kernel@vivo.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Aug 2024 20:26:49 +0800 you wrote:
> use dev_err_probe() instead of dev_err() to simplify the error path and
> standardize the format of the error code.
> 
> Signed-off-by: Yang Ruibin <11162571@vivo.com>
> ---
>  drivers/net/ethernet/alacritech/slicoss.c | 34 ++++++++++-------------
>  1 file changed, 14 insertions(+), 20 deletions(-)

Here is the summary with links:
  - [v1] net: alacritech: Switch to use dev_err_probe()
    https://git.kernel.org/netdev/net-next/c/bf4d87f884fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



