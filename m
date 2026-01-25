Return-Path: <netdev+bounces-253285-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJL9M5OhdmmOTAEAu9opvQ
	(envelope-from <netdev+bounces-253285-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 00:04:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2605183153
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 00:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DD6A3006B22
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FB1313525;
	Sun, 25 Jan 2026 22:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWQI+hHY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1147C310785
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769381417; cv=none; b=V/k50haKSoep0+kRetOTuwiMROhdp3pAq8K3UrYhrmJJy0fCcnZceA3zD36rAGYMpF1rIRF+eMJAchMCIhZzeGOpPigeQ4trkwB9H/jCwZB2vRtBhz+qpaXgshp8BFrRDfrwWKOJQunEyKMU8PI7n1o18yyOrOx7I6NWmw2DOoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769381417; c=relaxed/simple;
	bh=s3PqumVy0z6qBXycK21y4L7G2ZHkFXqL1dDzbz46rDg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OSvlAWBVLUDMkmx9W/RgbtD/KCUXBCOpyQqfafDSpKhmHhgFo7bqiF9tYbthWziF93p7lE+wjvLl+Fx6p3SEYZlIPDmoZSbkulHknGTtaotbgIaIQB6T62Y2dEgClchLoMgP11sY2odL9KCxTGEPMJGd+PR6of8Y4ZOIfg1EVNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWQI+hHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25A3C19425;
	Sun, 25 Jan 2026 22:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769381416;
	bh=s3PqumVy0z6qBXycK21y4L7G2ZHkFXqL1dDzbz46rDg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DWQI+hHYwLpeOj+gClVkgwX3Gz1mCZ+I3dP4Bi0bozTNfmyX0ICVpn+wPbi7GAkdp
	 HI5HFW4p3W8Bsa8ZpjGfxxnlxbN37PNU+/1P/ClFqMJJ+vpDklBHxmd6beb4b3Piot
	 sMy3ll1PXR4NfOij0yGIYbsJmuimohwhdbx+9IxQTtC+oU4cs7z4jmkt2l8vOzBftW
	 jhacTSXiIYQwbBgeFm9IuzzOs/NpXKGmyUuSqSwuaehw03OsZocQFYMMJBzZ4R/EEY
	 RRBEWJcIGiFy8a7X9KH7PYhM8RIG3PNQM8yNl2iNS0t6/MbtzTIjB3j0ULul735VvO
	 7KKaWM9E1wBoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8AB13809A15;
	Sun, 25 Jan 2026 22:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv4: igmp: annotate data-races around
 idev->mr_maxdelay
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176938141134.4002147.8332654342362165220.git-patchwork-notify@kernel.org>
Date: Sun, 25 Jan 2026 22:50:11 +0000
References: <20260122172247.2429403-1-edumazet@google.com>
In-Reply-To: <20260122172247.2429403-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com
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
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-253285-lists,netdev=lfdr.de,netdevbpf];
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
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2605183153
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jan 2026 17:22:47 +0000 you wrote:
> idev->mr_maxdelay is read and written locklessly,
> add READ_ONCE()/WRITE_ONCE() annotations.
> 
> While we are at it, make this field an u32.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] ipv4: igmp: annotate data-races around idev->mr_maxdelay
    https://git.kernel.org/netdev/net-next/c/e4faaf65a75f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



