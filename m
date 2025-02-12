Return-Path: <netdev+bounces-165333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF60A31AA2
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 01:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23FB18883B4
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 00:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292822D05E;
	Wed, 12 Feb 2025 00:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9faVQOF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052E92B9BC
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 00:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739320812; cv=none; b=FblrSWWmYh3rsee09y9WGw2TXIyNOrUbQqhJrBPid7t73l1kzNa4dY2yMPqZPOc4mFbJrS1pyeFCI277DWIXXVvVpckPpk9OHlEi/bpElrfiCbGmS95MNYXrYrq5l/OgiKmX+ywyRWR3R8kk3aIzXmFKjcezZLeVTTkzlGLbpd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739320812; c=relaxed/simple;
	bh=sFQdsqmjBtaONpq1J63ZKj4vncEBg0DemI5C7BzHWio=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EwJGzbsXzuexa8jDs7jeVa99WZiu3A5AaU0sRlVrCUmDQA3nkMDOzzpLX8ej7FR9ACjLZxHFR6CsQbBa+cmSOJb0vWdEG11EHt+BL9xxtmFciGIxKxnazmAaZKEmwGP5obYItkhINrmrvm2MTTTIptG81rIjjsB4YKKhUyb+m0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9faVQOF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5009C4CEE2;
	Wed, 12 Feb 2025 00:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739320811;
	bh=sFQdsqmjBtaONpq1J63ZKj4vncEBg0DemI5C7BzHWio=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L9faVQOFRqI147rOIATp4F88iCNKKoIoQomR/RK0kktOjQmMekAxif2HismJxIhD0
	 t5F01QkOM9/w2HD0pw1Fj3O3Dg6GKgdQeitRk5MKlBGXlemkBK6S2oL27qWUQy4SEL
	 pqVIHIO5D/yb1lLuo/AO/b8o0LIJblzABKkkqt7i9sz3hGVfUmT2LFM0itvVTCCETE
	 rvkxqV6SROmVoydwh64cGt4kLHlMd7T0OEz3sWGqU0qQV40yo2VPspgJugh2ejI8G6
	 X8iTYypgtYHQBg3o7whbQi9fRBT5MxOVLXxsok3yimKihrRaNDOI9Y9o3BhZDR4pdO
	 p7qjetUc+IqxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEDF380AA7A;
	Wed, 12 Feb 2025 00:40:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: freescale: ucc_geth: remove unused
 PHY_INIT_TIMEOUT and PHY_CHANGE_TIME
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173932084074.51333.14505766917767218539.git-patchwork-notify@kernel.org>
Date: Wed, 12 Feb 2025 00:40:40 +0000
References: <62e9429b-57e0-42ec-96a5-6a89553f441d@gmail.com>
In-Reply-To: <62e9429b-57e0-42ec-96a5-6a89553f441d@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew+netdev@lunn.ch, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 9 Feb 2025 13:27:44 +0100 you wrote:
> Both definitions are unused. Last users have been removed with:
> 
> 1577ecef7666 ("netdev: Merge UCC and gianfar MDIO bus drivers")
> 728de4c927a3 ("ucc_geth: migrate ucc_geth to phylib")
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: freescale: ucc_geth: remove unused PHY_INIT_TIMEOUT and PHY_CHANGE_TIME
    https://git.kernel.org/netdev/net-next/c/8729a9bd6efc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



