Return-Path: <netdev+bounces-302430-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jn7NL92iQWqXswkAu9opvQ
	(envelope-from <netdev+bounces-302430-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 00:40:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E576F6D52BE
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 00:40:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=W+hBuwcC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302430-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302430-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54E63300CE74
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 22:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E3936683D;
	Sun, 28 Jun 2026 22:40:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73FCE555
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 22:40:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782686426; cv=none; b=emAofzvhPv42AKc11IA+y18WWxyAJ1LKcXjNqFKCCjzIANBrU/qTmhbn0Pl4liz+AEJeYLmnJFVIkEgNYbRPCbOGpMp7j3NtqRTTPSeZi9/j7z72AZM+bmRgcEldgyncmYVPBogCxHDPvCewD7s+7c6klwumlh6eSovzxlYpX8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782686426; c=relaxed/simple;
	bh=8ovpqgNOoy3r62Ie6K3eaJKNRS1FYL7ymTTcCx7ZSRc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A3dUfEI3UgXoCRyHkEZPCjWspwV2VeBIzBkWwJM610cqaAT3lHY1nnKgO9wfLckTkUCrZWvCTZDEe5STMeeR3uz5hl19RtEi0Ssgq4KrHgoo42j3fIGlIxMEHGf8Ble2Hgq9qXlRYjvZ8XyvwRLOxEhizhAn5Q6jx1cyAMvixTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+hBuwcC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393571F000E9;
	Sun, 28 Jun 2026 22:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782686425;
	bh=DmDrBe1XAILxDIC4Vacz65646j73s844IR1DcIPL9zY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W+hBuwcCz+0ue12zXljp0zNzN8T2BZ62qfWyOxoOlG02X7eV/32Z0bQDSBslcuIkJ
	 dRGmL7hYaZ2l54MrT1dXkjzrCgmYhqELSBw1qSu9St1AtKepxnLxUj7g1mvthYvtyz
	 TxfX5rw0NCTF1SCJYNQj5+cOXiA8PgnD1CseISOnmbF1ptHuokuTKgHuuW4vc0Gdjs
	 hI+uDYGjYaVQVXAzxTxWPGUgTsrjeLcb68XOrY6YFNbiJLbgvtKH2RhhVp468WkS1a
	 Funiw7bD/zbkPpnwjT2qDZwvKRWpPMD1SuZuCUTG8o+qEOE0MdJWWl9DoBWaP+ujep
	 clynRpPF3I3Uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939133938EA2;
	Sun, 28 Jun 2026 22:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] man: fix troff warnings and whitespace
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178268641023.2198080.5124456905511691247.git-patchwork-notify@kernel.org>
Date: Sun, 28 Jun 2026 22:40:10 +0000
References: <20260628215830.379088-1-stephen@networkplumber.org>
In-Reply-To: <20260628215830.379088-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302430-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stephen@networkplumber.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E576F6D52BE

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sun, 28 Jun 2026 14:58:02 -0700 you wrote:
> Fix troff warnings about line breaks around URL's.
> Remove unnecessary whitespace at end of line.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  man/man8/ip-link.8.in  | 5 ++++-
>  man/man8/tc-flower.8   | 2 --
>  man/man8/tc-fq_codel.8 | 2 +-
>  man/man8/tc-netem.8    | 4 ++++
>  man/man8/tc-red.8      | 6 +++++-
>  5 files changed, 14 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [iproute2] man: fix troff warnings and whitespace
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=ee2a4a866256

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



