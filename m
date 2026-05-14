Return-Path: <netdev+bounces-288051-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHBxFkwDBmrFdwIAu9opvQ
	(envelope-from <netdev+bounces-288051-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 19:15:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A40F3545200
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 19:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C439E303C40A
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 17:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC0B38C40C;
	Thu, 14 May 2026 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEejOf9M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC95838C402;
	Thu, 14 May 2026 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778778825; cv=none; b=Bk07fKY60vCCFZeNydbyeJD5uPo0G8j7y+TnAIVnKeFjBckmBZaowDMAZ4f8HlwFDtGM5sT5FnMMmdAbCJTmk0vjoZhd4vqIcc0yiNElIPGUPPAY/L/uDu4IKJXhozWoIeSFsirUFApCHCzsYKHkCNEq86ZinP6Oa4yLRyiwFlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778778825; c=relaxed/simple;
	bh=QM/whvKLvX41+Y9jLXWAZUiQ4elDSwzkWxvmRWDZTqI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lcZNVGdGHYLZXoDGcQc3t7hHdBY48sSIK/7U/Q45rrro1M5I3vyOlVgZWg9PY73NaYYrs7EIsuwqdEgbXWXErlK5+ryIR+zWNtmzR6+VptF/X/faKAy3Ck21uOBseu4Okns8Fk01EyQuloQzUQ7xtZPKC5lq0q9zfrmltT0nHlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEejOf9M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC2EC2BCB3;
	Thu, 14 May 2026 17:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778778825;
	bh=QM/whvKLvX41+Y9jLXWAZUiQ4elDSwzkWxvmRWDZTqI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pEejOf9MA5mEICXwTs8rgSUaAG6GS/5DOgZfEUIhP/qAjQuaoj05CfFHoQQSN7k2d
	 2cO02q2rU/XXrcII+uZqUzaqq9Q8u45x183I0daHWbTFcQIj0cVDT8YNBkp9/wmbDZ
	 WSGbNlrFFAraUsyGqPgSbeNc0xd463tqVeBg1LB0+YnSbFxfYvjmkSx0mTYiWh2Ktu
	 2UV4tBp9xLxhkWHDQ9lyYqzjKmzBv983Jn6TBnMGe83OJH2N+h+rlBhjW/6ZjKurIA
	 WiXMlG14DP89D1C3IaJiXRNG+4ah8isM6x8hVbVoEWxvmWUr7/MBLAfbb3ikRdnq4O
	 4NCXUgS4KeJBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEAA39D6579;
	Thu, 14 May 2026 17:12:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/4] rxrpc: Better fix for DATA/RESPONSE decrypt vs
 splice()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177877877003.17572.12084366985884137835.git-patchwork-notify@kernel.org>
Date: Thu, 14 May 2026 17:12:50 +0000
References: <20260514155304.2249591-1-dhowells@redhat.com>
In-Reply-To: <20260514155304.2249591-1-dhowells@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, imv4bel@gmail.com, marc.dionne@auristor.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: A40F3545200
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,auristor.com,kernel.org,davemloft.net,google.com,redhat.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288051-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Thu, 14 May 2026 16:52:58 +0100 you wrote:
> Here are two patches containing better fixes for the in-place decryption of
> DATA and RESPONSE packets that can corrupt pagecache spliced into UDP
> packets and sent to an AF_RXRPC server [CVE-2026-43500], plus a patch to
> precheck the length of rxgk-secured DATA packets.
> 
> [!] Note that Hyunwoo Kim's fix is included as that is a prerequisite for
> the main patches to build.  This is in Linus's tree, but not yet net/main.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/4] rxrpc: Also unshare DATA/RESPONSE packets when paged frags are present
    https://git.kernel.org/netdev/net/c/aa54b1d27fe0
  - [net,v3,2/4] crypto/krb5, rxrpc: Fix lack of pre-decrypt/pre-verify length checks
    (no matching commit)
  - [net,v3,3/4] rxrpc: Fix DATA decrypt vs splice() by copying data to buffer in recvmsg
    (no matching commit)
  - [net,v3,4/4] rxrpc: Fix RESPONSE packet verification to extract skb to a linear buffer
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



