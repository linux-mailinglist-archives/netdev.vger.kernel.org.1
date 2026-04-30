Return-Path: <netdev+bounces-282887-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +G/LOqRn82ky2QEAu9opvQ
	(envelope-from <netdev+bounces-282887-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:31:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0832C4A415E
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A6FB03007B20
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC5642981E;
	Thu, 30 Apr 2026 14:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzkhJrGP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B37A402B82;
	Thu, 30 Apr 2026 14:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777559454; cv=none; b=n+Dm3Qd9cgPevOW5iulKjHQsmeWdGOeMaAVjpQm0LglXbCE+QrShQyqMnzAsdEQcHiKgvRxYNIApfEa7M4QK+GjA2VYdqOKtf5nhBwJQzz4kPSeyVLZhXGhu0MF/GVMv9klEKTy2iOaQsC1K3qtHXTuTkQf/2cH3PwAqkiBB2JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777559454; c=relaxed/simple;
	bh=pzHSXG/SVt1mR0gwSvwIhc/1brZ8OIbCrnl9WDTLZmI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FY63GHsxLRFwcbpYXm//dnlvGdw0/aat1t1Nvi8RhzqQ8pzcq6JDOTb0YnAKEVTVsV9H7LOnV5X/e4wHOwzBBpqLMlOZxrYdEFirVZlN7Zh9orh+Hln0lakt1ZPBHEoEsVB9w79eg8GmOdJAqJE2GbisRRzZabRWekQxKTEmt0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzkhJrGP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E644C2BCB3;
	Thu, 30 Apr 2026 14:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777559454;
	bh=pzHSXG/SVt1mR0gwSvwIhc/1brZ8OIbCrnl9WDTLZmI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PzkhJrGP21ZYB99LAZEIxGCm9vCo7dbwBlRJE6cS8VPC4vD7GGxWDSwOCKVOQdMfY
	 +4M39ZZZahSPByOvnX2ftXCfUGKt+Bx/KISBFOdlYIH+yNDO35EhbI84Xf96IuKjNS
	 kFSeltUamP0I8Mjvq9H0R+8Tah26m1ssB2iZ0p3HXAgrmWrlIkmGeLec+8cH8W/G5w
	 V7zB5TjVe04g0AMwNoEkjO9iD3FZvh7DrkJr0qx3LRnAkdQc8bjfaC/Kx455jHbwHV
	 yqOlk6vsnm2h1yt6Xus/Rx5uLVv+R02SDm7C0Ml3q/GmsmqexnkAW663bfYUJHg6fx
	 ltzWUKWeeG0cQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02F00380AA58;
	Thu, 30 Apr 2026 14:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] dpll: add pin operational state
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177755940880.3033474.8176113325052727327.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 14:30:08 +0000
References: <20260428154907.2820654-1-ivecera@redhat.com>
In-Reply-To: <20260428154907.2820654-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, arkadiusz.kubalewski@intel.com,
 davem@davemloft.net, donald.hunter@gmail.com, edumazet@google.com,
 kuba@kernel.org, jiri@resnulli.us, corbet@lwn.net, mschmidt@redhat.com,
 pabeni@redhat.com, pvaanane@redhat.com, poros@redhat.com,
 Prathosh.Satish@microchip.com, skhan@linuxfoundation.org, horms@kernel.org,
 vadim.fedorenko@linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 0832C4A415E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282887-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,lwn.net,redhat.com,microchip.com,linuxfoundation.org,linux.dev];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 28 Apr 2026 17:49:05 +0200 you wrote:
> Add pin operational state (operstate) to the DPLL subsystem to
> separate administrative intent from actual hardware status.
> 
> Currently pin-state mixes what the user requested (connected,
> selectable, disconnected) with what the hardware is actually doing.
> This makes it difficult to diagnose situations where a user sets
> a pin as selectable or connected but the hardware cannot use it
> due to signal issues.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] dpll: add pin operational state
    https://git.kernel.org/netdev/net-next/c/781c8893a5da
  - [net-next,2/2] dpll: zl3073x: implement pin operational state reporting
    https://git.kernel.org/netdev/net-next/c/c53f8f8dce77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



