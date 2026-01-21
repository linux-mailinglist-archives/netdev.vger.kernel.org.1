Return-Path: <netdev+bounces-251669-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIlYCGgZcGkEVwAAu9opvQ
	(envelope-from <netdev+bounces-251669-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 01:10:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4594E563
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 01:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D5CCDA05B80
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE50222599;
	Wed, 21 Jan 2026 00:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myZa6c5n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BBD136672;
	Wed, 21 Jan 2026 00:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768954210; cv=none; b=sl0VcPvb9rOxIVVd12e2zzXLVryz3qaqG9KVPw38OLgCV3/BNJnujKUAGavpiLbs4vSR9qiuw9IIf5c5jWh/kv9CtUjliTgethvUqD2zyPmQAQiUSy4jBnjUYMfc2D1SeAP/VTkXLRJkhn0/Pg80N2ZaJ+2OqBPyitl18KCbtA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768954210; c=relaxed/simple;
	bh=IsAzmrPLCIgmXY99oYz2ki2vOiTvZSfLscjg89VO+ao=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fLX9lQHKcXqiRaG8SOa3xIT3iZ0JTbwGSyJkWhGjTIWm4/iDlAw7VbzAquWepvJCEVIvLiludg7uNzTfn6IR/6K4YeoSk6/WSEoYah/DbZi3ROEBBuDsvhw0grvodf9miz+RhqD60ARzt/O9VVGElu0OmsnJoqZi7l35OK3U0do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myZa6c5n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686AAC19423;
	Wed, 21 Jan 2026 00:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768954209;
	bh=IsAzmrPLCIgmXY99oYz2ki2vOiTvZSfLscjg89VO+ao=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=myZa6c5n8vvcr87vjMxCFanLD/8HONUXDwjlYP38VkHPnjpPgWTUu+ciozhZptadQ
	 W9OVyxuDpezLgxqiWLcHW/JyiM+rbbs33Fy4BruQKkmV0bhqlhlK8t1Dj0MEghYSif
	 2Cdde2JDy5fqzbA9dzFEuiF30akx9Fi40VUxz0ehkDveERM0Nm98vajbyqicx2rgkQ
	 vEYabHESfDRnl6tplT/4jhYw99rqQGH7mawvTe7Ok81vLR++PhwJ2/efxTpqVg8g26
	 0DZPQniKPhRlcF8SaeLAxGrDSw3YZboIXnhoNQLDK7ae4Jl9mfn8dzvds/UdgtiiEH
	 XWcwGLNQbm6mQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11BF2380820D;
	Wed, 21 Jan 2026 00:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] nfc: MAINTAINERS: Orphan the NFC and look for new
 maintainers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176895420685.659962.13942253362463266029.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 00:10:06 +0000
References: <20260118094822.10126-2-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260118094822.10126-2-krzysztof.kozlowski@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, mgreer@animalcreek.com
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251669-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: BF4594E563
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 18 Jan 2026 10:48:23 +0100 you wrote:
> NFC stack in Linux is in poor shape, with several bugs being discovered
> last years via fuzzing, not much new development happening and limited
> review and testing.  It requires some more effort than drive-by reviews
> I have been offering last one or two years.
> 
> I don't have much time nor business interests to keep looking at NFC,
> so let's drop me from the maintainers to clearly indicate that more
> hands are needed.
> 
> [...]

Here is the summary with links:
  - [v3] nfc: MAINTAINERS: Orphan the NFC and look for new maintainers
    https://git.kernel.org/netdev/net/c/a9f470594c50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



