Return-Path: <netdev+bounces-224480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C5703B85695
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B88414E33D0
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDF13112B3;
	Thu, 18 Sep 2025 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfTELjuu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07C930FC25
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207620; cv=none; b=P57Zjls1rmVbftDirrpNbWwCzVjNFPXi2vrrHEoRuu8zmfy9s2UdONjtr3bOUaIcxaJqYmSEG6wUca6oAe0HlZLkwHVdSkdn6KOdavjmLL+zWt5B6s65OrqnRX1G9g2FPF7sRig5lqi7iOTLZdupivugtLg9ArV/QZVeBzo4j7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207620; c=relaxed/simple;
	bh=jS1+8xjCtukmuWPMJasggbPak6yLQvgF3TmLIu+RJgI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oFavzrqD7bt41mo6a51Pi3dcVFXpXQt3uKUBvjlJC10FDubf1ogLnCTC/0uyva3p/Tp3c61z4OjlFMHdui7VW6TdSBIhWLAvNi6m61JNSZqqEPrziNywb9nHOVHXcHV2X7cYCi1Lgs3TekGnZJV1IUTk5kyfy3drbyVeKnF04eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfTELjuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DBDC4CEF7;
	Thu, 18 Sep 2025 15:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758207620;
	bh=jS1+8xjCtukmuWPMJasggbPak6yLQvgF3TmLIu+RJgI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CfTELjuu8zSBSi4RYj4RnAKR3YHVlVktIghUIucuQL/0uoXYQDDrR4f8gyOdfnKfp
	 Tvj32LTBJvlMI89mb5YKl0kAtWIWQMiHPxBwveMKcNUDQ5clbqcS6FI1GTz5+Cz7zt
	 EeqUYznTpoTp5dtnPoMHYaVBehsVrF4ZuHIfaUpSzEU9AnKCez1XcCsztL/kUL8Etz
	 OyzQ9AUMymsIcpqJrJpUjY2wrfjD0PiAk/5KZl5JmTCCfpfrqTsSgg4qNY8lEeGDvv
	 cQ3u4dXT/aUIVWbZvWaulXkXlwvKGgSOz7Z7XZu14RuzftrIsd2wGo+ouHoXGgqrrD
	 39vJb8CWE3XFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F066539D0C28;
	Thu, 18 Sep 2025 15:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] devlink rate: Remove unnecessary 'static' from a
 couple
 places
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175820762049.2450229.11267031301923458832.git-patchwork-notify@kernel.org>
Date: Thu, 18 Sep 2025 15:00:20 +0000
References: <20250918101506.3671052-1-cratiu@nvidia.com>
In-Reply-To: <20250918101506.3671052-1-cratiu@nvidia.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 vladbu@nvidia.com, dlinkin@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Sep 2025 13:15:06 +0300 you wrote:
> devlink_rate_node_get_by_name() and devlink_rate_nodes_destroy() have a
> couple of unnecessary static variables for iterating over devlink rates.
> 
> This could lead to races/corruption/unhappiness if two concurrent
> operations execute the same function.
> 
> Remove 'static' from both. It's amazing this was missed for 4+ years.
> While at it, I confirmed there are no more examples of this mistake in
> net/ with 1, 2 or 3 levels of indentation.
> 
> [...]

Here is the summary with links:
  - [net] devlink rate: Remove unnecessary 'static' from a couple places
    https://git.kernel.org/netdev/net/c/3191df0a4882

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



