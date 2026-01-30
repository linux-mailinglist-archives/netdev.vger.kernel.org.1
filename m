Return-Path: <netdev+bounces-254967-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eP3VCQYMfGkEKQIAu9opvQ
	(envelope-from <netdev+bounces-254967-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 02:40:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A68B6379
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 02:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E8BA30107CE
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 01:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CB3330D22;
	Fri, 30 Jan 2026 01:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Td5U9966"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EB232B998
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 01:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769737212; cv=none; b=B7gCLXb7nJJCLZkCcq6uiRjZrnnkGrIsOyAl8Nq0AStQvvMH2cO3BuckhfuZLsNtyPfXGc84HwnK7w2m6Y0fUfQt+qmcc11kT8mCeUM5qr5blvA8jBd9fD3jzZAZil3MyHcviCJJlKXTrQoQAZCKPuQBlQX+j/Ha/HOPXaAdwLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769737212; c=relaxed/simple;
	bh=0hdqXhuyqlSLYdsCwNoEykvkB5oPU0pSMGGae7x0Rpk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Sp7mqjVQ6ueZ3216UxP2+lQZQU5WpZ1lOm8oPuyZuq3guiFkvtfRnFIOlzBA9OjKhIK7cnKrRUSyRF5Bnjm61eBSFDz0AJihRzEORuC9mF9B6lAh8pPGxt9YNs/op6wqqSMs0ai2lBtEihf+H26OG4W5XwB3zUqlNDlIDawfVdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Td5U9966; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16244C4CEF7;
	Fri, 30 Jan 2026 01:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769737212;
	bh=0hdqXhuyqlSLYdsCwNoEykvkB5oPU0pSMGGae7x0Rpk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Td5U99667bRVoKqWKAXJB9AFZ3C28zaBwmOan992JiMhiu3tRqKyptY2PawDvkrPu
	 /iL5qlf4byFCP+BUHHpc4TArBVItb1HmYBfCbnrPijMyFuJSc6mC+8qwJ8VLdR7Wyy
	 A0hvcVjMmTMulitAKJgMoUzqhCqx5BWdd2QqWyMUKC+mFgCbFh5uxl4TStb1OQBuIp
	 qxU7O9nIW8ZJmAb0e+fpdRifZcI5kU/PtrSwDOBrYjk0/KD6wMk6RLdua20+qKuuSt
	 vfLXlKh54Nhe9yKANFPX02q8mTLQROUy3KWpXHUTNMLj6YVgHMSSkkGip2BoEOwArZ
	 em5uUDgDfg+Iw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1198F380CEE0;
	Fri, 30 Jan 2026 01:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: add an entry for PSP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176973720485.3132411.3237239084578006353.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jan 2026 01:40:04 +0000
References: <20260128210435.161061-1-kuba@kernel.org>
In-Reply-To: <20260128210435.161061-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 daniel.zahka@gmail.com, willemdebruijn.kernel@gmail.com
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
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-254967-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 52A68B6379
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Jan 2026 13:04:35 -0800 you wrote:
> We are missing a MAINTAINERS entry for PSP, create one.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: daniel.zahka@gmail.com
> CC: willemdebruijn.kernel@gmail.com
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: add an entry for PSP
    https://git.kernel.org/netdev/net/c/37d312bf957b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



