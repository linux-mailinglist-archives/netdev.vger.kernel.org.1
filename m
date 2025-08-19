Return-Path: <netdev+bounces-214813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E55B0B2B5AA
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 03:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD61E18942E4
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 01:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BD3194A59;
	Tue, 19 Aug 2025 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMKIs5tX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9B786347;
	Tue, 19 Aug 2025 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755565208; cv=none; b=BysKAdwkpmDr2YlY3MKEacKu6M0ANlqKnwW4c+qhcpP/FLDRtRtyX/pBK22kE8PAuCdx46YOylf+3L86+1EkwUgjzq32UQs2xOnH+tD9jmydNLs60wM3pnHk5KNXfVeDwzXY8dPRsudz8bG71c5oh5SQOCGDgnC/QsOmLK1GObI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755565208; c=relaxed/simple;
	bh=mjhGf1fD6F3sBRQV/p2Yp/pFwSjUPwKTyveOfT350jA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iebM8ljeQaUcaSyIzzdq/J2WLCc0jfLF10I9frzzFwksnKiyEWpA5QhyBs9je/aRQQPX0i3TMgymiQOkcdZEBrS4zKv8eaE5KV1KwNzZLt8ET96I/J4RoFFHUox6RdreGiE/2/j/x9p07Go91kgTiwRzxfeS5I5bfAsTS5ENSpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMKIs5tX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A780DC4CEEB;
	Tue, 19 Aug 2025 01:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755565208;
	bh=mjhGf1fD6F3sBRQV/p2Yp/pFwSjUPwKTyveOfT350jA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gMKIs5tXFvbkoidlf0hWfKDbKSGgzgyK/rLQ489kUIRIpxfHoAsj5Izje4EBH7TmE
	 bUjV3g70YLgNj6eDE9eO4MHV3Bth1GqPRDcO9W7B9y7g/i5yKXjt8vFfLlvTGWXG8c
	 /1zYQeUpCEV2l5rzPr2UC+B/blb0FLTGII2aRL6xSbXJSI60UW51VBwrdRl5oC2XQL
	 HHA48m8y3aWRoSxiZfCWRT0oQJt8gQ9srEyn/462LRU5YIoFgT6i+wUJ6IPQElUwTi
	 Yap9IkJl4uObi5dgtB/Xikfhdtv41LRHbww0fJX9ipVO4iu8rFBNH/d6cdY0FDYmws
	 jfNV0SLYlSMSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEF2383BF4E;
	Tue, 19 Aug 2025 01:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next] amd-xgbe: Configure and retrieve 'tx-usecs'
 for
 Tx coalescing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175556521874.2966773.3654863619068581749.git-patchwork-notify@kernel.org>
Date: Tue, 19 Aug 2025 01:00:18 +0000
References: <20250816141941.126054-1-Vishal.Badole@amd.com>
In-Reply-To: <20250816141941.126054-1-Vishal.Badole@amd.com>
To: Vishal Badole <Vishal.Badole@amd.com>
Cc: Shyam-sundar.S-k@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 16 Aug 2025 19:49:41 +0530 you wrote:
> Ethtool has advanced with additional configurable options, but the
> current driver does not support tx-usecs configuration using Ethtool.
> 
> Add support to configure and retrieve 'tx-usecs' using ethtool, which
> specifies the wait time before servicing an interrupt for Tx coalescing.
> 
> Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
> Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> 
> [...]

Here is the summary with links:
  - [v3,net-next] amd-xgbe: Configure and retrieve 'tx-usecs' for Tx coalescing
    https://git.kernel.org/netdev/net-next/c/5883cb32fcea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



