Return-Path: <netdev+bounces-296014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id atJlOjF4I2oBuQEAu9opvQ
	(envelope-from <netdev+bounces-296014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 03:30:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8176F64C1C1
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 03:30:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WWOWmfWM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296014-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296014-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 99E213038861
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 01:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F78D2236E3;
	Sat,  6 Jun 2026 01:30:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D6419539F;
	Sat,  6 Jun 2026 01:30:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780709416; cv=none; b=SZbB92DDOoHJcOjzlMp5wMJ29BkptTc90V5PzZKYaepEaG5VQLiZFez6VJwE3zmVEfPimrQnvWfwu8zLOV6g/Wi8wyzB9D4nF6A1HRao3Nb2DsbOh7ERtoWAj2JcOjyJZL9h+51x+14AlI1RQfj1fqUP8genyMnb/Ay6K6XXV8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780709416; c=relaxed/simple;
	bh=pWnjxDwKWDQKvXjT95dOKH/pyj/RyfMzumZtXsuNIr0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dXNBl1GmD3Q54474e5DAtKCN5zSsKBt4ush8dpLEAiJprgPXeYzmxfhaLFGYGNQkFoQJRuQkaVUERwj16lakTmtI7yPlpqL1dcfulQtNjKDoHmpr+lEa33AHYcrJMdyzdmOEBWy8iICnBuXUvXy9jgc7PfSX8XUqjF0bdSzzrGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWOWmfWM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF35F1F00893;
	Sat,  6 Jun 2026 01:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780709415;
	bh=XudeQH2UZC1D/tqB/AIz6YfH6sW5aR/FrI7UO/3CU8s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WWOWmfWMQ8op4AIUe+WhfgzRxPpxGHh0gq8imOHr+NZCfvpBwSgs+El0GHQu4CXID
	 wlADCjiTuGjyQqxidgoWH1wa/KTpaYbRJyGFR6UxDeBimZxmBisiRV1sJHW80JEIlr
	 aH1JM/ODV+AQpk9OnEnX3krhMR+rfHjtIKpHSzFnezsGQzAiMn0VK+NvbVZy3R7Vbv
	 YAv7TOPgQjRkxawZPbPw+uSr5MikB08iZsxTyBGSrNdoh5by7McX/uLEtgTsy/J3aS
	 buNrRashh9w4x0Hdqr6udzDqhenl3kmHVNB13H82oWS9HKoQX+n1ZoZNLe9PkoA7OJ
	 1B9i+PDATJqPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568833930A9C;
	Sat,  6 Jun 2026 01:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: devmem: allow bind-rx from non-init
 user namespaces
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178070941488.3983833.14749974405723853859.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jun 2026 01:30:14 +0000
References: <20260602-nl-prov-v2-0-ad721142c641@meta.com>
In-Reply-To: <20260602-nl-prov-v2-0-ad721142c641@meta.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 sdf@fomichev.me, almasrymina@google.com, daniel@iogearbox.net,
 matttbe@kernel.org, petrm@nvidia.com, dw@davidwei.uk, bobbyeshleman@meta.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296014-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS(0.00)[m:bobbyeshleman@gmail.com,m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:sdf@fomichev.me,m:almasrymina@google.com,m:daniel@iogearbox.net,m:matttbe@kernel.org,m:petrm@nvidia.com,m:dw@davidwei.uk,m:bobbyeshleman@meta.com,m:donaldhunter@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,vger.kernel.org,fomichev.me,iogearbox.net,nvidia.com,davidwei.uk,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8176F64C1C1

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 02 Jun 2026 18:37:30 -0700 you wrote:
> NETDEV_CMD_BIND_RX is GENL_ADMIN_PERM, which checks CAP_NET_ADMIN
> against init_user_ns. With netkit and netns support for devmem, it is
> now useful to let workloads holding CAP_NET_ADMIN only in their own
> user_ns issue bind-rx for a netns owned by that user_ns.
> 
> The first patch switches the flag to GENL_UNS_ADMIN_PERM so the check
> uses the target netns's owning user_ns. Init remains permitted.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: devmem: allow bind-rx from non-init user namespaces
    https://git.kernel.org/netdev/net-next/c/e302aa3d00fb
  - [net-next,v2,2/2] selftests: drv-net: add userns devmem RX test
    https://git.kernel.org/netdev/net-next/c/78c1930198fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



