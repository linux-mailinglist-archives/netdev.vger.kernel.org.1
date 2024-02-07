Return-Path: <netdev+bounces-69945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF8184D1E3
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C193E1C220CB
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4905984FC1;
	Wed,  7 Feb 2024 19:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sq7woos1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2480F83CCB
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 19:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707332426; cv=none; b=uuyndvlUXNu/KNi+oTpFj39wKx3NmpvnPbLrH9OcLYspi9me9kWJJYJreu4KHjzzyE6Yx/V2ZWprmSbfGE1zyZLIZ8Ha+dDaL7B9objlLoFU4GjNNv93L63GLbW9fMQQszLQhxVOjFI99962jGpDoltELPWwlS8Uja1eRMGtmsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707332426; c=relaxed/simple;
	bh=0ZGp91iyBlxmpbFQorL7rnA7RLC8VhpYbGvpA/ds70o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=swDHpZ75T7yNF66blGwcQPJs+eQ1FObKU+ZeR/wH18kioflpO/WdhSN2Ktu18e7C7lhvn2CjIhquE/wQRu+C1ED9E6OfpnGOubxzgnGgpKuftSIq6iGHajJeIqckMocoHjvJXqa23k2PMFDEo7UMtHf90jgFwifTwfAlMXl1rdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sq7woos1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A27E8C43399;
	Wed,  7 Feb 2024 19:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707332425;
	bh=0ZGp91iyBlxmpbFQorL7rnA7RLC8VhpYbGvpA/ds70o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sq7woos165wqi5R8VQ80CGeqoCDrpn3cET9DD7OhAIDh49btHJaMbD9pGcU0K9XKC
	 JteTy325yxy788ruMzU5iKSkGWLLUoOgCAClvE/DudU5vbyBPEsi4NawWXTcMJcWy2
	 6eoWpDSiaUDqRtzBlV4e6jsDqZVADRA6SA6xHe1/3JkfnpgIhkdutt5r89Cnl1U4eC
	 EpkeUt4jLcNSon7POefeCivnDbZxz78Sfi+hPHIHOfeJRegHj+CCgpzGaWq8KPoac5
	 ZNLo0NHfy4aVvrtOOfm1Ah8gS1WY8NYTX5CjigzvVdewjzjuN2HA9i1B8+BSbBJd6e
	 C8GJt59bjXNvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8934FD8C976;
	Wed,  7 Feb 2024 19:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net-next] dpll: check that pin is registered in
 __dpll_pin_unregister()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170733242555.13200.7288166219023407933.git-patchwork-notify@kernel.org>
Date: Wed, 07 Feb 2024 19:00:25 +0000
References: <20240206074853.345744-1-jiri@resnulli.us>
In-Reply-To: <20240206074853.345744-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Feb 2024 08:48:53 +0100 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Similar to what is done in dpll_device_unregister(), add assertion to
> __dpll_pin_unregister() to make sure driver does not try to unregister
> non-registered pin.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next] dpll: check that pin is registered in __dpll_pin_unregister()
    https://git.kernel.org/netdev/net-next/c/9736c648370d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



