Return-Path: <netdev+bounces-269732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGq6F0WVvGmE0wIAu9opvQ
	(envelope-from <netdev+bounces-269732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 01:31:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFB62D4752
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 01:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A49030DDF91
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 00:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76C6212B0A;
	Fri, 20 Mar 2026 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOv1pp24"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FBB175A63;
	Fri, 20 Mar 2026 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773966628; cv=none; b=N5xvgUU3MmJsYORdmdPEzoET9y5fAwJ0JY7T64+CWAv0QXJZRGxRxbTFmzzvN8tc5OMSs18GDF3u2TpJhHyMITndaQnCjSTeTilJVDWY20NJCl4icpBpz+MMAzRMPEiCmJ41VCYWeC5AxlPcqdRLHKINkrRlYSKWEMOcfFLu0j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773966628; c=relaxed/simple;
	bh=bpwLxbWAaBvQD1DQg+qTwXh/UD8+oR7zVauZRKZ7Lxc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VDzZXqOaKD7hmSM9AYqtSVYPQ7NQGNCZ6LVcLVGWWn22Ma38Wii+Dae3Q3MqtXy6hH+b99LZ85QD+SHXAFBmXmp9DlRW/OlpYaVjhzAtVwpSkK6B3f8eL2aD/mkHUYirl50GomvHQUVpirQf7MCvGApokSoa6jO6hSKjq8BiB68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOv1pp24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9BDC2BC9E;
	Fri, 20 Mar 2026 00:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773966628;
	bh=bpwLxbWAaBvQD1DQg+qTwXh/UD8+oR7zVauZRKZ7Lxc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hOv1pp24WPYuQ6PQl6ltBTE0UK97fuY0KVmmCAzalLFBqfYs8tbCdpmiHY5eiEQJy
	 JNx0DAkj0bk92mfwcw9IrZcy9IA1xK/FqnPoVhBR0e0mFt7qFIksOsuKa8YJahDgNT
	 fjhl78foW0Uxiq7sZ8Pp1+iTfeOcMVdEtMnNdug4P4OpnWDsRXnHrqi+IBfN3hfSTz
	 6fBwpdQ8Ugj4mwZZGjXBfexJ4IsOYL11qFZzv7ofodBHJ7JYDkvx6HqmiFgvbJVL95
	 73+onivV04uus48TggQ/kvft6laM1pB+ei7F7m58033Et/nFj16fZPnyl4JHHM4rWz
	 xYXGpCYHNhUgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE2D39302F6;
	Fri, 20 Mar 2026 00:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: ntb_netdev: add SPDX tag and remove
 boilerplate
 license text
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177396661903.1861152.6006865353004444253.git-patchwork-notify@kernel.org>
Date: Fri, 20 Mar 2026 00:30:19 +0000
References: <20260318211153.9460-1-rayfraytech@gmail.com>
In-Reply-To: <20260318211153.9460-1-rayfraytech@gmail.com>
To: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
 davem@davemloft.net, kuba@kernel.org, stephen@networkplumber.org,
 ntb@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kudzu.us,intel.com,gmail.com,davemloft.net,kernel.org,networkplumber.org,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269732-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: EEFB62D4752
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Mar 2026 22:11:53 +0100 you wrote:
> Add SPDX-License-Identifier tag to reflect the dual
> GPL-2.0-only/BSD-3-Clause license, remove the redundant
> boilerplate license text and contact information, keeping
> only the driver description.
> 
> Signed-off-by: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
> Acked-by: Dave Jiang <dave.jiang@intel.com>
> 
> [...]

Here is the summary with links:
  - [net,v4] net: ntb_netdev: add SPDX tag and remove boilerplate license text
    https://git.kernel.org/netdev/net-next/c/b29580d58be6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



