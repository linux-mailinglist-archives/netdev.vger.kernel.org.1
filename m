Return-Path: <netdev+bounces-276792-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDswKrYR12khKwgAu9opvQ
	(envelope-from <netdev+bounces-276792-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:40:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 557AF3C596C
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4182E300E2BA
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 02:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0EB36D4EF;
	Thu,  9 Apr 2026 02:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8j97VF0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9476636AB7B;
	Thu,  9 Apr 2026 02:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775702448; cv=none; b=n8Sh2Y17kj8qdsAH6Sy+YE87NZa2riEcOxr279+GBLMbxQYXaVJHe4sMcCcHW4DO8RhZXIQXQkgLSAznUedHNgz0KNsyv44+FJmQOkbkGtkweDZbl9unNYga6zPwyME2dXPkT5nT21UQ8kTGgPJe2SloJCqiu1ZhruA88rROl9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775702448; c=relaxed/simple;
	bh=+Noc+9+EBGnV4khiWUb560zb5tB/H+l3DU7nWirRqvg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ex/4o/LAxSExKxHZ/BShGPtxn0duXl4xgS7VYxxifCkXzhvWehjfl7hfwKCAOnXNJVl+WRNAizxhCkQB6ycrYmr4Cpr4dph/9QyQeZkukevRozEmGlo3GUQxdc/QObHpEHmUTBf/P5KFwovlmEgZHeuRMpDfOP0FyCKUvk7lxlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8j97VF0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1701BC2BC87;
	Thu,  9 Apr 2026 02:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775702445;
	bh=+Noc+9+EBGnV4khiWUb560zb5tB/H+l3DU7nWirRqvg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G8j97VF0BOImnoRaA+wI27G6KIAkgeSaeCYatzDRk3J3XEt8zZvbj1t9a0UklLHV7
	 /DTgOWAO3sUwGSxecVZHw08WPcrmXhX9nWs9lffnfzzVew3zLOrbEcO5/QiAmQfak6
	 AWDOoCTOjtvMSFVmGJfb8P8vOMy+3tzJPeGLIdlvjzeQ865U7mTB6vawFGlOFZJXuG
	 +MDDgpngrXmH+bX7SRYpqov8lUZ39Ueihx7Pml33EFLDxxUEpJKSWCWzPd0t81b3Yf
	 +fZI0AfvzUlGKiomi1/Ayqi+UgR98Tbaitsgs1igguoJaoV9oUAaeAQq580ti7yaa1
	 YdLfvLnAEmbQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE3B3930793;
	Thu,  9 Apr 2026 02:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] mptcp: autotune related improvement
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177570242103.964658.15750765856068467028.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 02:40:21 +0000
References: <20260407-net-next-mptcp-reduce-rbuf-v2-0-0d1d135bf6f6@kernel.org>
In-Reply-To: 
 <20260407-net-next-mptcp-reduce-rbuf-v2-0-0d1d135bf6f6@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 fw@strlen.de, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276792-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 557AF3C596C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 07 Apr 2026 10:45:16 +0200 you wrote:
> Here are two patches from Paolo that have been crafted a couple of
> months ago, but needed more validation because they were indirectly
> causing instabilities in the sefltests. The root cause has been fixed in
> 'net' recently in commit 8c09412e584d ("selftests: mptcp: more stable
> simult_flows tests").
> 
> These patches refactor the receive space and RTT estimator, overall
> making DRS more correct while avoiding receive buffer drifting to
> tcp_rmem[2], which in turn makes the throughput more stable and less
> bursty, especially with high bandwidth and low delay environments.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] mptcp: better mptcp-level RTT estimator
    https://git.kernel.org/netdev/net-next/c/d2000361e4dd
  - [net-next,v2,2/2] mptcp: add receive queue awareness in tcp_rcv_space_adjust()
    https://git.kernel.org/netdev/net-next/c/7272d8131a9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



