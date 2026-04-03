Return-Path: <netdev+bounces-275275-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WI/qNxdJ0Glu5gYAu9opvQ
	(envelope-from <netdev+bounces-275275-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:11:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 041F5398F6D
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C29AD300B448
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 23:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0408E38B139;
	Fri,  3 Apr 2026 23:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqGyuTwO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D382E38B129;
	Fri,  3 Apr 2026 23:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775257856; cv=none; b=iNptuwUjIpjqn+gelAIS7nc6D3D4LkawWweC2t5sIKcuUC2NspKYDkiAGLaBbhkIa8XDP01yzbv63lJ+p7fsalXwmIfT9d+RPta5eHBiZsindcjvlCylc0Ubq/n9OyVwWkGD3u1AmaW3Kxki2lT4uT9bX9aAiG4GjghkUbtOtFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775257856; c=relaxed/simple;
	bh=oSGoMTcOSQvAt9pNaDJn9Zh2clvLmn7UDmVHXW4LQeo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FnPYvuHV8MFjLZzAzdGe8tFxKXU7KcN5jPQ+2vurek2vPrZqCtqTpEULlDMaJS4p2rq4GRJkzY24mKogP+GpiaJBnKL3AgQeURKkJMfNwX1jprDFU+p/8KrWobPQAAG2LJW6MFtfT+9yqh8mwOdqRc5eB74bx/RNhVc9g/A8Qag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqGyuTwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758C0C19423;
	Fri,  3 Apr 2026 23:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775257856;
	bh=oSGoMTcOSQvAt9pNaDJn9Zh2clvLmn7UDmVHXW4LQeo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gqGyuTwOv93dMtcVih4m3lOwhZwgWLW8Ozjzp3/3erFqi09SYe4rYCKN0EbhXiXP3
	 /CV4lm+8345tRPHaS/S0osUuzZqn135Q8sDRcrnxg1X7MqFRGFnurAbdm5aKI2OdNI
	 Ygl601BdoyTx8u+CeDD+je35T4r8JeWUiQj8Y3OSZ87OnZrYuvzPZ6yO/HNg8ggZWJ
	 o3z5tXNmKghKEIVW0aSwrYN37yYfdf6qCCShH2BWI9rWhxGcrucvGwnOvggjxDry4L
	 sxNo9AitsU3k8k+oJRttSoM/JfQcWOoMrSfRhOd9TkBF+rRYtV00D8ez4rUcpa402Q
	 EwHP0tiezTUkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC533809A14;
	Fri,  3 Apr 2026 23:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/8] selftests: drv-net: gro: more test cases
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177525783803.1484550.17902714476084600559.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 23:10:38 +0000
References: <20260402210000.1512696-1-kuba@kernel.org>
In-Reply-To: <20260402210000.1512696-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 willemb@google.com, petrm@nvidia.com, anubhavsinggh@google.com,
 richardbgobert@gmail.com, linux-kselftest@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275275-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 041F5398F6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 Apr 2026 13:59:52 -0700 you wrote:
> Add a few more test cases for GRO.
> 
> First 4 patches are unchanged from v1.
> 
> Patches 5 and 6 are new. Willem pointed out that the defines are
> duplicated and all these imprecise defines have been annoying me
> for a while so I decided to clean them up.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/8] selftests: drv-net: gro: add data burst test case
    https://git.kernel.org/netdev/net-next/c/30f831b44a98
  - [net-next,v2,2/8] selftests: drv-net: gro: add 1 byte payload test
    https://git.kernel.org/netdev/net-next/c/436ea8a1b7ed
  - [net-next,v2,3/8] selftests: drv-net: gro: always wait for FIN in the capacity test
    https://git.kernel.org/netdev/net-next/c/d97348474708
  - [net-next,v2,4/8] selftests: drv-net: gro: prepare for ip6ip6 support
    https://git.kernel.org/netdev/net-next/c/5469b695f236
  - [net-next,v2,5/8] selftests: drv-net: gro: remove TOTAL_HDR_LEN
    https://git.kernel.org/netdev/net-next/c/166b0cc6df8c
  - [net-next,v2,6/8] selftests: drv-net: gro: make large packet math more precise
    https://git.kernel.org/netdev/net-next/c/024597cc2077
  - [net-next,v2,7/8] selftests: drv-net: gro: test ip6ip6
    https://git.kernel.org/netdev/net-next/c/9a84a4047df7
  - [net-next,v2,8/8] selftests: drv-net: gro: add a test for bad IPv4 csum
    https://git.kernel.org/netdev/net-next/c/764d0833e795

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



