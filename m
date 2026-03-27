Return-Path: <netdev+bounces-272356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +B+7Mfv5xWmOEwUAu9opvQ
	(envelope-from <netdev+bounces-272356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:31:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2265133ECF0
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE0DD3017C35
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 03:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D234C36C9F8;
	Fri, 27 Mar 2026 03:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQ3LpiiQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2D336C9C0;
	Fri, 27 Mar 2026 03:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774582223; cv=none; b=VGA/5WWeNvm2bLVCMeXjTARNdiX0o8vyE7M1LVLK5hKXIhC0WuPwoqRPGS6WIBYeXoaIQs7FzMiTz70bZce9Laqw2tMbqUAQsvMQyACj5zQrnoFPkgeG/8RzCmPGZNBC3X+XNBubq/RYQrtvgsM3GdKJ/cJs9iuG/E586/1Xvfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774582223; c=relaxed/simple;
	bh=aaJRGPqgb61KY23V+ty+AwjuClm0OPw0i+z42m/+LsQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QNwXSgMIXXS4kLiulJgRblr5fOBGybeTLi7Sfbvljc/yWzs0uHEkyh8NwPrH7vea+cLrktyl7Vp39tY0rupSXIaDys71B9NNUYO/Lx6vIqAn4AXjfogsGqtWYlkMVFfZkCaKE4itKeS6UPJKVtNxYPERBfKBw4bc0I6tvNVtUpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQ3LpiiQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892B2C116C6;
	Fri, 27 Mar 2026 03:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774582223;
	bh=aaJRGPqgb61KY23V+ty+AwjuClm0OPw0i+z42m/+LsQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JQ3LpiiQYZLOFELuUUrMmgAGaOAQUuAZQs5eYaN3ltprz0suvk6RJu7ZG1VtgdkS2
	 YWhkGuohNRcp/hAglrZxTqSPOX4nCj4Itq33vRk84qUd2OHNnhvVv+7TFAROwwPJ1x
	 N3ODMM9DCmUG7fNO4t88N4+JsOJ+aQUQefFsGnZBT52AfMoHFGGGZytoB8fImfWhr3
	 rDS3axb5qWCw/59c4SGXrI/oGb4Da1FeU3ds7vS/VDYRnubVmKBN3iRU4ZRmGHEDWL
	 GOeMTzy7k5OaTxT41z/HOAxEieF/1mOlWEF5TxRHLiA8IBGy+K1irsEyF7+iRv1pJR
	 HdOq3U6uATGzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E8A3809A0B;
	Fri, 27 Mar 2026 03:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 RESEND net 0/3] net: enetc: safely reinitialize TX BD
 ring
 when it has unsent frames
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177458220979.3285968.1583263638777426157.git-patchwork-notify@kernel.org>
Date: Fri, 27 Mar 2026 03:30:09 +0000
References: <20260324062121.2745033-1-wei.fang@nxp.com>
In-Reply-To: <20260324062121.2745033-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, Frank.Li@nxp.com,
 horms@kernel.org, saikrishnag@marvell.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272356-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2265133ECF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Mar 2026 14:21:18 +0800 you wrote:
> Currently the driver does not reset the producer index register (PIR) and
> consumer index register (CIR) when initializing a TX BD ring. The driver
> only reads the PIR and CIR and initializes the software indexes. If the
> TX BD ring is reinitialized when it still contains unsent frames, its PIR
> and CIR will not be equal after the reinitialization. However, the BDs
> between CIR and PIR have been freed and become invalid and this can lead
> to a hardware malfunction, causing the TX BD ring will not work properly.
> 
> [...]

Here is the summary with links:
  - [v5,RESEND,net,1/3] net: enetc: reset PIR and CIR if they are not equal when initializing TX ring
    https://git.kernel.org/netdev/net/c/0239fd701d33
  - [v5,RESEND,net,2/3] net: enetc: add graceful stop to safely reinitialize the TX Ring
    https://git.kernel.org/netdev/net/c/2725d84efe25
  - [v5,RESEND,net,3/3] net: enetc: do not access non-existent registers on pseudo MAC
    https://git.kernel.org/netdev/net/c/f2df9567b123

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



