Return-Path: <netdev+bounces-187356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AE3AA682D
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 03:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9111BA594E
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 01:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880BE14F9F7;
	Fri,  2 May 2025 01:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6lGl8h0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6230814EC62
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 01:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746148198; cv=none; b=ZxXvoeXLNQefid9RlgXSQF7IrGL9JwMNLbhsznO68jJh0JCM/E15UDbrQeQOeE/Pell5Prb7sOse8cwEeVUXk7VoMPiSzJXjfXH3j5JGrUdbU3wCFbE0mU8Eb/nRU+dEW5/n9SVTKTqm9ylwVY4W5PDSaBTy3YP44zWfWiMcKwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746148198; c=relaxed/simple;
	bh=31dnyDSajXCqiPqeQwmsFAOvrV1MNgX8fav9rEkb2+k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KxEyh+GDAXuUQYXUPTvCL2yrV7VPj3bjG43cqItOrq1muuTV3mlzazA7sYMQfr12OCi4Ao8bS1G2dJ0FUNKY7wa7SW+uDdyVekPwVBv9jn3irFyyglYDrnWmDn9hAwdvfE5mEkDUvz/4jV8h57B6UHoAnOQbx5JVvvce2B7dDLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6lGl8h0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5998C4CEE3;
	Fri,  2 May 2025 01:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746148197;
	bh=31dnyDSajXCqiPqeQwmsFAOvrV1MNgX8fav9rEkb2+k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n6lGl8h0/BiMr826nMfUgshomiBpgNA+AtbuZmv+jpmLWRKYoWg6N83aHhdRfZ0u/
	 9nDqa01YR4dp+0v4yPsbWAVfYi4P0w/bmSI75PD74bWW113gks/LHTvtRQIQJ3mU81
	 lVLttdiDfXwMdu8sZ6qNr33mrrZ3dn31y/+ZVlhaG+kNvCKzaorIRdmrk9GH1c2c/Q
	 b0Mle6/HizkJIagzYhfX7ZU1Pr/7dWgjjwpEU7htf9Du5UABgM6c9mECTHn2RHlPBm
	 vxZH18pUOtxupA26rRoaJ7UFRfL2M6zs0BrADfNfRZs5Dak7mKU7zIdg159KCZdMtR
	 FYzYMjifsZ18w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC9B3822D59;
	Fri,  2 May 2025 01:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: phy: factor out provider part from
 mdio_bus.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174614823644.3123530.7230937264629116523.git-patchwork-notify@kernel.org>
Date: Fri, 02 May 2025 01:10:36 +0000
References: <c74772a9-dab6-44bf-a657-389df89d85c2@gmail.com>
In-Reply-To: <c74772a9-dab6-44bf-a657-389df89d85c2@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Apr 2025 08:04:46 +0200 you wrote:
> After 52358dd63e34 ("net: phy: remove function stubs") there's a
> problem if CONFIG_MDIO_BUS is set, but CONFIG_PHYLIB is not.
> mdiobus_scan() uses phylib functions like get_phy_device().
> Bringing back the stub wouldn't make much sense, because it would
> allow to compile mdiobus_scan(), but the function would be unusable.
> The stub returned NULL, and we have the following in mdiobus_scan():
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: phy: factor out provider part from mdio_bus.c
    https://git.kernel.org/netdev/net-next/c/a3e1c0ad8357

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



