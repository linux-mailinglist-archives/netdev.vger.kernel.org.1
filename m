Return-Path: <netdev+bounces-259381-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IH9aAU1elmnaeQIAu9opvQ
	(envelope-from <netdev+bounces-259381-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 01:50:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF2415B3FA
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 01:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 827343004D0D
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 00:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DC519C553;
	Thu, 19 Feb 2026 00:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A58uQCZD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8146514B950
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 00:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771462214; cv=none; b=bxk/vBuRHwmAN1d+hSYrWXJ72J5IZ1rmwB/pvVXxYT9oov3kHlqH8vBNskwVhdBs4nhZeejVDujCTsQbPiPvNJEq5MjISed1dxx9dcQ5BJkcZ4LNvsagK+m0n4GK4GkLKsfKET4iUCoXcG49UX3JUQFNi/9W2pvwui1r9P8MJt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771462214; c=relaxed/simple;
	bh=tPc8i4DHmTtgGcoimT2DYgQ54rjfJz8241PdtTjsj+8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s694QdA0R9xSQWeYg5HFP0i3CgOru9Jy3wKrITsBz8QXyadYFRJnlLRIC7LcrWu/Y5eCpB6bIxt3yVcKfouwIctCLOpWCG2HysLqK6yuXIsmfftKlXyxXntMp8CUo1+6LYeQ2O9sj2GIzVDm5dlDww3Sg2uEZuIBkaV8DIbFL3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A58uQCZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16834C116D0;
	Thu, 19 Feb 2026 00:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771462214;
	bh=tPc8i4DHmTtgGcoimT2DYgQ54rjfJz8241PdtTjsj+8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A58uQCZDSaiZjgTH13ArMOVFWDYCJbblY8eIjZy7NiOdSBhjEdjHTgXny+eBaJFQ9
	 nn+xRHE5z9JVhwc8r7h9hjYycxc9xsg5VRQToeHc1zcONH+VDtiF7aWNzlJ52kKofa
	 E1YJOVaZwRqueYuy2IoXAxsJEY17IWqQhY8RLQtnsjUMju7uiOguTaIv0Dq2PVrISZ
	 zbiAESjUaTuHs48jbzejf64sW/8tSI+E35r7nqLicp03L7z7x+TOfplw7k1i4pXnpa
	 rt0WjEbcG6n4Luk5M8GRtJ41ATGjX1zSy6C/XZnDBv5dpZdJCEW2/1Rj7dswjsrFQH
	 UPqf5eHVbkEKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 852F0380CEE0;
	Thu, 19 Feb 2026 00:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests/net: packetdrill: add ipv4-mapped-ipv6
 tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177146220533.1618281.4180487651837873905.git-patchwork-notify@kernel.org>
Date: Thu, 19 Feb 2026 00:50:05 +0000
References: <20260217142924.1853498-1-edumazet@google.com>
In-Reply-To: <20260217142924.1853498-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, willemb@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-259381-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ksft_runner.sh:url]
X-Rspamd-Queue-Id: 1BF2415B3FA
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Feb 2026 14:29:24 +0000 you wrote:
> Add ipv4-mapped-ipv6 case to ksft_runner.sh before
> an upcoming TCP fix in this area.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  .../testing/selftests/net/packetdrill/ksft_runner.sh  | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net] selftests/net: packetdrill: add ipv4-mapped-ipv6 tests
    https://git.kernel.org/netdev/net/c/570e4549f632

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



