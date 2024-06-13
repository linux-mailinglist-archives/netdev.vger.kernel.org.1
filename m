Return-Path: <netdev+bounces-103023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CB3905FD1
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 02:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0D41C20DC4
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 00:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8156B847B;
	Thu, 13 Jun 2024 00:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRWdZQFi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A79C8BEE
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 00:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718239830; cv=none; b=s/KTkmpKkS7qtjj6JQBB4Gwk4aV+0hfKOnQvqi16BvDrLVPGUlIwYUarG/fYtxzqkYZd+QmSrwTKrHMpMQeGiaBZ7u2vd/1W5FBe/BBKucD8gkae9r8+dZHrXYd2ZLWkTVO4FVcAeSd+ll9UjMVpKVIcDMyURzMQArurcq2PrWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718239830; c=relaxed/simple;
	bh=/IXiaIHpSNHvaZnbtpAeJfoUD+AbOMxFJ9R3j7fMUY0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ig5GwJ3NMpCLP2M62uHcH+U1iXYvmiyrwVsXRIliVG9vtEu5G3Wj8vhgY/+HluoKWj7aOCrnx92JXL/Cv8zR5bj9AYiLKSbgr/xmx5KZZGgZbxc5DFyXNwzEusHgTpqhTwqW1Kwebd2RyKTiDmI17hdB2+v04BdKnbnubH4dyGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRWdZQFi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFA7EC32786;
	Thu, 13 Jun 2024 00:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718239829;
	bh=/IXiaIHpSNHvaZnbtpAeJfoUD+AbOMxFJ9R3j7fMUY0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RRWdZQFiRaJmh3el1TQnDvQE5vXDA7naZ3i+G9o7aunwjv/mN73vE18D1PgpeY89I
	 4TXgMBIG93iBBKZqFTvZWthMFHoo+via7VcjcIQlQFmWM5A4jxz19J/BKeIucrp+3V
	 Rur4wE68nMl9h1zAYVcjJrW/Fs7OSPExye493iy0e3UctVyF3XrfRxMJ68CDZyvHGE
	 7QeMvx+mKKVvOiz8lv+S6ehBnfcN7+9omOJXT7ai5fqqFNpmi70NLc47nJazMqXVbQ
	 xgvTwx3k0okseOeImft1zzdyFHLCREAwA75MshjBREstJSGj2wwsI6ZHVNYeHoZV1T
	 23M5kzaiKT2gQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD338C43616;
	Thu, 13 Jun 2024 00:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] Allow configuration of multipath hash seed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171823982977.24798.7505772021139800157.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jun 2024 00:50:29 +0000
References: <20240607151357.421181-1-petrm@nvidia.com>
In-Reply-To: <20240607151357.421181-1-petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 dsahern@kernel.org, razor@blackwall.org, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 7 Jun 2024 17:13:52 +0200 you wrote:
> Let me just quote the commit message of patch #2 here to inform the
> motivation and some of the implementation:
> 
>     When calculating hashes for the purpose of multipath forwarding,
>     both IPv4 and IPv6 code currently fall back on
>     flow_hash_from_keys(). That uses a randomly-generated seed. That's a
>     fine choice by default, but unfortunately some deployments may need
>     a tighter control over the seed used.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] net: ipv4,ipv6: Pass multipath hash computation through a helper
    https://git.kernel.org/netdev/net-next/c/3e453ca122d4
  - [net-next,v2,2/5] net: ipv4: Add a sysctl to set multipath hash seed
    https://git.kernel.org/netdev/net-next/c/4ee2a8cace3f
  - [net-next,v2,3/5] mlxsw: spectrum_router: Apply user-defined multipath hash seed
    https://git.kernel.org/netdev/net-next/c/60bcfede3f9f
  - [net-next,v2,4/5] selftests: forwarding: lib: Split sysctl_save() out of sysctl_set()
    https://git.kernel.org/netdev/net-next/c/6f51aed38a4f
  - [net-next,v2,5/5] selftests: forwarding: router_mpath_hash: Add a new selftest
    https://git.kernel.org/netdev/net-next/c/5f90d93b6108

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



