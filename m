Return-Path: <netdev+bounces-263527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJXEJDeMp2nliAAAu9opvQ
	(envelope-from <netdev+bounces-263527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:34:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BA31F97EB
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C872309A220
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 01:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878811A6825;
	Wed,  4 Mar 2026 01:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GalJj31O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FC11D6BB;
	Wed,  4 Mar 2026 01:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772587832; cv=none; b=l2Tc2X7K7oUDxs+4DZ/ZZ/3e/g8fDw90Sj8Oa/FMcyNeekRbGCyXAs9hebsIAyOevVj1fiYp/j0cJc3ENVwSMToZSQMaVq1/k98fA/g4ztLpgQQlbY0alLCG/WYEm8+Lm46voXODpX4gRna4nT6FVEao2DYjNIco0H8a9sn751I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772587832; c=relaxed/simple;
	bh=V+Yr2ILKw7n0kn5hIzo3fQKAZ+y8eMRV5OuCN/Sbf3g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WO0K5dsv4912ZFVEbi6trYKyDjYn0Pkpp5AkPAhpb1ykubC6WOTu+fpk4rUpdc536wgpMoVKWqZWSDAjxWW+WCHSyEckmNL4I8cVeFBxzoUbqi/wRmCSnIKJqCE1ADg+oC6fa6QkY2qJD1im5waPpeMpQC7JQn7rn9ZAEcNmMWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GalJj31O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA1DC116C6;
	Wed,  4 Mar 2026 01:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772587832;
	bh=V+Yr2ILKw7n0kn5hIzo3fQKAZ+y8eMRV5OuCN/Sbf3g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GalJj31OKG+7j8/2gBCVg2KxsiBYVBY/cLmTYp4/TDGGGtLrpJmZ6hzRv7JyrBHiM
	 Nmzt3WS+0ZlazpUFX0yJCnqcTCSlxrsLzFQ5uLBkrsteexwBftiqzsGpq6mtoliCA4
	 GZSvoccDItMEZtExTkTrJvMeJwBzWdN1Q6/gg/LDb5wdsX/MjHO3nnkQJOVtidy8Mg
	 eMBXar+GreDzuhzjHAYRRyzcITSPgspUMSu8qi3LflNo2ksGQavbgO3pRQRjjqfvD4
	 Zaj/Qpd1LMGPp40nSb2WlrUyGnEHPHv1ocJH+y4EFzfmVXumIb58MFZ83DkJw7FH05
	 JO+tsVfEcgfKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE973808200;
	Wed,  4 Mar 2026 01:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] NFC: s3fwrn5: Replace strcpy() with strscpy()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177258783279.1546050.3131189679852517147.git-patchwork-notify@kernel.org>
Date: Wed, 04 Mar 2026 01:30:32 +0000
References: <20260302100908.26399-1-tomasz.unger@yahoo.pl>
In-Reply-To: <20260302100908.26399-1-tomasz.unger@yahoo.pl>
To: None <tomasz.unger@yahoo.pl>
Cc: krzk@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 krzysztof.kozlowski@oss.qualcomm.com
X-Rspamd-Queue-Id: 58BA31F97EB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263527-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[yahoo.pl];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Mar 2026 11:09:08 +0100 you wrote:
> From: Tomasz Unger <tomasz.unger@yahoo.pl>
> 
> Replace strcpy() with strscpy() which limits the copy to the size of
> the destination buffer. Since fw_info->fw_name is an array with a
> fixed, declared size, the two-argument variant of strscpy() is used -
> the compiler deduces the buffer size automatically.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] NFC: s3fwrn5: Replace strcpy() with strscpy()
    https://git.kernel.org/netdev/net-next/c/8ce185c7e00d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



