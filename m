Return-Path: <netdev+bounces-300915-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tTrlHSlfOGp9bgcAu9opvQ
	(envelope-from <netdev+bounces-300915-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 00:01:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 603936ABAE8
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 00:01:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hVJwVjj9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300915-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300915-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B98B30015B9
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 22:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E5A37104C;
	Sun, 21 Jun 2026 22:01:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCE126AE5
	for <netdev@vger.kernel.org>; Sun, 21 Jun 2026 22:01:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782079267; cv=none; b=MPX5e2tv1pTtRieDhPaN6cKXiH7kn0GJsAXL2Po1p6zoWJA1FdMhj9w4YZ7bP36K+Ff6BxJ3QSRIGVE3a5Fiypx95r6Ewgb8d4IAXbcCDb9Pg39uZEHS4i6BcOZiH+xfesZNwN7rn0g2+TABTOIFNWal2yll0z+5A2COSD9lo7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782079267; c=relaxed/simple;
	bh=LAJyms69SQUTucHOYeWIhLxnsThrdtJ+4KEC3S/e8vM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lrqr+Us2AccxTIBX8oqqW7KvUSlBxl3Go4tGUx5qYeoCnlsfVkUYIx/gilA92/FCZWuQpXOKIDFsmcpjp03q24mW1YccKSEugXQe8Q21fvly7/pOFZSOhQr4+UHU/cnUkkwTKkBO0QdAkYEMZ4CyNJOZ6yemWlApRw7aSRqKfag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVJwVjj9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9751F000E9;
	Sun, 21 Jun 2026 22:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782079266;
	bh=JsuGjancIB3kkaE8lcGEpPuGwIH1T+JObM1TkSSPMnk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hVJwVjj9jlzBF7ylv6HYk6gxMnz6gwTEqmOjiVxpnnB4HO9qFtkzoJPIBMcDvbazp
	 3zvsbR4p9E8L+9ekTH69f11sw9PMfkVAd0kiSKw7Wja6xhg2Nx3X6yu1GmSrEV3SmI
	 6UexNZylHjgTYQfpQjiUdfuy4cFU3Onn2iV2z6edw/MsXyqwFZT8oocDIdLuQoqvDh
	 ShJn1BJ7k7IiylyKFXxqeR/EK1ZQZIXKFsSrChttthOgFpgzeT9gdBeHR5KtP+nCVf
	 QVzhmlUekcvWKAu230jam6jGMsYkqNOJUnw7rIrQ7CPHB3BA/PsnILlyWKofyftV9z
	 SncsuOmmn5vng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1988B3AAA6EA;
	Sun, 21 Jun 2026 22:00:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 01/15] batman-adv: gw: don't deselect gateway with
 active
 hardif
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178207925758.516339.13920013302809099340.git-patchwork-notify@kernel.org>
Date: Sun, 21 Jun 2026 22:00:57 +0000
References: <20260619070045.438101-2-sw@simonwunderlich.de>
In-Reply-To: <20260619070045.438101-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, stable@kernel.org,
 neocturne@universe-factory.net
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300915-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sw@simonwunderlich.de,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:sven@narfation.org,m:stable@kernel.org,m:neocturne@universe-factory.net,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 603936ABAE8

Hello:

This series was applied to netdev/net.git (main)
by Sven Eckelmann <sven@narfation.org>:

On Fri, 19 Jun 2026 09:00:31 +0200 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> The batadv_hardif_cnt() was previously checking if there is an
> batadv_hard_iface->mesh_iface which is has the same mesh_iface. And since
> batadv_hardif_disable_interface() was resetting the
> batadv_hard_iface->mesh_iface after this check, it had to verify whether
> *1* interface was still part of the mesh_iface before it started the
> gateway deselection.
> 
> [...]

Here is the summary with links:
  - [net,01/15] batman-adv: gw: don't deselect gateway with active hardif
    https://git.kernel.org/netdev/net/c/df97a7107b16
  - [net,02/15] batman-adv: ensure bcast is writable before modifying TTL
    https://git.kernel.org/netdev/net/c/4cd6d3a4b96a
  - [net,03/15] batman-adv: fix (m|b)cast csum after decrementing TTL
    https://git.kernel.org/netdev/net/c/e728bbdf3266
  - [net,04/15] batman-adv: frag: ensure fragment is writable before modifying TTL
    https://git.kernel.org/netdev/net/c/b7293c6e8c15
  - [net,05/15] batman-adv: frag: avoid underflow of TTL
    https://git.kernel.org/netdev/net/c/493d9d2528e1
  - [net,06/15] batman-adv: v: prevent OGM aggregation on disabled hardif
    https://git.kernel.org/netdev/net/c/d11c00b95b2a
  - [net,07/15] batman-adv: tp_meter: restrict number of unacked list entries
    https://git.kernel.org/netdev/net/c/e7c775110e18
  - [net,08/15] batman-adv: tp_meter: annotate last_recv_time access with READ/WRITE_ONCE
    https://git.kernel.org/netdev/net/c/d67c728f07fc
  - [net,09/15] batman-adv: tp_meter: prevent parallel modifications of last_recv
    https://git.kernel.org/netdev/net/c/6dde0cfcb36e
  - [net,10/15] batman-adv: tp_meter: handle overlapping packets
    https://git.kernel.org/netdev/net/c/cbde75c38b21
  - [net,11/15] batman-adv: tt: don't merge change entries with different VIDs
    https://git.kernel.org/netdev/net/c/f08e06c2d5c3
  - [net,12/15] batman-adv: tt: track roam count per VID
    https://git.kernel.org/netdev/net/c/12407d5f61c2
  - [net,13/15] batman-adv: dat: prevent false sharing between VLANs
    https://git.kernel.org/netdev/net/c/20d7658b7416
  - [net,14/15] batman-adv: tvlv: enforce 2-byte alignment
    https://git.kernel.org/netdev/net/c/32a679925552
  - [net,15/15] batman-adv: tvlv: avoid race of cifsnotfound handler state
    https://git.kernel.org/netdev/net/c/edb557b2ba38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



