Return-Path: <netdev+bounces-282912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFf6DH5482mt4AEAu9opvQ
	(envelope-from <netdev+bounces-282912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:42:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 845844A502A
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B7B63018746
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A35322A3F;
	Thu, 30 Apr 2026 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9gp7IL5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BAE27F01E
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563656; cv=none; b=E1nz762FbybQgZGUvFDHntuJwBXw2AhO3JSfgBP0W/5zHIl8OixQ5xhC6ZBRlmJ91M2r+/Edd/mb0qnqo9uV+2V9R+ps0lvk6VyWEEUJqQPjpzNSKsHAGO3wY/IBd3xg2OXMMsWcmL/C4c13iKyOHYM4BtbRvh70gvsPR+TzVzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563656; c=relaxed/simple;
	bh=9zccanP4ZE19HwWfy28HcLhsu9JH7Hu4VQst5A/PYDw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a0OP2Vm+mslUsAzsz0UOIIr1ktF0X2AzHYn4aq3iLJAPRNQ+bwTNbCwUqXdpTGnd/65qoVzzkZspsiYQ2b6+EJ6Tlo/AJb+kbBgc48JtyLCHZBNpf7JkCGOKOiLCYVRAKrGtqYOhM59TCGwerWrwHyzeUg5w9rUOBcod9jnGWbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9gp7IL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EA1C2BCB8;
	Thu, 30 Apr 2026 15:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777563656;
	bh=9zccanP4ZE19HwWfy28HcLhsu9JH7Hu4VQst5A/PYDw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F9gp7IL5ZpldOZiBeS9yfkRJXxqlPSbL9jORFbG25B0X5YMIhx4WVzKYviZgcxGCR
	 FWrZvoV7YNgcly+c3T8XDLL7FPYaNZ4hDgtRK3/WtOkSWXC403YJSJZNtjvY7f1ERG
	 jyh95RzcE6wqbcq8dTkQZNINXuuzjIzVMLeANT2PvS5fWdjLDy5c2Vb+wAv+CTtbqN
	 362C0jKD+WNFFjJqmYPDmAH/Ge78cPUbpfxWPvwfzAIVmOG586mTj0vcx6KCCXQ4td
	 XZ9xgmhSM1feSr8mgG5e0POB5tYmgo82KWp9HkQoSTOSXmwwdbvPgkA+CrGuXSZ701
	 l8bTZ1S4H3j0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DD7380AA5D;
	Thu, 30 Apr 2026 15:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] ll_map: add RTEXT_FILTER_SKIP_STATS to
 ll_init_map()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177756361080.3063728.9662631157405982220.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 15:40:10 +0000
References: <20260428075647.3206962-1-edumazet@google.com>
In-Reply-To: <20260428075647.3206962-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org, stephen@networkplumber.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Queue-Id: 845844A502A
X-Rspamd-Action: no action
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
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,davemloft.net,redhat.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-282912-lists,netdev=lfdr.de,netdevbpf];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Tue, 28 Apr 2026 07:56:47 +0000 you wrote:
> ll_init_map() only cares about names and ifindex.
> 
> We can save ~300 bytes per device if we ask the kernel to skip stats,
> not counting many cpu cycles if per-cpu stats are involved.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [iproute2-next] ll_map: add RTEXT_FILTER_SKIP_STATS to ll_init_map()
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=7bd7f33509d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



