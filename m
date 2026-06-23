Return-Path: <netdev+bounces-301234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YxBnJMPhOWoyygcAu9opvQ
	(envelope-from <netdev+bounces-301234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 03:30:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E887E6B32F4
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 03:30:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Pc20cLSx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301234-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301234-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D7FA30471D1
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 01:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916B73845D8;
	Tue, 23 Jun 2026 01:30:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84528367291
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 01:30:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782178224; cv=none; b=ESiGHjBa3mtqI0wtXkqx72BSQ4MHxJd6hb0kjJ69Audjy+h8ESlN7XA8fRrUe5++g8YOwlkjuuKPykAq1snQUH2qOvRqWhPg4iaGaa0g0yYV77IGPG12ErGQW2DoTN/JcCzyZelWJce3xie0ar45XvsWgIpchTUiRzVB8CsljW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782178224; c=relaxed/simple;
	bh=2j9+SDYjUWCMQ3WA0hukGYSdWQQGvJKE9wM/UKFPZmI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AQ+uByN9KoR5BX1K0ACVtSin4RJGQhRZdLvC1y/LJ7ONWKceLzA6SEivkvkQbJlRzQLFAVQ4cYg8Ln+QBdRgGTQhuYQieatm8p0W8hk6FWv4R9sUBWAhL0vvw+Z7qN4oke5i2v9o+iIUhT13FETgFt5Bl8csLGA63Qx0q8IrlK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pc20cLSx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C731F000E9;
	Tue, 23 Jun 2026 01:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782178223;
	bh=qHdhSdX4B2wc7LUtgc2dBygUee7ufGmPo/4CRtH3UXI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Pc20cLSxLvdB6GCwxMGcmpEVc5Xukef1Hllpy+hddVmzUrOQFMJigmqzJlhplBe6l
	 n/Bcr51c/Ips55PmYOSKrMpAK67O1VESqEbIcCAJbaXz5B8MmETmZwsMdrUjuhEpF/
	 BEl6JanYS9b50xp7vqEdc/upIAf/vRXIjg0vc678PtrW1r0PSXiu1+TrO/H9p9Zf1X
	 1JTXBpb6v9KinyvKLUQIuDbvvoFW5yY7o993cK68gSKiVMuRp3Tz17Wd4S/flkn0C5
	 +zP8f8QLwuAZ5tLPEa3qlcOPJV/EZdb/K5dt5zbNPasOijnk9/lW/4B3IbFl+3hVDF
	 uktwxtPmjGE5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D123E393098F;
	Tue, 23 Jun 2026 01:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: Fix null-ptr-deref in fib6_nh_mtu_change().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178217821357.1493333.11557327325386713201.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jun 2026 01:30:13 +0000
References: <20260619045334.2427073-1-xmei5@asu.edu>
In-Reply-To: <20260619045334.2427073-1-xmei5@asu.edu>
To: Xiang Mei <xmei5@asu.edu>
Cc: dsahern@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, kuba@kernel.org,
 horms@kernel.org, bestswngs@gmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	URIBL_MULTI_FAIL(0.00)[vger.kernel.org:server fail,asu.edu:server fail,tor.lore.kernel.org:server fail];
	TAGGED_FROM(0.00)[bounces-301234-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,davemloft.net,google.com,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:dsahern@kernel.org,m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:kuba@kernel.org,m:horms@kernel.org,m:bestswngs@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E887E6B32F4

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Jun 2026 21:53:34 -0700 you wrote:
> From: Xiang Mei <xmei5@asu.edu>
> 
> fib6_nh_mtu_change() re-fetches idev via __in6_dev_get(arg->dev) and
> dereferences idev->cnf.mtu6 without a NULL check. addrconf_ifdown()
> clears dev->ip6_ptr with RCU_INIT_POINTER() after rt6_disable_ip() has
> released tb6_lock, so the RA-driven MTU walk can observe a NULL idev and
> oops. The caller rt6_mtu_change_route() guards its own __in6_dev_get(),
> but this re-fetch is unguarded; nexthop-backed routes survive
> addrconf_ifdown()'s flush, so the walk still reaches it after ip6_ptr is
> nulled.
> 
> [...]

Here is the summary with links:
  - [net] ipv6: Fix null-ptr-deref in fib6_nh_mtu_change().
    https://git.kernel.org/netdev/net/c/46c3b8191aad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



