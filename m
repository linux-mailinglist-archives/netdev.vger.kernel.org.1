Return-Path: <netdev+bounces-253214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFHHDD6JdmncRgEAu9opvQ
	(envelope-from <netdev+bounces-253214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:21:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 460CD827CE
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B8E4D3002D25
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 21:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB13E30DD01;
	Sun, 25 Jan 2026 21:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hN22mKuZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BA130CDAE;
	Sun, 25 Jan 2026 21:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769376023; cv=none; b=II+2PYc69YdXeovZjjcM/Njsnkj+hx0OLUoqgstP7CGTM4tI1sVZu5Bdeo2u7YNh4XbgQovzwSxaoDwFq+rvewWarsR/rj14kxMInGC/2XPpQRyj+SMD4qguUrGjt5REbkgvTzZSL+SkYSe27oU9DpP7jeQwtuoGanpd4RRITtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769376023; c=relaxed/simple;
	bh=ZPvEIbrdkyOksRW7uUxLFKxwuTsxzKXiKyTCaJX4QE8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FDFrPd23rbcDU8m0ZlTkLd24P0F+gyN0rWY7AVkZ8nByQCC7UOhZpf3wybnGbFsro5wp2h3CBk/XQbt4SX3f5YfeDRqei0ibmZqmgezp8kPilvtt5G5iTlPoNS8uNiI1BVjctg4er9R/efn1Fja8CFXscIEdjbfF+DnoVd51hfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hN22mKuZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30917C4CEF1;
	Sun, 25 Jan 2026 21:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769376023;
	bh=ZPvEIbrdkyOksRW7uUxLFKxwuTsxzKXiKyTCaJX4QE8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hN22mKuZQyPSvbDUqstAQHm2PZ9++toc7aDQV5OvV4YoR3pvxSeke3VuzHbnm0CGF
	 lIEw5u+SSsZhQ5jeYZRUlNF7reDhjS+ezeWMVIqm1YnUhRsFrYV7vUuXkiFeyenkFF
	 yf9A07f4PF4rkyPt9QjUy3LWvgZH+NfAZhPEURB0rfDRQEGmw1LIhY1wt3K0znaTFU
	 ghP7Xp9kLxMy0ifJtGjIaGKYUwExidx9tNJK+42DGJk2MoZ8CT+43MSqCMd4Xc2XIX
	 VN/IV3rnieedu6Q55q1XQUP57KiRVLE+9StCvEH1L6fbgSeaRH0TIGuForAOc6CX1P
	 yH5P4vKzsbahQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4ECF63809A15;
	Sun, 25 Jan 2026 21:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] Documentation: net: Fix typos in netdevices.rst
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176937601809.3588307.353607266893756801.git-patchwork-notify@kernel.org>
Date: Sun, 25 Jan 2026 21:20:18 +0000
References: <20260122225723.2368698-1-dimitri.daskalakis1@gmail.com>
In-Reply-To: <20260122225723.2368698-1-dimitri.daskalakis1@gmail.com>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253214-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 460CD827CE
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jan 2026 14:57:23 -0800 you wrote:
> Fixes two minor typos. Specifically, on -> or and Devices -> Device.
> 
> Signed-off-by: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
> ---
>  Documentation/networking/netdevices.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] Documentation: net: Fix typos in netdevices.rst
    https://git.kernel.org/netdev/net-next/c/3085ff59fec5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



