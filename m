Return-Path: <netdev+bounces-274457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAQ1GfZDzmlQmQYAu9opvQ
	(envelope-from <netdev+bounces-274457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 12:24:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C257B387AE7
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 12:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95DE33091FC9
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 10:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5333CF02D;
	Thu,  2 Apr 2026 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hce8DsSB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B4B37DE88;
	Thu,  2 Apr 2026 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775125234; cv=none; b=YoiYdG8kJr6sx84wKIUJipTdnMZ217NYadSpXW5A1i1czD+j6mAlyAN0WXKsvS0f1KybJ8wBztUgXREHkwDksZQSN5/+5nLhrrdmsFihHcrGV7oEM984UzQMayY/BgvLQnWnmUJGL8y0Rwv/sRFWVQn53l1mVq4tI9LE2FWabyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775125234; c=relaxed/simple;
	bh=lDDnl0aHqT+dS7LzbW7LonaK5kjJ8OtpsF78oOMDaaw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gBvLfVLUpaWUH8DKxvVvPAMwX+0wU0rZ2WnCnj5EleUHE2oH4+u2QVZ5Y9m8SliQLaxkZDhlCNvYmTxL3WLqgBlIdFAcqkZBYIQt7YoXY6m44xY61Tkm7KIvgUtPnaT1gdLxkbtdIQlPcTlJE6/H2SSRQ1wzfFPMbrgK5WeUKkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hce8DsSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87F4C116C6;
	Thu,  2 Apr 2026 10:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775125233;
	bh=lDDnl0aHqT+dS7LzbW7LonaK5kjJ8OtpsF78oOMDaaw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hce8DsSBgqarRu7rxqgTnPMUlFWnto9UWB/smyMEhApIEEsBxhCv49l6IXnxRjI1H
	 3xPMxb23qIr5s3KIq0VJtT9Zx7RPp3c0qKErog1OuAkSewLVGEXeYDdyKUFm4VL3vJ
	 m2sZImmzpt9gpDRkzxM/bFpu9R0QsvTcbRqG5TGG7LIP8++aySuJXlS6JYC+YZW1Bs
	 UxGAiNwTeMgvYYtfwzU2I2YgZGWeHQmFg3VMjtF+hUa5A1r6OmYheltHd2X6ZO3DKj
	 PtVX/JY8UpGavE0/gx0ABddMR1J3SxoDznomFiBKxe1JKPT049QiIY1HWS8gvMRqhg
	 frVRqLyDhNy6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D1703808203;
	Thu,  2 Apr 2026 10:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/9] selftests: drivers: bash support for
 remote
 traffic generators
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177512521629.4118425.2497786662339681268.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 10:20:16 +0000
References: <20260330152933.2195885-1-ioana.ciornei@nxp.com>
In-Reply-To: <20260330152933.2195885-1-ioana.ciornei@nxp.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, petrm@nvidia.com, willemb@google.com,
 linux-kselftest@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-274457-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C257B387AE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 30 Mar 2026 18:29:24 +0300 you wrote:
> This patch set aims to add the necessary support so that bash written
> selftests are also able to easily run with a remote traffic generator
> system, either be it in another netns or one accessible through ssh.
> 
> This patch set is a result of the discussion from v1:
> https://lore.kernel.org/all/20260303084330.340b6459@kernel.org/
> Even though the python infrastructure is already established, some
> things are easier in bash and it would be a shame to leave behind the
> bash tests that we already have.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/9] selftests: forwarding: extend ethtool_std_stats_get with pause statistics
    https://git.kernel.org/netdev/net-next/c/4799ff80c68a
  - [net-next,v5,2/9] selftests: net: extend lib.sh to parse drivers/net/net.config
    https://git.kernel.org/netdev/net-next/c/2de16ebe78f0
  - [net-next,v5,3/9] selftests: net: update some helpers to use run_on
    https://git.kernel.org/netdev/net-next/c/7db9da4c67c7
  - [net-next,v5,4/9] selftests: drivers: hw: cleanup shellcheck warnings in the rmon test
    https://git.kernel.org/netdev/net-next/c/afd1b9bf7529
  - [net-next,v5,5/9] selftests: drivers: hw: test rmon counters only on first interface
    https://git.kernel.org/netdev/net-next/c/e76c71483a56
  - [net-next,v5,6/9] selftests: drivers: hw: replace counter upper limit with UINT32_MAX in rmon test
    https://git.kernel.org/netdev/net-next/c/557c067c0001
  - [net-next,v5,7/9] selftests: drivers: hw: move to KTAP output
    https://git.kernel.org/netdev/net-next/c/eec1b9057c24
  - [net-next,v5,8/9] selftests: drivers: hw: update ethtool_rmon to work with a single local interface
    https://git.kernel.org/netdev/net-next/c/abe4929bc7d0
  - [net-next,v5,9/9] selftests: drivers: hw: add test for the ethtool standard counters
    https://git.kernel.org/netdev/net-next/c/3016574ea2f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



