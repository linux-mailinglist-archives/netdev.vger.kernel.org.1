Return-Path: <netdev+bounces-259186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJSzE00UlWlYKwIAu9opvQ
	(envelope-from <netdev+bounces-259186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 02:22:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE88E15280C
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 02:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE64A305FFDE
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 01:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E80B2DCF46;
	Wed, 18 Feb 2026 01:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvbRHCsl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C24A2DC77A;
	Wed, 18 Feb 2026 01:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771377628; cv=none; b=aI/2LXJVuVpinz+l68pTQORSrcbXLK+8SGR5CkgtbFynkg16mvF4MbLfkq8C3wrxZNU1Ufk6dHr6bVVahA30BoIhhrfsOaYQ6AqHjwSsGt1D2mvUCqAVYsoYT8038r539Q0do2em2H2kpKu7mSGBGTZLea/A64j9uMwPwo5yC8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771377628; c=relaxed/simple;
	bh=qM7r7PThBSgMc2wLL0yRj+RYRdTjs8F9sv5IGkKfXqE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sZHOYda53yTV561z2W1Om8ZbxT6Bd0PZGNOs/rlcHpKtVOor1M/JgYF6JTSh28f/SM2UErSSvaxnpURRVZaPFfG3kIrD4ob+ZrfAlO4fq7DtaZcjH/lf39Q0DF1dpX3DtU6qIk0GoQ4YKgWSLJfyKtayzlFUcHJXNDCYIuO4CMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvbRHCsl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F02BC4CEF7;
	Wed, 18 Feb 2026 01:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771377628;
	bh=qM7r7PThBSgMc2wLL0yRj+RYRdTjs8F9sv5IGkKfXqE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZvbRHCsl0BVG0tvwMJpWrShNKqUbqSdWQlaJTCJv8wFnRspQkOOVEJuKxRCvB+oYh
	 mrEzstLU1gDJVmxLBd0gW2RT/rAhqWtqYGAn/q7dSDyFha4bVCAb44hOXB6KSys0sN
	 FSCJK0tIuw4jP4FlV6lc5l1GUUcNEtKPCXxTR0kaBdIE8TyPzbxQBVacE/3wUoLZq2
	 qZlRFqlfpECUeOuCdRlYRuk9FUCdSEW132U84tuzhJo4t3JSIoOiBQz9gdN0I7ui/8
	 6lpAj8boky5V5GOWuo83pdBitpXyJ1qqlZnLbObCHT8qtjtWf4u8pKgTifgct+L0fn
	 ylYZL5epX67xA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B2BD3806667;
	Wed, 18 Feb 2026 01:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dpll: zl3073x: Fix ref frequency setting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177137761982.765825.18272220611550289967.git-patchwork-notify@kernel.org>
Date: Wed, 18 Feb 2026 01:20:19 +0000
References: <20260216194007.680416-1-ivecera@redhat.com>
In-Reply-To: <20260216194007.680416-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, Prathosh.Satish@microchip.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 poros@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259186-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE88E15280C
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Feb 2026 20:40:07 +0100 you wrote:
> The frequency for an input reference is computed as:
> 
>   frequency = freq_base * freq_mult * freq_ratio_m / freq_ratio_n
> 
> Before commit 5bc02b190a3fb ("dpll: zl3073x: Cache all reference
> properties in zl3073x_ref"), zl3073x_dpll_input_pin_frequency_set()
> explicitly wrote 1 to both the REF_RATIO_M and REF_RATIO_N hardware
> registers whenever a new frequency was set. This ensured the FEC ratio
> was always reset to 1:1 alongside the new base/multiplier values.
> 
> [...]

Here is the summary with links:
  - [net] dpll: zl3073x: Fix ref frequency setting
    https://git.kernel.org/netdev/net/c/a047497f9528

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



