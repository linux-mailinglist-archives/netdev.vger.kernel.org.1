Return-Path: <netdev+bounces-233365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CD626C12866
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 02:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 134E85038E5
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C642C227563;
	Tue, 28 Oct 2025 01:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvuTPhBa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECE5226D1E
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 01:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761614454; cv=none; b=LAqLQLxpz6uQwfY4Uc84QcdxJfQBMOw5hDnBLdMf0Co+SD56ebHHYoI9L3eDBVdrNYKBwa73epnWh5RnIdIqvt4bm6tyYVTWytexPkkR50VIf2aNOodIhJ9DwOo2lVuwd5Eu9ZHgmmpOOo4QQ8kD3HIfLmjHfz7e18RPWBx9LdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761614454; c=relaxed/simple;
	bh=iG62UREZT8DJmnlOSvLqmVDWri0tK8c/me48r3tGJ1o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i4kWJvjS5hZE/Arn1oFkJ6NXznxKDTJBhc/LAyI38Ghhh+YrlTPsMNzegVZgU9Mk+4LqmBZz+VW/85aHBtDcdIPcPj2FansYeqEKuPU+ntxcD/hn2TbN17J9GX/00ohQMS6hfSQ3XubQAYY1BzkK4dcVwxbeHYAkaEOeWuc/qwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvuTPhBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202DDC4CEF1;
	Tue, 28 Oct 2025 01:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761614454;
	bh=iG62UREZT8DJmnlOSvLqmVDWri0tK8c/me48r3tGJ1o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PvuTPhBaBus4B2vpKH5wFU74HEUgAhtzt1lAYLPkmtkd3KbmHUTrvTEyp9JmPt06S
	 UhI7ajANXXCIXeqPee6MBJRvGGQHzBMZS6u0atLYgCsbLqwdlG9DaDzl4AhRqJqIAr
	 5G3MuX32e5otR45Iz73K8PHlFyTYSfE0LVfAKlrRr+IYrHIulo/mKcdFkh8p8MyIUK
	 scFaVPe2THDr7oKArLB37u9bfsPyhnVGGRj0E0DSMU4+yrxkH1SsO2Syb+Uj7V+6+F
	 on1eIZXET2oI3sBoxR5qLPMgfUhY2zZk1WH7Q0j7H5S0yG4pDgzw79sUlM11gCo5V/
	 oT+f1NHHl6aVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E6A39D60B9;
	Tue, 28 Oct 2025 01:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] batman-adv: Start new development cycle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176161443200.1651448.12590891600883134266.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 01:20:32 +0000
References: <20251024092315.232636-2-sw@simonwunderlich.de>
In-Reply-To: <20251024092315.232636-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org

Hello:

This series was applied to netdev/net-next.git (main)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Fri, 24 Oct 2025 11:23:14 +0200 you wrote:
> This version will contain all the (major or even only minor) changes for
> Linux 6.19.
> 
> The version number isn't a semantic version number with major and minor
> information. It is just encoding the year of the expected publishing as
> Linux -rc1 and the number of published versions this year (starting at 0).
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] batman-adv: Start new development cycle
    https://git.kernel.org/netdev/net-next/c/e5ae07b2ef86
  - [net-next,2/2] batman-adv: use skb_crc32c() instead of skb_seq_read()
    https://git.kernel.org/netdev/net-next/c/ed5730f3f733

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



