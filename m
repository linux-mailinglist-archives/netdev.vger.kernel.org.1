Return-Path: <netdev+bounces-227248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 285E7BAADDF
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 03:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE27E188CF31
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 01:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CD72153ED;
	Tue, 30 Sep 2025 01:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMvTJHUi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311B4214A8B
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 01:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759195262; cv=none; b=NsOa1exIYiStu27pzjsy6zNiwOA0F7Sa3Lu7jsgt0hTo9Vp0KXeYkv876ESM9YUjyuHY0z0sFCgvhFPAhYBF+kBSJKCrSxIapiR88Yfy09eoc7+GAYDyO3mdH6XOQrhpowHA4h2wigF0A16CGr/XBbxRP0HrRtkc9FXyxicA2qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759195262; c=relaxed/simple;
	bh=fLUsM9GPDt1kKZtHy7PgFzrkLXKp0dB6S3Jcb2lSGow=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HP/Kpyx89urF/z3NJX2n1bud8heXNbOVKlBA5QiqTdRlmlQZPnqrFkfbMpFbZTM6U2XiZhEUtfJ0p2iHOfx1ZYhizpflvwT0yO9DaiBXpJwxbHM/70DbiVFYoHrVs5z/GlGDQ21zVOyNG74oJyuKfFIvTwELC9gTCFDfBItrR+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMvTJHUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C152C4CEF4;
	Tue, 30 Sep 2025 01:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759195262;
	bh=fLUsM9GPDt1kKZtHy7PgFzrkLXKp0dB6S3Jcb2lSGow=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TMvTJHUixeiCHwYeOsEkLHCXSygxsveFE3fzRd/Npmsn2Ti9qfBTIjp+IQbctQAkI
	 BB8yAxyr0ZDJn0a15+z+NaCYktINYuLXoFgxUSrzhwnMrQQBOg2+H7YqbWvEtkrjB1
	 B14U7oe8Laf/Rze8Zcn6W0PupP1uG/YpJh9x8wi//JC6SVEiPkhQdszlYak1jroGSh
	 /Q8ItUMW8MNXsTi2oWg/PbcT2DdUKQfjNhIupDy6uCqc0TOuXaYUcJiQySsC6FkGGt
	 Mcmpkf7yycqz0nLJOGJUKItZOCTRTVtKp6GOr9lvw9zCuFXVvwWoAgzSdKcS8iU/O6
	 cHiKEHvv9g9Gw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC1B39D0C1A;
	Tue, 30 Sep 2025 01:20:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ixgbe: fix typos and docstring inconsistencies
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175919525524.1775912.18040158539252294729.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 01:20:55 +0000
References: <20250929124427.79219-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250929124427.79219-1-alok.a.tiwari@oracle.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
 intel-wired-lan@lists.osuosl.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Sep 2025 05:44:01 -0700 you wrote:
> Corrected function and variable name typos in comments and docstrings:
>  ixgbe_write_ee_hostif_X550 -> ixgbe_write_ee_hostif_data_X550
>  ixgbe_get_lcd_x550em -> ixgbe_get_lcd_t_x550em
>  "Determime" -> "Determine"
>  "point to hardware structure" -> "pointer to hardware structure"
>  "To turn on the LED" -> "To turn off the LED"
> 
> [...]

Here is the summary with links:
  - [net-next] ixgbe: fix typos and docstring inconsistencies
    https://git.kernel.org/netdev/net-next/c/96ccc93744f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



