Return-Path: <netdev+bounces-275806-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPkJNONb1GlrtQcAu9opvQ
	(envelope-from <netdev+bounces-275806-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 03:20:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0023A8A8C
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 03:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E2703008201
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 01:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD761E0DD8;
	Tue,  7 Apr 2026 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+h9B8pu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75931A9FAF
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775524829; cv=none; b=F2ecI+mLCf05ZQMlnE+MUbIcrNTtzK1BJ61doQuv3Jve35Ml5j/CM3zM9ZlVbsYOIR8iYVsTy4eRVPaJ8FaB+LrG17MCSUdc7f+zJfD/3gRNrsxPmSdSHtNWTugi1qrNUovI97QPvblsE3Nr6jnIjegHSf5G1LKQ1JbQY4yj/38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775524829; c=relaxed/simple;
	bh=5xuAXG5/CDmSgHqJ25JDLvkv3EFCewW2mig86x9U5As=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SZjXfthg+O2pC1vU/x0hJSM6J7kMlBeS7CPZK+RL8DwAbUJJEhz2Y94ixQ9WswmKFSebmPnGM5HN1kJP2+Cb7fHP8Kkr3Aw8uMr/g2CbCPv6O0oXj0cJLyi6XS0pzlNegTHrrHr9jgTdAMr2vbFOcb3Za2Bczn1hIKUW/913fG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+h9B8pu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F849C4CEF7;
	Tue,  7 Apr 2026 01:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775524829;
	bh=5xuAXG5/CDmSgHqJ25JDLvkv3EFCewW2mig86x9U5As=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V+h9B8pu3EKTb+MmlIkihMUL0QaDwBcSvS/PjWkD3y1bCay5DYOZ8ZwIh8gtfheE8
	 vEcWLCrBWQNkyPE+dGVdeVphQIEVxZHpfDPw/gS+a3hZ2MgkS8ntwHI//iKs6WtQkR
	 Ep2S/EvHYcw5tNb62EhAkejCbULO01GU/u56fEv1zXrjsoWmvvAShtUBnx++1eRjxw
	 cKwOyyDGpbsLcAuwP7QAb/WBHosLv3L1k7J5hnjiHO6XZl6qxHYLmDnZicHxRXD7+6
	 uSnjhlMWaTGUicj+ZNoSA7gT9/zFiy6MUMFCXMjTuFpa/o8v6WCafv6rw/H/MVJFa4
	 DeKRTE5XugL1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC7A3809A28;
	Tue,  7 Apr 2026 01:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mctp: tests: use actual address when
 creating dev with addr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177552480805.3328957.3665125945304556729.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 01:20:08 +0000
References: 
 <20260403-dev-mctp-fix-test-addr-v1-1-b7fa789cdd9b@codeconstruct.com.au>
In-Reply-To: 
 <20260403-dev-mctp-fix-test-addr-v1-1-b7fa789cdd9b@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: matt@codeconstruct.com.au, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-275806-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F0023A8A8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 03 Apr 2026 10:21:04 +0800 you wrote:
> Sashiko reports:
> 
> > This isn't a bug in the core networking code, but the addr parameter
> > appears to be ignored here.
> 
> In mctp_test_create_dev_with_addr(), we are ignoring the addr argument
> and just using `8`. Use the passed address instead.
> 
> [...]

Here is the summary with links:
  - [net-next] net: mctp: tests: use actual address when creating dev with addr
    https://git.kernel.org/netdev/net-next/c/70e32aadb5ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



