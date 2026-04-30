Return-Path: <netdev+bounces-282556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDQyDSel8mk0tQEAu9opvQ
	(envelope-from <netdev+bounces-282556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:41:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC84549BCBE
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1C26300DCC5
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 00:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A0721D5B0;
	Thu, 30 Apr 2026 00:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdvxTres"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4301F7575;
	Thu, 30 Apr 2026 00:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777509656; cv=none; b=PoeePxuntotdXsm9Lep7iyh18Zxzv8lLLfRp/fuurMjo/Od4FAnr7ht3pShwNYSYZKkOqAlfJk/c7JnWluZN3FAS3DSGfEEUsdtCJplWjd7iIdhx6y5SgBERyQ/Z5smIKN6u2Ov6os3hifDJLXO4ZMFUOd1D47SI1i8AHeNnR+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777509656; c=relaxed/simple;
	bh=angfAkeLnu0IY3WPxTaEneZs2FY8D5JBHwT8KMtamcM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A8abm8cMztDfleeHbEaeT+KIoIWqskwCnnnyFOvc4p14PSYkiP++fHChagnddBGzJslxSvp/1I2yd4VvBRstghcTNwD1xWSfJhAlXxpwDVsTlt3jFB2L5Y5jLs4hzWa1MNtogFey2DCCU4EXWV1RlbhmFFtMYK5jM1GSZg2mv4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdvxTres; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB995C19425;
	Thu, 30 Apr 2026 00:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777509655;
	bh=angfAkeLnu0IY3WPxTaEneZs2FY8D5JBHwT8KMtamcM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sdvxTresNbkpkFLBhOvEC8LfNSXy+8s3d/VsZem//k5yDoHBa8xhntWJPFbx9hyy+
	 o5A1w4Bwxym6fcGJ/sHpMvg/bsok8F/C5OHAmAH5FbiQbsDgNj1nfVNgs+AZVWnRTX
	 h8VYyRvoKbvfkTG6pe4sSWNjqVa/aXTux5/5v1xksKaHV1r6dQGEiGGMOxbK3MBC1H
	 ZDP+enwAOCzGBkFH6bQiGmck0e+yosJcZQM0sWNkLPm8YTocQe5rG2X0f+ZCpxRnCm
	 872O6Uw0UW5cM0+Ag9hHp79KrkCF/BEFYOyMAd6vHJzhPEt5q1lMJgbBJso+2deMOR
	 s00UTmuB1QqmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC0D3809A2A;
	Thu, 30 Apr 2026 00:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: clarify linters and
 frameworks
 in README
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177750961079.2238701.10504743182027421985.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 00:40:10 +0000
References: <20260428203357.1222611-1-kuba@kernel.org>
In-Reply-To: <20260428203357.1222611-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
X-Rspamd-Queue-Id: CC84549BCBE
X-Rspamd-Action: no action
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
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282556-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Apr 2026 13:33:57 -0700 you wrote:
> Minor clarifications in the README:
>  - call out what linters we expect to be clean
>  - make it clear that by "frameworks" we mean code under lib/
>    not just factoring code out in the same file
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: clarify linters and frameworks in README
    https://git.kernel.org/netdev/net/c/72e9647e2b20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



