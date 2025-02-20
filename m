Return-Path: <netdev+bounces-167984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDFAA3CFF0
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 04:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F071897C7E
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 03:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDE41E5705;
	Thu, 20 Feb 2025 03:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEccLVxW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1539B1E493C;
	Thu, 20 Feb 2025 03:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740021019; cv=none; b=REU6ELcuk2mXpveGkLBQvBJ599XVc+a64m6tRoHfPnuQSpvBYO5lt1eScowcKSzDTNJ9KdWx/I1EqeHy/scMcs/nm5jw5mc6C8VhSgksOo0jEkFo/QeTcYJ2Ky59B8BWDWcIWBt8O8mHT/KGo3dL/dy9pzSv0N7sVKeAfHx1fuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740021019; c=relaxed/simple;
	bh=k6TOWsLLl3Jm04226gAjtNpWBfXjFTNjvPQKRhSefc4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G7yB0Cw7aFCvRjlFP988WRxkjBTEsw8cKFXPoNiiP6cfLot/8lOQGbxzg5FbpGQhASzECxcXoasdi9RROzhS49O3Ws9CtngUL4cC45/k8YG1tfofa71l6PMh84NW2W2JfQUEUp18WGbtpFppVvm3xqWyuXBFb/XfAfWEIcYbNBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEccLVxW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEA8C4CED1;
	Thu, 20 Feb 2025 03:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740021017;
	bh=k6TOWsLLl3Jm04226gAjtNpWBfXjFTNjvPQKRhSefc4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FEccLVxW/MQ7AZhXvOsnPlAc5C3/2GKF3is4IQ6HbPNABgLa1Rz20zG/wxqjsQKvO
	 982r5VWWgVK5t1kSjwg332knWi/l60B4dL/akaIrwJQx/DmWDrg+W0OXDImyMJuudc
	 d3toQ86Rg/k5FM9Dka+fEbBryVaP16Sc9itA/XdAVgyqpBG425edE4z+P7f6/UAbJr
	 /vfQOvLyStQOsgNjtYiPdN+8O8nLRuxrQs/t1MAIvrjHJrw0AodBN/vzOKR7oENCYh
	 76vJ9iLma/fka7UH5W33AfZr8B0LpNShn7in+b/FloXorrInN29esEb8B2NEyOGQai
	 HgGuLcXeDKMeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD49380AAEC;
	Thu, 20 Feb 2025 03:10:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH REPOST] selftests: net: Fix minor typos in MPTCP and psock
 tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174002104750.825980.7798452585282795501.git-patchwork-notify@kernel.org>
Date: Thu, 20 Feb 2025 03:10:47 +0000
References: <20250218165923.20740-1-suchitkarunakaran@gmail.com>
In-Reply-To: <20250218165923.20740-1-suchitkarunakaran@gmail.com>
To: Suchit K <suchitkarunakaran@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, horms@kernel.org,
 matttbe@kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Feb 2025 22:29:23 +0530 you wrote:
> From: Suchit <suchitkarunakaran@gmail.com>
> 
> Fixes minor spelling errors:
> - `simult_flows.sh`: "al testcases" -> "all testcases"
> - `psock_tpacket.c`: "accross" -> "across"
> 
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> 
> [...]

Here is the summary with links:
  - [REPOST] selftests: net: Fix minor typos in MPTCP and psock tests
    https://git.kernel.org/netdev/net-next/c/23dcacff2d11

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



