Return-Path: <netdev+bounces-266844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJ6BK5MgsmnlIwAAu9opvQ
	(envelope-from <netdev+bounces-266844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:10:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6628926C180
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F8C6302516A
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59169375F9B;
	Thu, 12 Mar 2026 02:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u30bnS7F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B2B1EF39E
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 02:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773281419; cv=none; b=fITKtVbV3PQAFFX1Cl5WS0H5SEDl0Xi8FY/kq9nxLfGWrBhQyrDPouk6RUf9WnfkTW6MnoO6XIV/BebT86uXYWVSiSJbzkFY8BP+pyyZkJ50JbcrEEAIlRmDgzIEOXcIpCUJ6nhZWn+vzaPUSFU5+iBhNB3J6XQmHYB+k1YK1Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773281419; c=relaxed/simple;
	bh=FITkiM7d3wyfqN6I9YYP0N1Cnqv7GJ/qn4IkvWF/41U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VvEDlwjDBjAsopMgWR7gEMMreN5pB6G9YtOyi3flcaq2y3zV1so0CfFrV6qsGVjdq4255/PtKHYGq0OePo4QwUXWsKd7NeyLUaBn9QsBU15jcpoFgCtmqpJ7Zwfai39F0f43tadgHbnI8Zc1XNoNsLf/NY7fT6HpX/gnTOEJVMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u30bnS7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF766C4CEF7;
	Thu, 12 Mar 2026 02:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773281418;
	bh=FITkiM7d3wyfqN6I9YYP0N1Cnqv7GJ/qn4IkvWF/41U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u30bnS7FNv412daorRTuARfhsct0Dz0hWo+qAM2kQIchUmDgNd/gJ/VKG9P3LkOqV
	 VkkhS6OWEOVW9f31IJroUJof1d1SFAs3JaHDlmq+apleTf41sSjGrc1P7lmizBZHpG
	 gLMeQ56YWSqKf7uFq9DkCU2l7kcKR9pRrxGNyBi7EvzQIZjyd+zlXjESoSKcrHTHRb
	 Ogh2ElngQlbLc/nOsgXN+nnxddsge4mpLHsq97hPrwZr2l62HHSECBhrIFluubtUed
	 +IoY+2pJhAFJ2oqV1LcnbiYyBiVKycweR5K8/6G+Wxw1NJ0f9JV3hoQPYH6sKmnsEq
	 bbGe7yBZdws0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E853808200;
	Thu, 12 Mar 2026 02:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] neighbour: fix update of proxy neighbour
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177328141454.3905617.15461656435350206907.git-patchwork-notify@kernel.org>
Date: Thu, 12 Mar 2026 02:10:14 +0000
References: <cover.1772894876.git.sd@queasysnail.net>
In-Reply-To: <cover.1772894876.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuniyu@google.com, dsahern@kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-266844-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6628926C180
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Mar 2026 22:59:15 +0100 you wrote:
> While re-reading some "old" patches I ran into a small change of
> behavior in commit dc2a27e524ac ("neighbour: Update pneigh_entry in
> pneigh_create().").
> 
> The old behavior was not consistent between ->protocol and ->flags,
> and didn't offer a way to clear protocol, so maybe it's better to
> change that (7-years-old [1]) behavior. But then we should change
> non-proxy neighbours as well to keep neigh/pneigh consistent.
> 
> [...]

Here is the summary with links:
  - [net,1/2] neighbour: restore protocol != 0 check in pneigh update
    https://git.kernel.org/netdev/net/c/cbada1048847
  - [net,2/2] selftests: rtnetlink: add neighbour update test
    https://git.kernel.org/netdev/net/c/68e76fc12df0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



