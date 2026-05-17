Return-Path: <netdev+bounces-288785-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKY5JL5DCmqyyQQAu9opvQ
	(envelope-from <netdev+bounces-288785-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 00:39:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 112A3564313
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 00:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 712453006F08
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 22:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1242A3C0617;
	Sun, 17 May 2026 22:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uc6s6Az9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43282F7F19
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 22:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779057594; cv=none; b=ClNXzNog3mUsCz+cXxg3G8WN2q9rbur+is25r8FjYNfEKFP4UbdCHryMnbmmNzG4Ni/M8KtIAd56oOIHCnDt4RLh+6QYSgxwFf1s2c3ciJ46zusGHIhNPr7T5yfLpVusjpNPmIqqR7HLj3uTiuvFBygOm3YUL3MnT2AaGpt34L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779057594; c=relaxed/simple;
	bh=R0Iv+fBFrWEXjMq5mik6ej8jbc+LV+EAnntgfouQrsI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M1mZcn5C5rSOTUF2GW6IpWVGfffET5l/tEC9mqAfQZTZCmbp+YF8qMFgzahUzEWuc4ayXcl9pVPzhpAk3bFZEZfc1oIX9bawxid5e0kmRrPBFt6WeUgh0YFka6wzPfOOxj5lkG6yn7U866TCehf/rbxYi0M5cn9Ch/wvY0UgtsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uc6s6Az9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C21C2BCB0;
	Sun, 17 May 2026 22:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779057593;
	bh=R0Iv+fBFrWEXjMq5mik6ej8jbc+LV+EAnntgfouQrsI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Uc6s6Az9SFHfk/QW85pbnZhy+9zXiV3iDiwuh/DwtmaPAHbZYda9aBLiHFyn+pCJn
	 hOwlhdOD8NskP2RIduhwWzgLaCr5zYWdC5Esxvu3YuihNVwis50I0bYXrB+Rs824rj
	 QkXw1Dm1CNfPCVniLHrrAuGVbC073bfCu/DjN9PxMHCe/S2tANj00ItwXmH59f+l5t
	 6BAtOOLrMJhm+uDR02NrjIgPr2QifNEYoLDPVuloBpR5tTyvufPpmGizzkM7qn1WSK
	 uApAVXedKrH3HhshFJnK2viQjgXRevfYbY5UhzmgJw4LNXdUmVRagtOjL8t9QWdIQ4
	 ZFldJeW6Tb7zA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939C23930B8B;
	Sun, 17 May 2026 22:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next 1/2] dpll: align help and man notation with
 actual option parsing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177905760539.1131623.3707450063145275135.git-patchwork-notify@kernel.org>
Date: Sun, 17 May 2026 22:40:05 +0000
References: <20260512135225.167158-1-poros@redhat.com>
In-Reply-To: <20260512135225.167158-1-poros@redhat.com>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, ivecera@redhat.com, dsahern@kernel.org,
 stephen@networkplumber.org, vgrinber@redhat.com
X-Rspamd-Queue-Id: 112A3564313
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288785-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,networkplumber.org:email]
X-Rspamd-Action: no action

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Tue, 12 May 2026 15:52:24 +0200 you wrote:
> dpll uses getopt_long(), which only accepts long options with the
> "--" prefix.  The iproute2-wide "-X[name]" shorthand used in the
> help text and man page implies a single-dash long form
> (e.g. -Version, -json, -pretty) that getopt_long does not parse;
> only -V/--Version, -j/--json and -p/--pretty actually work.
> 
> Replace the misleading shorthand with explicit "-V | --Version"
> style so the documented forms match what the parser accepts, and
> drop the redundant second usage line in help() that listed only a
> subset of the options and implied dpll could be invoked without an
> OBJECT.  No functional change.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,1/2] dpll: align help and man notation with actual option parsing
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=62d47c2dbc0e
  - [iproute2-next,2/2] dpll: monitor: add -t/--timestamp and --tshort options
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



