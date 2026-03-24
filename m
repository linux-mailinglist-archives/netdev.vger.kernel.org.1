Return-Path: <netdev+bounces-270833-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMBPEKXhwWlhXgQAu9opvQ
	(envelope-from <netdev+bounces-270833-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 01:58:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A43300169
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 01:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D568130A5B68
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 00:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A4834CFDC;
	Tue, 24 Mar 2026 00:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPM7Epkn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7A934E745;
	Tue, 24 Mar 2026 00:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313429; cv=none; b=fG4/6qK55q7smr0GPASc0E5ssIsp+z8kNBGMMeptMXdJMhm60LuD0I3CMjCJuh1GCO8FBaVULxVW++rUjvA74vjUd0pVwEK98OHJV0JaVSbRH5yCjeXv+2rUWvIb8dLvBF7ac/SwNCdRkUtgC8XmBmTMWMXyBxCBPkxiPwG5sBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313429; c=relaxed/simple;
	bh=4UUeiMZ/wyxYGbW56KipCJvK+uW5QqFSTftJPOUz+60=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uNJyzGt54xGZvkAZs92jNkq8bCuKafXEMQGqYeRhQ//o9xF+jP8Q3FhMgYhC7Kwn/svQRrFnchL7Tyxp8r7hG6KKEZunfDtq+AgG8d032amS3bLWGuhJV6T5wv4anzkVoZ6zdrSQhDRf2w4kuObx0MfXv9YXnLeMq0OcuQEYLXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPM7Epkn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6338C2BCB1;
	Tue, 24 Mar 2026 00:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774313426;
	bh=4UUeiMZ/wyxYGbW56KipCJvK+uW5QqFSTftJPOUz+60=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UPM7EpknW4/lwyCkDffwk/Dzjztf80zcgaKSDzACPvHSPQaZvBWI0RFZD1aMsxKjg
	 yumCNTsHnCQIpicxmOKMEz9CM/9XRbfhnMMGl4ELuXQUfyhOl4JaaJWemZFzI4v312
	 DdwhyukxklE6b5iQVDxNdyq5vclAajv6MsmkqN4h7Dwg84+8xNl90IOuqedl+Rf34Y
	 AznO0Yw2cXX/8mDwSJUpiq85DdU63icInjp+4mGpNt5CdmEuYpwTAJ8amhQ1d4qpou
	 2lA6yqtZaLBvZlUBfFGG7VLmwL8QniUdGHRsi7c4CgJfS4P8iFFwGrr+YrPsGilzxW
	 rRjy3FTjat6GA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD903808200;
	Tue, 24 Mar 2026 00:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/1] nfc: microread: Drop unused include
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177431341503.395707.4919884343334169204.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 00:50:15 +0000
References: <20260320215230.3236005-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260320215230.3236005-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-270833-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A8A43300169
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Mar 2026 22:52:29 +0100 you wrote:
> This driver includes the legacy header <linux/gpio.h> but does
> not use any symbols from it. Drop the inclusion.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/nfc/microread/i2c.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next,v1,1/1] nfc: microread: Drop unused include
    https://git.kernel.org/netdev/net-next/c/0e1038162654

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



