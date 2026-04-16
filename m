Return-Path: <netdev+bounces-279026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFewJrnQ4GkkmQAAu9opvQ
	(envelope-from <netdev+bounces-279026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 14:06:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1036840DD59
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 14:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 886E6317979D
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 12:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A19E3B38A1;
	Thu, 16 Apr 2026 12:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkf1MWFH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066AE3264E5;
	Thu, 16 Apr 2026 12:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776340838; cv=none; b=svy89l7f47opAOFud4UBq7fx84qa6X37qZsPrSfZ6OlPpkPg7DE9ZT2p+M3WgI8U51PiamwnLyNpbFwjRqRd3olODBMHV0+8+tCSE88XDqoRqBiURGTLVz+3ljQEhC9yrXapK6kn66/PKnwunraWfWdZrec485AXmMZECS6IE1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776340838; c=relaxed/simple;
	bh=vB2UW38Qsxy6HkmQ+i/p2fJNKXl27Njykbl1fdHvnNw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HwHtKplj/fD4ZrB4gv3jFYsN/+8fuYpdWQjvcUn6i1qL1NEqldwnw8kT1pyWgs5UQtf5bVCjrzxjoNicNrbXh0Uz2N0Z2IkRM11o5tyq10M9cG0HfRAV3srkgRrdJm18psAl3wD/BLY28R+R2HwUIHLQd1mTRf4Z6RC1SV8Wvvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkf1MWFH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B39C2BCB3;
	Thu, 16 Apr 2026 12:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776340837;
	bh=vB2UW38Qsxy6HkmQ+i/p2fJNKXl27Njykbl1fdHvnNw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bkf1MWFHaz7IMbhvGfCC0GfTFWl8MyXoudkoEoLYwcndB51Ju76OJdzbf3FDn+Wh5
	 Qf4DT0F2B80TXnJr0SueP9NRalUPBcBQ/oYfDe4emwczVKzYdneQWXnlwi+Ff/Gv20
	 VMGlxg0QRsjSd9moNsIaog/O4myy2gbuIhiQLJEI7Gg4jc2gNmtFBqad/jV5W3Wjq1
	 XX/ASFSrchVOZEzlmVsxktmCC8+VAYnbTHA/bAsdnfwJ5fj8QMp3dejginWXUDgfUD
	 LEUW8/XZgXkhomLoWAoAIYPjZty1YuCV/RXBjOEMR8E5ZqoxX4wkcTIGB0vJv3XDtB
	 rAcW0sZoIb9DA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E4C380AA4B;
	Thu, 16 Apr 2026 12:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1 1/2] nexthop: fix IPv6 route referencing IPv4
 nexthop
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177634080629.2761349.3112126436479245128.git-patchwork-notify@kernel.org>
Date: Thu, 16 Apr 2026 12:00:06 +0000
References: <20260413114522.147784-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260413114522.147784-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-279026-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1036840DD59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 13 Apr 2026 19:45:19 +0800 you wrote:
> syzbot reported a panic [1] [2].
> 
> When an IPv6 nexthop is replaced with an IPv4 nexthop, the has_v4 flag
> of all groups containing this nexthop is not updated. This is because
> nh_group_v4_update is only called when replacing AF_INET to AF_INET6,
> but the reverse direction (AF_INET6 to AF_INET) is missed.
> 
> [...]

Here is the summary with links:
  - [net,v1,1/2] nexthop: fix IPv6 route referencing IPv4 nexthop
    https://git.kernel.org/netdev/net/c/29c95185ba32
  - [net,v1,2/2] selftests: fib_nexthops: test stale has_v4 on nexthop replace
    https://git.kernel.org/netdev/net/c/104f082f5ed6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



