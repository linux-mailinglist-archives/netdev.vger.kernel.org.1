Return-Path: <netdev+bounces-259024-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADc1B+JhlGlfDQIAu9opvQ
	(envelope-from <netdev+bounces-259024-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 13:41:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3292614C0A8
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 13:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61F013049274
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 12:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5753542EB;
	Tue, 17 Feb 2026 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOIbx0FU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBA93542E6;
	Tue, 17 Feb 2026 12:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771332017; cv=none; b=gM5sfB7Piq61bwCBD7PfugJQDUOMhhBjZAwvyq9dimu7f/b/nFyYNMgU6ZnYx38dMbKVMTbI+WB2ihEAZK5sh+Z0dZDMCrvrkmq//AP1gqGHaLm/olyg5E6ZiUWprotRl9WM2TaikzergqhBUMcfdFYZgJ7eZvab5BmpVIwVn0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771332017; c=relaxed/simple;
	bh=OrxmlLHkDYAQKBm+YyGD45sLOVbepfHJISVxRarHhso=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DxE2/81mx8wnRO7rROe0KXYIjApMhUhDENhwPd9XtOHfCn9VrtHH5S9l5ll+6y4cHT/IbuEns43ZvCWQNmOp+/HHivNeS+muhICo4M2Ehw5YixO4Lajb7FYO1so7DKmKH9J8qt+uwQkDyjl83YdAbdYQbcxRh/vBorkkAw3Q1yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOIbx0FU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E20C4CEF7;
	Tue, 17 Feb 2026 12:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771332016;
	bh=OrxmlLHkDYAQKBm+YyGD45sLOVbepfHJISVxRarHhso=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IOIbx0FUBDRJNcRoS4816L751Sak5XJeA+oDo1tDYBRRlgAGDH7HC1i7lLTM/8YRg
	 iBIp1pwMMGcI8FmTxK9YNPcT5dHBerr6jKbW0RD4OahTsntt63UHCoyGKErQxvnkQk
	 krUKVvuj4vhKvFOHDc4U9mUZ/+x5STZZnMh9uT7G9pynYFViKHq0vLJmrjOPolOZUm
	 jUVFNs29iLnnFtSQGFlBK/vX+cT1L/MJe128DF0kgOIqqkIiW4C8AsUdFTjLad3+jp
	 75fBRxA02FZv/sFVGLRt5/lLH8z3LyZWwXuH5v1w7Em2SCh6XdY70Rig6WesGDlfHP
	 4LKACY+zE5MwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B29B380AAD0;
	Tue, 17 Feb 2026 12:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/3] selftests: forwarding: fix br_netfilter
 related
 test failures
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177133200882.59403.9737891689538537794.git-patchwork-notify@kernel.org>
Date: Tue, 17 Feb 2026 12:40:08 +0000
References: <20260213131907.43351-1-aleksey.oladko@virtuozzo.com>
In-Reply-To: <20260213131907.43351-1-aleksey.oladko@virtuozzo.com>
To: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, petrm@nvidia.com,
 idosch@nvidia.com, amcohen@nvidia.com, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259024-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3292614C0A8
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 13 Feb 2026 13:19:04 +0000 you wrote:
> Hello
> 
> This patch series fixes kselftests that fail when the br_nefilter
> module is loaded. The failures occur because the tests generate
> packets that are either modified or encapsulated, but their IP
> headers are not fully correct for sanity checks performed by
> be_netfilter.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] selftests: forwarding: vxlan_bridge_1d: fix test failure with br_netfilter enabled
    https://git.kernel.org/netdev/net/c/02cb2e6bacbb
  - [net,v2,2/3] selftests: forwarding: vxlan_bridge_1d_ipv6: fix test failure with br_netfilter enabled
    https://git.kernel.org/netdev/net/c/ce9f6aec0fb7
  - [net,v2,3/3] selftests: forwarding: fix pedit tests failure with br_netfilter enabled
    https://git.kernel.org/netdev/net/c/a8c198d16c64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



