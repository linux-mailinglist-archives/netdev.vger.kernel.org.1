Return-Path: <netdev+bounces-258675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBSvF26Kj2nURQEAu9opvQ
	(envelope-from <netdev+bounces-258675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 21:32:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D85139713
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 21:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A650C312DA4F
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 20:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9823729BD80;
	Fri, 13 Feb 2026 20:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbycWZte"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7557D299943
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 20:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771014616; cv=none; b=S7VLzYfSZhuY5EqQHpuaEGDZf9AeZrLY3MV0vy+0vmhbWoCehWMtPk23nXSGeIBMkp5mtBn/d3FTzrFE6t5PDWdxGgMSYo9XaoVz/d8CYB8xEZHJwqGuuTwtbSRNYldLvAJiC2p3IcU/SKqcRxxxOGlFD/DxejGZ95zCpHtHRdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771014616; c=relaxed/simple;
	bh=9IjSHHjeb5WeV2EN8Zp4C11XkMOkEZrfQxagLdlYTvE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Nsd9WAs0ye/CSE68AWURnsesJCA58UmHlwel6NLFblGF6rHhznoNhh2K8vde4FlyU9wtEeD1g/DjEBH/S8EPW0uTAqXYVJo1+LltkDobSNaUlwya6ZTjYj8iQzzk3qBSztAG3Snc5uqG0pU52RzQC+41D9peCQ48MJmeWfNyi1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbycWZte; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487E8C19421;
	Fri, 13 Feb 2026 20:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771014616;
	bh=9IjSHHjeb5WeV2EN8Zp4C11XkMOkEZrfQxagLdlYTvE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GbycWZtemwyxTvBp/o61d73mvZymRi6ywS00PFXiWlCOq5a6erlmqzpoB1PrClEKZ
	 /ra33x8fcKj8mgfhbGQM2pTt9rzlNRiEgws/8wWq//vZQXt/j4Tz65NuKVHwgjY5Ed
	 rTwQdA/XRjjcLgVOriicuzpe8OUt/7xai+6teUQgkUaiefjOhttJMfo59lc07twBJo
	 Cv8IMPOi1s8c8g12xKzhZ5auTsn9hnpaQFAstR9ZSzjEb2dza3Kcr8QUeVl9XH78EI
	 BYFPfAbHps0JSj3eA2qtQoz3h3iWl649LrUGb6v4emQdG0AHKqkwHm0wOqhk6kf1vA
	 nacHcjBhNnOEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 481E33811A44;
	Fri, 13 Feb 2026 20:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ipv6: ioam: fix heap buffer overflow in
 __ioam6_fill_trace_data()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177101461007.2548179.1583547596044815292.git-patchwork-notify@kernel.org>
Date: Fri, 13 Feb 2026 20:30:10 +0000
References: <20260211040412.86195-1-qjx1298677004@gmail.com>
In-Reply-To: <20260211040412.86195-1-qjx1298677004@gmail.com>
To: Qanux <qjx1298677004@gmail.com>
Cc: netdev@vger.kernel.org, justin.iurman@uliege.be, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258675-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B3D85139713
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Feb 2026 12:04:12 +0800 you wrote:
> On the receive path, __ioam6_fill_trace_data() uses trace->nodelen
> to decide how much data to write for each node. It trusts this field
> as-is from the incoming packet, with no consistency check against
> trace->type (the 24-bit field that tells which data items are
> present). A crafted packet can set nodelen=0 while setting type bits
> 0-21, causing the function to write ~100 bytes past the allocated
> region (into skb_shared_info), which corrupts adjacent heap memory
> and leads to a kernel panic.
> 
> [...]

Here is the summary with links:
  - [net,v2] ipv6: ioam: fix heap buffer overflow in __ioam6_fill_trace_data()
    https://git.kernel.org/netdev/net/c/6db8b56eed62

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



