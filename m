Return-Path: <netdev+bounces-252326-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MND9OEoicmmPdQAAu9opvQ
	(envelope-from <netdev+bounces-252326-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:12:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7A7671EA
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 30DEF925754
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05953BBA03;
	Thu, 22 Jan 2026 12:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q++0p+Rq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFAF3AA19B;
	Thu, 22 Jan 2026 12:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083812; cv=none; b=u1z2/9Jed0u5HSpPYWS/vPGzUiJ+DjiUy8OPqiYZsXJDiOI4xSasf4apclZIDiHMUSp/PPIFgF4tK8h1KoM3pgF1sS5q2i8mRVYU/Ic07q1SwUIgXgVfF6QmTDukPTHLVd07jWk37QJkUGmhU8ORnmiFhIuNl1mb0mc/Fzl7Kqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083812; c=relaxed/simple;
	bh=XngWy+6ViL5NLbBW8pb6CJtphxGdqQrHvhYeab9cySY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KjcxS8ti1t3SuMCKohuj9QG6OCHYGZwOPZsur3WkPh4NcFLBciBTr97D+mQ3vKm+aE+bCpb396PWkNOJ8hfPYC0703bYegGoVWeOubNG1wefItM4vDKyphvJZuS0EKKuAfj0JWO17ygfK8Z5FeU3ft8xWQ+w789cLRHmrLC1JcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q++0p+Rq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CB5C116C6;
	Thu, 22 Jan 2026 12:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769083811;
	bh=XngWy+6ViL5NLbBW8pb6CJtphxGdqQrHvhYeab9cySY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q++0p+RqQASndA1LmpBwQqbWmWBcETme7USzJB/kbWukUzdsEZSB9dug35CdZPEok
	 r57Y2kbptHXd7Ek92q1t8KCvK1/606dlCvXXeslRBAEWwH04cPwu8ENuSXsgl9CfsZ
	 3Juj3wjikSq+kydHYAM9OqYUdQuPT04G6bKZkNb7gg3lwhEFwwlZtRDUcxJ+50HtqF
	 zcfxBEtGbbZgDTt3YJ+BySCECSPBNdR6CJcGw90PhYfP7dG8qyZEw1narbFmiAlajU
	 Sry8mIDf5FeNw3Mjp2YEHmrTMgsYBQVQqgUj4v/8tKjcZiZK4fd+kqTJ6m/wbKFrbJ
	 O+BG9VaepTNmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8B9533808200;
	Thu, 22 Jan 2026 12:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] xen/netfront: Use u64_stats_t with
 u64_stats_sync
 properly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176908380810.1694846.13399878058009113913.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 12:10:08 +0000
References: <20260121082550.2389249-1-mmyangfl@gmail.com>
In-Reply-To: <20260121082550.2389249-1-mmyangfl@gmail.com>
To: Yangfl <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, jgross@suse.com, sstabellini@kernel.org,
 oleksandr_tyshchenko@epam.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_FROM(0.00)[bounces-252326-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B7A7671EA
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 21 Jan 2026 16:25:46 +0800 you wrote:
> On 64bit arches, struct u64_stats_sync is empty and provides no help
> against load/store tearing. Convert to u64_stats_t to ensure atomic
> operations.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  drivers/net/xen-netfront.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Here is the summary with links:
  - [net-next] xen/netfront: Use u64_stats_t with u64_stats_sync properly
    https://git.kernel.org/netdev/net-next/c/a2ba9902e4b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



