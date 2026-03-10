Return-Path: <netdev+bounces-265811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMOBDW9hr2kmWwIAu9opvQ
	(envelope-from <netdev+bounces-265811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:10:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 720A6242EB9
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA1433003351
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA6C175A7C;
	Tue, 10 Mar 2026 00:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCVz/EIL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD511F94F
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 00:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773101418; cv=none; b=SOGQCRe6TBxOTjV7NTgVKKZOimiJ0k8pNh5HjCGVW1DC6rt0Ujg4yS/K5t+OwX8SWFlBj68pS6j4mTiLC1Po7kNwG7+FyGpH2D808w8MI5qgjrqz0gfKCGGYoDws0daygsu2bgiswA5N0s65zcxlVhPJmkBXjpmBsXQ/zGtWFf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773101418; c=relaxed/simple;
	bh=Ab6SCstnqo3a/1ocsJ7f3vdNSYMp70koi8GRvf9A3Xo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jHYxd6lEmhCrlNPomSYUGjCdbSjs3w9njTOZmJIWRghhRhLK1aW79AUHTKOqR3A3bToIhxWZ1xDaf0fahhBBSyvvRFt14KtxvnSpsWX58m7/AMBrD3VPlDwPnXzxq2iOb2yqhqFON8/M04JZkp50QGmcIdQIqrtdbg/7qLrBWNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCVz/EIL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F5CC19423;
	Tue, 10 Mar 2026 00:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773101417;
	bh=Ab6SCstnqo3a/1ocsJ7f3vdNSYMp70koi8GRvf9A3Xo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CCVz/EILsjSDL5UqRbNLdNa76qVTiiASO5L/uibP2bpszuf0au3oDg77EYppMF+JF
	 GGQWBj/zH7h+bipjEsNg4vlpIGDQxhwcc4QAsqbAMFVc1zImwLwzS1mayM9j5Dv5s0
	 rKOEkB4zufMfJeHPK96B2oMiDt9cqD0iVJ3Hv04sTzz0CJVKBeSPByZO3Vqv99rTLx
	 vMeIcxIghTeIxBDZucyB3UY0HMUZDufZXkOjRxwqSeV8t8WCh61cqEZvrVcZwdfEW0
	 9IADxiL3sc73NsIibw37LBLZinQwc643dpyrUOLcbPzb8crmF21O6aXRfSQ5YTm2ry
	 AKOPxnKdpCjCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EFC3808200;
	Tue, 10 Mar 2026 00:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/10] tools: ynl: convert samples into
 selftests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177310141455.1987579.7739368986439051475.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 00:10:14 +0000
References: <20260307033630.1396085-1-kuba@kernel.org>
In-Reply-To: <20260307033630.1396085-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, liuhangbin@gmail.com, matttbe@kernel.org
X-Rspamd-Queue-Id: 720A6242EB9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-265811-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Mar 2026 19:36:20 -0800 you wrote:
> The "samples" were always poor man's tests, used to manually
> confirm that C YNL works as expected. Since a proper tests/
> directory now exists move the samples and use the kselftest
> harness to turn them into selftests outputting KTAP.
> 
> v2:
>  - add missing ASSERTs on allocation failures
>  - fix the exec in the bash wrappers preventing cleanup
> v1: https://lore.kernel.org/20260306020901.524105-1-kuba@kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/10] tools: ynl: move samples to tests
    https://git.kernel.org/netdev/net-next/c/e0aa0c61758f
  - [net-next,v2,02/10] tools: ynl: convert netdev sample to selftest
    https://git.kernel.org/netdev/net-next/c/285804d63f35
  - [net-next,v2,03/10] tools: ynl: convert ovs sample to selftest
    https://git.kernel.org/netdev/net-next/c/7e3effbc7627
  - [net-next,v2,04/10] tools: ynl: convert rt-link sample to selftest
    https://git.kernel.org/netdev/net-next/c/5c3206786c2d
  - [net-next,v2,05/10] tools: ynl: convert tc and tc-filter-add samples to selftest
    https://git.kernel.org/netdev/net-next/c/6cf8fb4722c3
  - [net-next,v2,06/10] tools: ynl: add netdevsim wrapper library for YNL tests
    https://git.kernel.org/netdev/net-next/c/7a95e5256293
  - [net-next,v2,07/10] tools: ynl: convert devlink sample to selftest
    https://git.kernel.org/netdev/net-next/c/db20b374e7f7
  - [net-next,v2,08/10] tools: ynl: convert ethtool sample to selftest
    https://git.kernel.org/netdev/net-next/c/1419fbf5a817
  - [net-next,v2,09/10] tools: ynl: convert rt-addr sample to selftest
    https://git.kernel.org/netdev/net-next/c/e7a39b8f5fcf
  - [net-next,v2,10/10] tools: ynl: convert rt-route sample to selftest
    https://git.kernel.org/netdev/net-next/c/aa234faa5a4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



