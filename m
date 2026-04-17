Return-Path: <netdev+bounces-279214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFQrJySf4WkIvwAAu9opvQ
	(envelope-from <netdev+bounces-279214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 04:47:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F26C5416539
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 04:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88BDD31BE655
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 02:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8AE30CDBC;
	Fri, 17 Apr 2026 02:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvTyebzA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACB1306B37;
	Fri, 17 Apr 2026 02:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776393653; cv=none; b=T/Lpytkt20v2itA5mgfCACpzEFqP0WCrReOywEyODTLi75TAYju5v+5i5gSXiOsSFCbObyxYYHdfh0DYNx5btZaTi2keN9kT3tumg6PsIWE25wWqBWgUZTY0H4+oC31wxXyXM48HN/VEmpbm0o4PdReI9FxrwKuQ8PV7Dz6jUaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776393653; c=relaxed/simple;
	bh=+vhgaR1BXJDvmGf7SyjktyUqgIKyld+4RvwBjZ08Xcs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ayf2V0Uct3EjqowrGczOuLZC2ntN/P+d9BrSFeVFuoTPDeutzHAaC5KNDdqMIjpcJMc9uE1imczkm5siOIXddarBLTWxM/GWggljioomhwPFzzl4wEx+S5qWKhZc834zBzwi2Hk4CNDA2Y1pBRacO7OydB9zJzcaqmfAejb53zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvTyebzA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C918C2BCB3;
	Fri, 17 Apr 2026 02:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776393653;
	bh=+vhgaR1BXJDvmGf7SyjktyUqgIKyld+4RvwBjZ08Xcs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QvTyebzAxB837AI2bJik2YEa6HV+jjpfjLRTh4RufpTKwReIk6ELQV6oWI9+mX71j
	 +QLGKOKjpFXKVMG2cLGN4V+MiWQeJaUY0ViwCbsac9vagaxHmVsCor4ZHr//AXWZyI
	 oj+/POAr2z7r6EOOJ3zYvuYVfqY111IwpUwJQLMwgkinDdN6lWqUG4PBpAyvQN63GC
	 A1h/462yyxfdyDE7J0s+H9HqZuhUW4TGECY0UzJof6GDTESpJgtb1SrGDqybXhl/QA
	 DXMtPhk/V7T43Uv0GfTWFgFtVaeLj5wdgG0vdOo0PWhW6gghHxZSzAsrWgud0ENoQO
	 lUGMdjrzT8BKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E96380AA76;
	Fri, 17 Apr 2026 02:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: remove redundant netdev_lock_ops() from
 conduit
 ethtool ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177639362129.3490984.6644525371852787274.git-patchwork-notify@kernel.org>
Date: Fri, 17 Apr 2026 02:40:21 +0000
References: <20260414231035.1917035-1-sdf@fomichev.me>
In-Reply-To: <20260414231035.1917035-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, olteanv@gmail.com,
 horms@kernel.org, sdf@fomichev.me, linux-kernel@vger.kernel.org,
 maxime.chevallier@bootlin.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279214-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com,fomichev.me,bootlin.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F26C5416539
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Apr 2026 16:10:35 -0700 you wrote:
> DSA replaces the conduit (master) device's ethtool_ops with its own
> wrappers that aggregate stats from both the conduit and DSA switch
> ports. Taking the lock again inside the DSA wrappers causes a deadlock.
> 
> Stumbled upon this when booting qemu with fbnic and CONFIG_NET_DSA_LOOP=y
> (which looks like some kind of testing device that auto-populates the ports
> of eth0). `ethtool -i` is enough to deadlock. This means we have basically zero
> coverage for DSA stuff with real ops locked devs.
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: remove redundant netdev_lock_ops() from conduit ethtool ops
    https://git.kernel.org/netdev/net/c/0f99e0c3e19b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



