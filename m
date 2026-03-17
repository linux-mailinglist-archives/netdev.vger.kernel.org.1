Return-Path: <netdev+bounces-268526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IFwLTIluWm1sQEAu9opvQ
	(envelope-from <netdev+bounces-268526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:56:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEF12A7585
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37340316D9B1
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 09:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98F139EF32;
	Tue, 17 Mar 2026 09:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgZcMl0P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D65366DBE;
	Tue, 17 Mar 2026 09:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773741015; cv=none; b=QBkH17wv78bVu01x0UpoID/WcvbOGgZjRMYTvv1R0ADmxr0vGil1xXNxCIEoHjsb23mj1ztZ+EJt3AaehQvW98q4dawVsoRuqvUSWP5pp6Np2trAC+d5UPPQIuY4J+hSIEoKFRkHObUuOCm2WByAFnIwl965afgVwA4P9OhR1tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773741015; c=relaxed/simple;
	bh=JOToXqk5QIbmrVEjmpk+PWfR2NMs9oY/PGHcKFBXyhs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JJ+XTIMrZR2e5Vogz09nXleGUZv3Xb8ogse2KR7ZX8YXZ4uQCEhXQZIc+jqtBbmvkethzkwCw77voVfU5Csz9pNcrJC3TxbHcpD9DYLtkvElLkOSKVYWfIepUc8fFk4O8VQHXaR/EMgUkilfo3dJ9ZRP8SCl7C+SROPfzyXB1cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgZcMl0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521CCC4CEF7;
	Tue, 17 Mar 2026 09:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773741015;
	bh=JOToXqk5QIbmrVEjmpk+PWfR2NMs9oY/PGHcKFBXyhs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SgZcMl0PvdRxxZRYb2Svz2fYUKkZvo+i+uNHRuVxNszyMIzSqcQ96X3JW/S2/hGUu
	 WW/NL+UlMcCfeLg/HuZEbKPPYl/26jO8tu7xa7C51UV7528MkJRLDpKcNTSi3q4hRE
	 5eFNGUGJEbwhw1rjRvDq68uaPoXo/bQ/dtv0udP1I08XAIPVNVn9pIIP8rcOBJwzIJ
	 0oIbRGU/YeK5qfK8pPBN6TSlXQZQamNEPo5Z0qx9MlbHfRFwDdW2gC0vHZxueBIrlY
	 jwR8qiIl09hvrlUqBcS2DSkAxcbgDsGmCvJhoh4CqOHHAlnKPfNgMhUu/sbAd7IzJo
	 /LUdzkL5H89zQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DEA3808200;
	Tue, 17 Mar 2026 09:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 0/2] net: dsa: mv88e6xxx: Add partial support
 for TCAM entries
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177374100779.3532624.11292439136204828925.git-patchwork-notify@kernel.org>
Date: Tue, 17 Mar 2026 09:50:07 +0000
References: <20260311-net-next-mv88e6xxx-tcam-v8-0-32dd5ba30002@luminex.be>
In-Reply-To: <20260311-net-next-mv88e6xxx-tcam-v8-0-32dd5ba30002@luminex.be>
To: Cedric Jehasse <cedric.jehasse@luminex.be>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, jhs@mojatatu.com, jiri@resnulli.us, horms@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,mojatatu.com,resnulli.us,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268526-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4DEF12A7585
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 11 Mar 2026 11:46:17 +0100 you wrote:
> This series adds partial Ternary Content Addressable Memory (TCAM) for
> the mv88e6390 and mv88e6393 family of switches. TCAM entries allow the
> switch to match the first 48 or 96 bytes of a frame and take actions on
> matched frames.
> 
> This patch introduces a subset of the available TCAM functionality.
> Matching on ip addresses/protocol and trapping to the cpu.
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/2] net/sched: cls_flower: remove unions from fl_flow_key
    https://git.kernel.org/netdev/net-next/c/b513dde96c0a
  - [net-next,v8,2/2] net: dsa: mv88e6xxx: Add partial support for TCAM entries
    https://git.kernel.org/netdev/net-next/c/639f1dcfde55

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



