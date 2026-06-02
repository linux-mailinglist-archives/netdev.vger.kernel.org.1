Return-Path: <netdev+bounces-294396-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BGnhFsM7H2ryiwAAu9opvQ
	(envelope-from <netdev+bounces-294396-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:23:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD32631B70
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:23:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="kqrp/JhW";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294396-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294396-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 585B6304994E
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 20:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9938C356741;
	Tue,  2 Jun 2026 20:20:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FF931F9A3
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 20:20:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431604; cv=none; b=pUrd8RxE379K6qzJoxPyGI8bGpYOdFSHo+VdEnJkm7H+e8CzJyHhjWXrQu7a5wBiJeGFlup3Rfy945ZyYdNsBZ7iUi56oljiP092uSd96UnAmj8IWlCsH5oZfZR7b32X/P0JI7uBwlnq5CwY2NrtMvfhxjhuEtH0sZXWyK4klzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431604; c=relaxed/simple;
	bh=kgceho+0XlJOgyjZRI9SgRW99KuLQh6YrwAgdFK4xqQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h4WrnTXff7sO3KKNYSa0Q2QdLs25cOQKxPzsCStGhhaz38mjbbaP93m/QNxP8w7YN3kJP9eOjj5ZspIT88EKx9OsE77i8YP6KIfzBKX7fisL5MqJk4XH22r4zvQ1hIuSawpgh4jmq7cWrBWHsig4gxh+wq3isxbu/aFbKZOlOOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqrp/JhW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349E51F00893;
	Tue,  2 Jun 2026 20:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780431603;
	bh=xDL3noZQ4+c0Y0j3di47vZi21OPvES67D7iciL0Ar2w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kqrp/JhW9vIr5akotqIYHf8XfM9dUjrOapZzddYoA2NmFmfOXSpEiD4zHiitn+PUW
	 FOv6YeqTYz+THlCqz6Cd2z79V3B3/aZToPosBuh0rs3RBmZpFwnyiN7nl7TxDKE6ST
	 YddrBTWzuRUUop/4FXtcnTxCXVIqW43fDY3bQ6U1WDY31feN3SAA76NftLrQUs7ZI1
	 9kaCWJW9xqIg1BSxFTtzmyrlXrjfQUoKEItshjmXU57LcpiKrCtZ+w3sYmphJddHuh
	 UzpKRSsGH/FpS+YoRbr6xGF4Mmkg1Zgnpktg0nr83mYiV+43LMfPuR+Y+t7qEypUlz
	 KKa39aFESmZZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 451153811A72;
	Tue,  2 Jun 2026 20:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] doc/netlink: rt-link: fix binary attributes
 marked as strings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178043160512.1033842.9955682922935521032.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 20:20:05 +0000
References: <20260529121355.1564817-1-one-d-wide@protonmail.com>
In-Reply-To: <20260529121355.1564817-1-one-d-wide@protonmail.com>
To: Remy D. Farley <one-d-wide@protonmail.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294396-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:one-d-wide@protonmail.com,m:donald.hunter@gmail.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[protonmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,protonmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9CD32631B70

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 May 2026 12:14:44 +0000 you wrote:
> These link-attrs attributes were previously marked as strings:
> 
> - wireless - struct iw_event
> - protinfo - a nest of ifla6-attrs or linkinfo-brport-attrs
> - cost, priority - unused
> 
> Signed-off-by: Remy D. Farley <one-d-wide@protonmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] doc/netlink: rt-link: fix binary attributes marked as strings
    https://git.kernel.org/netdev/net-next/c/5996b5ab8b37

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



