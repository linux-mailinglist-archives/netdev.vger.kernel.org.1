Return-Path: <netdev+bounces-290517-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFrXH2gfD2p2GAYAu9opvQ
	(envelope-from <netdev+bounces-290517-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:06:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B9B5A7E87
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 280B330C2E7A
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595C2368D7B;
	Thu, 21 May 2026 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLGnbwh6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D873672A0;
	Thu, 21 May 2026 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375010; cv=none; b=spNtOfrozq/p/PIB+shlpkMTHAJk8XR9TXYQxoiTJihfOPi6aiRwNd/74CvD5+e7Ur/eyQRRdXdVNhjYEf0vLx3WD0TtKLygZRT9vKnPkjKfnwqCgd4SMv9ZYAIYcX5OoprabDwU3jSbaF4cFiToXKUcTteOcW8lRcg9SaLCpHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375010; c=relaxed/simple;
	bh=tUtxi5DlEmbVARemvyZLQDWA8Nsa3EvQzxQUHSKuRXQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VmCFS/GJjmhSbdqpjHCBfnnWVA6g4AfeHkR0vZyzJ/w1J+j0s2eFIRbgmZ2iGQE+0+xv9noKPwyIuw3fzCY5we1F6QsGPUzAfGHb0sR3o9FBXjfDediarv1iNyC9WXOLMh/Adj2oTc0OcNrLYcuTPrsOCSn9JoW2KYJh7Srt7Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLGnbwh6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED1A1F00A3B;
	Thu, 21 May 2026 14:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779375008;
	bh=9kAzeAobd1QwVu+ZPC4IJRv2fFhtnZ43FHryBfTepSc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fLGnbwh683QQ/PbkbOuOXMOtebS2D2Ndl7KaL/0qVEPkfbHb6q9Zc19i2jzQOf5O6
	 cWRYEO09hQLZtq3CI6ll3DSnheCr+/mz+I7kpqKQEX3hAt6pr5AmBkUELxFzIqKV3t
	 haTAvoxD4UZPBzliak8pbgT9D32Y/yiuD7Bie//c98dq8xECrvHTNVdDX3mJrRfw1n
	 sAMcCfcPk+0ty5H8fWlkQ0nFwAo3jp9AJW7TYwq4YVAOC41eQwnqxurGQc7NloM5k7
	 hCE75Vwg2lUpU08YD7Wmv3irKjbK/tQj6xtr2so9tt2z+tD4CVeqKJu1VMrPQlElSI
	 Pk617Q2eN6RiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 00DEA3930DF1;
	Thu, 21 May 2026 14:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND] MAINTAINERS: Update address for Michael Grzeschik
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177937501889.361786.10254072888498836799.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 14:50:18 +0000
References: <20260521-maintainer-v1-1-29b5e106682d@kernel.org>
In-Reply-To: <20260521-maintainer-v1-1-29b5e106682d@kernel.org>
To: Michael Grzeschik <mgr@kernel.org>
Cc: kuba@kernel.org, mail@markussp.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290517-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 47B9B5A7E87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 May 2026 15:49:29 +0200 you wrote:
> Since I am moving from Pengutronix update my email address for the
> ARCNET subsystems to point to my kernel.org address.
> 
> Also update .mailmap.
> 
> Signed-off-by: Michael Grzeschik <mgr@kernel.org>
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> Acked-by: Markus Schneider-Pargmann <mail@markussp.com>
> 
> [...]

Here is the summary with links:
  - [RESEND] MAINTAINERS: Update address for Michael Grzeschik
    https://git.kernel.org/netdev/net/c/85fac50b58ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



