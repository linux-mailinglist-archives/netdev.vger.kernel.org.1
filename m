Return-Path: <netdev+bounces-88934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D72598A90A8
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 03:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740A41F22345
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 01:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A78A93B;
	Thu, 18 Apr 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJCpH6DU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40F66FB0
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713403829; cv=none; b=tZIHAEwFQZVPuxYCy6FdEUbPLkrRVLCkCRuVcZV8QsEdAqgQftZYdEpfwWz03bl7sTG+aPOpXiuov7KwaT95By7FV6EsQqXFNDmMbzZ92oiCn5rHNXPDuUdLPRmQRb9VThFigFric4TQQmxtrRRHPx5n3wAq8u4QGsuAV+mlCzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713403829; c=relaxed/simple;
	bh=jNQvDlUsM5tHGoBWouuYmfB/FSWwya2KLLvOkpuWpzk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VfylT8PA3nYxoSqg6d6S0DHz3BZ9Fb9xtaDZ2Ai9sJvA6gw2yzymiZBW5fckIPrPuhH9gWvNjiTIeocLbVPWQGyjYAp0LHuKa8hnZ9r1y1XEjHa8qhGzDO9qIF7tWT8CuIuDMqUDE1bHwd9K+14vmHLpzwClnOExKncxkHDnCxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJCpH6DU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AA68C4AF07;
	Thu, 18 Apr 2024 01:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713403829;
	bh=jNQvDlUsM5tHGoBWouuYmfB/FSWwya2KLLvOkpuWpzk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bJCpH6DURPEgLl4ykWWs8z/VwXYp+fjC0lWSEaMUY+zrrjuuWFYVqpTM9Vv+f1BWA
	 MEEjP5L2CbPBNEAHEwh285B1AmqPVmi5zvYj78PL5ysosuDo+YCGYe7tOa1DkNlTOa
	 zkHjtbqCkdJ5TXenltXX94ZoyHz7OvuNPE4JhoVS8H02BWfK7C7BGE5yduJI3lQeUs
	 bnjNpxW4a2ovNG/ClZGxoQoU4ELp2fKYtE+kXD3/2y3fUbmvYLea4KTByJyIN5JZET
	 SAMWdZB+4gVTq/IjVnFSGxcYvuaNYeVYLBdrjF3Yuy5ntQugehTaBQbDbHT4Ar2xgl
	 0JUm/an1ExEWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78E58C43616;
	Thu, 18 Apr 2024 01:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: netdevsim: select PAGE_POOL in Kconfig
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171340382949.22183.8390669119829314280.git-patchwork-notify@kernel.org>
Date: Thu, 18 Apr 2024 01:30:29 +0000
References: <20240416232137.2022058-1-kuba@kernel.org>
In-Reply-To: <20240416232137.2022058-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, lkp@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Apr 2024 16:21:37 -0700 you wrote:
> build bot points out that I forgot to add the PAGE_POOL
> config dependency when adding the support in netdevsim.
> 
> Fixes: 1580cbcbfe77 ("net: netdevsim: add some fake page pool use")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404170348.thxrboF1-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202404170527.LIAPSyMB-lkp@intel.com/
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: netdevsim: select PAGE_POOL in Kconfig
    https://git.kernel.org/netdev/net-next/c/94e2a19a0e22

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



