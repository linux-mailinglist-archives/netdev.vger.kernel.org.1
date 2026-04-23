Return-Path: <netdev+bounces-280723-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GM+uLer76WkFqwIAu9opvQ
	(envelope-from <netdev+bounces-280723-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 13:00:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D01D451054
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 13:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 074083016514
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 11:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2D73E6386;
	Thu, 23 Apr 2026 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2JpiwM1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4143E4C81;
	Thu, 23 Apr 2026 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776942051; cv=none; b=uvMlr3dVUt5v8tDM7to4icpKs5j/cNCBRGqpD2vpFnHn1eIYJfHoG2US4DRexnuA6NpTHm0r0u9yFtb/MH5eUxuY2y42KlV0+6SB6DNawJp7x48qh/h1QsXqSvbnUDDT7q23tB4sKTw/gBlX95opRZiGstvJ/Dl2pNnrhVy++nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776942051; c=relaxed/simple;
	bh=CcVRpRrFwUfSfwAItnzPocv4aXz89Ri6TkNEF7/UYKo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SqL1WMPT9dqYvVR/qQuYsTQfYop8IpSVkYqHQ/SWaW1I/nm+A0IqquzUz+UTph8IkHCTc0k/PQx+pl4IxWurRKyYoXZOic/reVIofTjzmTES+aFkXlXgkQdGzE1Sa+fO1iH0EaS2YSVRAuw1sWGhxNRL7k2VPaaXb8gBQD16owc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2JpiwM1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161B4C2BCAF;
	Thu, 23 Apr 2026 11:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776942051;
	bh=CcVRpRrFwUfSfwAItnzPocv4aXz89Ri6TkNEF7/UYKo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G2JpiwM1x5IfNRafQOcwTVhS7qaU+oehEbbx9gLqfPTQv5DgsunU6jvngmOTaGobX
	 QdKfhP3qaq+Hs/tYQgAJrd3iXYt2lAlKUOrtKjODRonTKupjsPxok0FMVa9mmhIbOi
	 H2lKA+CMphEvEFk8wOBobcSQ5c3MDyUIBUAnuy6bYLmqeRkHjl0lO1R50NgPeLgtYc
	 xxw0RHpDYiKdMBFxvGafvQEbMrf2roqk8xavhRvNshfIN2CMDTNcR7mpczguGu62nK
	 KDa0mVk/fBUGtha9dHdZrVXs61T+HkZOl1frH/xO2eYBWK6TqjAgl2wXx3xe8LzSG5
	 i0oh9B/i2ZZGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D30380CFFD;
	Thu, 23 Apr 2026 11:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/5] net: mana: Fix probe/remove error path bugs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177694201279.110732.14645010674542588173.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 11:00:12 +0000
References: <20260420124741.1056179-1-ernis@linux.microsoft.com>
In-Reply-To: <20260420124741.1056179-1-ernis@linux.microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ssengar@linux.microsoft.com, dipayanroy@linux.microsoft.com,
 gargaditya@linux.microsoft.com, shirazsaleem@microsoft.com, kees@kernel.org,
 kotaranov@microsoft.com, leon@kernel.org, shacharr@microsoft.com,
 stephen@networkplumber.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280723-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[pabeni.redhat.com:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D01D451054
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 20 Apr 2026 05:47:34 -0700 you wrote:
> Fix five bugs in mana_probe()/mana_remove() error handling that can
> cause warnings on uninitialized work structs, NULL pointer dereferences,
> masked errors, and resource leaks when early probe steps fail.
> 
> Patches 1-2 move work struct initialization (link_change_work and
> gf_stats_work) to before any error path that could trigger
> mana_remove(), preventing WARN_ON in __flush_work() or debug object
> warnings when sync cancellation runs on uninitialized work structs.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/5] net: mana: Init link_change_work before potential error paths in probe
    https://git.kernel.org/netdev/net/c/cb4a90744bcd
  - [net,v4,2/5] net: mana: Init gf_stats_work before potential error paths in probe
    https://git.kernel.org/netdev/net/c/6e8bc03349fe
  - [net,v4,3/5] net: mana: Guard mana_remove against double invocation
    https://git.kernel.org/netdev/net/c/50271d7ec951
  - [net,v4,4/5] net: mana: Don't overwrite port probe error with add_adev result
    https://git.kernel.org/netdev/net/c/a7fdaf069bd0
  - [net,v4,5/5] net: mana: Fix EQ leak in mana_remove on NULL port
    https://git.kernel.org/netdev/net/c/65267c9c4f28

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



