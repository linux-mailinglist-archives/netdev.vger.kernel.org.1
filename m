Return-Path: <netdev+bounces-277893-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8E0XLdj+22luKgkAu9opvQ
	(envelope-from <netdev+bounces-277893-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 22:21:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1925C3E5DFA
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 22:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F5D9300914C
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C86437F748;
	Sun, 12 Apr 2026 20:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpiuhhjE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD65B364028;
	Sun, 12 Apr 2026 20:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776025248; cv=none; b=Ub7JFE+V4WAqhfruPjoGW9GQi578s94NxBGAzC7N5lkcOxzfcxs7MiUXPiyX1vIFWkBPeu8wvl+QjlYSH7kw2y+ZTQ78s3tK7+tCdsyr5zqOxw9FKfNEIUe8xwVM1wnqybU3St7JXKz7+tDgYvktqbDEPOK8gWIBH+XfaK17DZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776025248; c=relaxed/simple;
	bh=gLpPgysxhLlJa9nY2yTS0JpNyujz+os93VUHl5tw6H8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lM8az4IIaW8Y7DIhqkzUF4+6JTVctsUK8OtjoswUJEPN6Ks/O+GqKl+odxdSG9lguVGDADuOUIkof0DhS0BBpQ9N3iHYAefD6IXVpiebW9F3+NOf34g+QANwo/VolShEg+yeNjYQ13PCvNqDAVZgvdePukCeJ0STJTA/XXSvDg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpiuhhjE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24EB3C19424;
	Sun, 12 Apr 2026 20:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776025248;
	bh=gLpPgysxhLlJa9nY2yTS0JpNyujz+os93VUHl5tw6H8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PpiuhhjEylmkmc+DsTpPS6WGzL1ji+DmGmXqBvbs9W+HfddTPd6XFjrR7ih7ITf6S
	 ydYLGu3GUYJOZkkRKzrgBoNXUgfVjtE5B0FLNzcqx/uxxZlgxaflzzCrcHevox1DUs
	 J6LDjmCze1EdUMJOj1gm+B9+yyVuIo/RWGBIKyNE/T0lcbMDt7T1W86b/SuCRkkRX7
	 uSeXf0jCCsMglNsZIx0flWQiTK+SKX1PxDjo7YJjlmKIiocLdbwiC20N8LQ/61p6iw
	 aS657XejOdLR1u9RkVPv9qWarc9l8PFWqd2Piun6TTGGoLwstYAwJaSIq8+2bzX0j8
	 s5cRXK5GAL3EQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9ED43809A8C;
	Sun, 12 Apr 2026 20:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] net: enetc: improve statistics for v1 and
 add
 statistics for v4
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177602522028.3398432.7978690408684084054.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 20:20:20 +0000
References: <20260408055849.1314033-1-wei.fang@nxp.com>
In-Reply-To: <20260408055849.1314033-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277893-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1925C3E5DFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 Apr 2026 13:58:44 +0800 you wrote:
> For ENETC v1, some standardized statistics were redundantly included in
> the unstructured statistics, so remove these duplicated entries.
> Previously, the unstructured statistics only contained eMAC data and
> did not include pMAC data; add pMAC statistics to ensure completeness.
> 
> For ENETC v4, the driver previously reported MAC statistics only for the
> internal ENETC (Pseudo MAC). Extend the implementation to provide
> additional statistics for both the internal ENETC and the standalone
> ENETC.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] net: enetc: add support for the standardized counters
    https://git.kernel.org/netdev/net-next/c/c6c223fd06ed
  - [net-next,2/5] net: enetc: show RX drop counters only for assigned RX rings
    https://git.kernel.org/netdev/net-next/c/c571d309d4cf
  - [net-next,3/5] net: enetc: remove standardized counters from enetc_pm_counters
    https://git.kernel.org/netdev/net-next/c/6d78c37a73e0
  - [net-next,4/5] net: enetc: add unstructured pMAC counters for ENETC v1
    https://git.kernel.org/netdev/net-next/c/dbc30b154e33
  - [net-next,5/5] net: enetc: add unstructured counters for ENETC v4
    https://git.kernel.org/netdev/net-next/c/98a4f3d34132

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



