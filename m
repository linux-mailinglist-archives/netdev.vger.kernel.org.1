Return-Path: <netdev+bounces-280865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAmJD3x46mkUzwIAu9opvQ
	(envelope-from <netdev+bounces-280865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 21:52:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 661D7456FB2
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 21:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1B2F930060A7
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 19:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B477B39A075;
	Thu, 23 Apr 2026 19:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FR0O3cGz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909C539A05A;
	Thu, 23 Apr 2026 19:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776973852; cv=none; b=tUnHKc4bzA8yHapWmfjffRqUp2DV5tfextCosx4gnJV+I1AHBZLD6bZRQIpQVlUTq+vQVMWi3jrTV/xzkPdzkhCPuEbjD+8hHr14nMPv0JW6hUgWunjF+ixWNQ3jKH/eLSglZAB4SCENuF/xx4rJHCsBSrOk9IM9uhHNS3gSgZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776973852; c=relaxed/simple;
	bh=U0CyDfCJvWNu+EA15wd4/oIWPPmLn8s74WMey1Bf8zg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ADPqVSH/GKxupr2PByfYpZvLeRdAWlfvXt3s7M2S7GNEujiADinTJf6e6rgDmOwhjpOkc16/lkuyqSRmI9jlWkHbZcayrP8PiWgUG1fHmG7otatThxDhkXUk3JZ7FB7ldqlKhbxumMjmkvtm7nibBhl3iKXblqQgcNU58aHTzms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FR0O3cGz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C755C2BCAF;
	Thu, 23 Apr 2026 19:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776973852;
	bh=U0CyDfCJvWNu+EA15wd4/oIWPPmLn8s74WMey1Bf8zg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FR0O3cGzLjvPaYkTUXniQgRhIaRTwyFaD5bupn99aK5vNQXPWElPatjBTa35xqhKT
	 DAy0GKiEYzbtUqheMxXLlHdcyf2N8YiE+QMebZd3yWeYpMd3RQfzTMYM1nu29pfX7k
	 81u6W1Sb/pH/CZL0G4hP3Y5m/76W9KRty3h9HOyfKi/ajD4zkmIoFflg7LAXrnFSY3
	 8Y4S9yW8u12idIXynKCgnqaxrAc9+hPVqQHJBg99dUgTePliyCOPLYowXqGISCirj7
	 wgduqu6++KB57H8wZ7A23+KH2rZaZuwXP+yuWI5/01gQ47hk+ER35RZQ04yrmYA3XN
	 sdo5qywVoczJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E2E3809A90;
	Thu, 23 Apr 2026 19:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/6] rxrpc: Miscellaneous fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177697381355.740120.3673972749152907468.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 19:50:13 +0000
References: <20260422161438.2593376-1-dhowells@redhat.com>
In-Reply-To: <20260422161438.2593376-1-dhowells@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, anderson@allelesecurity.com, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-280865-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 661D7456FB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Apr 2026 17:14:29 +0100 you wrote:
> Here are some fixes for rxrpc, as found by Sashiko[1]:
> 
>  (1) Fix leaks in rxkad_verify_response().
> 
>  (2) Fix handling of rxkad-encrypted packets with crypto-misaligned
>      lengths.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/6] rxrpc: Fix memory leaks in rxkad_verify_response()
    https://git.kernel.org/netdev/net/c/34f61a07e0cd
  - [net,v2,2/6] rxrpc: Fix rxkad crypto unalignment handling
    https://git.kernel.org/netdev/net/c/def304aae2ed
  - [net,v2,3/6] rxrpc: Fix potential UAF after skb_unshare() failure
    https://git.kernel.org/netdev/net/c/1f2740150f90
  - [net,v2,4/6] rxrpc: Fix conn-level packet handling to unshare RESPONSE packets
    https://git.kernel.org/netdev/net/c/24481a7f5733
  - [net,v2,5/6] rxgk: Fix potential integer overflow in length check
    https://git.kernel.org/netdev/net/c/6929350080f4
  - [net,v2,6/6] rxrpc: Fix missing validation of ticket length in non-XDR key preparsing
    https://git.kernel.org/netdev/net/c/ac33733b10b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



