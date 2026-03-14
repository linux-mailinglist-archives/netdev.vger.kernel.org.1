Return-Path: <netdev+bounces-267664-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NdMAADGtGlIswAAu9opvQ
	(envelope-from <netdev+bounces-267664-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 03:20:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E3C28B624
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 03:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D19D304C2DF
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 02:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF91727E05E;
	Sat, 14 Mar 2026 02:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b24aSspA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999212773CA;
	Sat, 14 Mar 2026 02:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773454841; cv=none; b=ndqxST3LjlJxAq3lEMtr72aVjtB7wwoPq0yXq+trxL9juN/rz1+kKsIZTBmM+nI5xaHYZKmSqok8jbg1Cvci5CkSV4XBHZfI3eWHwyj1kC4KKVWpHJQzEbjvWNgD82C+28aGPE2e1Ltcfmynx4W0CWWadSiUC40YlsN7rGBhCL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773454841; c=relaxed/simple;
	bh=CbjQzZCV7kz55hiznE31FLaBKnftm+BcDxJGe2kcgFk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FIzQjqe4XEzZI1GxeJKhCuMJBn5c9MTScYRnd+wMQKqttiYuBwU1NXtoilQmlzAxlOuXUINRSPfITw7tHIZv6Zj7eADWhmQLVAt/Hw5zdSJBZs9YOvfpqzcmRCegVVxorba9jfiGboxG6LnGZM4VwEYq+BzKowe+oizjJKzFdug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b24aSspA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE71C19421;
	Sat, 14 Mar 2026 02:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773454841;
	bh=CbjQzZCV7kz55hiznE31FLaBKnftm+BcDxJGe2kcgFk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b24aSspAvpljRpAmDb0Rafu03+JfsSxkwevxVG0h/uwjr2yIi9XMABZzljb8Syeou
	 kh6F6zqb6ge/eT0WevlgA2+jy6S4iU3qDuHkACAfOrOOMthOzlQ6/JNOznCvZ4oHnW
	 bZcOJeiQtHcBXuwzAEKVR8ZwFe4HBYQDJ7Fm2utlObwvRtJkZv0F9tOgZPzmpMJHyu
	 rnaVPY6tGpmIz578DJIx0X55NFiNTMmfKxNJ+x6WYdNctYIrxEwwYdfG+NIC9Lgq0P
	 YQHdKYqVWsAVZtucFmS7P5pwtcuVDu027L0ekYCCC8qpZFpGOBhdxkm7Uc8rijwz58
	 cOd0bSrM4hpDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FEE63808200;
	Sat, 14 Mar 2026 02:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] ptp: ocp: Add support for Xilinx-based Adva TimeCard
 variant
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177345483579.1571585.7471880514600632499.git-patchwork-notify@kernel.org>
Date: Sat, 14 Mar 2026 02:20:35 +0000
References: <20260312082009.249622-1-maimon.sagi@gmail.com>
In-Reply-To: <20260312082009.249622-1-maimon.sagi@gmail.com>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, lkp@intel.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267664-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,intel.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64E3C28B624
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Mar 2026 10:20:03 +0200 you wrote:
> Add support for the Adva TimeCard model built on a Xilinx-based design.
> This patch enables detection and integration of the new hardware within
> the existing OCP timecard framework.
> The Xilinx variant relies on the shared driver infrastructure, requiring
> only small, targeted additions to accommodate its specific
> characteristics.
> 
> [...]

Here is the summary with links:
  - [v5] ptp: ocp: Add support for Xilinx-based Adva TimeCard variant
    https://git.kernel.org/netdev/net-next/c/9089c5f3c444

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



