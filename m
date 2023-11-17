Return-Path: <netdev+bounces-48532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBC17EEB39
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 03:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60CDAB20A3A
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 02:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100F81C2D;
	Fri, 17 Nov 2023 02:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FG91uGWx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CAF1373
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 02:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DE99C433C8;
	Fri, 17 Nov 2023 02:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700189423;
	bh=t/fMPvzowbIBeh26cmKpY4lM2bTPVzXTaTXe8mMagjw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FG91uGWxAkNeiiCBhjUY32V2hKVuUhfmGG55PI93QK9g9xyhn1VZr7ZpBDHLGU5Zt
	 KkFtDG2V/cfeu3BkZyykUFziyzRESye70CHLH5ahrStB9gzOl924noBX3B4k6t1Z1v
	 arEFvPQCfMpbAdfs/AeA0NqLNlfS5Fk7cbxL7C+u9NGwCVSqR/fhkgtf4FGX2fXTC+
	 bcA75iYpKxa+mlyVe3U5ij412PktRmW0HTmbIoTLe7dbhMeTPP5HuswLTGIRDpmIaI
	 /FdWJuSYP/vlDWGerl8M44nddG+G89z6KPysnSjo68OrAOiZYD5kNOEpmh2slYBglD
	 KIDgfZ4jBVz4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C416E1F661;
	Fri, 17 Nov 2023 02:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] kselftest: rtnetlink: fix ip route command typo
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170018942324.29552.8881791100595991488.git-patchwork-notify@kernel.org>
Date: Fri, 17 Nov 2023 02:50:23 +0000
References: <aabeb7c156a45c878e1ea94a6d715e6908f330a4.1700136983.git.pabeni@redhat.com>
In-Reply-To: <aabeb7c156a45c878e1ea94a6d715e6908f330a4.1700136983.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, shuah@kernel.org, dmendes@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 16 Nov 2023 18:01:41 +0100 you wrote:
> The blamed commit below introduced a typo causing 'gretap' test-case
> failures:
> 
> ./rtnetlink.sh  -t kci_test_gretap -v
> COMMAND: ip link add name test-dummy0 type dummy
> COMMAND: ip link set test-dummy0 up
> COMMAND: ip netns add testns
> COMMAND: ip link help gretap 2>&1 | grep -q '^Usage:'
> COMMAND: ip -netns testns link add dev gretap00 type gretap seq key 102 local 172.16.1.100 remote 172.16.1.200
> COMMAND: ip -netns testns addr add dev gretap00 10.1.1.100/24
> COMMAND: ip -netns testns link set dev gretap00 ups
>     Error: either "dev" is duplicate, or "ups" is a garbage.
> COMMAND: ip -netns testns link del gretap00
> COMMAND: ip -netns testns link add dev gretap00 type gretap external
> COMMAND: ip -netns testns link del gretap00
> FAIL: gretap
> 
> [...]

Here is the summary with links:
  - [net] kselftest: rtnetlink: fix ip route command typo
    https://git.kernel.org/netdev/net/c/75a50c4f5b95

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



