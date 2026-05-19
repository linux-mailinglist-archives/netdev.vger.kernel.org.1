Return-Path: <netdev+bounces-289206-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBERJ5KoC2oGKwUAu9opvQ
	(envelope-from <netdev+bounces-289206-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:02:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2567257557A
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A9C7302ED67
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 00:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33D5339863;
	Tue, 19 May 2026 00:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCktNkqB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09D0306B3B
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 00:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779148811; cv=none; b=gxeQvj/P7cZUI2AlAF/Mnj3b3GiQaf1nRms9KbpHCHe2g6bBcZbOn5ymMPPPXCPCwT9Jmt57w9NWhhF1Je3YPoq7PXh0LnQNcbg3/+BdOdzir6YL2E3qeL3h5TqZCVrc2ideGRY5TnhB0scXx0GPueaamF9y+juj7YvF4g7kETs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779148811; c=relaxed/simple;
	bh=kuTqi/4P3P1Pltknu+oTj37VkQ8fT36kuly6Uv6oqms=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gVb2d3Eh35BHkQZoi7pQY6FnocuJqXxdEbjRntnkKIdht10miRc8fpHfavgdTQ8P2tagNz8XJOemcehEY8SqzDm/e53J4z2YroMY98faHcApG406hElyG/HtbewFOMQ/ZuhbY8qmkjlrdO29jIA2qNYPY6IRv7lBiy8+m78GH3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCktNkqB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44772C2BCB7;
	Tue, 19 May 2026 00:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779148811;
	bh=kuTqi/4P3P1Pltknu+oTj37VkQ8fT36kuly6Uv6oqms=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vCktNkqBSfqF6Vy/AXyocNpgtv4NktC/pTSwmggCo0ErtHh1o5HCdWwT7NQzkKRar
	 lGtnvpX4i1qb5hMAqrSjwBb1z1OibIrgGxVoYLhQ+CO7UmrbcH1m+sDrY5iOHef5se
	 vQL38z8XnCRRTSnVI7yR/Kf86scP9sPKbqph0uBlWq1b0leqqxrk4ytsqZeqUbVY1d
	 KNnDgj5bcXcwI1Kj9MNqSy/oNyW1G9QQ8gmT+gtieMDkKepd0uqnj62FYFmoWV5KGd
	 5/MAlW3NELVtzP/bhe6MXpL5N8I4DfSWTccN31pQSrrbj1sizv0GWdkMbx84tw5vZ2
	 r9H6mih09flwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BC83930CBF;
	Tue, 19 May 2026 00:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 01/14] batman-adv: fix tp_meter counter underflow
 during
 shutdown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177914882239.2018613.11265100133321410962.git-patchwork-notify@kernel.org>
Date: Tue, 19 May 2026 00:00:22 +0000
References: <20260515095540.325586-2-sw@simonwunderlich.de>
In-Reply-To: <20260515095540.325586-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, rakukuip@gmail.com, stable@kernel.org,
 yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 bird@lzu.edu.cn, n05ec@lzu.edu.cn, sven@narfation.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289206-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,lists.open-mesh.org,gmail.com,lzu.edu.cn,narfation.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,narfation.org:email]
X-Rspamd-Queue-Id: 2567257557A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Sven Eckelmann <sven@narfation.org>:

On Fri, 15 May 2026 11:55:26 +0200 you wrote:
> From: Luxiao Xu <rakukuip@gmail.com>
> 
> batadv_tp_sender_shutdown() unconditionally decrements the "sending"
> atomic counter. If multiple paths (e.g. timeout, user cancel, and
> normal finish) call this function, the counter can underflow to -1.
> 
> Since the sender logic treats any non-zero value as "still sending",
> a negative value causes the sender kthread to loop indefinitely.
> This leads to a use-after-free when the interface is removed while
> the zombie thread is still active.
> 
> [...]

Here is the summary with links:
  - [net,01/14] batman-adv: fix tp_meter counter underflow during shutdown
    https://git.kernel.org/netdev/net/c/94f3b133168d
  - [net,02/14] batman-adv: tp_meter: fix tp_vars reference leak in receiver shutdown
    https://git.kernel.org/netdev/net/c/77098e4bea37
  - [net,03/14] batman-adv: tt: reject oversized local TVLV buffers
    https://git.kernel.org/netdev/net/c/1e9fab756f83
  - [net,04/14] batman-adv: tt: fix negative tt_buff_len
    https://git.kernel.org/netdev/net/c/b64963a2ceeb
  - [net,05/14] batman-adv: tt: fix negative last_changeset_len
    https://git.kernel.org/netdev/net/c/fc92cdfcb295
  - [net,06/14] batman-adv: tt: fix TOCTOU race for reported vlans
    https://git.kernel.org/netdev/net/c/94d27005016b
  - [net,07/14] batman-adv: tt: avoid empty VLAN responses
    https://git.kernel.org/netdev/net/c/fa1bd704940b
  - [net,08/14] batman-adv: tt: prevent TVLV entry number overflow
    https://git.kernel.org/netdev/net/c/99d9958fa10f
  - [net,09/14] batman-adv: fix fragment reassembly length accounting
    https://git.kernel.org/netdev/net/c/9cd3f16c320b
  - [net,10/14] batman-adv: clear current gateway during teardown
    https://git.kernel.org/netdev/net/c/a340a51ed801
  - [net,11/14] batman-adv: dat: handle forward allocation error
    https://git.kernel.org/netdev/net/c/2d8826a2d365
  - [net,12/14] batman-adv: tp_meter: avoid use of uninit sender vars
    https://git.kernel.org/netdev/net/c/6c65cf23d4c6
  - [net,13/14] batman-adv: frag: disallow unicast fragment in fragment
    https://git.kernel.org/netdev/net/c/bc62216dc8e2
  - [net,14/14] batman-adv: tp_meter: directly shut down timer on cleanup
    https://git.kernel.org/netdev/net/c/d5487249a81e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



