Return-Path: <netdev+bounces-272720-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLwoBn1Sx2nfVQUAu9opvQ
	(envelope-from <netdev+bounces-272720-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 05:01:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1894734D370
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 05:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 04B823036559
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 04:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED51329992A;
	Sat, 28 Mar 2026 04:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keoJWVhs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA74C1F5858
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 04:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774670430; cv=none; b=ZXxmvPi1VAAbY8ytxBpMKO/Dn3/UVH8rL/GzgwDEHB1VhFFOw+a7ziFBRCxLPXdkv3IFvW+yv1jctr0DS14VIwkIK/In+4bCNPyWmznAYZWDgqlHtK6HN5yIgTRAI+rvgpg7Vslwqb6q15BW6F0IAEpcScw8+ubeotFBxLuzDcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774670430; c=relaxed/simple;
	bh=kAv8Nh5isRVfbuMPIKudp6bHh8g8cNLqGF3gABX2axU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QXcSkanQpfItvey22SDP4WNIDX1LsdhZA/UFrmsityTLVvI/8EdkmX0uY77KDs11knytoFr1AYcOIstCqGgQgimoFPGFzUAGYhQA5ag3fUvqmBWKoPwEjnnfPixQtCG9XLHWHQuz/ZScZGdy6KSkNUS/J50ilzHU3O7O9veMoks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keoJWVhs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EC1C4CEF7;
	Sat, 28 Mar 2026 04:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774670430;
	bh=kAv8Nh5isRVfbuMPIKudp6bHh8g8cNLqGF3gABX2axU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=keoJWVhsGVtFaktPYXONxzYgUpkxupuxFbpsXKT8xUyWKazC7s4F98F7YnrXfNfWH
	 /HWsv11tNFqmOZ9qWe3aCerlSABmEm/QseLAEOPafYvK9nw0CF7YiLMEPqedtmyVDC
	 M7nTYhWu5daI6DWSrMw3iiJIDHPTXo7o74Pk3b0lceWnoqnspENFeUSlExrOPeoEEb
	 TJ35Gz+ABS21nudCF7v6TIPFy/RdmcAO84pU/eUk0qKdt+6WO26CLuqUN0JqR0S4+f
	 wfM4gSMaujuAZZLI+canHo6u5Nc1OO0Pn+UABKCT7/OX8xjdDH+D1Q9liAr0VkFZmJ
	 uyYuf+bXk0nKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE753930181;
	Sat, 28 Mar 2026 04:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mlx5: shd: Gracefully avoid shared devlink
 creation
 when no usable SN is found
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177467041578.4173055.4519751475838501962.git-patchwork-notify@kernel.org>
Date: Sat, 28 Mar 2026 04:00:15 +0000
References: <20260325152801.236343-1-jiri@resnulli.us>
In-Reply-To: <20260325152801.236343-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 admiyo@amperemail.onmicrosoft.com, ben.copeland@linaro.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272720-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,onmicrosoft.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1894734D370
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Mar 2026 16:28:01 +0100 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> On some HW, not even fall-back "SERIALNO" is found in VPD data. Unify
> the behavior with the case there are no VPD data at all and avoid
> creation of shared devlink instance.
> 
> Fixes: 2a8c8a03f306 ("net/mlx5: Add a shared devlink instance for PFs on same chip")
> Reported-by: Adam Young <admiyo@amperemail.onmicrosoft.com>
> Closes: https://lore.kernel.org/all/bab5b6bc-aa42-4af1-80d1-e56bcef06bc2@amperemail.onmicrosoft.com/
> Reported-by: Ben Copeland <ben.copeland@linaro.org>
> Closes: https://lore.kernel.org/all/20260324151014.860376-1-ben.copeland@linaro.org/
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next] mlx5: shd: Gracefully avoid shared devlink creation when no usable SN is found
    https://git.kernel.org/netdev/net-next/c/b8f9410aefc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



