Return-Path: <netdev+bounces-264107-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLkkAdzVqGkqxwAAu9opvQ
	(envelope-from <netdev+bounces-264107-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 02:01:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6602A209A7D
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 02:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79FAB30479C7
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 01:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FEB226D02;
	Thu,  5 Mar 2026 01:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIVDZOFC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DD11A38F9
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 01:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772672459; cv=none; b=N8V90Zx3hTSosqzXTkEIEd5fMmUUNK4i+AlL9xSSMKpVcDHh+QmPnqHMln0cS1dtsYAAIJ3zvymrLAID8A+zA215UBYvXING6k979yj4R9kqudmle4WSwPiqLKQez62XDoFP3zFKrRSyoeYs738Xc8Uass1AzOkCclhldWOHDRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772672459; c=relaxed/simple;
	bh=zqqI2sTYcIX2TT3dhC8RGT8BLfWA0ZJvwnUIG04sJuw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LRq0hWSv9LhSO+f++A0a3bJbMZ1odK3w94qxWJVav0I5mAmxA8bxUbJKaorjidedzwqSSw9qdtPIz7F3TTUSGfSvNLUsAQyVG5BTV6s4RL+UujhueTZuwVLMlD7nlN91nLLW2e2RxIaa6NH2jqjtSOznHn2620ksVhcGdASr5OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIVDZOFC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE46C4CEF7;
	Thu,  5 Mar 2026 01:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772672458;
	bh=zqqI2sTYcIX2TT3dhC8RGT8BLfWA0ZJvwnUIG04sJuw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cIVDZOFCyUFoN3zPXwMoqTkZnx0U8DutASjXCMXkGR1JJVd2lApsSlrYcm7SafMN1
	 L4YyFupePlUF2mz1I2QxAVM8sWm2gvpurMdUVeJCGZ5T86JMFdPxiGSHcsBr9tZF5w
	 GTjWWOrHKWrHsxCke3YJr94wSHq+JNtNcjpn082kSEhQoGpVQcXJrf/c2EbhDkV6Kw
	 3ypfCYYEKRGz51TXkf1ZOTd+TG7XNLREH8iwEWBvzbmjOBkfEm7ELwydJuGtSJ7QMh
	 kil+1hDZCiDoZumnQK1Pq9MD6qqnNTznwZE7h7Nksyjx8Qy+C9v9EsS/adFjBaexCu
	 NhdxVCWbsnFOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEF03808200;
	Thu,  5 Mar 2026 01:01:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/7] rfs: use high-order allocations for hash
 tables
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177267245896.2463633.15444204983938498113.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 01:00:58 +0000
References: <20260302181432.1836150-1-edumazet@google.com>
In-Reply-To: <20260302181432.1836150-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Rspamd-Queue-Id: 6602A209A7D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-264107-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Mar 2026 18:14:25 +0000 you wrote:
> This series adds rps_tag_ptr which encodes both a pointer
> and a size of a power-of-two hash table in a single long word.
> 
> RFS hash tables (global and per rx-queue) are converted to rps_tag_ptr.
> 
> This removes a cache line miss, and allows high-order allocations.
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/7] net: add rps_tag_ptr type and helpers
    https://git.kernel.org/netdev/net-next/c/42a101775bc5
  - [v3,net-next,2/7] net-sysfs: remove rcu field from 'struct rps_sock_flow_table'
    https://git.kernel.org/netdev/net-next/c/61753849b8bc
  - [v3,net-next,3/7] net-sysfs: add rps_sock_flow_table_mask() helper
    https://git.kernel.org/netdev/net-next/c/9cde131cdd88
  - [v3,net-next,4/7] net-sysfs: use rps_tag_ptr and remove metadata from rps_sock_flow_table
    https://git.kernel.org/netdev/net-next/c/dd378109d20f
  - [v3,net-next,5/7] net-sysfs: get rid of rps_dev_flow_lock
    https://git.kernel.org/netdev/net-next/c/68b6394a220b
  - [v3,net-next,6/7] net-sysfs: remove rcu field from 'struct rps_dev_flow_table'
    https://git.kernel.org/netdev/net-next/c/b2cc61857e3c
  - [v3,net-next,7/7] net-sysfs: use rps_tag_ptr and remove metadata from rps_dev_flow_table
    https://git.kernel.org/netdev/net-next/c/a435163d3100

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



