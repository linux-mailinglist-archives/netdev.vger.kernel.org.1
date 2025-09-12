Return-Path: <netdev+bounces-222377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C06B54014
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 04:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCD4D5A6FEA
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 02:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E961D1B9831;
	Fri, 12 Sep 2025 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVc7XXco"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52F31B043F
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757642430; cv=none; b=p9c3kIgp5a2dqxU4ZNPf6LA7uY03Da+EIOyQTz5fqxLkMb0EG2ZLnoCBALGTKPd3nG30N1EstLL0P+E+xKJKNB8DMFVDHrgSn0ux4wNlX4ZiLUgYQ0G3ucZkPkRBDqbGfQzasJAXONbEbaFhpBigaNhts/z1vXCd6MyH63xMnkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757642430; c=relaxed/simple;
	bh=PMqQexRawP2+BcqmRu/ivW9B0wJ5KZzenmHYoRFkpu0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JBPtrabe/v4zCyJNW71ExDU1DFQBlSYZ7zQQFnEwWiJb0FuDrNjUpG+UeqHILT42jl90OVNKgMwqihKaTvvhldxv5CjKuygKeeRaZU4+Lu94K7mSbJrC08rHQdK4d7PjWyYfIOsuf66NAmo9ZfvInBPvJIOfsi4926HGOvc+z+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVc7XXco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F8DC4CEF1;
	Fri, 12 Sep 2025 02:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757642430;
	bh=PMqQexRawP2+BcqmRu/ivW9B0wJ5KZzenmHYoRFkpu0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qVc7XXcoOK9MA7tqgZQgPg86Y1TLsQ8Ac5PXDQpEkL3hFi4LWkDYWn/YwS49ffCVy
	 skMqr9d4E5TyEPaZzhi+Lhtj8KaBuH9mRyqqfh94s5VDbR5ZoiOV0LYgmS60VI68C+
	 SkKXkC+hTeMvIUClsYxhTu4AIMW/qupgP95mz34H8Cyr1F4Jsy31hn4Waod4V8TxHX
	 JS4jRFinRYaFdL54Vx9OT15peTzfzv5yhVPrXtPCvmCcnyW99GAMJt9NnYfwX1CdiB
	 awDUgn/fTC+oni36CcpYe1OabhpM3caPp84htFmD9rsHT6K6juPUPAoW9l9vrYQhbz
	 +6Nqxe6CWjZgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C61383BF69;
	Fri, 12 Sep 2025 02:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] wireguard fixes for 6.17-rc6
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175764243299.2373516.16193248400196654717.git-patchwork-notify@kernel.org>
Date: Fri, 12 Sep 2025 02:00:32 +0000
References: <20250910013644.4153708-1-Jason@zx2c4.com>
In-Reply-To: <20250910013644.4153708-1-Jason@zx2c4.com>
To: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Sep 2025 03:36:40 +0200 you wrote:
> Hi Jakub,
> 
> Please find three small fixes to wireguard:
> 
> 1) A general simplification to the way wireguard chooses the next
>    available cpu, by making use of cpumask_nth(), and covering an edge
>    case.
> 
> [...]

Here is the summary with links:
  - [net,1/4] wireguard: queueing: simplify wg_cpumask_next_online()
    https://git.kernel.org/netdev/net-next/c/5551d2128470
  - [net,2/4] wireguard: queueing: always return valid online CPU in wg_cpumask_choose_online()
    https://git.kernel.org/netdev/net-next/c/5bd8de20770c
  - [net,3/4] wireguard: selftests: remove CONFIG_SPARSEMEM_VMEMMAP=y from qemu kernel config
    https://git.kernel.org/netdev/net-next/c/30e1a1dfa228
  - [net,4/4] wireguard: selftests: select CONFIG_IP_NF_IPTABLES_LEGACY
    https://git.kernel.org/netdev/net-next/c/ff78bfe48be8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



