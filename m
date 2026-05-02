Return-Path: <netdev+bounces-283463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MByUEBRB9mlYTQIAu9opvQ
	(envelope-from <netdev+bounces-283463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 20:23:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9E04B3301
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 20:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F39BE303267D
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 18:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E90B3876CD;
	Sat,  2 May 2026 18:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjXXggLL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB673876C5;
	Sat,  2 May 2026 18:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777746077; cv=none; b=rXcS9PSOwgM7KBAe7NiOmjiz9NFgI9ouNUJVn/BG6aTy1Tp4Hg/OFN4anAPv2W2IOIV139PruXaohLACEnyYz+vGfsUM/NC3NWpS0ecotK+YnTFuvjGHAdHfJ/6OoqClEpAS+Ku6VQeonCSKDywqvLsHwC3Pdr6SImA1sXzbShg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777746077; c=relaxed/simple;
	bh=dcZwfWrlZbE1CFXk+IjsuDnfdbcriifj3/dxazuOL0k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GtXRPhkvmlBe3+LsQdvmnZtr+rgRuTXn/mkiZvCqKDGUiWucBNhDJlv0IuHVxJYmMmLt6bY3townKU3R1mGm1jFdniF9gHPUxz6xg6ZhvU3zggLwSNxw1Lqxh+aXnlTntvJ1mWLT3m2E2I3eo8WVAM255VmfvC9Zdsoa16jzgdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjXXggLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7061C2BCC6;
	Sat,  2 May 2026 18:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777746076;
	bh=dcZwfWrlZbE1CFXk+IjsuDnfdbcriifj3/dxazuOL0k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CjXXggLL0EvKijBE2HL1ph3CI+893Ko5HMi3EmOCrgjDa+Gqx3MMp0BeT/3We9DKe
	 gZIDhZbIu4Tn29JgtnnW+AniJ2dU06eorXFKuo9b1tqckBfOsMxU6kmBljfMYqWIjF
	 UhEpI8CWEmEdP5IhfjhYTa9Brh/aMYHAZ2fNOY56d3BI+TYRMAqCcStJAOuh9eGb3S
	 P1qm6oy/qiKbAwwig9cDz2X/zVXRu3M4eQdlcAfl7WZVAzfG/u/Hn3Yxgs9TQsAWj4
	 mmLPU5kHW+WskGXIu+j6/fLw9cZp3odzLuMprppjrslEZal4lY+bDEXjtiR6yIUsMd
	 4GrisOeIDvZhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDD7380CEFF;
	Sat,  2 May 2026 18:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/3] net: dsa: yt921x: Add port police support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177774602904.3903048.17546666423358548634.git-patchwork-notify@kernel.org>
Date: Sat, 02 May 2026 18:20:29 +0000
References: <20260430114529.3536911-1-mmyangfl@gmail.com>
In-Reply-To: <20260430114529.3536911-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, vladimir.oltean@nxp.com,
 UNGLinuxDriver@microchip.com, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, olteanv@gmail.com
X-Rspamd-Queue-Id: AF9E04B3301
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,nxp.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-283463-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Apr 2026 19:45:23 +0800 you wrote:
> v5: https://lore.kernel.org/r/20260428112606.1917230-1-mmyangfl@gmail.com
>   - remove new line chars in extact messages
> v4: https://lore.kernel.org/r/20260409171209.2575583-1-mmyangfl@gmail.com
>   - split series and drop patch for qdisc tbf
> v3: https://lore.kernel.org/r/20260407160559.1747616-1-mmyangfl@gmail.com
>   - explain long registers more accurately
>   - fix missing packet mode flag
>   - rearrange function layout, in preparation for further patches
> v2: https://lore.kernel.org/r/20260402223437.109097-1-mmyangfl@gmail.com
>   - refine commit messages and code styles, no functional changes
> v1: https://lore.kernel.org/r/20260225090853.2021140-1-mmyangfl@gmail.com
>   - pass extack to user tc policers
>   - keep reg64 helpers along with reg96
>   - avoid macros in favor of functions
>   - adjust log messages
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/3] net: dsa: pass extack to dsa_switch_ops :: port_policer_add()
    https://git.kernel.org/netdev/net-next/c/09e4d1298b36
  - [net-next,v6,2/3] net: dsa: yt921x: Refactor long register helpers
    https://git.kernel.org/netdev/net-next/c/9f8888984eb0
  - [net-next,v6,3/3] net: dsa: yt921x: Add port police support
    https://git.kernel.org/netdev/net-next/c/39716c00ed0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



