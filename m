Return-Path: <netdev+bounces-264650-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJxDF/lLqmmIOwEAu9opvQ
	(envelope-from <netdev+bounces-264650-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 04:37:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FCF21B2EA
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 04:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6D6C311FFB2
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 03:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D378336C0D0;
	Fri,  6 Mar 2026 03:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxeK+6MD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B159533F581
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 03:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772767979; cv=none; b=B8XEumRagmHuLOiDxtd1RzDMY0RCYA8mihRUJI1uDFgMqiyxzmRNS91Jl1cYrwp5BHhGefp7xNwHQ0nSjtyxsArbOBinM5yhKmI02jp9PV0qTcKTt0iOyMFXtPS4KiTz9FkkLtg4HlArkqmO1BEc3SsGjmaTNEpr8yjBbaTCxGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772767979; c=relaxed/simple;
	bh=DEvmvC8FmJemG8UZlcqWr4cmNJfepxvXgK76jOAgnQg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sqk3st3ttX6OWodcsMh/F7gngQvN6xlXjj+5CyYGBVHh64abf2X+cz6ZymPaZUkDh738WRB2WhpcbIQAKkCi5vYls/0fMggx+v5iA6iLZVskXcwq9qR3BjdxFBEDaTuvfrRZQdcD9IAURBwak9TqbprlIwmJzudz1IGInmguWqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxeK+6MD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943EAC2BC9E;
	Fri,  6 Mar 2026 03:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772767979;
	bh=DEvmvC8FmJemG8UZlcqWr4cmNJfepxvXgK76jOAgnQg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HxeK+6MDidN4rRcG7wraen/IS4yVj5Ne0SeL2iRTcdqVYeRfW48FJjy1+EDkl7GnF
	 AKN4i8hnGS+r4zLLiVuFSWR4Jf1cnPiF2mfafdxsXLExUlgA+bsHikevpqs1k8wmZ8
	 tLFpGN28xMxJuEMOUGewvjVmBgdR1jRHWosretcqojHX5x3w0nnt+PBfmsttRpVMzz
	 lCCmhGpBKFP39BU6MJ2blbmDIPvygLWgc3Q0lRXG4/l6kkxfpYKgCcd2acQ6vok3aE
	 HEdZEE3IZBAd1EnWpGIaxtWHOrcSggfMUr6aVkQM/vwMU9x8dEEcdjvr1lSl1dohKr
	 WLqdqBaLm+IoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF843808200;
	Fri,  6 Mar 2026 03:33:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl: add uns-admin-perm to genetlink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177276797904.3348267.3036793401644152557.git-patchwork-notify@kernel.org>
Date: Fri, 06 Mar 2026 03:32:59 +0000
References: <20260304141020.23270-1-antonio@openvpn.net>
In-Reply-To: <20260304141020.23270-1-antonio@openvpn.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, donald.hunter@gmail.com, ralf@mandelbit.com
X-Rspamd-Queue-Id: B9FCF21B2EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-264650-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,gmail.com,mandelbit.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Mar 2026 15:10:09 +0100 you wrote:
> GENL_UNS_ADMIN_PERM may be required by protocols using
> the `genetlink` family, however, this flag is currently
> only allowed in `genetlink-legacy`.
> 
> Add it to the list of possible values in genetlink.yaml too.
> 
> Cc: Simon Horman <horms@kernel.org>
> Cc: Donald Hunter <donald.hunter@gmail.com>
> Link: https://github.com/OpenVPN/ovpn-net-next/issues/33
> Suggested-by: Ralf Lici <ralf@mandelbit.com>
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl: add uns-admin-perm to genetlink
    https://git.kernel.org/netdev/net-next/c/e5e09233e8a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



