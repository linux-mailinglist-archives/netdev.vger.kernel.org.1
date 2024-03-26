Return-Path: <netdev+bounces-81887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3025588B80F
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 04:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4D34B2283A
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 03:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9691129E8C;
	Tue, 26 Mar 2024 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMgACAGl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A54129A8E
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711422630; cv=none; b=lZuX2o/jTMNuEB5bM2TXJ00FJhdXd48XKbCu2yDOC/FJesnpQfVNCY7l59tbbvSDeoD7Ym5Q81Nk8cpl7njRTTavI5mOFHizqLtpo4462a0KnSdjpacrrIIJoAdVEYKA8wSPvaUgpTMJVb0KT5nyAztQp2aDRdzRK/l5HaXdTo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711422630; c=relaxed/simple;
	bh=fpcSB7h5oCCliCVPUvCo6+Z7/NsojGrbxsq2DHYr2Ws=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sDLZUkZ4VmK3t4zTgs5mOYaDHWDTBUT0BHIL1VuAbJzpTNfq9Njz/YW9na+pBytQJdGDdATR0gihx9qZoaTnXtPxWB8pz1wy03x46JCDrw8GOZc1oiwXaksPPQDPT4LZwrEwjfaDZwRnx16MRimKsb8xqzOP6mPn9AtwXm//Fv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMgACAGl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B68BC43609;
	Tue, 26 Mar 2024 03:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711422630;
	bh=fpcSB7h5oCCliCVPUvCo6+Z7/NsojGrbxsq2DHYr2Ws=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VMgACAGl9VGqw4jjUC1JjfsLv4KpRtgO92H0mTXxp3qLMLjgTDPNG7SQu77M5/5bq
	 HKo+L8rGYcFJh/4GEF2oK7G9THD6+nyQidKzX2g3aNRBFTKSlMk5RQS/6M0/i0stIQ
	 BSTt1A/fCi/f2odxTyvvuf1Q84W6nZFGmDrBngyBPkuRp/xDUXovNbdO6zesve2jVS
	 3NSXF7n77IoIURy7Qso+CczJXuQrmJJZLBFydCfFeHXdJhQqLTLuzxLcAxvRtKpPsh
	 ALADNTID7XdeobUflgvRlLpPl5UNYoSJznC2Rmxl0gC3XnIgf9+xP3NeT57KyadiAM
	 7lcYR6fSQoqPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7EFB5D2D0E0;
	Tue, 26 Mar 2024 03:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] dpll: indent DPLL option type by a tab
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171142263051.4499.15352445898793436984.git-patchwork-notify@kernel.org>
Date: Tue, 26 Mar 2024 03:10:30 +0000
References: <20240322114819.1801795-1-ppandit@redhat.com>
In-Reply-To: <20240322114819.1801795-1-ppandit@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, netdev@vger.kernel.org, pjp@fedoraproject.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 22 Mar 2024 17:18:19 +0530 you wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> Indent config option type by a tab. It helps Kconfig parsers
> to read file without error.
> 
> Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> 
> [...]

Here is the summary with links:
  - [net,v1] dpll: indent DPLL option type by a tab
    https://git.kernel.org/netdev/net/c/cc2699268152

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



