Return-Path: <netdev+bounces-256315-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KklNv0EgmmYNgMAu9opvQ
	(envelope-from <netdev+bounces-256315-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 15:23:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 507B6DA86C
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 15:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2540930CF388
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 14:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9053A8FEC;
	Tue,  3 Feb 2026 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNjhqdyN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A94B3A8FF0;
	Tue,  3 Feb 2026 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770128441; cv=none; b=l5rMbH1kjkFYPbtP/mEtAbAwNruIxAtZ7HWITAFG9JA5ETKsXo/e4TmqozVNYYh5YjZevEPNZVCVHWN5GqKjWJJLbkBU6PtC2/OQ0lFLODyNA0EzfB7R0u//RpdVhKcc9cMg9U8bud1V+afSxjssuMKDJGnVnxkRUucQaB8eHD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770128441; c=relaxed/simple;
	bh=ez8ucbmwOj9gzsFO/T8FPJnRBbQCO4CFozMhXYpF4dQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fy8w5FYnzBxgo1OJc3/MJk1Onn+qyr269eu0CapTLwW9s6xgAaSKfo70h/9JNGFt0CvykBZgQ4G0L/lJSxhmNd6Pgfw/eI+sMrdPGepwCYQzpvbKkRn/lJ15ROE6YfVLx8OvjR65k+wOkDLQuxCeryExqXxY1oTdIUe7gDpyDPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNjhqdyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25964C116D0;
	Tue,  3 Feb 2026 14:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770128441;
	bh=ez8ucbmwOj9gzsFO/T8FPJnRBbQCO4CFozMhXYpF4dQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oNjhqdyNu3BoxqVXDqr0U49qdA0DhT97GzbKWHPnwOOoJEYe0aqh+nrzilz40QjT5
	 62P5SL4ul1H3RQtt4+WhhI7ljKMa59O7A3HqTqwg/oGzmwxSNcVg9pf+bp57h/OXt1
	 44ijuXjpRNWdIFl7bhRtUn8iFvIOj9GqX0gBvKy36cRqCb+bMfd82EEnFPL6itY7KH
	 iEvq1NAtLofIq1K6Io1/uCuqdz7om7Qkfry8skNl/cJJjG9fhD7CduPbBfF+hFNkXx
	 JJbfsKUrS9Qc1VOQT2XBR2tk8phy1YjSvDlwZJtPNcNpBNjz6POUCcoS7bt1+6F8dJ
	 QDnPe3rAD6F4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CE00E3808200;
	Tue,  3 Feb 2026 14:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/5] net: dsa: yt921x: Add DCB/QoS support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177012843762.1498169.4265155868013803304.git-patchwork-notify@kernel.org>
Date: Tue, 03 Feb 2026 14:20:37 +0000
References: <20260131021854.3405036-1-mmyangfl@gmail.com>
In-Reply-To: <20260131021854.3405036-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-256315-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 507B6DA86C
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 31 Jan 2026 10:18:46 +0800 you wrote:
> This series add DCB/QoS support to the driver.
> 
> v5: https://lore.kernel.org/r/20260128215202.2244266-1-mmyangfl@gmail.com
>   - fix xmit priority for tag driver
> v4: https://lore.kernel.org/r/20260127020847.1482724-1-mmyangfl@gmail.com
>   - change the color for DEI bit and add a comment for it
> v3: https://lore.kernel.org/r/20260125001328.3784006-1-mmyangfl@gmail.com
>   - fix port_del_dscp_prio()
>   - split yt921x_chip_setup()
> v2: https://lore.kernel.org/r/20260122194233.2777550-1-mmyangfl@gmail.com
>   - make DCB support optional
>   - refine with enum yt921x_app_selector
>   - add missing dscp_prio_mapping_is_global
>   - fix pcp support
> v1: https://lore.kernel.org/r/20260119185935.2072685-1-mmyangfl@gmail.com
>   - rebase
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/5] net: dsa: tag_yt921x: clarify priority and code fields
    https://git.kernel.org/netdev/net-next/c/a63daf73a587
  - [net-next,v6,2/5] net: dsa: tag_yt921x: add priority support
    https://git.kernel.org/netdev/net-next/c/8cdb2cc9a11b
  - [net-next,v6,3/5] net: dsa: yt921x: Refactor VLAN awareness setting
    https://git.kernel.org/netdev/net-next/c/75b85703fd48
  - [net-next,v6,4/5] net: dsa: yt921x: Refactor yt921x_chip_setup()
    https://git.kernel.org/netdev/net-next/c/95e6bcab3c08
  - [net-next,v6,5/5] net: dsa: yt921x: Add DCB/QoS support
    https://git.kernel.org/netdev/net-next/c/d5f778353fd4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



