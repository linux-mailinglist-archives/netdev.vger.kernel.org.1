Return-Path: <netdev+bounces-300930-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yWFfKgZmOGqkbwcAu9opvQ
	(envelope-from <netdev+bounces-300930-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 00:30:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D49F6ABC0C
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 00:30:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XeNl5Vpx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300930-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300930-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DAA183003D0E
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 22:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE172378D76;
	Sun, 21 Jun 2026 22:30:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FB437881E;
	Sun, 21 Jun 2026 22:30:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782081028; cv=none; b=IvGaKGwJVlC1nXlm1i8R41yfQEGUOJC0i6OMsYnfWyyStHwy4YMLHA+hFboYHp0VCeVJlL3TjqihEch5b+gQjbuicBcNYySqYaOj2Xn/On5oBe8A9L+m5M2OYwK0YRqYX4l0ArH3bY+YIPBwBCy0h3hLFwepk7ubclQ3MEDDbcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782081028; c=relaxed/simple;
	bh=15B/lacSNFYA2OWblbx5KQn9S79opc/vc2/I8DKfx/c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uQxr2fKJbdRitVuAG3wfTXBFOxhmLkTFF2I6+8cy1pwDZwb00thG4Ag/2imRnoaWiZfS0m1Ch5hJwU0YhghKzgsmYoDhfkNyB9lhLHmVPPV/FYX02q+z1RH5FF6VNAlSeE+SJSWahFLZ+WRJM0HQe2gWRKUbCbGRGDrWBwZYxss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeNl5Vpx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9422A1F000E9;
	Sun, 21 Jun 2026 22:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782081027;
	bh=SGNt+35FCNLvntUInR0SXGDQoWDIFm5v5divyZnyAA0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XeNl5VpxxFpCCsPcp3mucx3jqdx3o3cQdcJG+FxNC1bxwogY8pMat/Kwp0Qlrr+NT
	 tPMmp22+FcSSDFLSSrIFPMhjZewp6lozJcg/HuFYO4IhCfOLkr7T8/sn/ii3CvE8W5
	 Dx5UgEpQspNnOgPF7oN4zxf2quY+qXzM5T0xHRRaCXnM3RiiZuIcIhKQ2Hsm47S+7v
	 8K0p0ef4XFrJSOFGs39PKhLpw9PspuGt99JQPoRI6bq3ePsgh3ahUoaaEgCamy7P7k
	 TVfRLZEUAxiSNJFr2YyNQ2OGkeCqCNHiSW9Z2CG1bBzb76rjYmeGgwUB9nid4z/DUt
	 8AJZIAM+eX3bg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1976C3AAA6ED;
	Sun, 21 Jun 2026 22:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: ioam: fix type confusion of dst_entry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178208101866.524849.8650145418163928535.git-patchwork-notify@kernel.org>
Date: Sun, 21 Jun 2026 22:30:18 +0000
References: <20260618104336.48934-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260618104336.48934-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, justin.iurman@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-300930-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:netdev@vger.kernel.org,m:justin.iurman@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:justiniurman@gmail.com,s:lists@lfdr.de];
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
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D49F6ABC0C

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Jun 2026 18:43:35 +0800 you wrote:
> IOAM uses a dummy dst_entry(null_dst) to mark that the destination should
> not be changed after the transformation. This dst is stored in the IOAM lwt
> state and may be passed to dst_cache_set_ip6().
> 
> However, the IPv6 dst cache path eventually calls rt6_get_cookie(), which
> treats the dst_entry as part of a struct rt6_info. Since the null_dst was
> embedded directly as a struct dst_entry in struct ioam6_lwt, this resulted
> in an invalid cast and rt6_get_cookie() reading fields from the wrong
> object.
> 
> [...]

Here is the summary with links:
  - [net] ipv6: ioam: fix type confusion of dst_entry
    https://git.kernel.org/netdev/net/c/9ed19e11d214

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



