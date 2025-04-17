Return-Path: <netdev+bounces-183712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D59DBA919F2
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 12:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42CAD3B1A18
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 10:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C75222DF90;
	Thu, 17 Apr 2025 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEJyV2GX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31A21DE3C8
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 10:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744887596; cv=none; b=c/BmuXLpiW3XlwKws1ktQij3dd5/yx9QYV949/kSd61DwayfNUvWHzRfZh1RmyDmes3B3Rmg00Kxef1q58f8YfFxKuo7h1YkpmN99YImMeRAuJWN0WlQYV3SS+77iJ7ZECs3s1+MImWA5guJeOlGbjnU7NWK0RafVW09YW0N5Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744887596; c=relaxed/simple;
	bh=xtCMnYCNziSI3ut6RSeAU4XCbFNfbAUSvyCkAmnV4Hg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n4yS3FZmFFxp7Emsbx8HB9A8Q8AIlYqZd6ofG3PooK2iGyH2VGF9PYTNrffvWcFsrknGCB+jq8R+ne4rpuw9pNB30lglUgul1fHbd9FsG+sGY2kqXAL1ObfhWJ+bYkfNkJHHXmRWRnQNOSl6n84aLwbtuVUv9EyJ4h5wTe/tIhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEJyV2GX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBBAC4CEE4;
	Thu, 17 Apr 2025 10:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744887595;
	bh=xtCMnYCNziSI3ut6RSeAU4XCbFNfbAUSvyCkAmnV4Hg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CEJyV2GXpGQksulabp16yPCbNI6iM6Ojfg4mgbmhuVvuIRw099XeT/HPkSZusqfI/
	 7Jjozp367P9HaI/t7F2BaNUd+PbLTOQI5+h4jtNJ3tlJhrVcTHg1ARYnmhkz1bkPI6
	 6bFuzM/NHH5qQlhNV4bfLd6qTl6EQU5S4jsN1gUXisBWxvj10uGFjgQMoQthJIPhdk
	 f95sprFgK/I1nj9mJikc4yAcyttZL/5wn4kqUtIpCXdNrIgs4ZT1wBVVy40Hb4E54N
	 rrPDVCw5KYP4ox36WXV/bqC5Yfww0wrCfjcAZWvE1BvvorcWUpv/xlLp0iveX1i8X2
	 1Jl4770JBaBzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE5FE380664C;
	Thu, 17 Apr 2025 11:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] Mitigate double allocations in ioam6_iptunnel
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174488763352.4032648.11322956489996101788.git-patchwork-notify@kernel.org>
Date: Thu, 17 Apr 2025 11:00:33 +0000
References: <20250415112554.23823-1-justin.iurman@uliege.be>
In-Reply-To: <20250415112554.23823-1-justin.iurman@uliege.be>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 15 Apr 2025 13:25:52 +0200 you wrote:
> v2:
> - rephrase misleading comment
> - move BH disable/enable around if condition
> v1:
> - https://lore.kernel.org/netdev/20250410152432.30246-1-justin.iurman@uliege.be/T/#t
> 
> Commit dce525185bc9 ("net: ipv6: ioam6_iptunnel: mitigate 2-realloc
> issue") fixed the double allocation issue in ioam6_iptunnel. However,
> since commit 92191dd10730 ("net: ipv6: fix dst ref loops in rpl, seg6
> and ioam6 lwtunnels"), the fix was left incomplete. Because the cache is
> now empty when the dst_entry is the same post transformation in order to
> avoid a reference loop, the double reallocation is back for such cases
> (e.g., inline mode) which are valid for IOAM. This patch provides a way
> to detect such cases without having a reference loop in the cache, and
> so to avoid the double reallocation issue for all cases again.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: ipv6: ioam6: use consistent dst names
    https://git.kernel.org/netdev/net-next/c/d55acb9732d9
  - [net-next,v2,2/2] net: ipv6: ioam6: fix double reallocation
    https://git.kernel.org/netdev/net-next/c/47ce7c854563

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



