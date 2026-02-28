Return-Path: <netdev+bounces-262025-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMgeNrhAomlz1QQAu9opvQ
	(envelope-from <netdev+bounces-262025-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 02:11:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D781BFA32
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 02:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 614C430DE3DC
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107672D1F7B;
	Sat, 28 Feb 2026 01:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isSFADTR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B8E2DAFC2
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 01:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772241051; cv=none; b=JbGlMjhhSCinItQwQDs5b0w/tF2rDJZ/ctQ3UcTkK6gRbgbA+mKMw8Chl9szeREQ87MMpl/0lnGxzeikU7OPihiGkkySP3sgEmomkpvgvZJpzH9R2/7AHW0pw19DZAeXKcu8p0U4oCO1oYYEaL3ODF5xSXAUCoAczZT7l3dKMLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772241051; c=relaxed/simple;
	bh=EH8wB9qb+55oPMsTXOJWdjZrIQnQIcCndjS8UTRn0FM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VMdR6KPngAbRFR2t0dwpFrkC0r4PWmKaQ2XKAWkLAPRZbCiBZGjvxC+ejgrKWgx6ioq0rEcg9TrzzoPEK/u0MfPXvHIFfHVam7W7kezP0CbwSNiZmupOHYv5MWBTduK1Ah3WJNrv9pMisq5wLklx6qXmawfK2psKMcEsQNz3TDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isSFADTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B3CC116C6;
	Sat, 28 Feb 2026 01:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772241050;
	bh=EH8wB9qb+55oPMsTXOJWdjZrIQnQIcCndjS8UTRn0FM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=isSFADTRuPasXAu2W3Mo6TDjOpfau1D4oa60fdBIiKo5aypotPb7soaqlxSOFA8sU
	 w9hYJryLzT1VVcMZYVVH+sOxtJirl7NEcPwozcf6NhwyLPpAFfcUySFhxXEG8s9xh4
	 YvXKJn/ixLH6dGLGIQjvv3hqnt4ew2raP0jUj6aZInilcY5+AU/l3DC97+CYrrgnBT
	 HAKsdjor50m2GYXlRR9RUOXp6SMxVmanUx0XcybxNqo7VMZPGeeomXIGuHRGb+FvP2
	 VtnMQl+g7vGbEN7uDyeTBKicLlXikovIJSzMUEGSKV6CdPpwLsG/fnsGwFoboxc5BJ
	 g8fNwm17YRDiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FEB539EF96A;
	Sat, 28 Feb 2026 01:10:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH netdev-next v2] ss: Remove trailing whitespace when output
 is
 not a TTY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177224105404.2825498.5616222019553800062.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 01:10:54 +0000
References: <20260225194104.3182640-1-trilader@schroedingers-bit.net>
In-Reply-To: <20260225194104.3182640-1-trilader@schroedingers-bit.net>
To: Daniel Schulte <trilader@schroedingers-bit.net>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, stephen@networkplumber.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262025-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 45D781BFA32
X-Rspamd-Action: no action

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Wed, 25 Feb 2026 20:39:03 +0100 you wrote:
> Sometimes a value in the last column might be very long.
> When grepping ss output the matched lines are also padded to the longest value.
> In some cases this can result in multiple lines of the terminal getting filled
> with spaces.
> 
> Don't print right padding in last visible column when ss can't determine the
> screen width.
> 
> [...]

Here is the summary with links:
  - [netdev-next,v2] ss: Remove trailing whitespace when output is not a TTY
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=218757a8b8bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



