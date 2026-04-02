Return-Path: <netdev+bounces-274319-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCRuO07PzWnghgYAu9opvQ
	(envelope-from <netdev+bounces-274319-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 04:07:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 511743828A2
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 04:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C22830E1F20
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 02:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45613385AA;
	Thu,  2 Apr 2026 02:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnaQezIW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9224329B78B;
	Thu,  2 Apr 2026 02:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775095236; cv=none; b=lq1wfgzQJpsVQS64eaFUXeXhw+jWr9PGZkUPstvtAt3rcNruVbp71t55A5jsZzrUSAAn1p4CQe5pyaa4NHaLh8r8KA+6ymWKpGlR/ieFZNX3RqOfdmPLd5mntq/lIHhlgDnxtr60gGc3dNj5NimOcvyETCloNyaxHyd+kMMCDf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775095236; c=relaxed/simple;
	bh=wx/frtVYXirsruXjkDHmEsOKYVZ0u1QIPf+L5bguvOg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ejjYYdUAXKD/06el4l4QujAjkszsG4c7oQ4Cwx5kLwtpp3JynXCIDmokETj0o+YBNIBVZ37tz+vohAQlTbLBvaTCsDIuAXSne4qElyx5ZSmbzZwMeKs9NReJXN2QX9APlQnoPQbEMOeht2BR+EGaSzkixQ/qF9Rojk6s+bttpew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnaQezIW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E56C116C6;
	Thu,  2 Apr 2026 02:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775095236;
	bh=wx/frtVYXirsruXjkDHmEsOKYVZ0u1QIPf+L5bguvOg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FnaQezIW6fP+mfRPYR6Sj9RrZn2MvpQ4m5X7POYc2oS7qWSu00CVdKo4luKZExOF8
	 PvFBO+9FD8gKMFtMYGG1b1u1zc9hfx0Xcui7xZzwgLa+wXRb/KUdApEOI12i7nB1+6
	 /OeIe/NFvli82T2s+V+V03wHhODE329xYqdutBEbiZIi8475l2oc5McUqabQ1SBiDb
	 qB/lnf6CkbYdyGZtxJ6gF/WMwpcf/BJRxFcZ8A8IDuSiBBMoorYCY9zIiWQcvgx2WU
	 V5qMw6kSvOG+LTD25V/eiW1sSREwozjUAUI4jwtphnikdlNddgiKjZE8j0qBI7OZgM
	 pTY+4bMf0JrkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD633808203;
	Thu,  2 Apr 2026 02:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ppp: dead code cleanup in Kconfig
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177509521878.3948497.1504331290696397044.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 02:00:18 +0000
References: <20260330213258.13982-1-julianbraha@gmail.com>
In-Reply-To: <20260330213258.13982-1-julianbraha@gmail.com>
To: Julian Braha <julianbraha@gmail.com>
Cc: andrew+netdev@lunn.ch, pabeni@redhat.com, davem@davemloft.net,
 kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274319-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 511743828A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Mar 2026 22:32:58 +0100 you wrote:
> There is already an 'if PPP' condition wrapping several config options
> e.g. PPP_MPPE and PPPOE, making the 'depends on PPP' statement for each of
> these a duplicate dependency (dead code).
> 
> I propose leaving the outer 'if PPP...endif' and removing the individual
> 'depends on PPP' statement from each option.
> 
> [...]

Here is the summary with links:
  - ppp: dead code cleanup in Kconfig
    https://git.kernel.org/netdev/net-next/c/4cbcf82e26b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



