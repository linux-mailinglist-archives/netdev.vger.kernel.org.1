Return-Path: <netdev+bounces-262065-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFqqMpllomnI2gQAu9opvQ
	(envelope-from <netdev+bounces-262065-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:48:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5281C034A
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3973308DDAA
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 03:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7352D97A6;
	Sat, 28 Feb 2026 03:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7qAMEw+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698D62D8DDB;
	Sat, 28 Feb 2026 03:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772250006; cv=none; b=kohMU5r2vKeYpNEyESdkS+FRVmwP2qYe2RDn7ZSBOK5ZZ8aW2Mlptreh2RhNUJxf+PDh1eh4wVNGF0HHbIUT/MhsEfPtcvTh72StAn+iMMBG2G5eOYxIxm27QQ/fwf9tU9akGbU5XNZHqmytw7aXrNFFV7MnhEJRETPfAlROBLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772250006; c=relaxed/simple;
	bh=JcHxkkJ2jQ5l4alXXCwoOJ4Mo8Okdjm/WulrOIExrO8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OP5VvYaqYu5NMfm5Cx5MySaAEuGid7i0U/Hb2XRC7jKnlN59H0R9gMX0ogiY/MAyyuEjqskM2u2BTVcXcc/dykC5OpfdoKQAJsc+1hzx43VeZQHMewIZ70dvSMM537FAmCGN795MmP673ifUm5owK7HulIdwbJpI1LTLPkT7Z5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7qAMEw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15EEAC19421;
	Sat, 28 Feb 2026 03:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772250006;
	bh=JcHxkkJ2jQ5l4alXXCwoOJ4Mo8Okdjm/WulrOIExrO8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B7qAMEw+GnCYxnJI+FwkO8aJfeUp+4wlOzKwoypIuDwMtmw+XNy2k/DJoku1tEQjZ
	 XtTcRLNbbHSQODtLzYI7mLFfgllDySaxmTAVB8dBNrB/xBak7YwwbBS+ydOuVtZPoR
	 wUno+Nf4h8A5d/khfKxY1HpSf4aBOgMjHvut+NfisFOtFOQv0FmE7p3RFH0qNjO9Hp
	 x+V7iAkz/MWm9dN8UhNaLpn35d4+0UdhC6lIjua/Y6NTwZ48EOlqatRr06719mRrxt
	 St35lulSX1nFVyTuesmqnZGCxSYXKHrYOymChpcRDiFvyH0URXgTm83tUvDOLaYkSB
	 q+t53w6yiQ43w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E9239EF96C;
	Sat, 28 Feb 2026 03:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: usb: r8152: add TRENDnet TUC-ET2G
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177225000929.2855218.7598568979166882231.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 03:40:09 +0000
References: <20260226195409.7891-2-valentin@spreckels.dev>
In-Reply-To: <20260226195409.7891-2-valentin@spreckels.dev>
To: Valentin Spreckels <valentin@spreckels.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
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
	TAGGED_FROM(0.00)[bounces-262065-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[spreckels.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E5281C034A
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Feb 2026 20:54:09 +0100 you wrote:
> The TRENDnet TUC-ET2G is a RTL8156 based usb ethernet adapter. Add its
> vendor and product IDs.
> 
> Signed-off-by: Valentin Spreckels <valentin@spreckels.dev>
> ---
> Resend (to some recipients) because of now resolved mail delivery issues.
> 
> [...]

Here is the summary with links:
  - [net-next] net: usb: r8152: add TRENDnet TUC-ET2G
    https://git.kernel.org/netdev/net/c/15fba71533bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



