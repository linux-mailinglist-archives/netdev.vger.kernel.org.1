Return-Path: <netdev+bounces-252888-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKWsHimpc2nOxwAAu9opvQ
	(envelope-from <netdev+bounces-252888-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:00:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B82AA78BB1
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39127301A717
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A7C26B971;
	Fri, 23 Jan 2026 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggQgtIZX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE525231836
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187621; cv=none; b=FhQD3QqLDdbVJ4SsS1uAVh2pWovfgGa38CIKJcZGhjs2O8VsAFQN2Y58FoezNbPWKre3WYYInHsk2lHxrJmQInYARqTf+ZcNBUsCoqJiAcRLOxRE4E4phJeCHDIjbvWg1ZS8yQts1mmB8iPD74up5ERIHZyfhdQcTsvwiOGI7iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187621; c=relaxed/simple;
	bh=w16rRHuqyVuyI+kdcgh6DIxkiFL+FjbhaAb1Wvjj1Vc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H6Ii4jfTGdMZXgXEjW+qAUhA2UmCtSXef7R9xvBq5oJM6khtFzRXuEpf068D+9ikM8sDJ09lEWXvPuv4ijxBe5SLH8d48A/ZDoLwzdWz2afUF1Ib+0Yh50liExd/KjO3VXheq16yMb/QaDxVzYGtsx+xOfnHg+Hm0HouvQNalzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggQgtIZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BEBEC4CEF1;
	Fri, 23 Jan 2026 17:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769187621;
	bh=w16rRHuqyVuyI+kdcgh6DIxkiFL+FjbhaAb1Wvjj1Vc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ggQgtIZXPSb/hqXYNwsLPgMczLfgg6NZbgrqQMBVYZY/7TxYD9pCawYqLk1yr0Hxs
	 VFwvmgIPMkaWrz1zuYJh1C0sHVNRVRNJ6BkITDCzvNfhHixd6cpVXUbiq3mfflHajo
	 9j5ojYDDf7hBx1vyvRwgVxgvecwpnFhQKHnOeDZZePuedEfDniQkuGxlEiTlJFAf0q
	 8anIwt69F5IvLVS4SZV+aSf7LZbIwa6AIQ/oXFG2qKwwus00U3kvTi3DGOH9BnHz+s
	 3U9q5d7C37QQX+UVQ6jbzIwqgJTAOM2JEBO+2VRjgd7mCrkVJvjNcNTMlAIu1OYpbK
	 jREvyHT/vN7YA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BC4E3808200;
	Fri, 23 Jan 2026 17:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] man: Add cake_mq documentation to the
 tc-cake
 man page
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176918761736.2640340.16231742691190945864.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jan 2026 17:00:17 +0000
References: <20260122135849.200981-1-toke@redhat.com>
In-Reply-To: <20260122135849.200981-1-toke@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@codeaurora.org
Cc: dsahern@gmail.com, stephen@networkplumber.org, netdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,networkplumber.org,vger.kernel.org];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	NEURAL_SPAM(0.00)[0.940];
	TAGGED_FROM(0.00)[bounces-252888-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:-];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev,?=];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B82AA78BB1
X-Rspamd-Action: no action

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Thu, 22 Jan 2026 14:58:49 +0100 you wrote:
> Add documentation for the cake_mq qdisc to the tc-cake man page,
> including a section describing the differences between the single-queue
> and multi-queue CAKE variants.
> 
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> ---
>  man/man8/tc-cake.8 | 54 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [iproute2-next] man: Add cake_mq documentation to the tc-cake man page
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=a1a647fb04e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



