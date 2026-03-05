Return-Path: <netdev+bounces-264106-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOmEHsvVqGkqxwAAu9opvQ
	(envelope-from <netdev+bounces-264106-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 02:00:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FED209A6F
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 02:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 45C743013253
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 01:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6219E22126D;
	Thu,  5 Mar 2026 01:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lx4Ll9Yv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5881A38F9
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 01:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772672457; cv=none; b=sIBGLr4lNHFaqYAZ98KWG/2psedgRCdGRSc7KVBIjjlynCt8IZGYaY/HrGGvJDtYtMoJRnRTM9/MmyUDJ+dW/4jbABb2jnxt+65w/fl0lqOkjOz+IH5UoFWQ86Wi3KiGRrbcnFIJHOF8lBV4Y3rQcs2mVS0YI1Ifll//u+jb+9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772672457; c=relaxed/simple;
	bh=u7mn4LAmSobsIwvvmT/mdYN36xEY635U5lPvBlnE1EI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QJK8p0J2V1vnsLTKNdkJ4dsp/A04XDgv6nGwGU1LgaoBjkYt0hmYy+hbN3DZSqkrGav4lk30Zwu2Vsmk7dWiXDqMpKwDzg5UrTK+nn+I3JauQD3gctO1Z13oyQ8umGc79XxTTxAA9ZkdbumJVoeaCn7Xh0UN5Y3ZPw0wywAFMIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lx4Ll9Yv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D301BC4CEF7;
	Thu,  5 Mar 2026 01:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772672456;
	bh=u7mn4LAmSobsIwvvmT/mdYN36xEY635U5lPvBlnE1EI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lx4Ll9YvNRQA+2oaMTBzbyZrHYf/u2WKUBL8UFsCZOcRcF4rV+731Ws24xrSBHYPD
	 ZDU4DdHTJV5heupqZMf+G9iV9YzxBZ+ZvZJVi7hlZSAasm2VkPP/Nys/ifewoeuVDK
	 TrlHfcanoek5z1iDflYdqRZDBY33qMagrZQNstW0hWp8ZEjhPaqVxXSNNvHEkGn1eS
	 NwYeqQ75MBHz3ueTv7PnQBP/73hjDFjzluYBmn4zUF3ZVgKnLXd2FVQIiByLi1rDdG
	 baO/JSMJsRAXItVHfjxmF3y0S81DpT30b7wy8eEMA/3u3TgRm/Bzd9b33QIUu3KWdO
	 99OC/it5i99Bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDF53808200;
	Thu,  5 Mar 2026 01:00:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] tools: ynl: tests: adjust Makefile to mimic
 ksft
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177267245702.2463633.15275479502756842686.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 01:00:57 +0000
References: <20260303163504.2084981-1-kuba@kernel.org>
In-Reply-To: <20260303163504.2084981-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 liuhangbin@gmail.com, matttbe@kernel.org, donald.hunter@gmail.com
X-Rspamd-Queue-Id: 19FED209A6F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-264106-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Mar 2026 08:35:00 -0800 you wrote:
> Make a few minor adjustments to tools/net/ynl/tests/Makefile
> to align its behavior more with how real kselftests behave.
> This series allows running the YNL tests in NIPA with little
> extra integration effort.
> 
> If anyone already integrated these tests into their CI minor
> adjustments to the integration may be needed (due to patch 2).
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] tools: ynl: rename TESTS variable to TEST_PROGS
    https://git.kernel.org/netdev/net-next/c/d86670b837fb
  - [net-next,2/4] tools: ynl: don't install tests in /usr/bin/
    https://git.kernel.org/netdev/net-next/c/3e90e00da96b
  - [net-next,3/4] tools: ynl: support INSTALL_PATH in the tests Makefile
    https://git.kernel.org/netdev/net-next/c/2bfc36f5ea16
  - [net-next,4/4] tools: ynl: produce kselftest-list.txt from tests
    https://git.kernel.org/netdev/net-next/c/32d6fd5832ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



