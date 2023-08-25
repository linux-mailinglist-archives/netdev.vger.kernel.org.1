Return-Path: <netdev+bounces-30620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D44788368
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 11:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E89281681
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 09:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A522C8CA;
	Fri, 25 Aug 2023 09:20:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB738C2F2
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 09:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A1D2C433CD;
	Fri, 25 Aug 2023 09:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692955222;
	bh=RkKLK3ccBCSlvsLnPaVYJP51Ayxs+r8TXBqJBNM1MUw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bOY8C66vMnEFw/myY0Acf+rii7E+CiT439LUMG5HCLtVRGrtnMVENHIuVJ2dlO5NZ
	 /rRElSlq33DfE3AnIgmuUqZBpN6pydkwwWaDBDQxSVHOUgptu1UzY50dkzvShCDXHM
	 VWbDE+bfJohVXn7ac4Jqnmw7MeIomwWKdE7Vkk2+JSfdpK4Nw2CNNm5tsz0qnUJ8ye
	 hy+l43/uU21bMyPUVC2lFo9qhP8Z3stOB7y1kZ23vgGTFgaVsbnH5kHcD4DkpvQAAf
	 mrWr07xgkyXCUKpyvVZb9xJLIZuX0Ch9HA5H2A7dF7tv4+skdC0u/wcrflOPstlnq0
	 FAXVTGQ444Kbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65544C595C5;
	Fri, 25 Aug 2023 09:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] kunit: Fix checksum tests on big endian CPUs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169295522241.11125.1512224356582645824.git-patchwork-notify@kernel.org>
Date: Fri, 25 Aug 2023 09:20:22 +0000
References: <fe8a302c25bd0380ca030735a1383288a89adb11.1692796810.git.christophe.leroy@csgroup.eu>
In-Reply-To: <fe8a302c25bd0380ca030735a1383288a89adb11.1692796810.git.christophe.leroy@csgroup.eu>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: davem@davemloft.net, kuba@kernel.org, dave.hansen@linux.intel.com,
 goldstein.w.n@gmail.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 23 Aug 2023 15:21:43 +0200 you wrote:
> On powerpc64le checksum kunit tests work:
> 
> [    2.011457][    T1]     KTAP version 1
> [    2.011662][    T1]     # Subtest: checksum
> [    2.011848][    T1]     1..3
> [    2.034710][    T1]     ok 1 test_csum_fixed_random_inputs
> [    2.079325][    T1]     ok 2 test_csum_all_carry_inputs
> [    2.127102][    T1]     ok 3 test_csum_no_carry_inputs
> [    2.127202][    T1] # checksum: pass:3 fail:0 skip:0 total:3
> [    2.127533][    T1] # Totals: pass:3 fail:0 skip:0 total:3
> [    2.127956][    T1] ok 1 checksum
> 
> [...]

Here is the summary with links:
  - [net-next] kunit: Fix checksum tests on big endian CPUs
    https://git.kernel.org/netdev/net-next/c/b38460bc463c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



