Return-Path: <netdev+bounces-286911-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KELkKWKHAmrVtwEAu9opvQ
	(envelope-from <netdev+bounces-286911-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 03:50:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D69A518741
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 03:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AE2D3036090
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC342343BE;
	Tue, 12 May 2026 01:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKcTq3YK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BF338332D
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 01:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550594; cv=none; b=AYZFmOPBezV8PkL40jaGzCWYDPJcq66tzpalnrYz5/Ek4y7RkQ2ruE88WuKwDvF8mZA/tc9UTlYiRilemdgNRxF/1UFqhjvuPzcaqlf71PFx3K40HU6KM5JTAY9JgCdXh/ZEEWQqJnjYgruEhehh8Uybv4zgv+ytBHeZ5aEmBkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550594; c=relaxed/simple;
	bh=RKSvl7avxgkgH3Kx9qsK1+q9pA3+RzkjjndzAlNKrkU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MFfSySmVAZDtElsNdPXU82iPj8qNUE7gciCiBzch6G7sGA/f9Hv19Ctsk1wUV9T7qRbjswkXXp0TqB+doG8qIbulOoTpOuUAGuRf7/X7IAjNADuE0EB3IiIAt1+TDhiELr49AB9hfttCOTjP5E3DxEJFF1rCn3d7tx4ZRr3zNis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKcTq3YK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6F3C2BCB0;
	Tue, 12 May 2026 01:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778550593;
	bh=RKSvl7avxgkgH3Kx9qsK1+q9pA3+RzkjjndzAlNKrkU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nKcTq3YKlnZdQpv4VZm1ehj29l5yWNckPzOPhaQPX05jCJpI9W0QTVAQWjKN/5mZ2
	 o5+aWojWgaLjOQXjBTriMog9tyG8RCthMg4L0E09RoTifsZJznr7wTg6RGpwlg0h1H
	 iaanrjYwjyJr5kUqoQeHVGdhXhLgNa/vXZOMGhUxbWJTcrmC7appdFvpb3SLyPVIO/
	 y/sqgQ7QyuZNh9wFQgiQ0VZwTjtj+osc1pbQWzBMfu2/j3namlbMyKBnBtZqLUwZ6U
	 R1opkZ+rxQgDH3fBlkaAuems1jUv7ZLM9inRik8il0qegFzri3AIg6ROtNV1AO+YBN
	 7Z6wtKRfnjiVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDCB39308E9;
	Tue, 12 May 2026 01:49:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ethtool: fix missing closing paren in
 rings_reply_size()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177855054004.2567715.4961349489571823460.git-patchwork-notify@kernel.org>
Date: Tue, 12 May 2026 01:49:00 +0000
References: <20260508125412.189804-1-cuitao@kylinos.cn>
In-Reply-To: <20260508125412.189804-1-cuitao@kylinos.cn>
To: Tao Cui <cuitao@kylinos.cn>
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, vadim.fedorenko@linux.dev,
 leitao@debian.org, netdev@vger.kernel.org
X-Rspamd-Queue-Id: 1D69A518741
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-286911-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:email,linux.dev:email]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  8 May 2026 20:54:12 +0800 you wrote:
> sizeof(u32) on the _RINGS_CQE_SIZE line is missing its closing
> parenthesis, causing nla_total_size() to absorb the subsequent
> _TX_PUSH and _RX_PUSH entries. The resulting size estimate
> happens to be numerically identical due to NLA alignment, but
> the nesting is wrong and misleading.
> 
> Fixes: 4dc84c06a343 ("net: ethtool: extend ringparam set/get APIs for tx_push")
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Reviewed-by: Breno Leitao <leitao@debian.org>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ethtool: fix missing closing paren in rings_reply_size()
    https://git.kernel.org/netdev/net-next/c/73d587ae684d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



