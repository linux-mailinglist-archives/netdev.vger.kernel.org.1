Return-Path: <netdev+bounces-267247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHR1Otphs2lcVgAAu9opvQ
	(envelope-from <netdev+bounces-267247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:01:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4974427C1F5
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A948302A2EA
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 01:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CA43242A9;
	Fri, 13 Mar 2026 01:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grigSS9W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42302D8DC2;
	Fri, 13 Mar 2026 01:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773363614; cv=none; b=oNmL6NTGYPL90RWP7naDCqoT0pXXNN8c/QeFtWRrKEl/AbirMfdWF6cVvrJyxjhrOgWzK3mvF2Rp3kcc5mENjbRdTNwFzS5/gUqlzaLBC4cYbsvotl+vrgHaMR513RyKYR5DTDfNnUKGmyJ5TmEOP5Oz3tHzO2diNi2XNzOYTeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773363614; c=relaxed/simple;
	bh=WypQPQjNbTac4E343vo0IQ6gJSSuwLEY05p5Yyk1bxw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SIupzSy08Ylz0gwszgV1n8l9RgxbpdjPru5rPDJ9hksrySnlJce7513LnT7ruLgSFjNGTY2rfKnNTrqWNuv0RKAtLbiYi3/jGcXYt7OGTKUMfZD7YE+zoOq6CwbXZlqE5/lRmITciyH+r+5bsz/3RPegPGNf00GpcV1WNOCJ6p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grigSS9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FFFC4CEF7;
	Fri, 13 Mar 2026 01:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773363613;
	bh=WypQPQjNbTac4E343vo0IQ6gJSSuwLEY05p5Yyk1bxw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=grigSS9Wg3DmgBA0HCuglYA6zInHV+FbI9F9Ksil4vdak35LhLNv0v1vTHz3BWe2H
	 JJbyalmK47f2N1Yxers28dEThtlZdZwSY9S2w4QkTsmFjl05kuuqHCQi14zSYqA0Jv
	 3P3OzMhr3k0il/zHLSylWhmAgAQsK+CApCUqm6+ts0XdHyYh69Wx50PQHTpZluAepZ
	 Vh6NLiB8TaGoz2gX+aZv9VzOhX9Djf4gNkWUq/dnGxmjZuKOdieWsBAGq4gzfrVntU
	 kdKxLN+/mP4KZZXF773HU0Fo9/B56rCbhWwyzKe/f2p6Eb5DhzxlKjVXzbLkIIvMJX
	 IQM4qMAYttFFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA1A33808200;
	Fri, 13 Mar 2026 01:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] docs: octeontx2: fix typo in documentation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177336360830.619871.1748214746515221954.git-patchwork-notify@kernel.org>
Date: Fri, 13 Mar 2026 01:00:08 +0000
References: <20260311030450.8461-1-shravy112@gmail.com>
In-Reply-To: <20260311030450.8461-1-shravy112@gmail.com>
To: ShravyaPanchagiri <shravy112@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, sgoutham@marvell.com, lcherian@marvell.com,
 gakula@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267247-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4974427C1F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Mar 2026 22:04:50 -0500 you wrote:
> Fix spelling mistake "Crate" to "Create" in the documentation.
> 
> Signed-off-by: ShravyaPanchagiri <shravy112@gmail.com>
> ---
>  .../networking/device_drivers/ethernet/marvell/octeontx2.rst    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [v2] docs: octeontx2: fix typo in documentation
    https://git.kernel.org/netdev/net-next/c/00699d944836

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



