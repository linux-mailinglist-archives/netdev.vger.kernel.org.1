Return-Path: <netdev+bounces-273655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAifGsnZy2kaMAYAu9opvQ
	(envelope-from <netdev+bounces-273655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:27:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA35936AF02
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C89B330B2702
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C003ED5A7;
	Tue, 31 Mar 2026 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFglHuv/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A178A3EAC8F;
	Tue, 31 Mar 2026 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774966822; cv=none; b=Y6riMHgZET5rELu/qdirLAvfGCliBVB7cHvg/d3/EbPGzCBMI5ff4GTzqVUwvywJtmE3/7xO+hZW3XjLMyYmo71YrSqJu6GsVTu+uNNhDtBnwW9JNgGTu7mmzDOkEcX/y5+ozXqLO6X9vyHqm9EfYhJ8/ZoUwaRK0omcAC285ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774966822; c=relaxed/simple;
	bh=bH0arDUlq7YQ9/Dbackf+FEbh9CuPx03+Swmjwpcddc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DdaMIhc4iKEC1sYTDiX1sk4FpvLz6Z7VsQBf0tJv52eNrXxiK8osBZl1rxoKps0XDf3yfKJT+AKFND//R4NAZTEpxR8TXn20fsLPiPDEeUoT37emH23GdFp3/M+7E1YNlLQZaXERqaAYe7aiO+XDqgJWOvDnb1ntqpAoLMA7wAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFglHuv/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32255C19423;
	Tue, 31 Mar 2026 14:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774966822;
	bh=bH0arDUlq7YQ9/Dbackf+FEbh9CuPx03+Swmjwpcddc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VFglHuv/Uljj8PLu7AN1IJBHaM0B+QQwzXF/nQIYAYvIr4hYujeMubDgMhHIWncR6
	 whRBFFQiSd2jaspD2t+jSsvHr0LDXENMETdWi2X3WA4jsRt98Eh3tm5vxMkc2xkj75
	 6A6gZPGhU1TuLb9N9oh3kbWT+ZZPSYdAQ/6ABUsDGsJK5AF5//Cf2M42hHtGT1tw/C
	 bECCXZDF+lBylJPX99AGBLsR3HWgiIDcslhq67RvtdnVdJ72umLRH4uRACM3cEiZ5l
	 UEK/W6qLbzaiAEWTSJ8sYmtcljUOBEFR5gnu77tIFuN/ZUvGxdxBdYIwG4P443KxNC
	 sZD4cBZ6bK1YA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DA23809A05;
	Tue, 31 Mar 2026 14:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] bridge: mrp: reject zero test interval to avoid
 OOM
 panic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177496680554.2727366.2524464978514165694.git-patchwork-notify@kernel.org>
Date: Tue, 31 Mar 2026 14:20:05 +0000
References: <20260328063000.1845376-1-xmei5@asu.edu>
In-Reply-To: <20260328063000.1845376-1-xmei5@asu.edu>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, horms@kernel.org,
 razor@blackwall.org, kuba@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, bestswngs@gmail.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,blackwall.org,nvidia.com,davemloft.net,google.com,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273655-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA35936AF02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 27 Mar 2026 23:30:00 -0700 you wrote:
> br_mrp_start_test() and br_mrp_start_in_test() accept the user-supplied
> interval value from netlink without validation. When interval is 0,
> usecs_to_jiffies(0) yields 0, causing the delayed work
> (br_mrp_test_work_expired / br_mrp_in_test_work_expired) to reschedule
> itself with zero delay. This creates a tight loop on system_percpu_wq
> that allocates and transmits MRP test frames at maximum rate, exhausting
> all system memory and causing a kernel panic via OOM deadlock.
> 
> [...]

Here is the summary with links:
  - [net,v2] bridge: mrp: reject zero test interval to avoid OOM panic
    https://git.kernel.org/netdev/net/c/fa6e24963342

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



