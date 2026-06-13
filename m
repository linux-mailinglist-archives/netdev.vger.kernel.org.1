Return-Path: <netdev+bounces-298848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NciZBdOrLGpsVAQAu9opvQ
	(envelope-from <netdev+bounces-298848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:01:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6084667D608
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:01:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BcC7pzAm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298848-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298848-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F3683213889
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2BA261B70;
	Sat, 13 Jun 2026 01:00:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEC1255F2C
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 01:00:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781312417; cv=none; b=LY/7AeGPv9jhLbghv4ubc50oYdz56vLwCK2wZ1xdh9R0NE6SOA3kNSyEeuMupc+FK3Q9N/aULFxYHPEF47rLLtAkpkqxkwVaGvgNlqvt7COb7ZvMZj5Nr2wg45tP0KNNbLl8M63rGRc3PnJ/Uin8dkD+BRhWq4Oq5HJKYXxQdAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781312417; c=relaxed/simple;
	bh=0h2brqm6UcFB9+XNfUP9L6t59QecqykUNMjttWTLIVY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nrv5+vgbeiY87zKhTC6NHb287Rd38Lv5IpKXE/4IBqJNTW+MM6kHKzS8Pi7UTL09qol0Z16x2dE6LWVgBWTwwayyPX6D7esxGk0iUyhbTxjemisiYTThx6UEPgwdaih97Fevg6jlRd8W/R6fzEFh7t1b87aEZEaK2+MuuE+FIRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcC7pzAm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463A61F000E9;
	Sat, 13 Jun 2026 01:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781312416;
	bh=XTUM/NEUK8egCcyma1exCBdUidBx+9eNNS0ckpQbU04=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BcC7pzAmp81W6ZtxQdpXUrZG4zFHp1K1snLukH8fdMbeQ32wu5ByxhVR3k9lNtwW0
	 IFPbEGoxNYcUSJnb52UMG2MoTGOMbAx73ZAjRZsB9wBYc9v9QnlAIVBpebq2PvbhIh
	 oF5tT/Hi/KUupnY2j6h5/PRD6oIjoHu75wtHRo8i5IN4OzXI7yk9qPk/QnHCoGcBfT
	 YRLlaIE1QCYROxMEgbTkBmbS2nujLZmjcIaaw/O2rTz9uilMoQkvLyNPKxVHZRbz5V
	 aLXF8YmE8I8ENwPchdpnbNkL8PTFZVlptkNXJLOJRIpukzwAo90T9RdTJhryy5QToM
	 3kdL6RaChooHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19B7739E9607;
	Sat, 13 Jun 2026 01:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] net: watchdog: fix refcount tracking races
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178131241264.1315131.11092895992307738677.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 01:00:12 +0000
References: <20260611152737.2580480-1-edumazet@google.com>
In-Reply-To: <20260611152737.2580480-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+381d82bbf0253710b35d@syzkaller.appspotmail.com,
 syzbot+3479efbc2821cb2a79f2@syzkaller.appspotmail.com
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
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-298848-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:syzbot+381d82bbf0253710b35d@syzkaller.appspotmail.com,m:syzbot+3479efbc2821cb2a79f2@syzkaller.appspotmail.com,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,381d82bbf0253710b35d,3479efbc2821cb2a79f2];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6084667D608

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 15:27:37 +0000 you wrote:
> Blamed commit converted the untracked dev_hold()/dev_put() calls
> in the watchdog code to use the tracked dev_hold_track()/dev_put_track()
> (which were later renamed/interfaced to netdev_hold() and netdev_put()).
> 
> By introducing dev->watchdog_dev_tracker to store the
> reference tracking information without adding synchronization
> between netdev_watchdog_up() and dev_watchdog(), it enabled the
> race condition where this pointer could be overwritten or freed
> concurrently, leading to the list corruption crash syzbot reported:
> 
> [...]

Here is the summary with links:
  - [v3,net] net: watchdog: fix refcount tracking races
    https://git.kernel.org/netdev/net/c/8eed5519e496

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



