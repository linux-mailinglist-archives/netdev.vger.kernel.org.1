Return-Path: <netdev+bounces-258060-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJ/eJh8Si2nSPQAAu9opvQ
	(envelope-from <netdev+bounces-258060-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 12:10:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F7711A00F
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 12:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D2043012C61
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 11:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B8B342CBA;
	Tue, 10 Feb 2026 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3/j70n9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423FA2FB965
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770721820; cv=none; b=dvPfqYZBymG7nPjnjsN7r/qbQpAMf+/yF8vhnVAZF113rpb6effQavQEw7RrgDojpRfLZAzSdnmTjiZoYIN7qgMvXZ2F7gDODQ21NJaTpdR8WwySFqQHi3pZIiDnjoutTburqkOXRpLk7V/U5kM01Gy5PKBnyiW488ErTkimCZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770721820; c=relaxed/simple;
	bh=sxNt6g1ekcIVKpklm/j72DTDbcEEAOTzWB47oG2NE3Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pUMc1YwON0C//dObMjLajU8mQFniZmkAFBDbxhRS66k8O1ixCVFrgPIFHyZ/dOVIqzOJcU1MkftyUrAKDeLC3Nt+z5H+eOdX084386LhDcYwjZRnKvEfnS4Ip8WilFVGpRCT+4YsAjlORgVUB1kI8JaaoOzjMJh7GX2gUuyjoR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3/j70n9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D01C116C6;
	Tue, 10 Feb 2026 11:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770721819;
	bh=sxNt6g1ekcIVKpklm/j72DTDbcEEAOTzWB47oG2NE3Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F3/j70n9y+kilhydH31gkycjAryCGCEaAQwVsy8wPYVhfQUxF4xH5uKFzKqbZRisU
	 RxKhGr/k8Y6seBnwnZQS9KBD2ZbvywfMX0RsDLPpi9nt3jdZkXoccYt+wDL7x+Za9V
	 8FJSJhSjDmfA+P7uhTnWHUg7HXKU8NfFGSw/sgiRvCSDF1MbXnEvbk83xGGg1NlHB1
	 KbmSfCdVq/nU/ziHDKWY7kzr3PaLXHOA/ikkE4PWDj91UcmNf3bTcyDGa2gBHLDC3f
	 C1RMJmHhfQ3J7nyOiSZsDzNB7g04OHQ3Xm1HPDKp7vF56jFVbkchf+PteSgdelMVDK
	 p4aSAgta7DX0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8515339B167B;
	Tue, 10 Feb 2026 11:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/8] hsr: Implement more robust duplicate
 discard
 algorithm
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177072181532.3466112.16963014467821664497.git-patchwork-notify@kernel.org>
Date: Tue, 10 Feb 2026 11:10:15 +0000
References: <cover.1770299429.git.fmaurer@redhat.com>
In-Reply-To: <cover.1770299429.git.fmaurer@redhat.com>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jkarrenpalo@gmail.com,
 tglx@kernel.org, mingo@kernel.org, bigeasy@linutronix.de, matttbe@kernel.org,
 allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258060-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 04F7711A00F
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  5 Feb 2026 14:57:27 +0100 you wrote:
> The duplicate discard algorithms for PRP and HSR do not work reliably
> with certain link faults. Especially with packet loss on one link, the
> duplicate discard algorithms drop valid packets. For a more thorough
> description see patches 4 (for PRP) and 6 (for HSR).
> 
> This patchset replaces the current algorithms (based on a drop window
> for PRP and highest seen sequence number for HSR) with a single new one
> that tracks the received sequence numbers individually (descriptions
> again in patches 4 and 6).
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/8] selftests: hsr: Add ping test for PRP
    https://git.kernel.org/netdev/net-next/c/c01a6c700fd5
  - [net-next,v4,2/8] selftests: hsr: Check duplicates on HSR with VLAN
    https://git.kernel.org/netdev/net-next/c/776b64ba12e7
  - [net-next,v4,3/8] selftests: hsr: Add tests for faulty links
    https://git.kernel.org/netdev/net-next/c/ca4a09a950d2
  - [net-next,v4,4/8] hsr: Implement more robust duplicate discard for PRP
    https://git.kernel.org/netdev/net-next/c/415e6367512b
  - [net-next,v4,5/8] selftests: hsr: Add tests for more link faults with PRP
    https://git.kernel.org/netdev/net-next/c/8908c3c8cef4
  - [net-next,v4,6/8] hsr: Implement more robust duplicate discard for HSR
    https://git.kernel.org/netdev/net-next/c/aae9d6b616b5
  - [net-next,v4,7/8] selftests: hsr: Add more link fault tests for HSR
    https://git.kernel.org/netdev/net-next/c/bbbd531faa18
  - [net-next,v4,8/8] MAINTAINERS: Assign hsr selftests to HSR
    https://git.kernel.org/netdev/net-next/c/b3dabced355e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



