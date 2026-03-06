Return-Path: <netdev+bounces-264926-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJ4BAGFHq2lcbwEAu9opvQ
	(envelope-from <netdev+bounces-264926-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 22:30:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AFD227F0D
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 22:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED3A7305D6ED
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 21:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AD53AEF37;
	Fri,  6 Mar 2026 21:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdRC37sP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099DC39F190;
	Fri,  6 Mar 2026 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772832606; cv=none; b=Lp87xwyLbuoI0D/bDPCTj2wKKveV6rwMRD7X58dGhsT4X0YxSLjmEz21dyXyhux9vLpdVDL2B+n2PD9YhAztTmQ/yWaE2EEwuIyZjla9/G37OBaLjde/h+Ya33hkUHtmAQ4ImsLOy4GqOzEh+i1vcCWbUM6rHYRghxiXMiXZ1Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772832606; c=relaxed/simple;
	bh=nGBtxW+NexuqnWTIi8pax7D3YZzdb4cisjdbTkAVJ50=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=epvxbeyzWR2DCN2xy/IxgWjxK0DXZPXC+Kr80l4vsnkQsvmdO5VhPq/AZHOtSVYM6QwraHlhihHAhNm5ZUYBBlMbqK1qq1T80mZcqV/nF7cFcgCkuwPOQ8JljLAMhREYDazqLkxLhiUfejh4aoX4cExLYkxl62xa6m+GbCWZQBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdRC37sP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900D0C4CEF7;
	Fri,  6 Mar 2026 21:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772832605;
	bh=nGBtxW+NexuqnWTIi8pax7D3YZzdb4cisjdbTkAVJ50=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YdRC37sPE+NKlWYysRi5XQKNojNNDUE61ohS0LkEKed9mjszhxGerQKRf0KyVs8dR
	 /mIqScefvughLcYkLrr6rZbkRqrEuZ0TF3IW15CiGimCQcw9AyKhf+D0vUpO1aTrpy
	 /3pNGng5LBl/dpoizKW7wKTUYLvq1s9G0YCHdC7CsXxiNHC9Ok+7TjXt9bvCX7MBp3
	 VzbkN98K4q+mlT2NAib65b5JmhCaYVcIE2eG5tSPm2hIjqlfh1z3uyQNDUjr4jQGdI
	 z5qfQ5NET84Itym/t+tc6j2DnaqkO3iJIK24CVbA3WmVaMvfK3tJCEiy/SDOi5CB8E
	 a2rWvMq8HKAkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D8E3808200;
	Fri,  6 Mar 2026 21:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: Remove bouncing T7XX reviewer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177283260480.58743.5861072453468006740.git-patchwork-notify@kernel.org>
Date: Fri, 06 Mar 2026 21:30:04 +0000
References: <20260305172806.3118806-1-dave.hansen@linux.intel.com>
In-Reply-To: <20260305172806.3118806-1-dave.hansen@linux.intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, chandrashekar.devegowda@intel.com,
 haijun.liu@mediatek.com, ricardo.martinez@linux.intel.com,
 loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org
X-Rspamd-Queue-Id: 42AFD227F0D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264926-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,mediatek.com,linux.intel.com,oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,davemloft.net:email]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Mar 2026 09:28:05 -0800 you wrote:
> This reviewer's email no longer works. Remove it from MAINTAINERS.
> 
> Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> Cc: Liu Haijun <haijun.liu@mediatek.com>
> Cc: Ricardo Martinez <ricardo.martinez@linux.intel.com>
> Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - MAINTAINERS: Remove bouncing T7XX reviewer
    https://git.kernel.org/netdev/net/c/0e16181704e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



