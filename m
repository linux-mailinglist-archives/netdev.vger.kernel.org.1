Return-Path: <netdev+bounces-143568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDE79C302A
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 01:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC501F217ED
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 00:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE58BA923;
	Sun, 10 Nov 2024 00:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kataOhwD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7289101EE
	for <netdev@vger.kernel.org>; Sun, 10 Nov 2024 00:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731198620; cv=none; b=l4X+LEZgKCm4XHafrhMZLSmqHZYhQ0vVJf9MPPCqWM2CtQWpdcR/DJArdUowo184COJewcEC1dGwFnvzXPNCg3AUKtRkpxdHZKs0Zden69+OGenfsyf00ZHTHnJ+rA7eUnfYp6PQzIaQeNpQQVs4Env22mktuXUKb67hLvIfIHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731198620; c=relaxed/simple;
	bh=7JmhH6UIYC4+6p24kmOSJZy8bj0axf8IzILEdgQF7lU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k7ex0WeoOjGT+dpiqvLHFg4SrPpBoFMSdmHq30bfRMdQO45TsnyHvxJHmB7wpefH5K7BpdXgZEedMuomHVuGSkGUulSaONvfuFbe5Xy/DNHsz1zOAKFtv/VSB+SRCyYmcCPUzphfd93/+0Z4YcXA/90OfRP4pQ1juk6/ozG0tfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kataOhwD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C8DC4CECE;
	Sun, 10 Nov 2024 00:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731198618;
	bh=7JmhH6UIYC4+6p24kmOSJZy8bj0axf8IzILEdgQF7lU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kataOhwDzdDChtbcFe0ctcYIhT1fFGntq/UgBZFbOkGlPiY27nXZeBnVvTTnMXL+K
	 +ZkMu4PD5uLH9BtJaLFbg7yZHm70QWHJ8W0ernRxI+GiOhZI03xzp6nKBIbrtb+Q7b
	 DdbnEwHXS4+rNWZQyAYkWPU4AlQhvhaiHRv8yLzOzHFcnPgMft4D+52jeJGnDyumRf
	 hK/mmC+eP6ZCD6OLAr3WaOfQ30sNZXY1qOznTbkAG7Xtw8/Oy6T+2R+Nm/5T6m1NU5
	 CI3OWOc+Rshjxwv+WFEPmY2A7Ph2A/mRNspcEak4IJ7GXNea1RWTU+FRdNA+5m6N4i
	 WiOrC8ScOazRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF953809A80;
	Sun, 10 Nov 2024 00:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bridge: Allow deleting FDB entries with non-existent
 VLAN
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173119862775.3043730.8123158047350078052.git-patchwork-notify@kernel.org>
Date: Sun, 10 Nov 2024 00:30:27 +0000
References: <20241105133954.350479-1-idosch@nvidia.com>
In-Reply-To: <20241105133954.350479-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 razor@blackwall.org, roopa@nvidia.com, horms@kernel.org, petrm@nvidia.com,
 aroulin@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 5 Nov 2024 15:39:54 +0200 you wrote:
> It is currently impossible to delete individual FDB entries (as opposed
> to flushing) that were added with a VLAN that no longer exists:
> 
>  # ip link add name dummy1 up type dummy
>  # ip link add name br1 up type bridge vlan_filtering 1
>  # ip link set dev dummy1 master br1
>  # bridge fdb add 00:11:22:33:44:55 dev dummy1 master static vlan 1
>  # bridge vlan del vid 1 dev dummy1
>  # bridge fdb get 00:11:22:33:44:55 br br1 vlan 1
>  00:11:22:33:44:55 dev dummy1 vlan 1 master br1 static
>  # bridge fdb del 00:11:22:33:44:55 dev dummy1 master vlan 1
>  RTNETLINK answers: Invalid argument
>  # bridge fdb get 00:11:22:33:44:55 br br1 vlan 1
>  00:11:22:33:44:55 dev dummy1 vlan 1 master br1 static
> 
> [...]

Here is the summary with links:
  - [net-next] bridge: Allow deleting FDB entries with non-existent VLAN
    https://git.kernel.org/netdev/net-next/c/774ca6d3bf24

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



