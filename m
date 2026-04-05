Return-Path: <netdev+bounces-275464-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAS4FCiO0mmCYwcAu9opvQ
	(envelope-from <netdev+bounces-275464-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 18:30:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B19839EFB3
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 18:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1916F3002515
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 16:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2052BE65B;
	Sun,  5 Apr 2026 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZQNxRXX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBEA1F2380
	for <netdev@vger.kernel.org>; Sun,  5 Apr 2026 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775406626; cv=none; b=AIaqTBB8AFgck70pXm3+AwcmisnriHEFxvjLn0+M7wJq+Q2lrRLq+/N5e493Nh6EUlCeQeOG13CdKpoJRRFIRokYHn3r6b5Rq9+MK3M4O+nVnIoKflDeqoeKWkBnW/ZtyjBB0S6/eiSaKZmJ+wBHjQU5QA3Bas11iKj5jAQKUO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775406626; c=relaxed/simple;
	bh=9m2J4xrYR8Yb/V7u9eNyrkni88blMFL0jQ45585nhxI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O0pWiCdFrgmKHcDQlr8AsfqEzP/lcyRUR+NqFmQb62TunQVE9ke5YTpCzBZimh/dRWs/1JxvfaPQkzJkx1bL3Umv24EGfvUhhjIpllg15k27ZFDCTApHjhTVWlt2hLQ0T+BfSIPENrerjkkg5Pn+aCZX9PU40UuOYHv2ceYcdT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZQNxRXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECF9C116C6;
	Sun,  5 Apr 2026 16:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775406626;
	bh=9m2J4xrYR8Yb/V7u9eNyrkni88blMFL0jQ45585nhxI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sZQNxRXX4GYOgGNmL8pXyRTyWir9jhJSV+MuHiu0gfaEHAllXPYeYy0xo1cTnWT6/
	 ae7SfwUpwjdAtXE8mMCVM4H5cntdluLROBkawBfQXzurzN6N/B4UBqR+TYrqffPy2Z
	 WUivN6Mr2ldh0eDjRcuES6HzY5EwCi3yQx3pgqOubeSi2xw2nlJopaCUSq4I9dPcQb
	 CCz/n0m+HILBMj1pHosmYc7+jrBO9TX1z8/dUP2LqItViU7UjkHqyygWpPWzkkxs6P
	 K8bAsvrSuG/mtPowBO6wZzKA/pLrFrTH4WE6RlMU7gpBvmJG8D2Bp3xKrBmcR6ui7Z
	 DGX0gz8V7e31w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD1F3809A22;
	Sun,  5 Apr 2026 16:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] ss: add support for TCP delack timers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177540660604.1987085.6520895876036351354.git-patchwork-notify@kernel.org>
Date: Sun, 05 Apr 2026 16:30:06 +0000
References: <20260403102309.338648-1-edumazet@google.com>
In-Reply-To: <20260403102309.338648-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org, stephen@networkplumber.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, ncardwell@google.com, kuniyu@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-275464-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,davemloft.net,redhat.com,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4B19839EFB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Fri,  3 Apr 2026 10:23:09 +0000 you wrote:
> Kernel commit c698f5cc940d ("inet_diag: report delayed ack timer information")
> added a new enum for idiag_timer values and support for delayed ack timers.
> 
> Change tcp_timer_print() to use the new enum and display "delack"
> instead of "unknown":
> 
> tt -to
> ...
>    ESTAB 10     0   [2002:a05:6830:1f86::]:12875 [2002:a05:6830:1f85::]:50438
> 
> [...]

Here is the summary with links:
  - [iproute2-next] ss: add support for TCP delack timers
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=37c010d59a44

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



