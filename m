Return-Path: <netdev+bounces-299603-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JsTvOS9cMGpfSAUAu9opvQ
	(envelope-from <netdev+bounces-299603-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:10:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5719E689B19
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:10:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ixQttQrf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299603-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299603-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01E7C3040C86
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 20:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14C93B6C05;
	Mon, 15 Jun 2026 20:10:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85083B6370;
	Mon, 15 Jun 2026 20:10:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781554211; cv=none; b=O96u4gEmih3BpPh8Rnktk56CZ4qTra6+9/D8EXoMMcsM91aojV2Btg0REuBfBSscxUvut4AtxE6F+cDZW+wKiPWdZmGBeYg7BJ5UdYCQG99xGP85VDpBp/B/w6fJ3EwZR40pCWmIt7zjCAFV2fnsdldObrKCzdR5P2t3yZKXeNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781554211; c=relaxed/simple;
	bh=JrLNQ2KxQjXdeHNP33F7jVzffg7pfoYgYfBKM+oznpI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LFoSf8MEnYVb/bRi3XJ03MCqmiMHQOZMoaRyMfV8KA1742tw6GdGrywkeZPHYYi/3Wgkn1g//r67lMKmWvioj+wUlK9ZwmdNu2YM4wIZScwnK1gBaEiGjHZJjoF0pCaqgJvt7BeJkT3cFmjrAAt2POnjdG17zzsHK9v3585MLbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixQttQrf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844161F000E9;
	Mon, 15 Jun 2026 20:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781554210;
	bh=813B8TM+5Wzr7ucH74TxsD8qEwCVYbImchoQsGyqzgQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ixQttQrfLilqZQu4FrYHpYkEeqLQc3u8mDAwC5xtXicYV5sJpnD4gjurQBgw0SIwa
	 IeF23h1zUYi6ojC/V/BrYTkQ9Cb+VXjzenTO3agMFoHDCD38MAEkXnIqS7UdVpXnYA
	 lpzEmI33gFZUAOX2Phmo5IGvoFuUlHfc1jUK86fHBMkbasu2OFSlcniZ9X0TLt0fF/
	 mXeQKL7Hktpt448h93bPET5CqiXZFNnX5O+s2yh6DxG227lo2MS6qsPjAYeZRPsApb
	 cOYY3wDl1QmJkhZuaLyPO079N31C7QUFNJaV4axcofsqEHVqEkP5hL1I9x3if1Lyo3
	 HLCINasDn/24Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A9A3839A06;
	Mon, 15 Jun 2026 20:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mailmap: add entry for Jesse Brandeburg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178155420539.276509.14338598237222100729.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 20:10:05 +0000
References: <20260612224727.141614-1-jbrandeb@kernel.org>
In-Reply-To: <20260612224727.141614-1-jbrandeb@kernel.org>
To: Jesse Brandeburg <jbrandeb@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org,
 jbrandeburg@cloudflare.com
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299603-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jbrandeb@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:jbrandeburg@cloudflare.com,s:lists@lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5719E689B19

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jun 2026 15:47:21 -0700 you wrote:
> From: Jesse Brandeburg <jbrandeburg@cloudflare.com>
> 
> My Intel email address is no longer used, redirect it to my kernel.org
> address.
> 
> Signed-off-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>
> 
> [...]

Here is the summary with links:
  - mailmap: add entry for Jesse Brandeburg
    https://git.kernel.org/netdev/net/c/f3d64e53998a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



