Return-Path: <netdev+bounces-255307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEHdMq5dfWnKRgIAu9opvQ
	(envelope-from <netdev+bounces-255307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:41:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA2AC00D9
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8F6D30210E9
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 01:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9728A32BF26;
	Sat, 31 Jan 2026 01:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srKuNvrA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C3D32AADE
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 01:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769823624; cv=none; b=fmtePvmb8AXU1Z2tZlJnfHyC+tfd2e2Amg6r7sJkqBzh6JxPGPI1Wvnn1aIGlR74KJ7SWXooIl13Yw78B7GNXhC9MgbVRtfJrhxeQZqlPRYOSU1w3sdlTtT8NSWdtYw6c8XFTYyi/A2cwSqt0ohMm6BPI4n9AUSWud9ZomMSiE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769823624; c=relaxed/simple;
	bh=bNER4K5YtGHoPZX3o8vlwCrlKIlvgR3V+XZDojO53JU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ARH9mKZ5O9bi4SffFusOXHFYnMegk+5SJmVQgr/66rhOERdtqGu9X11YctJpbgz4doSuCQNi0h9tcF+FXNSG7/HhoU8OXrntv4gDg0bi3qYQY0jYnN+KCTyhNC3CVgg8q3XFtpNLB1iZWWVlGCtyetIrXiLOF86wjKpS6dJ2ZYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srKuNvrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538E0C4CEF7;
	Sat, 31 Jan 2026 01:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769823624;
	bh=bNER4K5YtGHoPZX3o8vlwCrlKIlvgR3V+XZDojO53JU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=srKuNvrAa0LU5cwmiT+4rWVOAijL7Szr9hjQwI9EvX7aHp0Wo++ai4dlSgKkVeyPp
	 KuJhKpY8WvFwMP3M9Y/YtZ8kAOwLbJ1fGC3/A46/wYhsV2BtzYGexCyD0f3mRYK06t
	 A5ReK5q/s6jJilRsdX3Rma17+jv6ZuJHi3S7zRqvWk9FFLcvZwD0Y8b6obfiXK03gj
	 vGPjAfIEM3FSOSqVapbRePpehk41p8/jTjIkT0nplI8456jxbf9vCjSXDVN+sfm7+E
	 Fq+t9vqYORjMnJcQpd8OzKzYM5VkpqPhiE672GO2spaGHH86EtBZsy84icwgrIYpC7
	 bRsumlcP9CGZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8BD4380CFFB;
	Sat, 31 Jan 2026 01:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v2] amd-xgbe: add support for rx alignment errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176982361660.3959411.16534173721208493108.git-patchwork-notify@kernel.org>
Date: Sat, 31 Jan 2026 01:40:16 +0000
References: <20260129111520.1567097-1-Raju.Rangoju@amd.com>
In-Reply-To: <20260129111520.1567097-1-Raju.Rangoju@amd.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 Shyam-sundar.S-k@amd.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255307-lists,netdev=lfdr.de,netdevbpf];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3EA2AC00D9
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 29 Jan 2026 16:45:20 +0530 you wrote:
> Add the support to read the rx alignment errors and update
> them in the standard rtnl_link_stats64 structure.
> 
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---
> Changes since v1:
>  - skip the duplicate instance of rx_length_errors
> 
> [...]

Here is the summary with links:
  - [net-next,v2] amd-xgbe: add support for rx alignment errors
    https://git.kernel.org/netdev/net-next/c/43dc088c19a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



