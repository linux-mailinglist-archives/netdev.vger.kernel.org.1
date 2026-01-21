Return-Path: <netdev+bounces-251727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPhyInU+cGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:48:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1709F50038
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95F41BC7FA7
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4348D356A1C;
	Wed, 21 Jan 2026 02:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTK+LUqC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178B83563DE
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 02:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963246; cv=none; b=PDU3S+lo6RHjBHs+1TXlaGqHjReEPm7IguPu4615Mur5ElXEDoZX0L01ZKulfOU6MDeRNuAR484ZHPejhi8xYJVNLNwQpaHBDw6cmQ8ENAVb6kKB2jl1Ir6FKqWh35SWTQTX5r0k0ijZIev/Nvu7B4k4gIjuNq6aJfKllVoSers=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963246; c=relaxed/simple;
	bh=WwDkITX4aV/z3ZUwIm3L0HArYb8mXkVPRrHn037T9Vw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZUWdGx2LV3Tg4iF3une6qOyGgNU7cPmTeTflhruljZdAh+N9fDcFvAjEdrriBvzFpQwWTYZDyLlQEZbKCm7R57qraCLHEc4MHntTHpP73m9Df2wXfT2qDG2gtlADzTzJy0FR97IsEHPDzmRfWxYbPpWLpE5rrbNiwS5I9wbvb/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTK+LUqC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB741C16AAE;
	Wed, 21 Jan 2026 02:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768963246;
	bh=WwDkITX4aV/z3ZUwIm3L0HArYb8mXkVPRrHn037T9Vw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aTK+LUqCbeoloufUyrGzUjO1mu1Yb6F2flnIR+U6OEF7Q3b697i5cb4dGsgUil+N1
	 4A+sUz4AWGes8aG75HM34wrLfaXnzhTpx1h8nRrisZ6ZEAfQeJWz6GMbKsemth8rCJ
	 0ctRH01JUOze2q2aNvv0lpfUgjEYUmQKBAW0ssA/f6/GpqprvlYcDt29AZt3fycC4z
	 viU75u6RyYep/VmNEPhFqTQPNXps2lUmW4wSeRTXE8lFtgOs13tONZV3SMWkboZpiS
	 UCshPkXJV8HGr4cu+Sepevmig4kT/Qxf/20P9uwLEYlbzm5aqWKkLrXAEgGYqFuK9e
	 5gGGXhh7D/pJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BDAA380820D;
	Wed, 21 Jan 2026 02:40:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: add kdoc for napi_consume_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176896324310.699622.6761389403594615905.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 02:40:43 +0000
References: <20260119224140.1362729-1-kuba@kernel.org>
In-Reply-To: <20260119224140.1362729-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 kernelxing@tencent.com
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251727-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 1709F50038
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Jan 2026 14:41:40 -0800 you wrote:
> Looks like AI reviewers miss that napi_consume_skb() must have
> a real budget passed to it. Let's see if adding a real kdoc will
> help them figure this out.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: kernelxing@tencent.com
> 
> [...]

Here is the summary with links:
  - [net-next] net: add kdoc for napi_consume_skb()
    https://git.kernel.org/netdev/net-next/c/cd18e8ac030e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



