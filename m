Return-Path: <netdev+bounces-275807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGxfAvZb1GlrtQcAu9opvQ
	(envelope-from <netdev+bounces-275807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 03:20:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 649A63A8A9A
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 03:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D78CC303F7FB
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 01:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4221FFC59;
	Tue,  7 Apr 2026 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ee28lNcd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A78F1FE471;
	Tue,  7 Apr 2026 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775524831; cv=none; b=AtU/3WDQJ5Lk0wKoDoGurDTBO2/3wT8JuQpP6agDuqR35KVNrXfgon61OqDfUBBfdPSAfrYgSNQNjY0Bqryvk/E8UVUfLgnfEwhsD8IN06cY/oKVPSzKMY+BIQROEcmttUhlYesp5rJvSAa/WbIqE7bY0bh/OoEZJCMZm0Y+Nfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775524831; c=relaxed/simple;
	bh=tliBJzA0Oz1ud3vn5ENeXWBS87IYNsaMC4U13WYAZR4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dRptf+dWDJwonMMOFrXo0GIkKASzh2+qySJPClTs8OLam30UYJCFbH/WeAlHUKWRtY8hsQdwtDaChQmZe0vffps/paZ/4/EAmd1fJn1SjjNYcAESJUEouRhcSV/2rJgrQQeqE1QUY9FOsef2YsKmcCRlMqJImCmoDLvEg9T7T3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ee28lNcd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9323C4CEF7;
	Tue,  7 Apr 2026 01:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775524831;
	bh=tliBJzA0Oz1ud3vn5ENeXWBS87IYNsaMC4U13WYAZR4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ee28lNcdRgwWDm3Oup4XJv5WcNTMSNqprnq/jbzwATTEgk6yr2NgkM/kwIRTA6K/P
	 D13VWzmL6bUvfx8hepN8Y4uTzqhZI94cOFkMy4OodbKTNrqHoG1iaotHFk1UlG7lIb
	 09XbPcerKQHuf2dxPRB1lkFbC4BQdRbTst6b4pTNCk8jpkA6dYaVKlX+yZwdR6iAWZ
	 B4YVhlwf34CC81v3caRWPou67nvw3ixwA8bg9BKIa9cn0e6ucInLNQUhANO4Yo5DYp
	 GUx4LvE/0gxna2cOJhBs1Sn3OfgJYmrErMglxVqCTbhMeJIwfXAkmgFKCM9RH+JA+a
	 SJHgUZVNL8fIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDD53809A28;
	Tue,  7 Apr 2026 01:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] psp: add missing device stats to get-stats reply
 attributes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177552480929.3328957.15711154154667874515.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 01:20:09 +0000
References: <20260403-psp-yaml-fix-v1-1-dacee0663903@gmail.com>
In-Reply-To: <20260403-psp-yaml-fix-v1-1-dacee0663903@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: kuba@kernel.org, willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 donald.hunter@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275807-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 649A63A8A9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 03 Apr 2026 03:26:31 -0700 you wrote:
> Commit f05d26198cf2 ("psp: add stats from psp spec to driver facing
> api") added device statistics (rx-packets, rx-bytes, rx-auth-fail,
> rx-error, rx-bad, tx-packets, tx-bytes, tx-error) to the stats
> attribute-set but did not add them to the get-stats operation reply
> attributes. The kernel reports these attributes in the reply, so
> list them in the spec to match.
> 
> [...]

Here is the summary with links:
  - [net-next] psp: add missing device stats to get-stats reply attributes
    https://git.kernel.org/netdev/net-next/c/c8eee00c0fef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



