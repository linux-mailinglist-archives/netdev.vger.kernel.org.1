Return-Path: <netdev+bounces-295557-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7rYaOVopImpUTQEAu9opvQ
	(envelope-from <netdev+bounces-295557-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:41:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2F1644795
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:41:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="D6/l1+tK";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295557-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295557-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 00BB93015A87
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 01:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DEA3DE422;
	Fri,  5 Jun 2026 01:40:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBA0364939;
	Fri,  5 Jun 2026 01:40:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623629; cv=none; b=OZuxOQNs4H+Byg8kIJsWpQTGlLsns7MqFIIHSAK+DbP55vHlRWbjZYh7Zo1oiq0iXYD6Pz2rFBuD+SSsCnd+J91eVuIgIi35w9bfyZdgXegwEzD67y6d/IfioOIsuwzH8E2bWtCnVS0soKhSvAJ3TMG8/4JVcgV6G1zZNENT844=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623629; c=relaxed/simple;
	bh=vRXAdQtaMB/n3LIqHdj8QcWdDFCWhTQBmDwBN/jt9rE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q9iCmXhyWvg6lhpfG5Z/NNKLfO3UDQ4XgFR2IcrOaPg1dlnmT//YEpSdQ1LBHSxLZzeh2F5Ox0/aXVI3RB7iBrTD743PeEnS/FOH1c1gZ4tc05jrYqWQT8ohrP4FSgH/T1dDtNYmm2lUUIn46ZMOziFiEvcHgOCbpA9nUVQ3S8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6/l1+tK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E021F00898;
	Fri,  5 Jun 2026 01:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780623617;
	bh=e1dGGFkL7mOP11H/4QSRAmNfsELjK81noFUNsbOWfS8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=D6/l1+tKegYdwgmTkTfH/p8zNg9Rfj/hINa3uVl5TscbpoVlJFuJERFuDM0iphxLz
	 UZ/dmKV1W16SiytwzfbllX361bYzPTxhMxiYEG4m9fa74MmIUI7lafNos4B32te6XH
	 2hH/taRnfuDiK1CNhhT9syTSQxsqdr5Tynay4sM43cJua50DBv8acpLqOsJZG1H1Vj
	 7BihyKrDYrOhtwIQOuOySYwdXkkOhOC3OrvMTMqHPdQWNAlNRYcmN9p2zZMcYE4y8+
	 28bmjnLfWRvsbiewu3/f4pO5/1uR5b3jvH00MgA15+1jPikghshbSa1Nuug5oVNkDY
	 K6rVmI2hyz1Kg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AA13930A8B;
	Fri,  5 Jun 2026 01:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ipv6: use READ_ONCE() for bindv6only default in
 inet6_create()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178062361789.3097022.10379548092017503549.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 01:40:17 +0000
References: <20260602002414.1504106-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260602002414.1504106-1-runyu.xiao@seu.edu.cn>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, idosch@nvidia.com, edumazet@google.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-295557-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:edumazet@google.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC2F1644795

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Jun 2026 08:24:14 +0800 you wrote:
> inet6_create() reads net->ipv6.sysctl.bindv6only locklessly.
> 
> Use READ_ONCE() for this sysctl access.
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
> v2:
> - Shorten the commit message per review feedback
> - Drop the Fixes and stable CC trailers
> 
> [...]

Here is the summary with links:
  - [net,v2] ipv6: use READ_ONCE() for bindv6only default in inet6_create()
    https://git.kernel.org/netdev/net-next/c/7a20eb54224a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



