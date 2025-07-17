Return-Path: <netdev+bounces-207915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0F5B0900E
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8611C417BB
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 15:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E48C2F8C4E;
	Thu, 17 Jul 2025 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thLeDimj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDF51DE3C3
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752764406; cv=none; b=rEmxdvcmiPu4NL/neGHmcK/APTZQCJvMWxKc6PnzhjyWYOa4MoW6ZN0oErdRTcZeIHSudWUM5qpO2uebBvb5XCmsi6ZzcLsQqIHxg6QkmBGU2K7trYN2w/fZGKgEPvSMibZ2pZc60dT/Z30X0w3XU8qWNIaTSA6iRok26nP+ZWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752764406; c=relaxed/simple;
	bh=HxdH+8AltY2h4fpaGngDoif/yIkjcqfppDFv3+a3bfI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NfAWD+HGwi+28Qhhp/Cw2DtjCAj/UgFO2eNj5svCnoxPvJtDfL3Xu1LSnlaipOPvhT5P1Iou1H/YxxUSpNavHoEgPtlTq2vGbhZ4A6tsSHdMLevGgK0mh8tW747fnwSgIIabXymylumxKuZNX0DZ02tNDQygtciJBHSBJ3/R4f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thLeDimj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3610C4CEE3;
	Thu, 17 Jul 2025 15:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752764405;
	bh=HxdH+8AltY2h4fpaGngDoif/yIkjcqfppDFv3+a3bfI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=thLeDimjOP8QqsVAigOnsbBV5B6VbFHHvxmYxWUKaFONjwk413yHKxKUvp7adEzlf
	 j8DvNnjNoWxId8Gv5eGTDUMxHTgg5a5aVGOQ+QhZoOJvDWedAwd+naBo8DInW+cx95
	 e8e7JxgxX4/7D0cA6q+0kJ9nUQ6EeKhcDOPw9ZfcO6vViC3MT6QDWKUw1+9KQE9dAL
	 PaS/6qo4Y4CS1HyYuIB2hfz89XbcFS6Z1iCwDFmRzOWuO59TAG2H80rMO/NeKzqHFQ
	 jpxQITrG1J0aDGpEw4qGDcgKjSW1k+mrXb8y2hp/f6fL7ewjZIdSRpiOaBsJaEBc9f
	 YV2Ii1h2JTgSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAED7383BF47;
	Thu, 17 Jul 2025 15:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/2] net/sched: Return NULL when htb_lookup_leaf
 encounters an empty rbtree
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175276442550.1962379.12116815931515333407.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 15:00:25 +0000
References: <20250717022816.221364-1-will@willsroot.io>
In-Reply-To: <20250717022816.221364-1-will@willsroot.io>
To: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 pabeni@redhat.com, kuba@kernel.org, savy@syst3mfailure.io, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Jul 2025 02:28:38 +0000 you wrote:
> htb_lookup_leaf has a BUG_ON that can trigger with the following:
> 
> tc qdisc del dev lo root
> tc qdisc add dev lo root handle 1: htb default 1
> tc class add dev lo parent 1: classid 1:1 htb rate 64bit
> tc qdisc add dev lo parent 1:1 handle 2: netem
> tc qdisc add dev lo parent 2:1 handle 3: blackhole
> ping -I lo -c1 -W0.001 127.0.0.1
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net/sched: Return NULL when htb_lookup_leaf encounters an empty rbtree
    https://git.kernel.org/netdev/net/c/0e1d5d9b5c59
  - [net,v2,2/2] selftests/tc-testing: Test htb_dequeue_tree with deactivation and row emptying
    https://git.kernel.org/netdev/net/c/88b06e4fb4bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



