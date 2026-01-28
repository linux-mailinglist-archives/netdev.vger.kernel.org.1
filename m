Return-Path: <netdev+bounces-254040-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILLvBvJTeWknwgEAu9opvQ
	(envelope-from <netdev+bounces-254040-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 01:10:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C109B955
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 01:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDC2F302B818
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 00:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E5618859B;
	Wed, 28 Jan 2026 00:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+OhCtRj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E16A2836E;
	Wed, 28 Jan 2026 00:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769559016; cv=none; b=giwKMdWBIZzmRrbCkR7znQqhD1ACWLu28xF5cbzwtgT2ycl/T3bC9vPewYMQG8fy7tzb5j7Zh/2uKnDRr8eAwum1XKb2swoN1Ki5UYeEFpON1aOT9sQkiSgS0TFngyRr7mlyvDPbgNwB0TEOnaAkGVXgJVT96SfBdOSzxOZ1hk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769559016; c=relaxed/simple;
	bh=YFywH1NNICjJT9Qan9SX2ws511YbJA/z71q+8XPWPkQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NMAPHvZ2ym+LyqDSpgEZxb9CScowk60esYF+4LM5j+uiBDsui3q08TXpZVKX+Flf2CKypxWoOxv5iOxS1sJyebXO4Oe7octCtRe0Ipl+i7KY7wx+d4aOO/acpaFEkajESK6usx7uHp6w9pMl3En5BWWmc09DkMnr2IwHtUDORCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+OhCtRj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0778C19425;
	Wed, 28 Jan 2026 00:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769559015;
	bh=YFywH1NNICjJT9Qan9SX2ws511YbJA/z71q+8XPWPkQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C+OhCtRjHcY7mZynFuZsKWtjMQT+gzMert3/KPLWyoq2RCibJHzk/cG4Qcc1GEHyl
	 29YqBOuHZ4SdO8gGntXJDnnMbR7X3oj4FpeaYyEbgeBDuQJ6rCIaCS61bhEg3efQtb
	 HqCpXVMISDIkXoL0rYGxQtJi0xgiBFwDzeFVjJuw4qM3hj/u5DvpK34RsHgUkJtEx4
	 0cCtM7CiR95buoaAeHgb/yApJeaTWHzT+lI7AcjDagUs5vzeNZ6CbjNrGr/9IOBAHP
	 XCOiDvpu19jgmYIcPjt/+87hBvaQjdwuxbE3I23NA/O5yoOeGadremK79ujJHKmvBG
	 vGg2sN2EsK/wA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8C5E380AA67;
	Wed, 28 Jan 2026 00:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] Remove low-level SHA-1 functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176955900959.1450890.12872654962892844333.git-patchwork-notify@kernel.org>
Date: Wed, 28 Jan 2026 00:10:09 +0000
References: <20260123051656.396371-1-ebiggers@kernel.org>
In-Reply-To: <20260123051656.396371-1-ebiggers@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, linux-crypto@vger.kernel.org, ardb@kernel.org,
 Jason@zx2c4.com, dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254040-lists,netdev=lfdr.de,netdevbpf];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 69C109B955
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jan 2026 21:16:54 -0800 you wrote:
> This series updates net/ipv6/addrconf.c to use the regular SHA-1
> functions, then removes sha1_init_raw() and sha1_transform().
> 
> Please consider these for net-next.
> 
> (These were originally patches 25-26 of the series
> https://lore.kernel.org/linux-crypto/20250712232329.818226-1-ebiggers@kernel.org/ )
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] ipv6: Switch to higher-level SHA-1 functions
    https://git.kernel.org/netdev/net-next/c/5023479627e3
  - [net-next,2/2] lib/crypto: sha1: Remove low-level functions from API
    https://git.kernel.org/netdev/net-next/c/9ddfabcc1ed8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



