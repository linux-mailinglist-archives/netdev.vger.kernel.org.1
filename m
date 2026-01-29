Return-Path: <netdev+bounces-254544-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cZr5F7HdemmL/AEAu9opvQ
	(envelope-from <netdev+bounces-254544-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 05:10:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D2AAB9D1
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 05:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 146FC30131FC
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 04:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E70925332E;
	Thu, 29 Jan 2026 04:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCIHsfVm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C04319D071
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 04:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769659817; cv=none; b=bidmwdmf/XwdafXPqMHLehs2IQhpT+R3fFDKcbb5ZEApXvnHw0jLlnJG77Qwf26ZD+zy9omquCP2dHedz2Iz5nmUdcQLSw9Bgr2kXyJNrFZSCj+bFby4RXUde/h+JtvJ28F2UwnyccSAdBwUpGP/OZ+Vf5y1X2f/KOEpLp2VfLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769659817; c=relaxed/simple;
	bh=/Y4xPxXVeKcFK+djUgaaEeNt9bE24fjOQjlzctbi7ls=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kg6JeOrNRb0GmosR9e0znnQW28hAFgOzntXsHt9Y3OGMDrctv2D9e/IPty3S2ket4zYiSpcNLnhcLe/PmYJXcF8deibjHmFaXtVNyuO4TKkwxFilRdkKAVsx3/eEZ19RlhyLgN5HuounpWL3tfZQMd675mWClylMOZ2ritjZztM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCIHsfVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E049EC116D0;
	Thu, 29 Jan 2026 04:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769659816;
	bh=/Y4xPxXVeKcFK+djUgaaEeNt9bE24fjOQjlzctbi7ls=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jCIHsfVm43anRX5tnfKdTZMYW3I9u/fDAeCPxYPQXHc55fKWUYGWd3F5RDZAyZ+dD
	 tFEDQG1oBs6xufiURu8eq4l3W7TWHhBs9TNJOaNh3qhrUu3Ia17Xegw5aTYkgawaae
	 ftQ8SGif47wtrJCMsP7DG+d6wd7yI5WTnfeoP2uepLJTJtb49bxVheVDygrZJVK2gq
	 GGfUEmcQH/YXI8SakPe5kdgrf9j+kJxGoThjqXdKdtYUyYI6jRHTd+UXdMTv9DX6kL
	 qKu734ODwbng2MueZcr4r5aQwS4qdQNKXO3RjEfZCpH8uEZO09p9bE0CpE2kfwGgLE
	 9nGYoTp7FpudQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EC55380AA61;
	Thu, 29 Jan 2026 04:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates
 2026-01-27 (ixgbe, ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176965981010.2343973.12459834676591978429.git-patchwork-notify@kernel.org>
Date: Thu, 29 Jan 2026 04:10:10 +0000
References: <20260127223047.3979404-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260127223047.3979404-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254544-lists,netdev=lfdr.de,netdevbpf];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: D4D2AAB9D1
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 27 Jan 2026 14:30:41 -0800 you wrote:
> For ixgbe:
> Kohei Enju adjusts the cleanup path on firmware error to resolve some
> memory leaks and removes an instance of double init, free on ACI mutex.
> 
> For ice:
> Aaron Ma adds NULL checks for q_vectors to avoid NULL pointer
> dereference.
> 
> [...]

Here is the summary with links:
  - [net,1/4] ixgbe: fix memory leaks in the ixgbe_recovery_probe() path
    https://git.kernel.org/netdev/net/c/638344712aef
  - [net,2/4] ixgbe: don't initialize aci lock in ixgbe_recovery_probe()
    https://git.kernel.org/netdev/net/c/100cf7b4ca6e
  - [net,3/4] ice: Fix NULL pointer dereference in ice_vsi_set_napi_queues
    https://git.kernel.org/netdev/net/c/9bb30be4d89f
  - [net,4/4] ice: stop counting UDP csum mismatch as rx_errors
    https://git.kernel.org/netdev/net/c/05faf2c0a765

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



