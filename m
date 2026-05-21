Return-Path: <netdev+bounces-290147-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AsYOBRLDmrL9gUAu9opvQ
	(envelope-from <netdev+bounces-290147-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:00:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D75059D182
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CA918303A4D4
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721CE1A239A;
	Thu, 21 May 2026 00:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKwk6qrT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D5E3BFE33
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 00:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779321608; cv=none; b=M9P39JW4EnHVrAPaP4q6PXEEqq8lBxnLasM5bfHThjNCp7h8ShHYUd49Sm6D/gs2fkWhjO+qfadeMAQFzKaRSdtlHCu5l0dxaJgomi0ICt0l4hSJO++H/ZMSuQleqMKd7PtmZsoUxp2HY/DugtJO13ON0tDCzmUvYI5KLiHO1Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779321608; c=relaxed/simple;
	bh=zc0Li5klHhN7/CNdLPCIhrhM9DnBGJaHTzdocGIy9To=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dQ7piCNAZLMeDM5FMO1fhfCTcVa2kV1N3iYwzkbhpSAnipVfdulkyssd6/w3cuJ5QUiW0as6makSjPwOF8INs8NTLoNV+cjChVSZhZvnj4PVqzFpHIz/E1kkqHFJGF5cyL6tSwha47tbSq4arlrNbfdd0EZrS/u7/7foGoa3QRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKwk6qrT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA22B1F00A3B;
	Thu, 21 May 2026 00:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779321606;
	bh=L8YPEpjC8kh1+sN/xLvalMqp4jfiL2JMP0WuRdhKZZ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WKwk6qrTTAjg2mocaP6v+pb8NNkYN3wtYHtStsHc27p4ylOhv4LjjRm6D+7wA5TTr
	 fimAU0myegOWWhtL1Ir/qkvPPIIpCSLFC8umOI3Mhg0Ua+Xio9kyAu7r0WvXjDxsTb
	 mKmVcvssd5W9Eo0Cb/kI54j6nmF/2ZED26UiaBiJUYsJfAl87DkZ8Xd5KcEWGxGG9K
	 DyN7tNSydwSxw3JXx8UPaQK9fSgeuecc0gCR7XCyfx9a3hER0gcNLUd6b7o0izKtfd
	 3N15f1GFr2nSTyuuWdQorpnGqlIUb2go7si9Z3AG4POrJ2vbkb/VirO0nZLw8WP/S5
	 OCVb4UzsgMP2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568C23930C25;
	Thu, 21 May 2026 00:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] net: shaper: fix VALID confusion even more
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177932161688.3801238.2683783855893750126.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 00:00:16 +0000
References: <20260515221325.1685455-1-kuba@kernel.org>
In-Reply-To: <20260515221325.1685455-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, hmohsin@meta.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290147-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 7D75059D182
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 May 2026 15:13:23 -0700 you wrote:
> Sashiko reported another pre-exising issue in the previous
> batch of fixes:
> https://sashiko.dev/#/patchset/20260510192904.3987113-7-kuba@kernel.org
> 
> Turns out I over-esitmated the guarantees of the XArray flags.
> Stop using them completely.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: shaper: annotate the data races
    https://git.kernel.org/netdev/net/c/a3442936dd05
  - [net,2/2] net: shaper: rework the VALID marking (again)
    https://git.kernel.org/netdev/net/c/b8d7519352ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



