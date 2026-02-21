Return-Path: <netdev+bounces-259790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA99HJj1mGkaOgMAu9opvQ
	(envelope-from <netdev+bounces-259790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 01:00:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C845A16B7AB
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 01:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 765003059F13
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 23:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B023168E4;
	Fri, 20 Feb 2026 23:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpvSmVtS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734E431282A
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 23:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771631997; cv=none; b=J7Nis/FxsacfIBg4AFNe2DHMi4GTyt7i8OvYCmjf/CAOV2cnQ7zsN9M9u961SKDS+JPmwIhSSdSip4VN0wBzkR6vjXtiO/7aYEmPU4Z6XSYK0tT0hoYVpi83Vs/EyNihgift740KgoldWdWDfyAA9zoVms+pJhuC6LoRUcQltW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771631997; c=relaxed/simple;
	bh=j6FWh/RRIK2dtGXPOi9XBzgxwzW9odKTxw5//tHbqDw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gnAApU+dZHNVbct9YLLIS9ZotYufgs4XuXaBXyqWhtl0X/gPlW8FZNKyccCZMQBUKfFllw+kwMX0JvxKLbqc8Jzb9u32LBdnOCXgOANiQZzYml7xiV0i2V3Bf0GzuUO3P8szcgEy9iRLtVpqtVuBo0GWQtitGq8Udzt+Gn9RuFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpvSmVtS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CF0C116C6;
	Fri, 20 Feb 2026 23:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771631997;
	bh=j6FWh/RRIK2dtGXPOi9XBzgxwzW9odKTxw5//tHbqDw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jpvSmVtStIVw0TL2RDF8sYUpgDpOlsPEebQCF122mJqAovzXJLXx91O0aD2nNi9mB
	 FBH8ZN6snMUaTx1UN7680Nk/HiqhIzJC1kUrlLGWwJFu3Om0WUfFjt5vsnN3TR3cV0
	 7Zp6WZCT9QUdx6n7GnVe3Q9gQK760huWLqIZzuiQErSAKC7YZ3+N0IBBeFLNVkkodA
	 zVAqNbjyfGxWwfriCQXRBD1zPYDPcjQfxCETEVHhXsOXTt6Z3nK4FFPD1VWuw881TV
	 3pSMqH09fY+GL9zZTN0AW9uOw9ldIERLZXC/mjqwpp+iE6A7qASDQs4/DGWEpd0L99
	 OvaPj7u0rfMbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD203808200;
	Sat, 21 Feb 2026 00:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: update enic and usnic maintainers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177163200479.950472.18224516981577651137.git-patchwork-notify@kernel.org>
Date: Sat, 21 Feb 2026 00:00:04 +0000
References: <20260219-enic-maintainers-update-v2-v1-1-c58aa11c2ea8@cisco.com>
In-Reply-To: <20260219-enic-maintainers-update-v2-v1-1-c58aa11c2ea8@cisco.com>
To: Satish Kharat <satishkh@cisco.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-259790-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C845A16B7AB
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Feb 2026 11:24:00 -0800 you wrote:
> From: Satish Kharat <satishkh@cisco.com>
> 
> Remove Christian Benvenuti from the enic/usnic maintainer lists because he
> is no longer working on the drivers and the email address is no longer valid.
> Keep Satish Kharat as the enic maintainer and the usnic co-maintainer.
> 
> Signed-off-by: Satish Kharat <satishkh@cisco.com>
> 
> [...]

Here is the summary with links:
  - MAINTAINERS: update enic and usnic maintainers
    https://git.kernel.org/netdev/net/c/9b8eeccd7110

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



