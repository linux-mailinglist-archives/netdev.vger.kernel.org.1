Return-Path: <netdev+bounces-263035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AF8FAJZnpmljPQAAu9opvQ
	(envelope-from <netdev+bounces-263035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 05:46:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8A21E905B
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 05:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 261703079C5F
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 04:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FC036C9F4;
	Tue,  3 Mar 2026 04:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbnZmcFO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B689735F5FB
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 04:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772513150; cv=none; b=hmzKqvmjKeBzfsBFH4/hyrkjAABktq6bHPCyGKHemnhkW1+U/0BGZvNZ3kyCTHC/uZQT2vkeOXdJ09+uTf5Hi5/Itls6+phUnLACW/nEPIp2SUDYurT0TimPWTlL+/MNs37PDz8WMUZT7HHMJGvAcO02iq2672yrflFJs9zXkGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772513150; c=relaxed/simple;
	bh=mQoX0orLbaSOOChYmYuuDvaM7UKGwmJJHVczHEXN5wo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tsrO6+0mSoiRThc0T8H+exLgF5woy2DhxF9q4530qxCbi5pawqUplm2Cb1luBBNsr8AILYp4YDCMQX2Nf3TSDu8Od8bR8LPEnVSp8mgFrIusOM1G81dfZFwevJVqgCHPcd9qpOMnO8xrGPXpgTrQqclsL8Dk7avrANwOvOCb+Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbnZmcFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9B2C116C6;
	Tue,  3 Mar 2026 04:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772513150;
	bh=mQoX0orLbaSOOChYmYuuDvaM7UKGwmJJHVczHEXN5wo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WbnZmcFOOlk/5jzXQdDBUeveOfMyHeVhk/xPhBWWANImsiIunEYWijUPZIHb0tlJo
	 GMBG15bPgFmKPLBS1maxB39cqVGPy2xSAE7TSuEm702/RbtGdygOROVIsncL9dHlrx
	 /8RfuljQDXiRHHhk69DOIDRT/mRhgrQwztEP1FlTLTnYITxUzgbd0hiy2PLkkZdiBs
	 uJ0F0lWMACaANT/Kx1IWR7Nnhu8jT6oZYQ+ku8Y7N76qMSAU4NtPcQYq/gYR/lXGAC
	 ktlKFtb4LGVdLFe/xrMLTzEau0Q6QdrJ3FGV/i01t4A/cfkOt8iNdD7ldZZ/IAVFqY
	 Pcd/H6D7rzlig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE533809A80;
	Tue,  3 Mar 2026 04:45:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] MAINTAINERS: ena: update AMAZON ETHERNET
 maintainers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177251315204.625663.4989436208716963402.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 04:45:52 +0000
References: <20260301191652.5916-1-akiyano@amazon.com>
In-Reply-To: <20260301191652.5916-1-akiyano@amazon.com>
To: Arthur Kiyanovski <akiyano@amazon.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com, dwmw@amazon.com, matua@amazon.com,
 saeedb@amazon.com, msw@amazon.com, aliguori@amazon.com, nafea@amazon.com,
 evgenys@amazon.com, netanel@amazon.com, alisaidi@amazon.com, benh@amazon.com,
 ndagan@amazon.com, shayagr@amazon.com, darinzon@amazon.com,
 evostrov@amazon.com, ofirt@amazon.com
X-Rspamd-Queue-Id: 4F8A21E905B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263035-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 1 Mar 2026 19:16:51 +0000 you wrote:
> Remove Shay Agroskin and Saeed Bishara.
> Promote David Arinzon to maintainer.
> 
> Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
> ---
>  MAINTAINERS | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Here is the summary with links:
  - [v1,net] MAINTAINERS: ena: update AMAZON ETHERNET maintainers
    https://git.kernel.org/netdev/net/c/1939d9816dbf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



