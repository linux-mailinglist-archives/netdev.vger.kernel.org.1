Return-Path: <netdev+bounces-297740-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MfHcF7aIKWqAYwMAu9opvQ
	(envelope-from <netdev+bounces-297740-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:54:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BC766B116
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:54:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dFd6dNeT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297740-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297740-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C78EF303BF40
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDDC40B362;
	Wed, 10 Jun 2026 15:40:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A994183D4;
	Wed, 10 Jun 2026 15:40:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106013; cv=none; b=LtnZwnu4yK2UGTJ8/t8Dw6wlxtsadMcLmy2Okl5oQnG0zx6yAwep77RjiO4uTueRnz008fsli8i3Lvjbk0OtW/U/LC0vtLFLvYwePNp37B41V4VdrFfYyUoPMqbx7/tUTYDs7SSp0UGWLmX3e7Z/7t1ib6r78iK5ylyErzzQdYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106013; c=relaxed/simple;
	bh=g11rXWo764w7w2UnaSP4Mz0lA1sUdipOEZlDKPSqHF8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=syJQtYWt1mDvBQeXGS0XRWlmqzoZRBpf9Tvbzn1K3o97eKnyoakT/mpFlswRDAWpInkmldgDsDfedjV0bRCuEVu7DZYbnADSBYwTG6jabnWcqTt8J+rTCt7U1Cor0ubgesl2fjIDv4s5AQLKJc08ErBTXoW6c0yErVEUwONTuFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFd6dNeT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B201F00899;
	Wed, 10 Jun 2026 15:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106012;
	bh=Ipi4H9dzi+Qs6ZDuhDxegFVgWSl8sNIvuN8B8FuopVs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dFd6dNeTk8aS6NNKHMa58attu0SncQq8gmLQb+ELFjKomXLhIqjEBpHAgTMWWDAC5
	 ktyLh3R4QlgzghlTgz9rV3x94fg5m9xxv9XMFpj4+KJiH9Y7xC6yd645fe1I7bM4EN
	 3vq72cgGBcRnnLoUc5VmRov1LNQoyodgOD2uDtfcXD9OaMr8TPasIhPput6sWi/nmb
	 u6P+DRP7wNIwR2xmyWiaCxRDxR6NXEXOuODRcX0ii92f2l8herZrJeo1+jdncipp3W
	 513n0vql4gRi7BHLP/Zw1c6mw8U9Azwq1BHlMourdyMO/DQj01PYJJxeBr+z5vjPyJ
	 zkEMthVnC82hQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938EE3930D7A;
	Wed, 10 Jun 2026 15:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/2] net: dsa: yt921x: Add ACL support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178110601014.3101197.15607035605580497941.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 15:40:10 +0000
References: <20260606130011.307812-1-mmyangfl@gmail.com>
In-Reply-To: <20260606130011.307812-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-297740-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mmyangfl@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 68BC766B116

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  6 Jun 2026 21:00:05 +0800 you wrote:
> v5: https://lore.kernel.org/r/20260602083755.79411-1-mmyangfl@gmail.com
>   - validate tcp flags
>   - fix TRAP action
>   - unconditionally discard rule on deletion
>   - trap traffic when hardware meters are exhausted
>   - avoid devm_*
> v4: https://lore.kernel.org/r/20260528193726.1893365-1-mmyangfl@gmail.com
>   - make use of software fallback
>   - guard duplicate POLICE and PRIORITY
> v3: https://lore.kernel.org/r/20260523020704.503966-1-mmyangfl@gmail.com
>   - handle ACL tag code
>   - fix the upper bound for FLOW_DISSECTOR_KEY_PORTS_RANGE
>   - extack messages when possible
>   - check the redirect target for FLOW_ACTION_REDIRECT
>   - fix candidates overrun
>   - fix the activation order for rule and action
> v2: https://lore.kernel.org/r/20260520022242.120640-1-mmyangfl@gmail.com
>   - v1 was mistakenly sent as v2
> v1: https://lore.kernel.org/r/20260514192140.3468543-1-mmyangfl@gmail.com
>   - fix issue reported by test robot
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/2] net: dsa: tag_yt921x: handle ACL tag code
    https://git.kernel.org/netdev/net-next/c/cf14ed49802e
  - [net-next,v6,2/2] net: dsa: yt921x: Add ACL support
    https://git.kernel.org/netdev/net-next/c/8eb9e7520b17

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



