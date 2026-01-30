Return-Path: <netdev+bounces-254995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMtsFxIdfGmAKgIAu9opvQ
	(envelope-from <netdev+bounces-254995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:53:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A4598B6985
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 85666300BE0C
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 02:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27556343D71;
	Fri, 30 Jan 2026 02:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbdyesc/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02086342CBB;
	Fri, 30 Jan 2026 02:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769741446; cv=none; b=fwF4EnhBbWRgQqI+dnrgqp8pHTZ34Z3kiamjvmZnUZcW2t0xh9vYMbUfXp4qGlzj01ZCKNx+PrVG0irCT240tHY1+o74aKOyki0kMXDrONj5rTnQ+TiwsY5msNLTBbln7bfMIpc+wXxMTcnywvY8oN0MJhkO8eqKHH7QRD8/yBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769741446; c=relaxed/simple;
	bh=mhuMetPpX87bX0Sl/nc1fYnEUf2eQbwFt68DLNLMwqs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BqYo2nBTdrZQtUoGhrUgLVZLqVw/7J3fFe75JZyGo9eh3Dz/7fdvQwefYM+mQuiMSrT+2piU7xCiZZdhxQWBmK353Z/UQ8K2cUfwcuTyfF0e63e+qt9EJFygMKLwqQ2TayazQDcdiAcp2WawMZSMJ0AJCVB+TNbTJthMe1niFoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbdyesc/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4872C2BCB5;
	Fri, 30 Jan 2026 02:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769741445;
	bh=mhuMetPpX87bX0Sl/nc1fYnEUf2eQbwFt68DLNLMwqs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fbdyesc/D9u6ia2BNG2w25ukF0vUneWNMLccBMdSzNVor96IdsI1e8J3Nep0wr8Ow
	 tHp6RfwUlrlq9xKyuv5NWc+GiZMPfjgDcq9COc5pMksCdXklOsMrIvsUofUXiIlwKt
	 oqRlnZg2QGu5dNDqrWK78Z59Lww/6XlW8Q3PwIpmboa+JqQaHaYcXXzhC3W+vTo4Ke
	 xu3n6H34E1O/RPVjQctfFSJwdcgg9iHKAMoY3ux+8wTdgaXD65+7YSoQ6/1uQn8jgC
	 YrWgia69uzWyNYKWissGZprJ2Iq8slw9jSahoXwzoKt9tkjE5S4Qugv75qJL1GYYuE
	 lS3hiZ0bO9rHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8C6B380CEE0;
	Fri, 30 Jan 2026 02:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] octeontx2-af: Workaround SQM/PSE stalls by
 disabling
 sticky
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176974143835.3149010.13587073395074604681.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jan 2026 02:50:38 +0000
References: <20260127125147.1642-1-gakula@marvell.com>
In-Reply-To: <20260127125147.1642-1-gakula@marvell.com>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, sgoutham@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254995-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A4598B6985
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Jan 2026 18:21:47 +0530 you wrote:
> NIX SQ manager sticky mode is known to cause stalls when multiple SQs
> share an SMQ and transmit concurrently. Additionally, PSE may deadlock
> on transitions between sticky and non-sticky transmissions. There is
> also a credit drop issue observed when certain condition clocks are
> gated.
> 
> work around these hardware errata by:
> - Disabling SQM sticky operation:
>   - Clear TM6 (bit 15)
>   - Clear TM11 (bit 14)
> - Disabling sticky → non-sticky transition path that can deadlock PSE:
>   - Clear TM5 (bit 23)
> - Preventing credit drops by keeping the control-flow clock enabled:
>   - Set TM9 (bit 21)
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-af: Workaround SQM/PSE stalls by disabling sticky
    https://git.kernel.org/netdev/net-next/c/70e9a5760abf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



