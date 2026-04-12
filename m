Return-Path: <netdev+bounces-277823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEYZESXA22mTGAkAu9opvQ
	(envelope-from <netdev+bounces-277823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 17:54:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 948F03E4A04
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 17:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56B6D303A5E0
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 15:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E44E2C1788;
	Sun, 12 Apr 2026 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8dbS1Mf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A79ED531;
	Sun, 12 Apr 2026 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776009056; cv=none; b=HaA4RoUheE0QnUDG9rw0B90qWkUPSrSeTYDqkaf6nSgWA4KF7iB9JfvWtdbywJ0NtIiMvIenbS+a9k4d9BzOfdGkRUpPNvk/W2WJLl0hk8WJhBd1TB33ALs/V9ARCdmNRZKtGdTpB3B3rFbT6QftM5xolMmtVj0Tk+z7UuCglyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776009056; c=relaxed/simple;
	bh=KHS/zZhqUsS6MvZIlIb/B4usR4SJUXAR3GDkT211Pu0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oqUSMilmK8M92kJInztyj1tVPIOciSdxE6szxhQgdW0q0bWiGoBgwo+y8dXC+bqbdrPZK7MsMYfkyvxzGSVyCGly1qLcvr05vL7c4yxOEZu/8QaJXs98nzz7zKPul1HErPg3CQPIKscJ9Vfgj4c5Ow12+QK5Dm8XBDTjpZ5cn7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8dbS1Mf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E928FC2BCAF;
	Sun, 12 Apr 2026 15:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776009056;
	bh=KHS/zZhqUsS6MvZIlIb/B4usR4SJUXAR3GDkT211Pu0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N8dbS1Mfr90Lqt3QenxgTHDp84Y14g7GPYvRnhTP2XHRRr5SujaQVys5OPC6SiOF/
	 ngOh8TdgVGXIZAW0BTL65hlZE/dP6wXHXVomB2gFGwJcBDsOzp443wmgqsACrciBWB
	 3ZeK7jOx8WJIS57kV7P+k2V7/ExzUThmD4FIgG/Qd/1LvOcJoNd2LphkxC4xzYWwe/
	 jshKdrpI5NnEv4jE9U3rTRkY7SQSICORAZCJgKHo6sSGo4lBYY7PtujsZ4TjtI7nrY
	 p1kQzORZTvhp+Zokkm4S1hhtwp3kulhkxNanbOeviVn8VazfVSEnlmj8/eE8Ztk41m
	 yrstN+YVgJNKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E6F3809A8B;
	Sun, 12 Apr 2026 15:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/5] dpll: zl3073x: add ref-sync pair support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177600902829.3323732.16856607917216838310.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 15:50:28 +0000
References: <20260408102716.443099-1-ivecera@redhat.com>
In-Reply-To: <20260408102716.443099-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 mschmidt@redhat.com, poros@redhat.com, Prathosh.Satish@microchip.com,
 horms@kernel.org, vadim.fedorenko@linux.dev, linux-kernel@vger.kernel.org,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org, pvaanane@redhat.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-277823-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 948F03E4A04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 Apr 2026 12:27:11 +0200 you wrote:
> This series adds Reference-Sync pair support to the ZL3073x DPLL driver.
> A Ref-Sync pair consists of a clock reference and a low-frequency sync
> signal (e.g. 1 PPS) where the DPLL locks to the clock reference but
> phase-aligns to the sync reference.
> 
> Patches 1-3 are preparatory cleanups and helper additions:
> - Clean up esync get/set callbacks with early returns and use the
>   zl3073x_out_is_ndiv() helper
> - Convert open-coded clear-and-set bitfield patterns to FIELD_MODIFY()
> - Add ref sync control and output clock type accessor helpers
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/5] dpll: zl3073x: clean up esync get/set and use zl3073x_out_is_ndiv()
    https://git.kernel.org/netdev/net-next/c/3c8c39768b10
  - [net-next,v3,2/5] dpll: zl3073x: use FIELD_MODIFY() for clear-and-set patterns
    https://git.kernel.org/netdev/net-next/c/737cb6195c40
  - [net-next,v3,3/5] dpll: zl3073x: add ref sync and output clock type helpers
    https://git.kernel.org/netdev/net-next/c/63009eb92b0f
  - [net-next,v3,4/5] dt-bindings: dpll: add ref-sync-sources property
    https://git.kernel.org/netdev/net-next/c/a1a702090def
  - [net-next,v3,5/5] dpll: zl3073x: add ref-sync pair support
    https://git.kernel.org/netdev/net-next/c/14f269ae6998

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



