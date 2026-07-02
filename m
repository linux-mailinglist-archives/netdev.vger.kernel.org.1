Return-Path: <netdev+bounces-304038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kCrrNiUyRmpELgsAu9opvQ
	(envelope-from <netdev+bounces-304038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:40:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1416F5618
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:40:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kThrb5fX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304038-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304038-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A18653014E5F
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 08:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DA43655E2;
	Thu,  2 Jul 2026 08:50:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AF7358384;
	Thu,  2 Jul 2026 08:50:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782982227; cv=none; b=lxXsTcb+po/zlhH8F4f8ceS5g3+qh74wBoBDlcbLNeTuQyMaltZR9DeAV8F9r+Sz8cndBHcXvphgKuvGXxTv/8rlZQCcMA3AtFyZ7bq/HiI76Quv+qt95A/QlXnZPJkXenntu4FJngHvm/iz22AE/3LkgBx7dbXH07YYsX21sek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782982227; c=relaxed/simple;
	bh=SvnIdff4lFSi/oK8to5Hi1LFw7xHoqaDqrBzYy2auC8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dcVneh5h2Jq16PxUKrG7APnTHO4Oa5jNyW2VD4DaB0LqfbcpRPU6uViLmNaiUbwoPmbopyQyCx0ufDsBO97MNc1wxUtwv8lYAW4ViAoZ2imOuUaXQ6gDQtir63tTnrpaJE6pYEwtlSHgltYefTrhwDn2v8r4FDnTasAMQNVMjUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kThrb5fX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB481F000E9;
	Thu,  2 Jul 2026 08:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782982226;
	bh=rhxeF43WyemNyllTwqUsGUcBXIry0Dl0g/EQ590O6Yo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kThrb5fX38chmzb9y35tycR6aL2Y2DuCPVk0G57doPYKL8DR0yrJtOrsovmmttLSy
	 FsA9lr0YZV22HDSbSEy9QiBWHzfOz13P3chp1ohak70bghZ+h8/lY6Uq+rnmZf2xJv
	 98zQhyFsA7lxjjTCgGQqoBcAmHALVBtGP6C6jrw5gXET6a+GkVcMsCkUCdgM+L+RA2
	 0tyBaT6/v4je8EyP3vuU91lc+uz9Zdu3E8MfHQetBzj8Bz+3YpZKKfxZFbZ5NcW+7q
	 4vYADYEZ/4NXOQbnGh92DgVCAjXvxw+SWTKIaLwJxNCeWZ4MqOkJvUYHgnkiucnNPC
	 UMr1csfjyEjeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AD23926665;
	Thu,  2 Jul 2026 08:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: remove the orphaned IBM eHEA driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178298220914.1528507.15309784548994376903.git-patchwork-notify@kernel.org>
Date: Thu, 02 Jul 2026 08:50:09 +0000
References: <20260629211343.3712775-1-drc@linux.ibm.com>
In-Reply-To: <20260629211343.3712775-1-drc@linux.ibm.com>
To: David Christensen <drc@linux.ibm.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304038-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,ellerman.id.au,gmail.com,csgroup.eu,vger.kernel.org,lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:drc@linux.ibm.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:christophe.leroy@csgroup.eu,m:netdev@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF1416F5618

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 29 Jun 2026 16:13:41 -0500 you wrote:
> The IBM eHEA (Ethernet Host Ethernet Adapter) driver has been orphaned
> since April 2024 with no active maintainer stepping forward. This series
> removes the driver and associated references from the kernel tree.
> 
> The driver was marked as an Orphan on April 18, 2024:
> 
> commit 97ec32b583bb ("MAINTAINERS: eth: mark IBM eHEA as an Orphan")
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] ehea: remove the ehea driver
    https://git.kernel.org/netdev/net-next/c/eb56577ae9a5
  - [net-next,2/2] powerpc: remove ehea driver references
    https://git.kernel.org/netdev/net-next/c/4bbb6f594070

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



