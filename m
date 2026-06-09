Return-Path: <netdev+bounces-296866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Rc7wJ7N6J2oyyAIAu9opvQ
	(envelope-from <netdev+bounces-296866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 04:30:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E58F465BDAF
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 04:30:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RMkihzRm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296866-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296866-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 951053018D46
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 02:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2614B30CDB6;
	Tue,  9 Jun 2026 02:30:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9482823BCF7
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 02:30:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780972209; cv=none; b=a2oGS2W69M0HRohO7RBcB96HOrKMeAc9Ylh9oZqyogIo0hZ2B8tKDK6NxXuTpCVTGyy+vRUDvwwjJ0HutQcmTHw+CGlUxirdsm3ktGzgVcbEvBLcfYwbJ+NPQ2J/MMBqtB3o7ccug9NU08gii/zUuM5/XFjlzZv8idzYKObk9SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780972209; c=relaxed/simple;
	bh=6zRaNyyx5p1RPDC+gDtT4asXL6wZXukFfZVzd6Rlhx4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hLQbHVR/l1yYFSr/VkIolE3a9ADZ65IoXk1cz2Mik2FfdRzUS1ZA5jDpxQS5AR5hJ6LvJai6Oe8O0hXHd5LqjVYHl8O/29+gbLbNunUIMeuSKUK2NUndxOUuyUZ/j9y1F1ekYdIiCquHw+6UEYfYkL64C7nUgZHOkj8MN8yMOvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMkihzRm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E901F00893;
	Tue,  9 Jun 2026 02:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780972207;
	bh=6Z8UMPOAwqlMRkd3DNRjrUV2kgo7wRobAA3f3uOBeok=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RMkihzRmSXUGGu9sWWMPRlRFVNrWmiYRyZQZADJDco/nuub1zE9Kd/3z3q67LMIgo
	 Ad3PpDmdmLWSOFKVHk4htdHPvaCtSIazPl3pmbQ9shbKOd86mrc0hZ5lkYQdGjxpqz
	 hIghrR1koXPEcdHRNzzEhcL2KcYem8iGfK1qDbeH6xyzfOXdSvUS2bvqFS/DtLLWKx
	 l2mVCau4C3O4Qj9o/XHy9B0v5/GAkDwfOH8LWmvwGUp7DFeESMre7dFc6idjr+Azrn
	 kX8AZrxfiNNCrngyFpQ0JQYi7dewirW7ntBy7zNRS8mWWB2XAKKmUc7f6U2DYfDUJ/
	 gdOJLqW5Naeyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1984B3822D43;
	Tue,  9 Jun 2026 02:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] if_ether.h: add 802.1AC, warn about GRE 0x00FE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178097220564.1760827.5382787915538818000.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 02:30:05 +0000
References: <20260605164144.81184-1-equinox@diac24.net>
In-Reply-To: <20260605164144.81184-1-equinox@diac24.net>
To: David 'equinox' Lamparter <equinox@diac24.net>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296866-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:equinox@diac24.net,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E58F465BDAF

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  5 Jun 2026 18:41:44 +0200 you wrote:
> Because LLC wasn't complicated/annoying enough, there's 2 more
> "ethertypes" being used for it:
> 
> - 0x8870 is pretty "normal", it got standardized in
>   802.1AC-2016/Cor1-2018 for transporting LLC frames > 1500 bytes.
>   It simply replaces the length value (which is no longer encoded, and
>   must now be derived from the packet.)  The actual value dates back to
>   2001; https://datatracker.ietf.org/doc/html/draft-ietf-isis-ext-eth-01
>   (it was used without "proper" standardization for a long time)
> 
> [...]

Here is the summary with links:
  - if_ether.h: add 802.1AC, warn about GRE 0x00FE
    https://git.kernel.org/netdev/net-next/c/69710a37bad6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



