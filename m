Return-Path: <netdev+bounces-264275-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDvLLhRcqWkL6AAAu9opvQ
	(envelope-from <netdev+bounces-264275-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:33:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B08BD20FBEC
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF338300F116
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 10:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDC337186C;
	Thu,  5 Mar 2026 10:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4mdmyy4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9CD3101A0;
	Thu,  5 Mar 2026 10:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772706611; cv=none; b=YDNhRaa1QnW27txfU2q+WDwnir+doQyyxdgE0AnCuUr98CzViAiua0AKfY7vv2YXy55rGE2JuNnKExKIIh6Q1mvYdbSWVrdPF8gQAghbbSlM9BucAAzGxB1NbC7HBdeBf/lCjXUtppW3BdU3sT1tNmkpralHLAsKMLMEuBS77/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772706611; c=relaxed/simple;
	bh=h5RV9J2ngbF9HvXKNohHD6Tra2kDoQORNCyce5Fb0M4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gXsxosUmbDiHf5EGCsFbGVQkTdmmYpuWHHKig1W1iuALGnVmWjdkoFgVRNfp11GK+I1pFdK9yfezBBw96Ufo1OcxZkpJQ/nMbTyWoQQe9M5fzGJu3UgXlb3Zk05hNEgi/OYNA6LnYMurzgGDpa42/kpGe7KSi+q6Xrc9753KEtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4mdmyy4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE61DC116C6;
	Thu,  5 Mar 2026 10:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772706610;
	bh=h5RV9J2ngbF9HvXKNohHD6Tra2kDoQORNCyce5Fb0M4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a4mdmyy4xhWGS2Z4qTpxm7Qo8BJF9DFfIwz6/0s/MoxK9mujRtFHw4DPYmRCggAp2
	 A4ZcQkfaqPHYB3wAe4Tglr8Axzhf79uSPkVj1M7ysrqLVApA+4FP8zYvQy8rbD4KJc
	 tuczpdYyz9ClcxiyrQ0wwP8H9Ox4o42ldRdBUY+AN+Ekfath5oMt9m96hFVo+xWj49
	 e3i41UTmsF0DhVEh+DuPwHyHg1zOfac/R4cHjreUDbIrJNGPFUO29/o2RQBSh8ziAI
	 mBg+1NIN6hhmzfdItsIsfVrKHsxOZHeg5LQ+v+x7ZssbUTSoRcjR+N6twyFirukM9g
	 hH2FM6N59Cocg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CF33808200;
	Thu,  5 Mar 2026 10:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] amd-xgbe: add support for P100a platform
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177270661079.2637474.8023203743318106675.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 10:30:10 +0000
References: <20260302044409.1388430-1-Raju.Rangoju@amd.com>
In-Reply-To: <20260302044409.1388430-1-Raju.Rangoju@amd.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch
X-Rspamd-Queue-Id: B08BD20FBEC
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
	TAGGED_FROM(0.00)[bounces-264275-lists,netdev=lfdr.de,netdevbpf];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 2 Mar 2026 10:14:07 +0530 you wrote:
> This patch series adds support for the AMD P100a platform featuring
> the ethernet controller PCI device ID 0x1122.
> 
> The P100a platform uses different register access patterns and speed
> encoding compared to previous generation hardware (Yellow Carp,etc.)
> Key differences include:
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] amd-xgbe: define macros for MAC versions and speed select values
    https://git.kernel.org/netdev/net-next/c/718e1f6dd06e
  - [net-next,2/2] amd-xgbe: add support for P100a platform
    https://git.kernel.org/netdev/net-next/c/ea274bf8529a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



