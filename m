Return-Path: <netdev+bounces-57876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DCD814624
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33937B2354D
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDC024A14;
	Fri, 15 Dec 2023 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdfYTVg7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C652125112
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 11:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5098EC433C8;
	Fri, 15 Dec 2023 11:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702638025;
	bh=vZ/bYpF9kT/8YYemIbez3ErhZVCsWMDMy/kuGEz6mpA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QdfYTVg7fYoHq/ZKdULSTgtKFjH4YZEtRUFZC4urWuszU+64IHyd2y/y54dmspEWH
	 XLtpjhr4ICWXtGjcokqYiHnYMWedtrW4mncf/T5ZaYqcikafoE3EAfRU32rg1LwCNi
	 wJKmScZ+G1ppIKf3o0jmEX+eMmomzSYOFkxOD079OShgDGC4iRFccgMEozxh+mDCgP
	 Bg/4aInvgvhPqbnPjwD5/4gWpGX6Rwl8jdSvMzgEDfG0a5wrXKTyEU1hLuBHKJKH0f
	 yvXeAg2paJgJgBKNd5JuPWB28BB7NSSe/yacq1O/NGEmSaCQLQTESfxEHhB4w1LQYi
	 DlcECu/4rS9Ig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D06EC4314C;
	Fri, 15 Dec 2023 11:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] mlxsw: CFF flood mode: NVE underlay
 configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170263802524.14267.2160696083296934842.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 11:00:25 +0000
References: <cover.1702557104.git.petrm@nvidia.com>
In-Reply-To: <cover.1702557104.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 amcohen@nvidia.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 14 Dec 2023 14:19:04 +0100 you wrote:
> Recently, support for CFF flood mode (for Compressed FID Flooding) was
> added to the mlxsw driver. The most recent patchset has a detailed coverage
> of what CFF is and what has changed and how:
> 
>     https://lore.kernel.org/netdev/cover.1701183891.git.petrm@nvidia.com/
> 
> In CFF flood mode, each FID allocates a handful (in our implementation two
> or three) consecutive PGT entries. One entry holds the flood vector for
> unknown-UC traffic, one for MC, one for BC.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] mlxsw: reg: Add nve_flood_prf_id field to SFMR
    https://git.kernel.org/netdev/net-next/c/d9d441e8e89d
  - [net-next,2/3] mlxsw: spectrum_fid: Add an "any" packet type
    https://git.kernel.org/netdev/net-next/c/b2f5eb5a6509
  - [net-next,3/3] mlxsw: spectrum_fid: Set NVE flood profile as part of FID configuration
    https://git.kernel.org/netdev/net-next/c/6dab4083260b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



