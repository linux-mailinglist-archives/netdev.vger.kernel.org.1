Return-Path: <netdev+bounces-278565-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAkaNgON3mkIFwAAu9opvQ
	(envelope-from <netdev+bounces-278565-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 20:52:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D28A3FDD7B
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 20:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C51443014BC6
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 18:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F184022A4E1;
	Tue, 14 Apr 2026 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkYRvONg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF59FF9E8
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776192640; cv=none; b=kxPeDhjvTo/+LTwVpBb3sLv/sVL6tGn8Hq2+0y3HqtqsUJVty1yKqZodgMVepRmCYtIshfKkSJQSo4QMq/9AeL1G/UM/U4pzZU/EWFjUsmLZNP6UAHJyTRfKDx5M76jAgbon0tIrE+pKEnv44zoW9rWC+aXNz3pJ64o6ipE/hE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776192640; c=relaxed/simple;
	bh=pr48Yq7zbmFQvMBw6bWL5BvdnLTeMbUdF4SaEW0N5Yg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Eb0O9Tl+fD1SFUleUGIj2cm2+rhouj/ci3H4/r8MP39hmhB3FQ+bfWm6vfJS7yefpMW7r+2nh14R8oH1HHrhAYhVgU0CDuOJjk/j4r6dlhIV5cTbAbYpC8Q06lHdS92zzws01Az0RbJOqEA4XHN7b3nRPb2ws2DCem8wRz2kccg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkYRvONg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68758C19425;
	Tue, 14 Apr 2026 18:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776192640;
	bh=pr48Yq7zbmFQvMBw6bWL5BvdnLTeMbUdF4SaEW0N5Yg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BkYRvONgQZAWN3IQMDTZMjqIN29Zf7Uhv18Sz0vFkop+q5+/Y0SADMqBmsJVUDT6f
	 lGoI2QndRyPV8qEhQVl629VjBDCzdWVo53ysgIl6i2xUkfcfX09bnSoISk39DVsXwb
	 eJFnwNqypTMGoaynO+csqrtfymEr5PnjrctbGn1K3XtD/5DYBl+u6trsrsAFwkmqx+
	 I97j0daiNrYJZhy1nTjT+lYzCMsq50V7QGEWiLRsHUEwBOIz6U3kATw4M5eoJJBh4v
	 W4Qiv0SYuW90kAZ24LKpSJEKaGKEIEdkhoiNazkq1R2HqF1n0JxRvVzvSpkZs7xh6z
	 Mh8Boomwr3Q6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C0B3809A0A;
	Tue, 14 Apr 2026 18:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] WireGuard fixes for 7.1-rc1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177619261080.1424819.15082422216238767602.git-patchwork-notify@kernel.org>
Date: Tue, 14 Apr 2026 18:50:10 +0000
References: <20260414153944.2742252-1-Jason@zx2c4.com>
In-Reply-To: <20260414153944.2742252-1-Jason@zx2c4.com>
To: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
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
	TAGGED_FROM(0.00)[bounces-278565-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D28A3FDD7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Apr 2026 17:39:40 +0200 you wrote:
> Hi Jakub,
> 
> Please find 4 simple patches attached:
> 
> 1) Asbjørn's YNL sample, finally merged. Sorry for the wait on this one.
> 
> 2) A simplification to use kfree_rcu instead of call_rcu, since
>    kfree_rcu now works with kmem caches.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] wireguard: allowedips: Use kfree_rcu() instead of call_rcu()
    https://git.kernel.org/netdev/net-next/c/e5549aecdd24
  - [net-next,2/4] tools: ynl: add sample for wireguard
    https://git.kernel.org/netdev/net-next/c/121f416756d6
  - [net-next,3/4] wireguard: allowedips: remove redundant space
    https://git.kernel.org/netdev/net-next/c/f364db381c9d
  - [net-next,4/4] wireguard: device: use exit_rtnl callback instead of manual rtnl_lock in pre_exit
    https://git.kernel.org/netdev/net-next/c/60a25ef8dacb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



