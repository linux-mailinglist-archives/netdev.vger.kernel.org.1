Return-Path: <netdev+bounces-298841-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wxtrFe6mLGq7UQQAu9opvQ
	(envelope-from <netdev+bounces-298841-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 02:40:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E3867D541
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 02:40:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OjT9YPY8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298841-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298841-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CC4D317BAAC
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 00:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F54F1F099C;
	Sat, 13 Jun 2026 00:40:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F44F63B9;
	Sat, 13 Jun 2026 00:40:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781311210; cv=none; b=lkA1RT6qRPfLSmpoZUc/6X20FdlDobjyyAGK0iioB8WADtbN+nSIBG5iTNRnPqHodUZPe/PZa3atRVGOyY8onoolSj93zuj8X3nmJHKWXiBBwZuNj4cvhCsTs2HGCursyFCgwZej3Fljk1WZRoEvFnysvfePhne15yCetvAkbvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781311210; c=relaxed/simple;
	bh=GrIsekCfLZfXPKDJYonqMRDao/UsouriD4WYGi6l6UE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nSPJ2exSMshREsRbJhQv/mxY/4HNnqrVMMmMFTpvMgtSdOzBWNHGBmjcua9J4gILgcSRCtDc9vNkQOGeqQUlUwUxywM0Dl+RTNmad78vvWxgPEeQZmOmv4Syo4AeU9ftY2vBlDXP7YZx88tea2C/sIL9xiRe6j34uvUtG4SIva0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjT9YPY8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF29C1F000E9;
	Sat, 13 Jun 2026 00:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781311208;
	bh=6PNkjT15m64g+Jsy3PTzP7sBCQpV4Zugg+Mp3HRjGkU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OjT9YPY8cBt3tIOEDTgwOmQVkmNvYqABj8T95fwTgfequKCgMHqzq7PCRcqLwawki
	 FrRdTv8VreXblWytFCXHy/11zuYug5OmXeGm/Oc6nFWeIig9qlhPEjlfllTkzZedip
	 yAO++5nr/khS4/WBXyWK5DZ2UvVYSBro57k9K+Hzt6fG1W1GmqVfJeslUNFncLZDDN
	 3azQc/RieKsYt7jy4+vxWO6Zve7JkrsyCNdy70nXh0wJLoB2YMXWfhE7nzwWhh1IzQ
	 Ljw0DjTlBKm/7HqFAp5v1bKvW43Vw0WfHnAGPQ2NLyHUvQU0IMC1AV+TMClwPvJ5O0
	 Qpv4AasD2xacA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A6D39E9607;
	Sat, 13 Jun 2026 00:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: iou-zcrx: defer listen() until after zcrx
 setup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178131120515.1308931.1175372456893962436.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 00:40:05 +0000
References: <20260611160341.3697227-2-dtatulea@nvidia.com>
In-Reply-To: <20260611160341.3697227-2-dtatulea@nvidia.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, dw@davidwei.uk,
 axboe@kernel.dk, cratiu@nvidia.com, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298841-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:dtatulea@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shuah@kernel.org,m:dw@davidwei.uk,m:axboe@kernel.dk,m:cratiu@nvidia.com,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99E3867D541

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 19:03:41 +0300 you wrote:
> The server binds the queues for zero-copy after listen(). If the client
> does a connect() during this time it can fail with EHOSTUNREACH on
> a cold system. This was encountered with the mlx5 driver where binding
> the .ndo_queue_start() is a slow operation during which no packets
> can be exchanged.
> 
> This change moves listen() after queue binding, when the test server is
> fully operational.
> 
> [...]

Here is the summary with links:
  - [net] selftests: iou-zcrx: defer listen() until after zcrx setup
    https://git.kernel.org/netdev/net-next/c/ec782be97d2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



