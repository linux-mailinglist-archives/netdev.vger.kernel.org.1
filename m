Return-Path: <netdev+bounces-266846-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNmxGcIgsmnlIwAAu9opvQ
	(envelope-from <netdev+bounces-266846-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:11:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B744C26C1A8
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3B2930D7724
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E24377014;
	Thu, 12 Mar 2026 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/DlTBAk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443FE375F8C;
	Thu, 12 Mar 2026 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773281431; cv=none; b=XX3PmtJNy0SQmQbQTe/3x+OnvZR0d+ECdIF/tL77BzVTRFZMgPxBR6YmEaPy1AXr8KmnIk+appd0/DJkb6Z+mVn5ZWhfj2xIYpcEuxKoRUFJCzQXviHUc1D6vO7WpihSqCoOMprSkUrN60O4oMshM2/rozT2q1Qk0Z7E/G6PLKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773281431; c=relaxed/simple;
	bh=CVnfc4BIEPjo69A5r5Tk378IgCJLl4/GMYAI8lR8qKY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q2wygiXI9WKBiY1WKuyWepKyPXp1eVCrYOnux0QVxSSGr+dNVimHxG1kJk/zYC5pqHMJIm3qCzJ+kIR23OkOETOiofaJaS6VyAX4hcPpNseAc22O3KOaIQv76oxPmkqtZH5eJrUGRo9Q4L7lUJ8a0VLVIL47MndzF9o2KSao+So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/DlTBAk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97B3C4CEF7;
	Thu, 12 Mar 2026 02:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773281431;
	bh=CVnfc4BIEPjo69A5r5Tk378IgCJLl4/GMYAI8lR8qKY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I/DlTBAkv8WG1gdwY3bLZFRbvft+rPcSjsMxsrMAHvWmOEpoPslQGTaGXfovtBrGC
	 4EKPr2R7acDWxSjPoc0qeXH/uNWHij4nq7JFQG3iQstIDQUkM7Z0BJV/nGzFii27wN
	 3fCbrh5liyWYDVGLwoLqBJev/jVW2IL9sP3lxkMKLO9/ThTYAu5SeYZWbEjuM1dlu7
	 L0ZnBfv1T3Ahe842FNy+Ty16y0U4rNNwlRp/XTFhChiucRDv+nz+6tgzT8tzrnwML0
	 MZmRguzZAZ1W1HbBRmowg+B+zNKZITRYfrGxVgMJwjQKIDyEUxHWI+GSk2ZBeNqCEX
	 iRgBV3aBxWyMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02F6C3808200;
	Thu, 12 Mar 2026 02:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] selftests: net: local_termination: test
 link-local protocols
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177328142654.3905617.10397683957251336017.git-patchwork-notify@kernel.org>
Date: Thu, 12 Mar 2026 02:10:26 +0000
References: 
 <1a67081b2ede1e6d2d32f7dd54ae9688f3566152.1773166131.git.daniel@makrotopia.org>
In-Reply-To: 
 <1a67081b2ede1e6d2d32f7dd54ae9688f3566152.1773166131.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 alexander.sverdlin@gmail.com, vladimir.oltean@nxp.com,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266846-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,nxp.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B744C26C1A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Mar 2026 18:10:32 +0000 you wrote:
> Add tests to local_termination.sh to verify that link-local frames
> arrive. On some switches the DSA driver uses bridges to connect the
> user ports to their CPU ports. More "intelligent" switches typically
> don't forward link-local frames, but may trap them to an internal
> microcontroller. The driver may have to change trapping rules, so
> link-local frames end up on the DSA CPU ports instead of being
> silently dropped or trapped to the internal microcontroller of the
> switch.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] selftests: net: local_termination: test link-local protocols
    https://git.kernel.org/netdev/net-next/c/7e27d6202e90

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



