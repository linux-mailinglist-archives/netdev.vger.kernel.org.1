Return-Path: <netdev+bounces-181849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B949A86950
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 01:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48F4A189513F
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC6E2BEC38;
	Fri, 11 Apr 2025 23:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBcnZmv3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053CB3234;
	Fri, 11 Apr 2025 23:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744414796; cv=none; b=k3bFQX1JXw8ZOpDniQfNodi2SeASBKVFs4rOkLNFP/IDQ+B0yCj5rVUePUipd27wZ/phUdNQgWNF7wWMxX/HlyoyUMWRMOrxUXaDvdb3h0danixRRQM9LQUS6cSZ8HRoDEa64z+ANkOMRC9kERjcR/7o4dsRLQp8pGJkhwzS0PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744414796; c=relaxed/simple;
	bh=++wYaIrj3C2ZV5bOYqSEcsVhOStqZL2wJ7OB7mGhvyE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V6vmJ66DZGtQ5bGendCMT88cx6xhutnQZxJ6aSZ8j/6RLt8MPPwh1LiyJxCoHMCCGkWiRxZ5WO/MO17sc4BOQJ547RIjG+TaAOKuFuNbpQ2YBGeSDL73rQ0j2gUo54HWlKEYh2KDB3Lrt1/ikKvPBjE3W6H0qdaeAd7Qkp7pN54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBcnZmv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3829C4CEE2;
	Fri, 11 Apr 2025 23:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744414795;
	bh=++wYaIrj3C2ZV5bOYqSEcsVhOStqZL2wJ7OB7mGhvyE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fBcnZmv33kdYUqRrDHMY5BOofCyUPRLVdeWVSbFiAyTx+QPDQtXN78xwYZOnp0Y6X
	 P6b0f5Icsn+rFGb76B/NMM1FZKp6GLz4Tpml/LTauvQiFms9hw9/OO3IqKr54plAvo
	 LSU+01RrDszwcBY44+tkf+tEFG+RLckFmCyFjN7FdMWNNGfJ/9IxOM/XW4doLOwmbl
	 Rc+WqrMOk0FZLV8DSMgQtHT3D5Rx/g+ce2v1WFD8UrlNC8xzSN6ODy3MPRuX4rMDPk
	 twUrl2BF4jSfOgkPW4UDY8Mvas2rIm4Y7eZ/PxKcln6LLxwYjMCPly3KvswF/c1jCh
	 Aqxx0vNuB9jJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEACD38111E2;
	Fri, 11 Apr 2025 23:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] selftests/tc-testing: Add test for echo of big TC
 filters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174441483351.518794.17356849326579261334.git-patchwork-notify@kernel.org>
Date: Fri, 11 Apr 2025 23:40:33 +0000
References: <20250410104322.214620-1-toke@redhat.com>
In-Reply-To: <20250410104322.214620-1-toke@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@codeaurora.org
Cc: linux-kernel@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, shuah@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Apr 2025 12:43:21 +0200 you wrote:
> Add a selftest that checks whether the kernel can successfully echo a
> big tc filter, to test the fix introduced in commit:
> 
> 369609fc6272 ("tc: Ensure we have enough buffer space when sending filter netlink notifications")
> 
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] selftests/tc-testing: Add test for echo of big TC filters
    https://git.kernel.org/netdev/net/c/18c889a9a419

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



