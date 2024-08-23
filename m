Return-Path: <netdev+bounces-121288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A547995C941
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 11:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8C921C21FDC
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 09:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA555FBBA;
	Fri, 23 Aug 2024 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2HL6VIe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AED720DF4
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724405431; cv=none; b=ozowIaKDgkqv5acxjeN1LOlkvg9DUhKpPQd3wA09XZSqP2XAYaR03BGB9K6hhcu4a4ZqX7k0AY8mE0Xfckn4XNzHo192XIyOJEhuIpdPn3/PHTmXLwquf+QgKMmxHexyv2KwJ0g+4TZU8we5NxMQboqwvNjTw+LQ5o3f5Timapo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724405431; c=relaxed/simple;
	bh=rxyzs/vtv3OZHKaaAvek/5e3Ir/w01Z5D1bngYydbaU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jp5DMJHyMu4C350GzjDiyvlH+NawCCSwQzSAfyUWNPYatNr4Nrwc0NgdVK3sPV+w2nU2Gd0RK3NkcELzs/EEB6B57KHwHGdFfKyS9reifIcBHbGJWvxfgvPRfviSA8nlFr6UGw3SlqhI6bCrDrK03lRjYeqA8vhTLkKgc9o2eyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2HL6VIe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C12C32786;
	Fri, 23 Aug 2024 09:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724405430;
	bh=rxyzs/vtv3OZHKaaAvek/5e3Ir/w01Z5D1bngYydbaU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F2HL6VIe4Bv9DVZdHxCMCnhbB8FmQB7ccRLM5bBI2QSm6No7UfZSfnPVES9QPnyEq
	 ZsCUswnaeXq1K+F9K8joFaLBFf9jkldgc/GiFBUvAJOk61B+dYVx2CGirqs6ok79Ys
	 plnEWqxsLc+hs731jUy3I3M4Okl+0YitLcliLH2oUAJyOOoe0CiqS36M9Od8zMbFDd
	 urdPRdtX4F+HpF4EHXo4apKcAJAq3Vy0tMEylHX3/Kpl/lh1OXc+zX472DrLJ1+f2e
	 G7yPkycOzSQLbxNo3vXNCsCqP+U2ZTIYMYq1tlLwxC1J1xO1E0XSvwk7uIk2mlP1Zt
	 T6yvjUQHtpKag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FB13804CB0;
	Fri, 23 Aug 2024 09:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: drop special comment style
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172440543028.2907821.10499662396275244504.git-patchwork-notify@kernel.org>
Date: Fri, 23 Aug 2024 09:30:30 +0000
References: <20240819110950.9602c7ae8daa.Ic187fbc5ba452463ef28feebbd5c18668adb0fec@changeid>
In-Reply-To: <20240819110950.9602c7ae8daa.Ic187fbc5ba452463ef28feebbd5c18668adb0fec@changeid>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, johannes.berg@intel.com,
 stephen@networkplumber.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 19 Aug 2024 11:09:43 +0200 you wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> As we discussed in the room at netdevconf earlier this week,
> drop the requirement for special comment style for netdev.
> 
> For checkpatch, the general check accepts both right now, so
> simply drop the special request there as well.
> 
> [...]

Here is the summary with links:
  - [v2] net: drop special comment style
    https://git.kernel.org/netdev/net/c/82b8000c28b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



