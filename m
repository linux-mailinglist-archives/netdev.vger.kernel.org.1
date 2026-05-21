Return-Path: <netdev+bounces-290148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCzeNkFLDmrL9gUAu9opvQ
	(envelope-from <netdev+bounces-290148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:01:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B82C59D1BE
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46C6130DB949
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FBC1A3029;
	Thu, 21 May 2026 00:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIk9kuUe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B814F1D7E5C;
	Thu, 21 May 2026 00:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779321609; cv=none; b=VvgaW/8HL+l74xgWU/ox30NNLyErjCgUnvKb5a/L3cccE2bFNHUIKtSThXwADrweJYlWQljC3X6/bMl0qiPWtsdJXKVcXzziTry/PW/uZnWu2KyxqIJO2rzTnTdttvIL5BB1ZtM9tcLTwBRr9hx+vdWwRIvS/XWykMeBm22lhXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779321609; c=relaxed/simple;
	bh=fvkoiWLqV2/AptBwE0QVbp8LEjocrOonHt2DoKyP0LU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oaoTORbInb2tkcO2xJtCSOE++37zpIFF3AjhYYzTD37SXNuMcC75YK3q95Opwp906XNYJCy037QSpg7N65WOvTCYyUfxZ0AgaJWFNVJ3ZDJXz7x/Xkok9raHWQAitPKAMj7kp28GpS1pGBE7TAq1ViVrcYaR19SGNByt2C4bJCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIk9kuUe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6811F000E9;
	Thu, 21 May 2026 00:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779321608;
	bh=LsjMo0IjMTvjV3N7GOiCep0H1iVUsfbJcQ/bsHmu/dU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cIk9kuUeovnhtjiM0dMBsReE4YCqQ/IlfipOonw2nZJB5sszUoKV/IbZ3F/2hlrKl
	 qKiTkSglltMdeeXnxW75omGhmhE+RchAjSCJx0rd8Rztw19o+NVJXOr2iasq9KaapV
	 oZg7hkWR9Yb/6nrblNKjv5PyxN5kG6I1UpOeNJr0zBR5za+tQ35oXrvEzTBj1h3ci4
	 Cu47hj62UZSVKBtbqcdrg4ODn5aoGI+fiBQzwBsiScf97ZFv2SDrJGWQffXH52g5H6
	 gr/61ECN8utgJsmIG2vCevdBsx7M/+VA9nfwvWX+wvlGa7GfoaZxGVlytl7xgp6L1f
	 LKeBjj3vwdqVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A363930C25;
	Thu, 21 May 2026 00:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net] net: ag71xx: check error for platform_get_irq
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177932161838.3801238.12987420755249059552.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 00:00:18 +0000
References: <20260516212616.11758-1-rosenp@gmail.com>
In-Reply-To: <20260516212616.11758-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, chris.snook@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 o.rempel@pengutronix.de, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,pengutronix.de];
	TAGGED_FROM(0.00)[bounces-290148-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5B82C59D1BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 16 May 2026 14:26:16 -0700 you wrote:
> Complete error handling for a failed platform_get_irq() call
> 
> Fixes: d51b6ce441d3 ("net: ethernet: add ag71xx driver")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: adjust description
>  drivers/net/ethernet/atheros/ag71xx.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - [PATCHv2,net] net: ag71xx: check error for platform_get_irq
    https://git.kernel.org/netdev/net/c/e7c70bf97e90

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



