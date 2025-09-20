Return-Path: <netdev+bounces-224940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA67EB8BAEF
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 02:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D9B37BBB98
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 00:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57635140E5F;
	Sat, 20 Sep 2025 00:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0+QczVJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335EE137C52
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758327607; cv=none; b=SeIgl0T+wULXziZ40pu68ejaUwzVJfKdiGbVNMbSFd8GJCZSEoydCFK13QpPjgXnqtro+tBecR/Yp8o+rfV36i1wK1z1dNhgJ2dBtZHd38UC6ESdvgPG+SJAp7sk83/RoD7AC6CormDpl8yw5oQgHjRugsO8IFhdRAjkzjvWnLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758327607; c=relaxed/simple;
	bh=BRG2Z91Haz+s09/vYqoaui2QIwvhRQOIoFTz+AheApU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V9ieiShvBUjL8zh80Uzgao8B7E+NCjCHhKxZtRoE/PFMG+6GUt4HWPt5H2q312G/5y98/x1KIPcHTDUQN0IavMoB4Hl/aokCsb/EXb4q11w4k8lpCAbHOdTaNDRN07KFcihn3imHaK93TRnTzneajl3lSC3BonHhbtG6+3TNt8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0+QczVJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB83FC4CEF0;
	Sat, 20 Sep 2025 00:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758327606;
	bh=BRG2Z91Haz+s09/vYqoaui2QIwvhRQOIoFTz+AheApU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D0+QczVJUwXBKxDVWMmqoHalpRNTfCK3j3WyV8HQT0pAiTQJN3tM44ce8TMMCtQ6f
	 6ckL0YgY2kGhr9ukDkOoEkL7d13+DPVi5ADlL/log5KXWU4sV/Tje8YALiLIFp1r0V
	 WLZ69doO1ItHgzYjU7Ajn4WtP47PyvVchNKMFEuQDN70nC3RxhXxduETPhMDWyCksd
	 F355lx2W8DVrt/uNV+jQqVQZXVLbOA53JChKlDv7UXDwtATjnvNTNJeXmCGHacd7Uz
	 bVTDfhqOS8MzZl90xLm+x1VlM3WeRCQ4uKyTSVn3gM/ObZdpz0DvxE4bCOs3cHAPql
	 HgrOMPQ0h1yEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D5639D0C20;
	Sat, 20 Sep 2025 00:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ethernet: rvu-af: Remove slash from the driver
 name
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175832760601.3747217.6562192836256690746.git-patchwork-notify@kernel.org>
Date: Sat, 20 Sep 2025 00:20:06 +0000
References: <20250918152106.1798299-1-oss@malat.biz>
In-Reply-To: <20250918152106.1798299-1-oss@malat.biz>
To: Petr Malat <oss@malat.biz>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, sgoutham@marvell.com,
 lcherian@marvell.com, gakula@marvell.com, jerinj@marvell.com,
 sbhatta@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Sep 2025 17:21:07 +0200 you wrote:
> Having a slash in the driver name leads to EIO being returned while
> reading /sys/module/rvu_af/drivers content.
> 
> Remove DRV_STRING as it's not used anywhere.
> 
> Fixes: 91c6945ea1f9 ("octeontx2-af: cn10k: Add RPM MAC support")
> Signed-off-by: Petr Malat <oss@malat.biz>
> 
> [...]

Here is the summary with links:
  - [net,v2] ethernet: rvu-af: Remove slash from the driver name
    https://git.kernel.org/netdev/net/c/b65678cacc03

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



