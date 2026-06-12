Return-Path: <netdev+bounces-298409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0E6NEmtOK2pE6QMAu9opvQ
	(envelope-from <netdev+bounces-298409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 02:10:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A84C8675E27
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 02:10:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IPVZ9CR0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298409-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298409-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92A3C3095CB2
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 00:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A7F1A38F9;
	Fri, 12 Jun 2026 00:10:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B41219FC;
	Fri, 12 Jun 2026 00:10:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781223014; cv=none; b=dKIHI8ersZiAiW0xV1IrsEJGHlR/8XoD6CSXDX4LaESykmQzYeKxGXMCaFIL5Zk+djnsRJl6FuFTN1H8lf9V+nxxGx1NBJtgK57DEu4FoG4Hadv6aaMRqnfMel0QULJs4gH8A2cC1f86xN6g0yueB6C6ZsSstrwUVwpDvxxtN9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781223014; c=relaxed/simple;
	bh=7Mdb8ig3ulyAdSZ/I7o6f86lqNToxFgCbho9Ms1gYxU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TbC2Wmt/AReaVINq0lKy6n/lwao2W5PvyQigm6F15GWNgizB/fJbLaCt2afkWPD67+heO7i6nllI0Xt4HigOOf7Ui2rHmpl9Id7mfKjQeYhoCqlqUBvM+G3WtsGaL7q39l31anT2stuRhgLRCqmFyp3eh5mNwoq663EI/o2uM/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPVZ9CR0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29C81F000E9;
	Fri, 12 Jun 2026 00:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781223013;
	bh=XrUMbaDc8/HfNLNGRKx2Sy7mZ/WrNEmmBFzCmLexcW0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IPVZ9CR0W8/8S5OWNKFBKeUEPohLPa11r4J7lLDxpbIctJOD82+24UPsUHPcM9loI
	 biWH110x2jnzWZHyzTsdbmP8m2t01Lwjyd2qCRudkit9Vz7NEv77tdPgimVfy0/EW7
	 ENiXrI6GRlV64bxPgScmxDsjv5s9i5K06klZ6caSoPScvD9NG6N3NH0aRoms9vHQ+k
	 FmsCCii2uUdUHURiQ3wWBKw8Upk+471C3RHmSkXy/TDJkhLoIWAkLrNsbMfNGwZ8Ay
	 pP92qrJRkXL3657CTbWE9TXqneB1Nw4RGnqcLt8r61iV99RW3RJx8S5VLjq6lJqmlZ
	 bwkYNntlOfUnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198413930FB4;
	Fri, 12 Jun 2026 00:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [pull-request] NFC updates for net-next 2026-06-11
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178122301064.415137.4307378428317682270.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jun 2026 00:10:10 +0000
References: <1aed7555-3d24-413c-b284-bc85fdd33055@ixit.cz>
In-Reply-To: <1aed7555-3d24-413c-b284-bc85fdd33055@ixit.cz>
To: David Heidelberg <david@ixit.cz>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 oe-linux-nfc@lists.linux.dev
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
	TAGGED_FROM(0.00)[bounces-298409-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:oe-linux-nfc@lists.linux.dev,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,codeberg.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A84C8675E27

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 20:44:34 +0200 you wrote:
> The following changes since commit 518d8d0199538a4d6d5e51064044ece71e0c42e7:
> 
>    net: sched: avoid printing uninitialized link speed (2026-06-11 15:44:55 +0200)
> 
> are available in the Git repository at:
> 
>    https://codeberg.org/linux-nfc/linux.git tags/nfc-net-next-20260611
> 
> [...]

Here is the summary with links:
  - [pull-request] NFC updates for net-next 2026-06-11
    https://git.kernel.org/netdev/net-next/c/5a031965451c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



