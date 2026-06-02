Return-Path: <netdev+bounces-294372-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ci2WLJssH2qbiQAAu9opvQ
	(envelope-from <netdev+bounces-294372-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:18:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E38631599
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:18:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=M4aWfJ0d;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294372-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294372-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CF613045394
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 19:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22443A4F5E;
	Tue,  2 Jun 2026 19:10:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B31B3A5431
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 19:10:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780427444; cv=none; b=QXlWB9S6yRLm/iJrWbn9YNWf0qYJxX7ybvy5QcwzgugtFBwz5KYecKre/XZeo39ShyC+m2zbkC4mNdIFpcx6quM5u6ocuYTFKAg8SlNd1sReHXnLl7X4SvDbFXKDQbEybcmhFqxDB08hRoogcw49LuV9mxovOc5VPBnnrIdHGMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780427444; c=relaxed/simple;
	bh=hSAr0Gix1PSh9fDg+0Bh9uVtnEt1iXB9VstNymjQ714=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iQJrbqATm4fPnJ04ZhwulSU/gTsRioYrYf6UXOA1e9TueOWyC8UjP7LBIe0Z1D1AcmSNZfmZpF+sj0K2Lbc4qbNxt84dl622v5cNLl0b+zPlTRH4jRi9x2Cx1GqmY7mkusHTuDUZylutYcAA8Zc/qNu/LYug3S/8ge19MKikNf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4aWfJ0d; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC5F1F00893;
	Tue,  2 Jun 2026 19:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780427443;
	bh=/qDg78ixEj2MH/tGiTu0JsKHtgfhzCK3Z95O0mqgqiQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=M4aWfJ0d/k0caXpXHIqgJKr0AU1teEKFvLBu9TnK9IkxB695SPtPUgMNx4SbCpt1M
	 lPXgLBW3Cxji9S5VI9jGXbwRkKNBebQCf+NX/VnCUso7gshFP+Pio+DJRS4FPd0AXZ
	 ZXWH1YxY7GYYW1y+Gzm1NFMDB5z7vzgW1QKmS198F7C3YTr3jIfiDgX74zBvAsrfkn
	 t2+A7aftMNe3l3UEpV//bS5q0wHOZ2It89JxiA415kjIUf8JlbskhR5W/CGAodbgi7
	 wqvDo7ep2/1BKNBmssbdo6TiS7qXS3owfYE9srwbVSzcd8IOqq9La4BKnDYOepHM+4
	 VB4kBMJWIUMaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569463811A6C;
	Tue,  2 Jun 2026 19:10:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 01/15] batman-adv: drop batman-adv specific
 version
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178042744488.1010994.13027563047282027332.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 19:10:44 +0000
References: <20260601123629.707089-2-sw@simonwunderlich.de>
In-Reply-To: <20260601123629.707089-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-294372-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:sw@simonwunderlich.de,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:sven@narfation.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17E38631599

Hello:

This series was applied to netdev/net-next.git (main)
by Sven Eckelmann <sven@narfation.org>:

On Mon,  1 Jun 2026 14:36:15 +0200 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> Bumping the version number on the first pull request after each merge
> window was deemed inappropriate for an in-tree component. The version
> number carries little meaningful information in the context of the Linux
> kernel release model, where stable and distribution might all carry
> slightly different patches (without any change to the batman-adv version).
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/15] batman-adv: drop batman-adv specific version
    https://git.kernel.org/netdev/net-next/c/6f864eb5cfd8
  - [net-next,02/15] MAINTAINERS: Rename batman-adv T(ree)
    https://git.kernel.org/netdev/net-next/c/1e323d0e7d22
  - [net-next,03/15] MAINTAINERS: Don't send batman-adv patches to netdev
    https://git.kernel.org/netdev/net-next/c/6dbf9f76a692
  - [net-next,04/15] batman-adv: add missing includes
    https://git.kernel.org/netdev/net-next/c/b8fbbfe81d3e
  - [net-next,05/15] batman-adv: use atomic_xchg() for gw.reselect check
    https://git.kernel.org/netdev/net-next/c/9550dd11e360
  - [net-next,v2,06/15] batman-adv: extract netdev wifi detection information object
    https://git.kernel.org/netdev/net-next/c/c0559465842c
  - [net-next,07/15] batman-adv: replace non-atomic meshif config fields with (READ|WRITE)_ONCE
    https://git.kernel.org/netdev/net-next/c/6a4f30e6e34c
  - [net-next,08/15] batman-adv: replace non-atomic hardif config fields with (READ|WRITE)_ONCE
    https://git.kernel.org/netdev/net-next/c/dbb48d9089bd
  - [net-next,09/15] batman-adv: replace non-atomic vlan config fields with (READ|WRITE)_ONCE
    https://git.kernel.org/netdev/net-next/c/26f8f9f9379b
  - [net-next,10/15] batman-adv: replace non-atomic mesh state with (READ|WRITE)_ONCE
    https://git.kernel.org/netdev/net-next/c/2b2450e3266a
  - [net-next,v2,11/15] batman-adv: replace non-atomic packet_size_max with (READ|WRITE)_ONCE
    https://git.kernel.org/netdev/net-next/c/58020571b54f
  - [net-next,12/15] batman-adv: replace non-atomic last_ttvn with (READ|WRITE)_ONCE
    https://git.kernel.org/netdev/net-next/c/4dd2055046c4
  - [net-next,13/15] batman-adv: tt: replace open-coded overflow check with helper
    https://git.kernel.org/netdev/net-next/c/5ffd4dd87425
  - [net-next,14/15] batman-adv: tvlv: avoid unnecessary OGM buffer reallocations
    https://git.kernel.org/netdev/net-next/c/735522e7ca3f
  - [net-next,15/15] batman-adv: use neigh_node's orig_node only as id
    https://git.kernel.org/netdev/net-next/c/3bd64ca11d9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



