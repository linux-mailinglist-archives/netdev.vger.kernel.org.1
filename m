Return-Path: <netdev+bounces-105718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CE49126CE
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 15:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86DCC1F26F55
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 13:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544486FB2;
	Fri, 21 Jun 2024 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nk2BlMru"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5C6F4FC
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718977231; cv=none; b=TWX0O0rfY/x9N7mdymCxOs7fhRsfrSswojS/yfNfVuHoGYVNkut6soEZ7cNZZsd+4SSwJGhIV+fwFYf3FPlG1AD/z3Wj5MerjdO9ED0zET4kiFtGkbQ4fBzIYi/whkQdhfC8MFXE0hjwF+AEfcNVH2GlJlV+t8BypfvjKQ168Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718977231; c=relaxed/simple;
	bh=R5AE5zcZ3E1dq168fdigiPFmIMOjdiYtAkYLt7K50jA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OvKzO0yGqP5FwLiXKLI4hANS7P9f9CF0cMpVijs23LgH7UpSomYZcrKlMo3cKX4I4VHxs73Y6iqPVu4bU4bBsPGXMe1L8JutjQo++o9HC3Oh6BKucRLbaRy+gv3Gxks+ieBIMuF2ilyMzeHURLbZW4ROMZfOklE61S8nWmNQFZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nk2BlMru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E464C4AF08;
	Fri, 21 Jun 2024 13:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718977230;
	bh=R5AE5zcZ3E1dq168fdigiPFmIMOjdiYtAkYLt7K50jA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Nk2BlMrudM23mfKjOnS+dsK9+KE1QMqmXRts5Qz0CDiaSbr5PFc8K/V9kjnNNWh1t
	 se9EwAPrqHLaXqkx+wISDHSRWtothhcB3UwefJqxl52dGrt1HJKImnktEs8ANitGX/
	 34Kq+iOt3E2LjHExijJnTVz74FVNnnA42xzowCpqlQgMGMsmw0JSmk20hzn0b3+Rdh
	 r5nzUqIPXcTMD5OsyP/HcnKKs0yW15mQu3Ond3686MHzgfxBkOR8rvJObRJRjw5Ee1
	 /6/a1ZzcleeSuaxXR/ORcisFUm3++IgB8zZIRnoOrhVTMG4RilYTz7dSTSKznc5dSn
	 RcN0LWmt4qWZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A185C4332D;
	Fri, 21 Jun 2024 13:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] mlxsw: Fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171897723043.16944.17127501313356306736.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 13:40:30 +0000
References: <cover.1718954012.git.petrm@nvidia.com>
In-Reply-To: <cover.1718954012.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 mlxsw@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 21 Jun 2024 09:19:12 +0200 you wrote:
> This patchset fixes an issue with mlxsw driver initialization, and a
> memory corruption issue in shared buffer occupancy handling.
> 
> v3:
> - Drop the core thermal fix, it's not relevant anymore.
> 
> Ido Schimmel (2):
>   mlxsw: pci: Fix driver initialization with Spectrum-4
>   mlxsw: spectrum_buffers: Fix memory corruptions on Spectrum-4 systems
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] mlxsw: pci: Fix driver initialization with Spectrum-4
    https://git.kernel.org/netdev/net/c/0602697d6f4d
  - [net,v3,2/2] mlxsw: spectrum_buffers: Fix memory corruptions on Spectrum-4 systems
    https://git.kernel.org/netdev/net/c/c28947de2bed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



