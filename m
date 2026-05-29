Return-Path: <netdev+bounces-292923-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBdcA3PqGGruoggAu9opvQ
	(envelope-from <netdev+bounces-292923-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:22:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 793A95FBFB4
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25FD6306536A
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0B835200C;
	Fri, 29 May 2026 01:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pdv+apmy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68580175A62;
	Fri, 29 May 2026 01:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780017602; cv=none; b=WevZ3omDM38mF8bqVtzAeAPY+E+ppwrnXX3xppeh3Uy/CBt1fUVbn3u6HAu0FAzP8hnvJhSTN7RetnKu9FQFR+biiEpVqL3Wr/ORYe2FwczUkJa6IBIKMGWkTHGf+E3Wn9KrLWFEicHtU++ARPf8sFP6SqtV8Z16f7qmrmaXj68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780017602; c=relaxed/simple;
	bh=KJFh6fYFuF1Qar1uyqryK9OjdpuC4m/DpY9xhQxy+EQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Aj9nSJND4S9lf1hNK+H28yCLWorpxRwTToViur1AIgXPRhLfHTxC8R8C7l/iXdWCF9qsuZP1iEKLv4ks02VT0NSGCU+gKLM3/lUOHRb/H3pxvGTdf2fwuYSrqNxTYxhpFtLAKqWO9F4fj/6E1QE/SzF+il11SPIv8Hc6afiCTCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pdv+apmy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5AF1F000E9;
	Fri, 29 May 2026 01:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780017601;
	bh=lOaKOCR8muSZegpxRQTwrSb3xsHi/hx1Esr98dOCWEg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Pdv+apmykyR9FKD9yA0LR52fMkOlE2aYqQBtEe+5OTPwusSkk7Og9EDqgOuc4wTji
	 OJ9YNb8nmTGNZHLdbcyF9nkhcRcRr19QfloteOjPjn/vV0zYhUlmzuxX8409XgBxil
	 xInGNVfO8i9QW7VcOdMTJ1S8mDhCvu1HcmRMi5gy0K0PJQ/ShZc1m94JmbvE9V/8Bs
	 LyM/U8NR0ydSZIrcj4wDGus2fHmnnq3nlG0ZDwIFUmr5s0lnvYTRp5zovbVtwhMkuv
	 PZuJmIpZX2tGECNTwhZgjxDyw4O8rhe6kNX2qrgHpE0UrNEUSX6QXxz3cJFN0SAo+a
	 ZtDA7YEKvve7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568C3392FFFE;
	Fri, 29 May 2026 01:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net v2] net: pcs: pcs-mtk-lynxi: fix bpi-r3 serdes configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178001760515.1584301.241177425272173045.git-patchwork-notify@kernel.org>
Date: Fri, 29 May 2026 01:20:05 +0000
References: <20260526153239.30194-1-linux@fw-web.de>
In-Reply-To: <20260526153239.30194-1-linux@fw-web.de>
To: Frank Wunderlich <linux@fw-web.de>
Cc: lynxis@fe80.eu, daniel@makrotopia.org, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 frank-w@public-files.de, vladimir.oltean@nxp.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[fe80.eu,makrotopia.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,public-files.de,nxp.com,vger.kernel.org,lists.infradead.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-292923-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 793A95FBFB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 May 2026 17:32:38 +0200 you wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Commit 8871389da151 introduces common pcs dts properties which writes
> rx=normal,tx=normal polarity to register SGMSYS_QPHY_WRAP_CTRL of switch.
> This is initialized with tx-bit set and so change inverts polarity
> compared to before.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: pcs: pcs-mtk-lynxi: fix bpi-r3 serdes configuration
    https://git.kernel.org/netdev/net/c/422b5233b607

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



