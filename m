Return-Path: <netdev+bounces-265028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHyNOieXq2l6egEAu9opvQ
	(envelope-from <netdev+bounces-265028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:10:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F98229C2D
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DFD68301075F
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 03:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D3A3054C7;
	Sat,  7 Mar 2026 03:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaSUnY5+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318E83033EA;
	Sat,  7 Mar 2026 03:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772853024; cv=none; b=J0hKhqGsYPNngF9U0/J4am6tpERSOUAcGhOvi1tuxEVXxNl+5hH1SxHigw8mtntKdQm4q+WDI12cH7YRl+rH07PoLFqQmCv0Ej56MCkZAxTw4oPA6drg0piWp1YUfhDsWH31Zf5OSHXLx6GV646KnnSDMpU9kbTkSmnBxdG/4O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772853024; c=relaxed/simple;
	bh=TiajJF8FGs34cMcYXnME5ueOoAbs9UDJQ7cGdkNKzsU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t1BxF9NXQ9YczqZW72nQTcfdMjD+7fe2GnnHi3Y2tpq0dCH2eyEZJANQU8C8osArQXpHzzJpgDiEryoAaSO4GTwQsz2r/NMK5fkt/jKfYfx235MIPyhHzSCdqSLEUJEx53ic5Y+QfqgsQSVjUehyLv9e1tXXO47eYsGr4HB80jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaSUnY5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC62C4CEF7;
	Sat,  7 Mar 2026 03:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772853023;
	bh=TiajJF8FGs34cMcYXnME5ueOoAbs9UDJQ7cGdkNKzsU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FaSUnY5+LJDvosPvE9K6uYmazcUbcnbAqKdoouAsxz742LnmiJrFiO+V9Qly3I4bS
	 Yb2x9XSbRgA65bXi5UmhFpiepN2/SSREYhtTrI1mMk8txuWHbG6CcDsLprjMozZ2tW
	 QhVheN+Xw7JmX1LuNxudVvy1yTzOb34l/d/xO/VWH7WboKPBxyEi7uPYwb147kXeEV
	 BkvXHJr07CcKGceE/H+7I964JxyuALRUPyWI5kg1xVuaZpVy34hjXmnI6f6CCX+9i5
	 ROD8JW2J2EnpXMZa5LKj1DsU8kJwYP/PGTBkrCtsQYQKGo5Z8pT7JndoOINSC/i1FK
	 IgXsfifn4SZvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C763808200;
	Sat,  7 Mar 2026 03:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: spacemit: Remove unused buff_addr fields
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177285302252.135595.8145843484531781952.git-patchwork-notify@kernel.org>
Date: Sat, 07 Mar 2026 03:10:22 +0000
References: 
 <20260305-k1-ethernet-cleanup-buff_addr-v1-1-e978ef119231@iscas.ac.cn>
In-Reply-To: 
 <20260305-k1-ethernet-cleanup-buff_addr-v1-1-e978ef119231@iscas.ac.cn>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dlan@kernel.org, netdev@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 07F98229C2D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265028-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.974];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,iscas.ac.cn:email]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 05 Mar 2026 15:00:29 +0800 you wrote:
> These were never used. Just remove them.
> 
> No functional change intended.
> 
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> ---
> Cleanup patch split out from:
> 
> [...]

Here is the summary with links:
  - [net-next] net: spacemit: Remove unused buff_addr fields
    https://git.kernel.org/netdev/net-next/c/70eba59f9207

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



