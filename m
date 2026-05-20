Return-Path: <netdev+bounces-289724-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOqEChwdDWrZtQUAu9opvQ
	(envelope-from <netdev+bounces-289724-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 04:31:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 752EA586D9A
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 04:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FEDB30166C1
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 02:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD423033C6;
	Wed, 20 May 2026 02:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyAxDUXi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5503033CB;
	Wed, 20 May 2026 02:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779244202; cv=none; b=pUoXeLcG2qvAGyx3z4e45zFH8h2q5pS7dDfB2KbXNmKYBTT+VbMXyL4BW+ge7NVrgJ/dTzscVg/7H9eZQE6hzNwT6yzywCnTvu1ksaiPn7kz3CSWTv20GFRkHv26refLM+x1b8oJu/rAJp51DD9o/d38SMeBMThcnQH7ZQLURrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779244202; c=relaxed/simple;
	bh=wbUff0nU8TSBLh0YU/5pAhlj/AXfQrxdibuqVAiWFLU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=amhUtVO1WjklTZQmGcuhtDTWmxYpxCo2TPBaCPYKhCbZ1XOcH+1tkPFriKEb1UzjQ/8PUgYNujizGN9ipqX3+2g+b3yql7koYvnk8uJnJmbpt6FIj0TIgHnNefXt5V8y1VH7yDZNthWraQpF8UDCCUl2ZTTrsFiv8Mf/IUnP+Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyAxDUXi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1CA1F000E9;
	Wed, 20 May 2026 02:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779244201;
	bh=yaoJposcQhjc5ztSY0Wu5Zar4pUWGxMZV6xB0gMFPHs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AyAxDUXiUn4dVKQhOMDOIpk53G97jOSvodABaD3qdPjzcrbG3MSQIzlqYMm5OqV54
	 2ioHl8rJKtVLEAe5xXkebgEqhlS13xQ8jydzTyyZ0sltCY0woGupmwwd3zJqwpiklF
	 hojwLiH0ZT1hbZmEFIh+rLvfMUQvHzZ19+KBOTAR4tvXgryJzvyic2NqLDC5SuzyRZ
	 xYEbcSHG6pGlI0lkjHrEHLPXaunQYFt+uqZ26JMLj+TxNbjzxRK2wGzRj5TSV2I6wa
	 FnUM3RSPosGI85+stttY/LnOBjQmu8rJAeXLxRF01ekKjootGjJ+AGIfwgL1cLbIBQ
	 mPzzJwjgrEM0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19851383BF53;
	Wed, 20 May 2026 02:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: socket: clean up __sys_accept4 comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177924421164.2955096.17543057385955830364.git-patchwork-notify@kernel.org>
Date: Wed, 20 May 2026 02:30:11 +0000
References: <20260516101109.479042-1-avinash.duduskar@gmail.com>
In-Reply-To: <20260516101109.479042-1-avinash.duduskar@gmail.com>
To: Avinash Duduskar <avinash.duduskar@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289724-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 752EA586D9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 16 May 2026 15:41:09 +0530 you wrote:
> Fix a typo and a redundant phrase in the block comment above
> __sys_accept4(): "thats" -> "that's", and drop the trailing
> "to recvmsg" that repeats the recvmsg() reference earlier in
> the same sentence.
> 
> No functional change.
> 
> [...]

Here is the summary with links:
  - [net-next] net: socket: clean up __sys_accept4 comment
    https://git.kernel.org/netdev/net-next/c/bf53bf332061

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



