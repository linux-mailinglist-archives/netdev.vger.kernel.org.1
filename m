Return-Path: <netdev+bounces-296876-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ahxcOYKGJ2o2ygIAu9opvQ
	(envelope-from <netdev+bounces-296876-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 05:20:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B8465C03F
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 05:20:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="TQF1/951";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296876-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296876-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6699530639F8
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 03:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17555367B6E;
	Tue,  9 Jun 2026 03:20:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129C5364E9E;
	Tue,  9 Jun 2026 03:20:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780975231; cv=none; b=khD/ev+rxk+fXIzSiMRek9+wlTE3nmsxuZkXciczAsJk+f73hS+pOKl1zW7Vakc7oR8Ec16PgbqnSxdgS++IVMRP4RuLmRftrRywVUfcN7Q+yaYKuuoEdZaEW7cCIMD6c6xgQDYhY4YG/+tdqQMlfd1r/kavEuuJ3P7v4cet/Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780975231; c=relaxed/simple;
	bh=n0B6QDSJKrgmpt19FWl1qB81zF8yRGvWfNsGxqRxVsg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WQVFg4Vchdn+fTUfEkXaGVmtEnCWYT+sfmjV4KYBk4JY6y+TJ8oDDFcOP9t8+NFpZKJs+V4eL4dGZz7L4soKri6LSD9ALfsDn8PZlZlHAdg5aLf6T/QkwE7HcPdNUIU1UsaZVx6SkyBia9ubad7/HUhZdMtzfaJg+hcp4hkK4TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQF1/951; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72AD1F00893;
	Tue,  9 Jun 2026 03:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780975229;
	bh=1oAHpPSmD7jpCqfTtnRpAlLCAOu6JtJd19c1EBnc66Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TQF1/9518BZ+Lb1LcN+hR8r0Yd+zJOeXndAoe/qICDAiNecTTgRIu09yrJMDlnXO4
	 oQ2LywqCGzsSCiB4daHQAVhv2+q9DD4H+jvDzMVF6aRgStFpFwfaqxLvbgciQVdmi6
	 lY2rmf7UxBcvAIuEtvcqyjDNM5j5ELo7mgmJpp3YRE4aW4WE4RnJRjbCgHl2t9t0IL
	 bPYI+CHXY3Nf9EZOfEwVHqO3S6HMDSLs9vU0BkUAmIWZQJJpoXi698bbkLQBljI/2T
	 hvfsJ2ytHhW5/vx5OI35e5S5T6EUTOnWd/7eM683JyogG3yRe4saccsIcpwCBwtrhz
	 PcNyPnzUedHHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A2D3822D4A;
	Tue,  9 Jun 2026 03:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v12 0/6] tls: receive-path fixes and clean-ups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178097522813.1776256.11633933878763995491.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 03:20:28 +0000
References: <20260604-tls-read-sock-v12-0-b114efa6e3e2@oracle.com>
In-Reply-To: <20260604-tls-read-sock-v12-0-b114efa6e3e2@oracle.com>
To: Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
 edumazet@google.com, horms@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 chuck.lever@oracle.com, sagi@grimberg.me, hare@kernel.org, hare@suse.de,
 alistair.francis@wdc.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296876-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,queasysnail.net,google.com,redhat.com,vger.kernel.org,lists.linux.dev,oracle.com,grimberg.me,suse.de,wdc.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:sd@queasysnail.net,m:edumazet@google.com,m:horms@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:chuck.lever@oracle.com,m:sagi@grimberg.me,m:hare@kernel.org,m:hare@suse.de,m:alistair.francis@wdc.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56B8465C03F

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 04 Jun 2026 13:48:23 -0400 you wrote:
> I'd like to encourage in-kernel kTLS consumers (NFSD, NVMe/TCP) to
> coalesce on the use of read_sock. While auditing read_sock for that
> purpose, Hannes and Sabrina flagged a few rough edges in the receive
> paths.
> 
> This series is a set of clean-ups, not a performance series. Async
> batch decryption and its submit/deliver scaffolding were dropped
> during previous review: async_capable is always false for TLS 1.3,
> the version NFSD and NVMe/TCP both require, so async-related
> improvements were unreachable for the in-kernel consumers this
> work targets.
> 
> [...]

Here is the summary with links:
  - [net-next,v12,1/6] tls: Avoid evaluating freed skb in tls_sw_read_sock() loop
    https://git.kernel.org/netdev/net-next/c/4da7925c124a
  - [net-next,v12,2/6] tls: Re-present partially-consumed records in tls_sw_read_sock()
    https://git.kernel.org/netdev/net-next/c/3f05d3bf9422
  - [net-next,v12,3/6] tls: Move decrypt-failure abort into tls_rx_one_record()
    https://git.kernel.org/netdev/net-next/c/524bc67509ff
  - [net-next,v12,4/6] tls: Factor tls_strp_msg_consume() from tls_strp_msg_done()
    https://git.kernel.org/netdev/net-next/c/8cf0c70ec84d
  - [net-next,v12,5/6] tls: Suppress spurious saved_data_ready on all receive paths
    https://git.kernel.org/netdev/net-next/c/22f8bf8808dc
  - [net-next,v12,6/6] tls: Flush backlog before waiting for a new record
    https://git.kernel.org/netdev/net-next/c/edcf32b8a48f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



