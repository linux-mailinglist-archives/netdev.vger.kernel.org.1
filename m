Return-Path: <netdev+bounces-276784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEqvKlcN12npKggAu9opvQ
	(envelope-from <netdev+bounces-276784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:22:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5553C5811
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CF6930470E0
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 02:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3957536828D;
	Thu,  9 Apr 2026 02:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvxadHEg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16619368269
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 02:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775701239; cv=none; b=CsycHDHo4c6t/DpjH74p5V5oycJH1MfEjKlED3UHXW3mvRSpFGBM3Tx/JJq8Fa7gpwd8j7HkPVVq2Z2I0ht0rJHN2dvslAL3w54WN6cBl3TmzMfEbnBl2XhXyHzDeSQSmYOe2vBMrexChSxOpRMCPpQpBYiVbCwKDag6j/E0m98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775701239; c=relaxed/simple;
	bh=5EBPDiH0LonXJLAqj2eYVrdivX7ycWDXdFRZ1Okc37c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sVripGmkk0ABkVkb+6gbZPJ7lAiwUv7ARQenBuMOXnLEmXCxJNuhsrxyj65Mf2D74Nv8WN25pcqzE5l8pichL1BitMQSlEBs86hAoW0Tz6Ara2LwgcEWS7SghcvgDHSU4W1c7lqJSZkKZ00zizI/JN73m8SQxzUXn34OE0KLZDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvxadHEg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE28C2BC87;
	Thu,  9 Apr 2026 02:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775701238;
	bh=5EBPDiH0LonXJLAqj2eYVrdivX7ycWDXdFRZ1Okc37c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gvxadHEgZIiUc7FHvVsQsXA/4WnE7CTuS4VufHTJU4Ixy+Ln8/0x1ieTXLbKbVOj7
	 diS6jUzGK34CDelLUAAI/5pqJKRsdE6kS431vbqQSOIxi+4WOtbrtVIDJIEzO2FW/r
	 prlGE+7izQemXyFU3kHw6zeKdB7pQR5UjyBu0/NPAc7JJo4FqFiJxh8ngjPxE6ZpzG
	 LijdbLARIcYOx1mJ0si0WM7oqfi0EzP5XPzY+M+sXa0ulw/AjveLjyBH19ky+9rQl9
	 V0LMDGGNmSTPQQL1NqtYw9crQDF7ensVsQK/O2CDBVYX1fTC8isMsBTbYLfRlUqnx5
	 NQYAxCSrX/ZKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FED63930793;
	Thu,  9 Apr 2026 02:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bonding: remove unused bond_is_first_slave and
 bond_is_last_slave macros
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177570121479.959042.4125466866444257615.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 02:20:14 +0000
References: <20260404220412.444753-1-xmei5@asu.edu>
In-Reply-To: <20260404220412.444753-1-xmei5@asu.edu>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, andy@greyhouse.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-276784-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E5553C5811
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  4 Apr 2026 15:04:12 -0700 you wrote:
> Since commit 2884bf72fb8f ("net: bonding: fix use-after-free in
> bond_xmit_broadcast()"), bond_is_last_slave() was only used in
> bond_xmit_broadcast().  After the recent fix replaced that usage with
> a simple index comparison, bond_is_last_slave() has no remaining
> callers.  bond_is_first_slave() likewise has no callers.
> 
> Remove both unused macros.
> 
> [...]

Here is the summary with links:
  - [net-next] bonding: remove unused bond_is_first_slave and bond_is_last_slave macros
    https://git.kernel.org/netdev/net-next/c/f81f4e79b192

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



