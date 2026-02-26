Return-Path: <netdev+bounces-261155-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLyfB6e6n2n5dQQAu9opvQ
	(envelope-from <netdev+bounces-261155-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:14:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BBC1A0635
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E8C03129B3A
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE6938945E;
	Thu, 26 Feb 2026 03:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7hbkQAS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C974B38945A;
	Thu, 26 Feb 2026 03:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772075420; cv=none; b=nJhttmnpIKGhisWucR53Esy/4kamcQa82HLhU7MW0TwImH4Mh7b0E8maVn6SKL1JzHhE9XnNZEQKD7JCcp5r/kSi8LDsQxGoQcW5X1Ep+Pvkydz0s+OQohIDARBBRI0imMebk0EZCIMxqOuBuluB4NfdLY2V1CGLMQIwY/FUTLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772075420; c=relaxed/simple;
	bh=IjXhAYsw4OUQTJMNuPG7lix6YagktwGTXHy5SUxgx74=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R4BqLpSBi+1VksCGUYgMjm5KtOdu4A7l5M7r409NH8ihHfzso9WEvBjJcWU1pk1ntByHbeO8Z1JQDQcwc9GC5db7asQUDEiYn9wAqggJY585z8UdTUwcmqVNl3oy1OXrCEHxKdhFbtK/LEcQ4eGiYRfuMwxr18D7Gls2IkQrtTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7hbkQAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86001C19425;
	Thu, 26 Feb 2026 03:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772075420;
	bh=IjXhAYsw4OUQTJMNuPG7lix6YagktwGTXHy5SUxgx74=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H7hbkQASDOFJWNgtwTVCBJecfXV6Fs53uqEtCidoXgdl9mCSgvPnJq0r6OPxlSudP
	 hj8f1L6Byh8X6GShV0DVx4UwHfnPgSEdJfNmgmdgInJ1Gda2HjGM+3njpiGcHgpM81
	 aCs//BuPAnlJhoivjk0FqDOOD8gTNoML18F3vkaEgZMqQUZCaiESIUTe8v9tpjlq1n
	 +aS9gZ2rGN1ldqYqMGms8rCktbGdWbfBWSTpX9cA+JE4ClSdw+HljC+e8MerY/b6Ro
	 UcnXWWXfe3ajJpdDGJSads+iiwhyobdzCKcVzmadchbeFZRbfI6Sn3ZlN2JRp1UxOC
	 yOvVmQc2qkdJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD69380A94B;
	Thu, 26 Feb 2026 03:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: hw-net: tso: set a TCP window clamp
 to
 avoid spurious drops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177207542504.1014739.4371014505655007281.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 03:10:25 +0000
References: <20260223204030.4142884-1-kuba@kernel.org>
In-Reply-To: <20260223204030.4142884-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 daniel.zahka@gmail.com, willemb@google.com, linux-kselftest@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-261155-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 91BBC1A0635
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Feb 2026 12:40:30 -0800 you wrote:
> The TSO test wants to make sure that there isn't a lot of retransmits,
> because that could indicate that device has a buggy TSO implementation.
> On debug kernels, however, we're likely to see significant packet loss
> because we simply overwhelm the receiver.
> 
> In a QEMU loop with virtio devices we see ~10% false positive rate
> with occasional run hitting the threshold of 25% packet loss.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: hw-net: tso: set a TCP window clamp to avoid spurious drops
    https://git.kernel.org/netdev/net-next/c/6698d6ce6a6b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



