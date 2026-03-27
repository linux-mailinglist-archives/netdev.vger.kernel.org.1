Return-Path: <netdev+bounces-272367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHloOOkAxmk/FAUAu9opvQ
	(envelope-from <netdev+bounces-272367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 05:00:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E0C33EFE1
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 05:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADD9D304B4C5
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB901372B59;
	Fri, 27 Mar 2026 04:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtM7uFSK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F3E31F9B1;
	Fri, 27 Mar 2026 04:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774584022; cv=none; b=oqpIQOWkOa6MZvCLlkE3KsQH1S/F18uVWsSZ9SoUxwi4uYOvuAYRxy/W3gD6qDe9FRIOi8CRzosgzJPppZABjJTX0j2W8E/frDnkCpNBz+YtkSFnqNLiUSP/zUJ8W9VVw+Zxy+YOZIpOPCH2LmW2Go7GjVuc3jaPVgXlSQk3/e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774584022; c=relaxed/simple;
	bh=MUz1Cclys+71wGKUyklyqufPEC0o6AVqODwSCLdYEuc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CSNenFe0T9Z+y6IuHHdLUmwQiCXnOkRDyntmV0/IJbJXJFQq1UkJK4E1DrX51PcPJ3TYbg4N83feLut712TVqFqrOSISZfJFYXJwzupAEPI6Zlyp2Sij/kLdT+qMMk6Zj1wTEWD8vgJXuC/TPIyySInC0blpEPeLHhXjR1JytwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtM7uFSK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE9AC19423;
	Fri, 27 Mar 2026 04:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774584022;
	bh=MUz1Cclys+71wGKUyklyqufPEC0o6AVqODwSCLdYEuc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BtM7uFSKLRriCvEJMUx/OrQmr7lpNctfNiNtB3a5iX1bc3f/SoYobxnHG652X/Pay
	 ht82wUru1vy55CXUlFxdlEIq9lkWwJBjk6DYQDE9eLCQl4BZnDiqHK+AwNgSqGqWdB
	 vfAR/IcE6A6j8IBghhGr2uSsYytnokiDGE46OwLEcbbfEaCZEb3rLrobvArbSSzptz
	 W9ggi6rm4GpEbtWVmGGzzKVqYNh96q/MaRIIPeKX4aST6yaB2ZnwZgQtZGkaqk4/rM
	 82slbGm7DLuIi5CbmiafE6v+kwEhBA3VcfcnvfIV36+Pax4RzHafZAZ6I+qxL6EiUx
	 TH0TmxW2sCvWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EE73809A0B;
	Fri, 27 Mar 2026 04:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] tcp: Fix inconsistent indenting warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177458400837.3293285.12552904181841357465.git-patchwork-notify@kernel.org>
Date: Fri, 27 Mar 2026 04:00:08 +0000
References: <20260325071854.805-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260325071854.805-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, lkp@intel.com, edumazet@google.com,
 ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-272367-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linux.dev:email]
X-Rspamd-Queue-Id: 46E0C33EFE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Mar 2026 15:18:54 +0800 you wrote:
> Suppress such warning reported by test robot:
>     include/net/tcp.h:1449 tcp_ca_event() warn: inconsistent indenting
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202603251430.gQ3VuiKV-lkp@intel.com/
> Fixes: d1e59a469737 ("tcp: add cwnd_event_tx_start to tcp_congestion_ops")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> 
> [...]

Here is the summary with links:
  - [net-next,v1] tcp: Fix inconsistent indenting warning
    https://git.kernel.org/netdev/net-next/c/552994294fe2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



