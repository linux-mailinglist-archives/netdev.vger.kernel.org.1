Return-Path: <netdev+bounces-146108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933939D1F18
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 05:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5C95B22393
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 04:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF2C19CD1E;
	Tue, 19 Nov 2024 04:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omQlR0sV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860F314D6F6;
	Tue, 19 Nov 2024 04:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731988842; cv=none; b=bIWi06KDiiP8lhexId/3Y6ht890q9GKyd3u3+o5C5u7dTvl+Vsdx6snhh4E2071sucqWBGxbTTFPXSMA2Yp2vHSyDbsJo6CTxFJDHYM1WCvganmAhEQWKOCCpxRKvYkcOzGZuoof4LBT/JGN6ESPfHW6mYiJMuJXtYt6u6Z9KSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731988842; c=relaxed/simple;
	bh=JyXXnU0XGsJuEfa4DybvWyy1AwBQK+RZioyGqrEgC7M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PiHT8E3KLWlN/SqepnOO0qfnGxupnUQjUE4sLj/G1ENx5DipsFj1630s7Dq46prosE7h9mzu22RiRrgXq14Mp815WxCnmx2wmmAJcTNndP5F0cQjR9vT1WcreFplaBHcI88Sl+OQ/Z1gEDbvdzlCAfzxJ3vCVxGBoqV+pWAkm7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omQlR0sV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C248C4FDFA;
	Tue, 19 Nov 2024 04:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731988842;
	bh=JyXXnU0XGsJuEfa4DybvWyy1AwBQK+RZioyGqrEgC7M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=omQlR0sVDetqj9FvY12WwwLWAccBKQeMQ+42MOSh9OMOLHR2M6hqSr8Ogpg25XDI6
	 XZAsX6dFQeHg8XClhMSltHhvFEUSmF3Zqmv46TRm1J7kIYxk/F7sP+71lvzeuUU4pI
	 EQEvCrZWplouBFDj+t0aW21hfP5Hv8Ale5GQRDSRVdC8sEyiAbuNlIZzKt64lr3v4U
	 Rva9xefYGa7DzMAku6NG1zRNaulkbKikdH//za6KMQElC5RrD/TbwxXYFIjBn0p/Xf
	 hqdSkLbNJsfTOBt539rpaOSK+QemV1JEKArJHIwPcnRnpWtF57QtXGsOL7kZQm995l
	 rs7utTpwSAOVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE6D3809A80;
	Tue, 19 Nov 2024 04:00:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/fungible: Remove unused fun_create_queue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173198885329.97799.15365876554601024267.git-patchwork-notify@kernel.org>
Date: Tue, 19 Nov 2024 04:00:53 +0000
References: <20241116152644.96423-1-linux@treblig.org>
In-Reply-To: <20241116152644.96423-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: dmichail@fungible.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 16 Nov 2024 15:26:44 +0000 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> fun_create_queue was added in 2022 by
> commit e1ffcc66818f ("net/fungible: Add service module for Fungible
> drivers")
> but hasn't been used.
> 
> [...]

Here is the summary with links:
  - [net-next] net/fungible: Remove unused fun_create_queue
    https://git.kernel.org/netdev/net-next/c/78a36139fcec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



