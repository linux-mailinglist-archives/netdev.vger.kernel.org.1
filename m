Return-Path: <netdev+bounces-277241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNRsO5tz2GmodQgAu9opvQ
	(envelope-from <netdev+bounces-277241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:50:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 858C13D1F27
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF20E3028EA3
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 03:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35852329C7B;
	Fri, 10 Apr 2026 03:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQgoyPqF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C5E3246FE;
	Fri, 10 Apr 2026 03:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775793031; cv=none; b=ZoovHaYKalKeTm6HV6mLBOKzUd34UzjLARQ46JlklS2P66iB03k+2sA1WJSAQrmH1FlmON/tkCPRydayfW6E38PuxXvTQIwUy/qWqH561tsr07zDHUox7tWAvESfX+zZQoIDh1H358JqpM6hAomSezl5x7HxX5Ro0L4SatL/gN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775793031; c=relaxed/simple;
	bh=Os8XMvrK2K7MjWaFPAKA6zXmAMqAIfrIjK3tiFZYKg0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LXtA3GNu+8o0W9HZinu+FKp8S2go4moAiqSiKI40MH1OGnD7OFlBCWYc5iqwcHTxq5U7t9ECJOmQm27oC6cZZOVXK3Y4Xe2FBXn2klBCNfTo1GyP4VHEwhXtLU26pEwH4wNk7dsx7rOk5sTeHdT/q+SSVIVrcan8wvHlhQurOeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQgoyPqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFD8C19421;
	Fri, 10 Apr 2026 03:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775793030;
	bh=Os8XMvrK2K7MjWaFPAKA6zXmAMqAIfrIjK3tiFZYKg0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YQgoyPqFVWd1/B83yQuQVy8nxdniPlr/gkX1gTRoVgunmwhVcUJOjPmvMIOHSlPzu
	 fiEGgywt0novBG+k8Z/ctPu+36/Mayuhpm0o8QOKXyKwP4AqTS89eWJ/2aQG+n2hBc
	 YnEt7cplKZrrBko6bweN6NRLAVCnFtAW2kCmStPWoTRpGbBYyZ4bJGN4s5RXjIVKef
	 Q5Ks410+lAZhU4DjXzRZjsad5qfRq3qr/QGJpfHf4d55FiXYdNrCQEnmN0FrmdJhZ3
	 7eKa584ehrhzJIti3kjCoOqAm1ycRfjcajbPg57rieVM6IM37ZhNPLF0fLnhnAErVl
	 AYAm4Rt9wc0yA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C473809A22;
	Fri, 10 Apr 2026 03:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl: tests: fix leading space on Makefile
 target
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177579300580.1857305.12755877628643246332.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 03:50:05 +0000
References: <20260408-ynl_makefile-v1-1-f9624acc2ad9@gmail.com>
In-Reply-To: <20260408-ynl_makefile-v1-1-f9624acc2ad9@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-277241-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 858C13D1F27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 08 Apr 2026 15:19:05 +0800 you wrote:
> The ../generated/protos.a rule had a spurious leading space before the
> target name. In make, target rules must start at column 0; only recipe
> lines are indented with a tab. The extra space caused make to misparse
> the rule.
> 
> Remove the leading space to match the style of the adjacent
> ../lib/ynl.a rule.
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl: tests: fix leading space on Makefile target
    https://git.kernel.org/netdev/net-next/c/42f9b4c6ef19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



