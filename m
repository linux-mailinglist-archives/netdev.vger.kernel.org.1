Return-Path: <netdev+bounces-252186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFn0AiqicWmgKQAAu9opvQ
	(envelope-from <netdev+bounces-252186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:06:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8086196E
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CE3AB52686B
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D50734C808;
	Thu, 22 Jan 2026 04:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0uORdUq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6DA322B9F
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 04:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769054414; cv=none; b=MuCq2hdcGOod4LZAig5H7GetjDemjcP6I4MPF5iceI3NOKL4hoBYmqMEudcStQ3h+M+P0KlBsbm8kiLUZ3hy9gso+PbzgCiZhZRo3hDD36Eu/tmxtlENbWx+pJwJ10W4dHzDtUnCSDF0grgpg+EvehHJt19Es/QJm/mDPgCBrtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769054414; c=relaxed/simple;
	bh=POsAxH2ufvLrBKhDtDwnIaXqrnLXPR4/6Xv+x98B9XQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UA8S9GCwHsf1bG1ZB5ok5kdVQrAgErwWzvENsHounxBOlAmBaKcc3XEjDn9hmD4J7a0KWXRGvpvIO2B+zkV5Ns6DrwWFp7kqbvM168uxHg82jDQgVGcAJ7y4nxL01Kn2RM84GVqUdYArxGZezdazNBkAuWBoRPfv4wRkL+yctSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0uORdUq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8E3C116C6;
	Thu, 22 Jan 2026 04:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769054413;
	bh=POsAxH2ufvLrBKhDtDwnIaXqrnLXPR4/6Xv+x98B9XQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q0uORdUqc8iGUC+bTqH3JDZgy5nCMhRLDo1JzFCwIsdpkcdd7oHA2dyZhl4mrxlAH
	 l92EUzOvGFoafHGjNoxNvcYhiIpPlzbjgFkH5vtAV9VbEIG9PbGB6fxBs5R0v76zdM
	 FgJTcXIj7CBTo4NyWUHqMBuJEZQLkKgJvQsX++ikdYe8tw6hOijUe62aNdY2zGbA7I
	 AMUNE97DeNMMg3BlxBAimO9J0ntEmpxxSRO0SDBEZy8VWKpKzSF/0+CvAVqY/XxzIi
	 3TTtprgfaezYZGoEiPC7vhYtSlJCulVTnJx6jhWFrrBORujvtJakW/NC7rdlp621JC
	 w782iZTX4vrrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EE833808200;
	Thu, 22 Jan 2026 04:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: fix off-by-one in maximum bridge ID
 determination
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176905440986.1550373.18140833827678654878.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 04:00:09 +0000
References: <20260120211039.3228999-1-vladimir.oltean@nxp.com>
In-Reply-To: <20260120211039.3228999-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 alsi@bang-olufsen.dk
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252186-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BF8086196E
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Jan 2026 23:10:39 +0200 you wrote:
> Prior to the blamed commit, the bridge_num range was from
> 0 to ds->max_num_bridges - 1. After the commit, it is from
> 1 to ds->max_num_bridges.
> 
> So this check:
> 	if (bridge_num >= max)
> 		return 0;
> must be updated to:
> 	if (bridge_num > max)
> 		return 0;
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: fix off-by-one in maximum bridge ID determination
    https://git.kernel.org/netdev/net/c/dfca045cd4d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



