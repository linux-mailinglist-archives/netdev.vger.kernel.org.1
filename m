Return-Path: <netdev+bounces-138164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B33D49AC73B
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 12:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A201F21623
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 10:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDB0158D94;
	Wed, 23 Oct 2024 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3oRAYzY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73CF1487D6;
	Wed, 23 Oct 2024 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729677624; cv=none; b=lFSr19ODDgiW7zrhFVmBJBpKyiuRIL3DsDGGNuiHBbfaGJIO7s4jt2iSMLglM1hWp4GfOqXTeDVIp2aXI9nMGa2hyNeZIbsFv5d6UA/g+m5wsPf1TDfMrcvxn5ipDs6I2JN5v6usI//SI/PpebXux+fdT/aOOuKMUfCyvZsRYuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729677624; c=relaxed/simple;
	bh=kuc8y+q3GXcLv0L3KARkdt/7V6mJAIyiPs1YVHhiG6s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eiQIY2MJlkfiVCO6L71Ic1JAjzwbCCW215Awi5eKkhSIjxA1kJ+z2Q/CMLhrbsp83oko+cw5xkI+f1919DIDU3JFx42dXnT+QqIjwoPrVp09tYc7eT1/pj36g6al9nKc3Q36HlMP7NwuOYxs8JJu4mRjkRH8tj3acaZHc2yK1PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3oRAYzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B41C4CECD;
	Wed, 23 Oct 2024 10:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729677624;
	bh=kuc8y+q3GXcLv0L3KARkdt/7V6mJAIyiPs1YVHhiG6s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y3oRAYzYQKHQvWn2VmJuiDW3NlhzI1sNF2TZ2XEVCt0TgXBkIG1UwrcPdhPiPpYtI
	 mMWL6CfWbwPZvxp2O2QNdK6oopSiA5RqJ1ycZiAfGqMkENmzgHYhuaKR56MNEzC77p
	 3pdopZogSVIjLO5KUSVwKE8D+O97jZ8hh271rJIe7qJSpcYyDhZWzEYW7OUffQDaU6
	 8keL89SeT02ftLHErrfcZqMNMu1BMCrIkRxx1EmDkTMEy9O2zQhtZ6vaooUGOKlbuJ
	 O5fOSaXlDyMuKE8AWbBaPhmz71oQczyR4bAYWrQdylU7n0HY7vq1+m8bGBayhDfHJ3
	 ebsm2+VnvMK0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1703809A8A;
	Wed, 23 Oct 2024 10:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/sched: act_api: unexport tcf_action_dump_1()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172967763052.1546501.9577791496088481146.git-patchwork-notify@kernel.org>
Date: Wed, 23 Oct 2024 10:00:30 +0000
References: <20241017161934.3599046-1-vladimir.oltean@nxp.com>
In-Reply-To: <20241017161934.3599046-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, pctammela@mojatatu.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 17 Oct 2024 19:19:34 +0300 you wrote:
> This isn't used outside act_api.c, but is called by tcf_dump_walker()
> prior to its definition. So move it upwards and make it static.
> 
> Simultaneously, reorder the variable declarations so that they follow
> the networking "reverse Christmas tree" coding style.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net/sched: act_api: unexport tcf_action_dump_1()
    https://git.kernel.org/netdev/net-next/c/83c289e81e88

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



