Return-Path: <netdev+bounces-276237-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBD/AcK21WmU9AcAu9opvQ
	(envelope-from <netdev+bounces-276237-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 04:00:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB343B6282
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 04:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC0703016C8F
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 02:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E944317D;
	Wed,  8 Apr 2026 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jz6rWChH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E1C9463;
	Wed,  8 Apr 2026 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775613631; cv=none; b=QI6n70Lay5TBvr3wBto53LdeIrxvAyucTW2b8UhgOkZImN0MWqItzaK9kFmFnj2lnsPvv0mckavjdsCykFvvMZg2mbn3o71SDKYoeI0jbIHt7wuSy7Zr26jzMJPOrZ711EAF0amrVS4fjOlM0TA8DYrc9Y9xKX2ixM+HSRwKHkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775613631; c=relaxed/simple;
	bh=xpV5ixxVNwIs1y77Krx9Aw0xFffIlWQdYpziGdQvjT0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vy3IY+W9JHH1R7QX5k/j6sEGmqdkkrJpr2ljdKT7G25ItU/meWKmos7NXYVTEfoud9/r4lV1c7wMaEBivt/1Z5mS+QMAWu3kZzk79KA4obpkFD6gSNbhRWi196kFIazAD1thuAOG0obH5SGSn9jtF3LI034rvKbcLqgJjRgc4pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jz6rWChH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3AF4C116C6;
	Wed,  8 Apr 2026 02:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775613630;
	bh=xpV5ixxVNwIs1y77Krx9Aw0xFffIlWQdYpziGdQvjT0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jz6rWChHWltA5p5musO1I6Gf+5DZ/ZLP7T26s7WoOhoXESkDDK9gs5LQ3vI1se7A2
	 d1T+7kgCuyRtUq5rR+Sc26k/I3Lmo08iKVWMHzn4xgTdkYevGz5nn2z92H8m8WZhV+
	 Y+ViSkJ8w/jVHQgFDiDIBR2N6zyaX47PhD77Pt8hk7Y7nxzVev3y1ccdTZoJCYEGWg
	 t4eQh4gugKplL3aeIULZ1Jau8snwcxvDzSzbbctc0HPZbuda8NQ9OT/xWFaPctHU+J
	 MQiJnnI1/aE0hV4lpoPE3MUBPHIpLEjxjg01r3fNL6leYthDu83i0Cwc/jSA7BKNOx
	 LFLFpPwpWia5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCBB3809A3D;
	Wed,  8 Apr 2026 02:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: adjust to socat changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177561360779.36273.6873126268378400690.git-patchwork-notify@kernel.org>
Date: Wed, 08 Apr 2026 02:00:07 +0000
References: <20260404230103.2719103-1-kuba@kernel.org>
In-Reply-To: <20260404230103.2719103-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 leitao@debian.org, shuah@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, linux-kselftest@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276237-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,debian.org,gmail.com,fomichev.me];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5BB343B6282
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  4 Apr 2026 16:01:03 -0700 you wrote:
> socat v1.8.1.0 now defaults to shut-null, it sends an extra
> 0-length UDP packet when sender disconnects. This breaks
> our tests which expect the exact packet sequence.
> 
> Add shut-none which was the old default where necessary.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: adjust to socat changes
    https://git.kernel.org/netdev/net-next/c/e65d8b6f3092

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



