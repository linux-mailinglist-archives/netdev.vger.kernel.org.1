Return-Path: <netdev+bounces-269235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAW/KwdJu2kliQIAu9opvQ
	(envelope-from <netdev+bounces-269235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 01:53:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 069EC2C4385
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 01:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B933310324D
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 00:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C53A245005;
	Thu, 19 Mar 2026 00:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJYLeSb3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689B6238C1F;
	Thu, 19 Mar 2026 00:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773881414; cv=none; b=GWtFF8Cny+fDU8hsxxeJy6G22XZDBDeMOQHYRZgdWDb5efKtJX1jYotDBjDAmzrLVBChWWHIw9/bC0q4qA5D22m7+IcQQT3Q5qBwrUD3YvBGCTja9KVvXn2dc2yEUrNMg4xQIjVutnm13/6+Z72fj5OpXvUuCAVCKHwKWB9JEmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773881414; c=relaxed/simple;
	bh=zVSPhyCN3HbYx/+zS8Jfh3txHDqhUdsmp5XEI4vKPxI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eRnlgyPyGHR8gujjI4Z/617wiTwzolS043ocQfhnO4c7bbDXQtahgO5P91rmRg0kr8rnd3g2S2YUyWywAXGd65oU75bNVfyebUMTFT/E79sEZQzI4uzOdO5FcVnMijoYyS/FtPJez0C9SAJbQkmun8jz0/tazv//nt5Dl537bwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJYLeSb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77EDC19421;
	Thu, 19 Mar 2026 00:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773881413;
	bh=zVSPhyCN3HbYx/+zS8Jfh3txHDqhUdsmp5XEI4vKPxI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HJYLeSb3Qctac8TOmNF1fAn23HOhFKSi8Do0r/T8SKNAsdZ1RTY5Gy8jN3e3bJGdu
	 mRsTbN6wEIqIhjGCf8/0VBNiA9cqow0jj99tM4Rf+pnZMFiKkyUrud1yJlTAx0qdtq
	 pY5TgBBGclYnwaeFoDKO85n4h/0pqtfCLxPqOeiIfCbF0wIb5nrlsLmL3Pl4pwx/Xk
	 4w0dW5GC7m+2jdY/zThw2G2gP+BA+TqV6285NnqDH7sSHWnv+Gb4zVq4bgpJ5NzvSH
	 iqD+EyqOHpv5usvkeR6ZYE7BenDX7gpwzS2xKvJp4XGbl2t7xQZIN+kqRxsznho2q5
	 6F7N4EI1wb9EQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D1053808200;
	Thu, 19 Mar 2026 00:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] batman-adv: avoid OGM aggregation when skb
 tailroom
 is insufficient
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177388140529.969605.9189456516645267942.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 00:50:05 +0000
References: <20260317160002.1869478-2-sw@simonwunderlich.de>
In-Reply-To: <20260317160002.1869478-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, n05ec@lzu.edu.cn, stable@vger.kernel.org,
 yifanwucs@gmail.com, tomapufckgml@gmail.com, tanyuan98@outlook.com,
 bird@lzu.edu.cn, sven@narfation.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,vger.kernel.org,lists.open-mesh.org,lzu.edu.cn,gmail.com,outlook.com,narfation.org];
	TAGGED_FROM(0.00)[bounces-269235-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lzu.edu.cn:email,simonwunderlich.de:email]
X-Rspamd-Queue-Id: 069EC2C4385
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Tue, 17 Mar 2026 17:00:02 +0100 you wrote:
> From: Yang Yang <n05ec@lzu.edu.cn>
> 
> When OGM aggregation state is toggled at runtime, an existing forwarded
> packet may have been allocated with only packet_len bytes, while a later
> packet can still be selected for aggregation. Appending in this case can
> hit skb_put overflow conditions.
> 
> [...]

Here is the summary with links:
  - [net,1/1] batman-adv: avoid OGM aggregation when skb tailroom is insufficient
    https://git.kernel.org/netdev/net/c/0d4aef630be9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



