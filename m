Return-Path: <netdev+bounces-159126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACA3A14779
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 02:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23BF33A9D65
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 01:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12A270838;
	Fri, 17 Jan 2025 01:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/5kBdjH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD52E56446
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 01:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737076810; cv=none; b=S8B8bM6pebcYLXI3LgVT0Yac34gYxvyCoxpKtu/mWtPL7ViB96/fW2V6eYPtGeJFbWH3wzMDPx8VCQrV8fZ1gFdPDt2wLbzVamTQUTTSvj0/fHcyATg5PqjcUYuoatYJDf0zW/JObzfieOk51tU7zL4cAh8zEzG7zGS+A+80CWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737076810; c=relaxed/simple;
	bh=ziG1BFTlO62ehFbdToSre49AKypP2IJl0nDn+kKnxTE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T7SrsAV9vQVeejnLDg0EnStLFQjUFAicLYY3qY5ukMzQF0GxvBqkC3/uH3YUgnYp/DKVPmaDahG6a3weeanvziPMuC3p0FgAzEnpw0NM6BgW1rovABoOk0iEqsTm7kF/Clg5snaQyvfKx1zhH7PvwkXQooJ21FG5ji7u9H7vnDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/5kBdjH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FACC4CED6;
	Fri, 17 Jan 2025 01:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737076810;
	bh=ziG1BFTlO62ehFbdToSre49AKypP2IJl0nDn+kKnxTE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n/5kBdjHRlWotU1ZFHsLnHXseBpxdAZepHmf0fBdWa+K55wtWP6UeQr1z+Gv9ndac
	 4MzPz7JaTPhaPgzBJR/KrEC3asbblVKa8fiir1fu1TmPrntPTabggTnyn8Ts0PELlM
	 lKjJUWd1rJ9wA66YPSV9p7KQVNS9TRavaFG594FQ/bCmK02eHNZ4PTcx0IYMgty9fo
	 B1Pu21js+zQuW4C4tBmvJeUQwww968hoB5nx4UJMO4u/KxzOCly5l77LZdGyAJMtJ8
	 dOta6RQL3vk+8YLHImjUzct81ME2iUPCUtcOWPn42LbFIxk5VAeRW8cjf/KMwUdUZn
	 /eFQ3jhDt/a7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADB95380AA63;
	Fri, 17 Jan 2025 01:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv4: Prepare inet_rtm_getroute() to .flowi4_tos
 conversion.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173707683350.1645866.10973614821635265508.git-patchwork-notify@kernel.org>
Date: Fri, 17 Jan 2025 01:20:33 +0000
References: <7bc1c7dc47ad1393569095d334521fae59af5bc7.1736944951.git.gnault@redhat.com>
In-Reply-To: <7bc1c7dc47ad1393569095d334521fae59af5bc7.1736944951.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, horms@kernel.org,
 dsahern@kernel.org, idosch@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Jan 2025 13:44:52 +0100 you wrote:
> Store rtm->rtm_tos in a dscp_t variable, which can then be used for
> setting fl4.flowi4_tos and also be passed as parameter of
> ip_route_input_rcu().
> 
> The .flowi4_tos field is going to be converted to dscp_t to ensure ECN
> bits aren't erroneously taken into account during route lookups. Having
> a dscp_t variable available will simplify that conversion, as we'll
> just have to drop the inet_dscp_to_dsfield() call.
> 
> [...]

Here is the summary with links:
  - [net-next] ipv4: Prepare inet_rtm_getroute() to .flowi4_tos conversion.
    https://git.kernel.org/netdev/net-next/c/65a55aa7e64e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



