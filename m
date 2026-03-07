Return-Path: <netdev+bounces-264978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGXwNa1xq2m6dAEAu9opvQ
	(envelope-from <netdev+bounces-264978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 01:30:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4114C228FD0
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 01:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB40B302D0B1
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 00:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F21221DAE;
	Sat,  7 Mar 2026 00:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sl4qheD1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86FF128816;
	Sat,  7 Mar 2026 00:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772843413; cv=none; b=hDrMjrbeKS7Y951ODLv9tRGG53zL7Hj2VPw20Foi7offBH05Rf93cwPoLiifI2aTT/yuIi8MnWvdYGjTlQirlhsesT+1sFJs/7MVJHeixexyW2w+uSIARYQ1skpeRxtkqx2MOsyUnT5yR8EK5wEmNT0YE2bDf++0er5o8g2lKDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772843413; c=relaxed/simple;
	bh=X3NEC6v9ddbHBcjUEGagcVK0P/7ARbgkMKzA2JYy/l8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IfQNrKKSY+q0arrFgKG0zc3gzYSWSeRcMPa8rs+d/vOe4v9Bstn3HP3LY5yE4XO4stia1mi/A9R0r5f6vC0nkMo0FWKX3ol5NcIpOWHWLnWQcsMgh94/w/HqQVxhW4gubB0winkTLRfJbcIUam5yccToqO2yI24RrGNn10gqW+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sl4qheD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67335C4CEF7;
	Sat,  7 Mar 2026 00:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772843413;
	bh=X3NEC6v9ddbHBcjUEGagcVK0P/7ARbgkMKzA2JYy/l8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Sl4qheD1Tu/nAwx+UPhmck0gfdPhyDcSk9iYMa5We84kCiuUzv2d3xJZpnUr4UeyN
	 5zoCxnZE2vhPhOQw+WPTbDWubhghP7ncPi4gq1eaABfNhW66mULLaF8YDwbMhCUVb0
	 aJPpRH089s4fKvCFucGc8FyzfQWLoP024fHWR+8B5lH0J7FbU2rlx+f73IHDePefhO
	 DYcScT7ogMfzpe16mZpOoipS/joDRDdCMK+AbC0RXOTd84Pq9w+P5cG+dnTbkCGchM
	 tlrpOG/Pne3tj9dhXMXEdVmrioHLk/Fhnq+osCc5HGsagr7F2h5NJEpcOX3X608Vtf
	 +UPK03STrt6bg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F123808200;
	Sat,  7 Mar 2026 00:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] bond: fix 2 link state issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177284341255.102436.4734534081527319110.git-patchwork-notify@kernel.org>
Date: Sat, 07 Mar 2026 00:30:12 +0000
References: <20260304-b4-bond_updelay-v1-0-f72eb2e454d0@gmail.com>
In-Reply-To: <20260304-b4-bond_updelay-v1-0-f72eb2e454d0@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 tonghao@bamaicloud.com, razor@blackwall.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jay.vosburgh@canonical.com, liali@redhat.com
X-Rspamd-Queue-Id: 4114C228FD0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-264978-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 04 Mar 2026 15:13:52 +0800 you wrote:
> This patch set fixes two bonding link state issues:
> 
> 1. Broadcast mode incorrectly sets usable_slaves, causing updelay to be ignored
> 2. BOND_LINK_FAIL and BOND_LINK_BACK are treated as invalid states, generating
>    confusing error messages
> 
> Here is the reproducer:
> 
> [...]

Here is the summary with links:
  - [net,1/2] bonding: do not set usable_slaves for broadcast mode
    https://git.kernel.org/netdev/net/c/45fc134bcfad
  - [net,2/2] bonding: handle BOND_LINK_FAIL, BOND_LINK_BACK as valid link states
    https://git.kernel.org/netdev/net/c/3348be7978f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



