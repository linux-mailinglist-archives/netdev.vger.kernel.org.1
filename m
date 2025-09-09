Return-Path: <netdev+bounces-221035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 066C1B49EB5
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 03:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C36B4E45AC
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 01:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BDC78F34;
	Tue,  9 Sep 2025 01:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neS+itgd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6572139D
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 01:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757381432; cv=none; b=b8nVWfDeGmcxlnJNBCK4DZgFd0WQS9u1ZaWLgHC4v1r3WqlXeBzVm+BmdV2Uph8FvHosIvNBRYmcOP1JauU2k0TDU53pANd3m4OARonOK1lAW9u6zDlBR7WE5kFDdnjnNZ1mDEdgjbKM6unfJk5fPKYnE9qoS18Jn3nUzIbJgV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757381432; c=relaxed/simple;
	bh=ftGrREOfmSadpYCf/T9DzPWWcTgvvS2Sp7394gP2vaA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ngzQwZX8XE/nGvlxjgln+EwzCvE1Q5QpjEpHEx/cgw4DrFH+NKTZlLOkgjq5FdyyPaQ9On1Ky8BwQS79zftIOZ0/ZHU4AyRAjmEMRG0CgtnUw4Hv8Y3ktyB7B5mhZ7Nn4YY70Qd5QXGNZhJ/KpYvkInZlHLvut8zYMdj3WPDbm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neS+itgd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441E3C4CEF8;
	Tue,  9 Sep 2025 01:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757381432;
	bh=ftGrREOfmSadpYCf/T9DzPWWcTgvvS2Sp7394gP2vaA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=neS+itgdi4bEZbJBO8P7d9ykt7VSbF2rFC9UydjevPFqxzDT62Op8bM97RvhM8Teb
	 LrUuOFnAt8KEFthdmRuT7jSMY+UFh8/amcuZeNYvvNUDhPbD6QMGXE2OEcaRCALn3y
	 XZsALvaqET9wjhBweB2aNqD/LgA1S6erlSrOlxtg/EPkvc7367EJhHF2sYsCCnO8P6
	 bPhbzl4CkcKaPBVtGVoEiHmHwfj7e2MRIqnmD+729i8KQ3/53vhh5zxJiVxwEnUQ4o
	 pMmx7VmdwC7HL6F41k7gxUTlqlDYplRAHT8B53j9an19GSkwh5UC0wkbyWlJGjxMbd
	 rZQ5xyy+62/iQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD37383BF69;
	Tue,  9 Sep 2025 01:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/9] ipv6: snmp: avoid performance issue with
 RATELIMITHOST
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175738143575.108077.2162956329371519452.git-patchwork-notify@kernel.org>
Date: Tue, 09 Sep 2025 01:30:35 +0000
References: <20250905165813.1470708-1-edumazet@google.com>
In-Reply-To: <20250905165813.1470708-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, jamie.bainbridge@gmail.com, rawal.abhishek92@gmail.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  5 Sep 2025 16:58:04 +0000 you wrote:
> Addition of ICMP6_MIB_RATELIMITHOST in commit d0941130c9351
> ("icmp: Add counters for rate limits") introduced a performance
> drop in case of DOS (like receiving UDP packets
> to closed ports).
> 
> Per netns ICMP6_MIB_RATELIMITHOST tracking uses per-cpu
> storage and is enough, we do not need per-device and slow tracking
> for this metric.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/9] ipv6: snmp: remove icmp6type2name[]
    https://git.kernel.org/netdev/net-next/c/b7fe8c1be776
  - [v2,net-next,2/9] ipv6: snmp: do not use SNMP_MIB_SENTINEL anymore
    https://git.kernel.org/netdev/net-next/c/ceac1fb2290d
  - [v2,net-next,3/9] ipv6: snmp: do not track per idev ICMP6_MIB_RATELIMITHOST
    https://git.kernel.org/netdev/net-next/c/2fab94bcf313
  - [v2,net-next,4/9] ipv4: snmp: do not use SNMP_MIB_SENTINEL anymore
    https://git.kernel.org/netdev/net-next/c/b7b74953f834
  - [v2,net-next,5/9] mptcp: snmp: do not use SNMP_MIB_SENTINEL anymore
    https://git.kernel.org/netdev/net-next/c/35cb2da0abaf
  - [v2,net-next,6/9] sctp: snmp: do not use SNMP_MIB_SENTINEL anymore
    https://git.kernel.org/netdev/net-next/c/52a33cae6a6f
  - [v2,net-next,7/9] tls: snmp: do not use SNMP_MIB_SENTINEL anymore
    https://git.kernel.org/netdev/net-next/c/3a951f95202c
  - [v2,net-next,8/9] xfrm: snmp: do not use SNMP_MIB_SENTINEL anymore
    https://git.kernel.org/netdev/net-next/c/c73d583e7008
  - [v2,net-next,9/9] net: snmp: remove SNMP_MIB_SENTINEL
    https://git.kernel.org/netdev/net-next/c/20d3d2681544

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



