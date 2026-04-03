Return-Path: <netdev+bounces-275271-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKi3NxBJ0Glu5gYAu9opvQ
	(envelope-from <netdev+bounces-275271-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:11:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F52398F65
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34C493040477
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 23:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0CF38AC9D;
	Fri,  3 Apr 2026 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsFoRmCq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B52938AC96;
	Fri,  3 Apr 2026 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775257830; cv=none; b=lyhQ+PZ3va9pR01+KiO8vX2H4RWxSw+xzaqE8B4DKyl6F5dw7+B780io3jQhpWU9ryIuXbsQNziOnuHZcVxoxp4TGIh3a+G1SDiahL7JLTG8e8LoJAnwNpfHXFtWhNV7v9lFyye1xA2iOBZEOtgQJvYumRexteyoz9409Ulr99c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775257830; c=relaxed/simple;
	bh=FPTubZ8PkgV/2G18D1CalrS2xnmPPMNdDF2j2m/uQlg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KL5Em7cQnDh1GKs9Yrz0DqcbxZ2DMZ75tqhaihJ6sC6VqspSO81eRDRTkvQUhXFJ5hCsM4praedZbxbAUwYLSv+IBDdNoJrb4w+gF1ATO3As2lUoQrf6sRnaEewSOJeRI9Br4sQfGIZxTTKOSvpWZkx8WcXiXqilCUNtxzfzOQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsFoRmCq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1A6C19423;
	Fri,  3 Apr 2026 23:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775257830;
	bh=FPTubZ8PkgV/2G18D1CalrS2xnmPPMNdDF2j2m/uQlg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HsFoRmCqyWf9oIPbg8xUamkP73L/y6H13kKU8hw0BxGYDiE7Mat//nDfpInN2SSt1
	 suB3vd9m1bnXF7a0Rpv9X9MfnTqG4e0A/EK5JLyq9z3MNhASdU05yfy7Urfo6yHC4y
	 dn7lSgeJvVTrqtceJrD97mImWc1d0MkeHpbbFCe4bWeVCDxv1CQm7YTFecpGMbccaW
	 ZX6gDgpcasMGfw4EnvxNWmdiA+U6etWbNOjNAja3dbRIn0jFXGI9oUAjj654l9z2sz
	 O7bLv9SJpY9+2Y5R0MQlAAxqB7DVoEQB7VhhTdSAtuTXkgeTBhsc+wHSk4amf0+lSJ
	 8mYvzcqylp5jQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9D853809A14;
	Fri,  3 Apr 2026 23:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: increase IP_TUNNEL_RECURSION_LIMIT to 5
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177525781153.1484550.12909055678943447025.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 23:10:11 +0000
References: <20260402222401.3408368-1-carges@cloudflare.com>
In-Reply-To: <20260402222401.3408368-1-carges@cloudflare.com>
To: Chris J Arges <carges@cloudflare.com>
Cc: pabeni@redhat.com, bestswngs@gmail.com, kernel-team@cloudflare.com,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,cloudflare.com,davemloft.net,kernel.org,google.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275271-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 58F52398F65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 Apr 2026 17:23:16 -0500 you wrote:
> In configurations with multiple tunnel layers and MPLS lwtunnel routing, a
> single tunnel hop can increment the counter beyond this limit. This causes
> packets to be dropped with the "Dead loop on virtual device" message even
> when a routing loop doesn't exist.
> 
> Increase IP_TUNNEL_RECURSION_LIMIT from 4 to 5 to handle this use-case.
> 
> [...]

Here is the summary with links:
  - net: increase IP_TUNNEL_RECURSION_LIMIT to 5
    https://git.kernel.org/netdev/net/c/77facb35227c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



