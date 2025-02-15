Return-Path: <netdev+bounces-166642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1569A36BC8
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 04:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A965F172344
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 03:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D58C170A1B;
	Sat, 15 Feb 2025 03:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8PHVpm/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B76165F09;
	Sat, 15 Feb 2025 03:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739591402; cv=none; b=CELKr/PazjtnndIqpnMwFUHhIruCneB2+tIF1yUliLRakGpftg8y/fthhOc5rsYozvJ9E7JxB5PWxFEilxGAJCpdzxc5uenrbAhrxVvDhnecf/+3HbhetNKXmvIEWkmAvcL2y5PGzi4hm+zCcw7LxpJkBS4EmAKXvUmK17l/yHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739591402; c=relaxed/simple;
	bh=b6/nZ7sBtZaW+Yl+7HeCc7E5cWu6kXLhCpeAAIGuaVc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G+O/cCQ5g2ZWEgM0XjWYRdkNbUGofRSXryvkkDihbEqEIPaBU7BnXnHgeclKgX1lm017RB5u9XAcMffBfnFCHEiyoznI+/hgnijBRSqi9OEIsoGb2JbsfpM048J19cQTSNFGOaB6qs/fuWXYYqibzxoxmocZPe0cbtYlbGzLHOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8PHVpm/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B44C4CEE6;
	Sat, 15 Feb 2025 03:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739591401;
	bh=b6/nZ7sBtZaW+Yl+7HeCc7E5cWu6kXLhCpeAAIGuaVc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n8PHVpm/zIv+EEUgZlqBtk68vjtMrm+psHja54LQv0U79vJth7qac/2gvxa8lp3Lj
	 dVQDx/PsqWBEPFqFR2TnlmeLcIbeQHOwJbIT4MsfjBud/MMu+964LIIhQWHAqZHPsv
	 pIOVGQc1udYxC6l0FeER9uR1xEe9/4vVi5tC0kIovzisjLpSx8/lRSDYlYmTqsCWO4
	 W1/3tuGL2GurDcIeD1JG6J4EvGvsKXEkbovo92fcT5Z1uqzkglKOYhQSpKZdkCEAPa
	 zNjfyIl9KmtpYAW7mJo3e3XdTXD1bweI2gGmH8lJ3H8CpRSp1BKbBj838OyZfZldwQ
	 O0DuJzBr9xZgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 726D7380CEE9;
	Sat, 15 Feb 2025 03:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] ice: Fix signedness bug in
 ice_init_interrupt_scheme()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173959143126.2183234.5450052888067824074.git-patchwork-notify@kernel.org>
Date: Sat, 15 Feb 2025 03:50:31 +0000
References: <b16e4f01-4c85-46e2-b602-fce529293559@stanley.mountain>
In-Reply-To: <b16e4f01-4c85-46e2-b602-fce529293559@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: michal.swiatkowski@linux.intel.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 wojciech.drewek@intel.com, jacob.e.keller@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Feb 2025 09:31:41 +0300 you wrote:
> If pci_alloc_irq_vectors() can't allocate the minimum number of vectors
> then it returns -ENOSPC so there is no need to check for that in the
> caller.  In fact, because pf->msix.min is an unsigned int, it means that
> any negative error codes are type promoted to high positive values and
> treated as success.  So here, the "return -ENOMEM;" is unreachable code.
> Check for negatives instead.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] ice: Fix signedness bug in ice_init_interrupt_scheme()
    https://git.kernel.org/netdev/net-next/c/c2ddb619fa8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



