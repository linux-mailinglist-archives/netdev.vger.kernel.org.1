Return-Path: <netdev+bounces-302364-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xEGlDsdTQGo+ewkAu9opvQ
	(envelope-from <netdev+bounces-302364-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 00:50:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABF66D2C63
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 00:50:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=e8mZdO38;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302364-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302364-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C7303018772
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 22:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A935334692;
	Sat, 27 Jun 2026 22:50:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ED43016E0;
	Sat, 27 Jun 2026 22:50:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782600642; cv=none; b=KHfUqQAHsBkfDUu+YfaPKcIjOUPL9UQlygNWwPQqlit4kw8LZzSOSLzNAsMMxgn1/Pp+oxJW1traCg71y+bras4lPtd/hBcyY6gEVz5x2puUOYJxIWkrqJbL05v1R00kJzCSd5EEAqcupQoYIPZ9pq9X5hyQgmdwI7qSn5fuuqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782600642; c=relaxed/simple;
	bh=dJ7pXABRGOScU6m4JSi0LnBB2aXeCP2ysvxhvfBOh4M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ryedgdm/u6N6px567TudISzt8hMN78t/Udh+ZmAjZg8CTzwl8EJ+WwtI8EYsXg5njCBt/fSw6Bbw71nKIU0k8qBkoR/j19XciusXx5ewrEyYYnxEtuOuLgM/BlZNaPrpZp/mIpJsD9oRBhsLXthl/+xzkyEbP+JKksFxP/5Hk1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8mZdO38; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1538B1F000E9;
	Sat, 27 Jun 2026 22:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782600641;
	bh=KK1xQmf+wVy5ZvgMHkZv2n76zynSmPXrIRD2VdxwkJ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=e8mZdO38R36kEk4ixQxV02UtHkI/bO/JKZpF8prhj0Uf3ahkON7dMN8yJypr+mxPc
	 AzZCor7nxsgwwzkuge5w8PPYFZqD6UbyaNG2B+JY1CyNo7p8HuVhYXSPN2Y5npo0FM
	 mzPbnJK6tN9j9FYs8JQj10PvP2d4Qp7Pu4zPZM0OL9gld5wNn1Z2eNwN1+IfIEewqa
	 cQpWjzhUi/RH3mobLGhKAHC9evQ6YfYR2yR2YmPf11m5Pp3MeUL/2FPDijtWB8ZoZ5
	 y6x+oDn/CuhGkMt3sPX5D7op2+9nqLE/c7alJm+W9Kd0xPpupb5rn/l5Uya2HM4BD1
	 CUWJ08s41GZ1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198AD3938452;
	Sat, 27 Jun 2026 22:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: enetc: check the number of BDs needed for
 xdp_frame
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178260062679.1451849.6906135488386878812.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jun 2026 22:50:26 +0000
References: <20260626073244.2168214-1-wei.fang@oss.nxp.com>
In-Reply-To: <20260626073244.2168214-1-wei.fang@oss.nxp.com>
To: Wei Fang (OSS) <wei.fang@oss.nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, wei.fang@nxp.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,lists.linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302364-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:wei.fang@oss.nxp.com,m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:wei.fang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6ABF66D2C63

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 26 Jun 2026 15:32:44 +0800 you wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> The size of xdp_redirect_arr array is ENETC_MAX_SKB_FRAGS. However, the
> number of fragments contained in xdp_frame may be greater than or equal
> to ENETC_MAX_SKB_FRAGS, which will cause the access to xdp_redirect_arr
> to be out of bounds.
> 
> [...]

Here is the summary with links:
  - [net] net: enetc: check the number of BDs needed for xdp_frame
    https://git.kernel.org/netdev/net/c/555c5475e787

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



