Return-Path: <netdev+bounces-151291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 034B49EDE7F
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 05:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71D301889116
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 04:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AC215AAC1;
	Thu, 12 Dec 2024 04:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZTMY1at"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F8913BADF
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 04:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733977825; cv=none; b=gTJ6zCUMf06dlywvY3MFQd5OANEndR67y+SwjaK5lh31YJr1jG57KbzdRZVdqO2aQ8l1yX/ji+kW5ylzVZVdz/4sFzXSdS13bVw1zpfTXc+myCmG+b4dH+iJuVmHWe8k1zywqeRmpR9k6YOFyvi28D4y86MKfDssZy7dE8/MF0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733977825; c=relaxed/simple;
	bh=J3G3rkKHFX3+b28RAlPrGLl9og+ZybaVm2Y4bOK3I7o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nAQ/nuP8aJ4zUEAqdqXSARkL4u+RALTysuv8QGUIRl8pXeBNuqUen+eR7X5NTC2COjOU319kGYfSGEKVA5HuNv/BMLUP6g8JEdXk5DUj7UGHNevJo3/Bn/XRg4WCrO0ydkNv/lQIUh4NluxepCrAkQl5Iesnlg7T1c+LPgD4hMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZTMY1at; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99803C4CECE;
	Thu, 12 Dec 2024 04:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733977824;
	bh=J3G3rkKHFX3+b28RAlPrGLl9og+ZybaVm2Y4bOK3I7o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rZTMY1atf5c123ooRfcLeAfrWqnBtFgA0e0frTFvpcWW8IwNGPP+gAKR6yYtfJmN5
	 yzwKwhCH04QJn7ii/wSIBSrOeQ69oSVq/g3nnNNgoFrKZ+LtImzzskASRCsjwy8tPP
	 tjj1X44EhW6HPTKuZs6doKWFQ6UN0NIkbyzl5smkZHdR307H3y/bWt1wt1BvNRssfI
	 u4qTe0zzi7f/DbnbcZEtqK095L/jLAv7XU/tsI5P974muI+Ucsw3xlhMsOPm7Fp0wy
	 RZ9TRLWWKOYqHPdARnK4V9M2EXdASh2+USdjeIYXzU5mtGtG0CJfVmVYFW1knsRDld
	 OS39U7Ie/Ke1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2F9380A959;
	Thu, 12 Dec 2024 04:30:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] ipv6: mcast: add data-race annotations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173397784049.1847197.4402224554529130257.git-patchwork-notify@kernel.org>
Date: Thu, 12 Dec 2024 04:30:40 +0000
References: <20241210183352.86530-1-edumazet@google.com>
In-Reply-To: <20241210183352.86530-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, dsahern@kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Dec 2024 18:33:49 +0000 you wrote:
> ipv6_chk_mcast_addr() and igmp6_mcf_seq_show() are reading
> fields under RCU. Add missing annotations.
> 
> Eric Dumazet (3):
>   ipv6: mcast: reduce ipv6_chk_mcast_addr() indentation
>   ipv6: mcast: annotate data-races around mc->mca_sfcount[MCAST_EXCLUDE]
>   ipv6: mcast: annotate data-race around psf->sf_count[MCAST_XXX]
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] ipv6: mcast: reduce ipv6_chk_mcast_addr() indentation
    https://git.kernel.org/netdev/net-next/c/d51cfd5f4fe0
  - [net-next,2/3] ipv6: mcast: annotate data-races around mc->mca_sfcount[MCAST_EXCLUDE]
    https://git.kernel.org/netdev/net-next/c/626962911ad8
  - [net-next,3/3] ipv6: mcast: annotate data-race around psf->sf_count[MCAST_XXX]
    https://git.kernel.org/netdev/net-next/c/00bf2032e976

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



