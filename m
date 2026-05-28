Return-Path: <netdev+bounces-292641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBH2EZMVGGprcwgAu9opvQ
	(envelope-from <netdev+bounces-292641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:14:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D91EF5F0603
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D21A4303A11E
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6FC39903E;
	Thu, 28 May 2026 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvya7uVu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F8D38C2A9
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779962407; cv=none; b=eACIs7pa/74WX/qpZZpMXoqwIN0ACGINciDNertpwQTfQsEeg3dq479YBqf4wk/RLHxstixuJoLBgYC984N/k4XAzhIe7bQN4Inw8QJK5n8pkzbtk2rNzGM3CxdkHIDzwewb+l1/LDJEqdktNoSEk17OTVyUSORwlyW+hrRsfrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779962407; c=relaxed/simple;
	bh=/rgRL9VM8R+TLnyW5Sc5UQH7b/OWsbUUyZKTSJw0vlc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mjDcT+vdh8gDqR1/6IbEtjBHa04yZM2KhO0jUoqJ3vwzLzXnSYORq8Rswug6WwQgQpCy0mgl/P8c4xGT7rYsjB9kgxW8e+5wqvFHUzTjqOuZ9wwhGprJhTZplrQ4ZrTX6jGA/GQ9XX/We2BThk4tPPgdRnFvD76lBvDEc2z62x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvya7uVu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3666D1F000E9;
	Thu, 28 May 2026 10:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779962406;
	bh=OELPdEGxdDqwbEEGnvI8CDKuQHJiapXe6hI5CnU0B6E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gvya7uVuMKN1OKAMHB1GiC+tgo27Q4vjk3DGv1HjEfJkChx6Ec6KU2gDxi1TlQyyh
	 jGaGotbgubdkVM88Kejtso7ZGmfSktpHkK9MseMZmKPINI9E6QY6kxbi33wp1h8M4r
	 DOqQvM6X2B7slOeU9Z4mMCQH5y73lWpj1n30ONLLTqMZ5/gm/CeC9KxI083kVApSxI
	 /4VLZEUlJtycjXQa5vnXDX7Wtl/D+3rZFcgQEEr/aVHs4TKl9mVWnU9EOkqeLVrfXR
	 YRWPYh8TH7I2jA7Z3SDUBITj2vsMkAP0tJGJs4miefVXlSmO3qli5giyp7htYf8rZZ
	 FAU+m1vD3Elqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 138F938111DD;
	Thu, 28 May 2026 10:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] wangxun: improve service task
 synchronization
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177996241088.854469.10883197622089016041.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 10:00:10 +0000
References: <20260525100543.27140-1-jiawenwu@trustnetic.com>
In-Reply-To: <20260525100543.27140-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, kees@kernel.org, larysa.zaremba@intel.com,
 jacob.e.keller@intel.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292641-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D91EF5F0603
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 25 May 2026 18:05:40 +0800 you wrote:
> This series improves synchronization between asynchronous service work,
> device teardown, and module event handling in the Wangxun drivers.
> 
> ---
> v2:
> - Check WX_STATE_DOWN before setting WX_STATE_SERVICE_SCHED.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: wangxun: introduce WX_STATE_DOWN to serialize device shutdown state
    https://git.kernel.org/netdev/net-next/c/7116ffb48ad0
  - [net-next,v2,2/3] net: wangxun: avoid statistics updates during device teardown
    https://git.kernel.org/netdev/net-next/c/58ac2f8eb050
  - [net-next,v2,3/3] net: txgbe: rework service event handling
    https://git.kernel.org/netdev/net-next/c/f67aead16e85

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



