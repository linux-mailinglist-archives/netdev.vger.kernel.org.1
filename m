Return-Path: <netdev+bounces-115397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7124C9462BC
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 19:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E070B229E9
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 17:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E81D1537A7;
	Fri,  2 Aug 2024 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZVwdDyh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052801AE05E;
	Fri,  2 Aug 2024 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722621033; cv=none; b=GC+09Ru5cbvSaEs25ZtKGnsAjiLbbX970vWHTuayKzP1qz38fg528aE768clIIJF/vyiq/kLP6e9JrH++wwxvQKvmReL/9zwA1Q58rz/lgdZhhygPeLRbjf//SW+Ua/ii1UMk+6zA5du49ZfmX1F1WThJsXtscHKq666um1DhJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722621033; c=relaxed/simple;
	bh=DYfqICvUxtUBacVEPjO3itpH455jDIPz6MuXct51aF8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gQu0C5ReDqzELx10nwKEdyMo6cLuKzNxHjTRmiHlr/1iM9jdzj4HqY/nVhE4+PG3pk/ZbdcoRkZ4WvPzSGEitKPDrK9vmB9BwT5g+hxU8fXSZJpBWVdVIHBv9NpatKEn1flbAlhhqjNLuYph+/vcBYd+FTUs6w8h+GxbsUk9iDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZVwdDyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 780C7C4AF0A;
	Fri,  2 Aug 2024 17:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722621032;
	bh=DYfqICvUxtUBacVEPjO3itpH455jDIPz6MuXct51aF8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cZVwdDyhpzASsXXWbnv+4fMaKxgo/L1hG2Sl7Ndu4w02zKNGv40+xn3u6JrPdVc4z
	 OnMIja5JV+PZ2iGlFEcJqIU3TMGEwAMu/2qm/l5gOQs7J0s/ih8DSguUlPLkQ95zu2
	 5CVzYJ1Z9Pz44v7T5NT5MO+qctYWPUNAfsAA8ia1Tzpquo/XbMCB6Pqr7pQHL8uyje
	 HVuDmLSZ6Y8M5BLH14LnXpA3QQKjD5TBSVpB51XIZ5px/RS+tORjY3alkj1GF/hBX/
	 9QXODziBLs0KawlWND+syXH3jKtfLnte1CkR7bEjfIT+ipMzNgwLcbmLLV/ozoNN6Z
	 76VgmJa0Y2bNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66057D0C60A;
	Fri,  2 Aug 2024 17:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-net 0/7] mptcp: improve man pages to avoid
 confusions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172262103241.30562.13396080153288941317.git-patchwork-notify@kernel.org>
Date: Fri, 02 Aug 2024 17:50:32 +0000
References: <20240727-upstream-iproute2-net-20240726-mptcp-man-user-feedback-v1-0-c6398c2014ea@kernel.org>
In-Reply-To: <20240727-upstream-iproute2-net-20240726-mptcp-man-user-feedback-v1-0-c6398c2014ea@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: stephen@networkplumber.org, dsahern@gmail.com, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sat, 27 Jul 2024 12:10:29 +0200 you wrote:
> According to some bug reports we had in the past, setting the MPTCP
> endpoints might be confusing, and the wrong flags might be set.
> 
> This series adds missing info for the 'dev' parameter in the manual, but
> also clarify a few other parameters.
> 
> While at it, a better error message is reported when 'id 0' is used to
> 'add' or 'change' an endpoint.
> 
> [...]

Here is the summary with links:
  - [iproute2-net,1/7] man: mptcp: document 'dev IFNAME'
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=484009f46e9c
  - [iproute2-net,2/7] man: mptcp: clarify 'signal' and 'subflow' flags
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=80392875faa8
  - [iproute2-net,3/7] man: mptcp: 'port' has to be used with 'signal'
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=8251786f3d81
  - [iproute2-net,4/7] man: mptcp: 'backup' flag also affects outgoing data
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=e3c1e2a4e20d
  - [iproute2-net,5/7] man: mptcp: 'fullmesh' has to be used with 'subflow'
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=640ebc23d8ab
  - [iproute2-net,6/7] man: mptcp: clarify the 'ID' parameter
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=8145a842736d
  - [iproute2-net,7/7] ip: mptcp: 'id 0' is only for 'del'
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=b176b9f40368

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



