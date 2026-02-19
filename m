Return-Path: <netdev+bounces-259518-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFwyLLJBl2lXwAIAu9opvQ
	(envelope-from <netdev+bounces-259518-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:00:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F56160DF4
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E8963010BB0
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 17:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C8E2C0294;
	Thu, 19 Feb 2026 17:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJUbPMiB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D631F2C1586;
	Thu, 19 Feb 2026 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771520417; cv=none; b=H9IL6y/HEkAF4GH6oNADtS6uhIx5pRN4sPhSwW7gwcMUOziaiETKWRX+Brd7Js/KmOdhVaa/BpyrZpldm9KGwuGx0HyozKe4EEtsHkP/ykmBB1kEoWbNW/qKDaXWoZAzdk0sMvv71nNVVTvYhpTBxdSBW1nuXZe8DQa/3MzZVdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771520417; c=relaxed/simple;
	bh=XvPDoDY1pPUq2k4fN+DFMpOuKnftkoMNinTaw9sQDoI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BKpCmVhb0hNSjrmY5ygI0L1/2KcR0HzknuW0RVgbzEBljbc29kKqLxH6gqSd/ZXp2PtrHE5mnPuxS18x7+qnE8n3E4uPyyuHnmn7tVzoe0PYIqelwPuxBbPdPLgIH8ViQ4eVdljd8xwqsr7qnVR9IOPIUAHB3mqlR/CYe43j0po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJUbPMiB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739D3C4CEF7;
	Thu, 19 Feb 2026 17:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771520417;
	bh=XvPDoDY1pPUq2k4fN+DFMpOuKnftkoMNinTaw9sQDoI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eJUbPMiB2E1T9Lhc+4dT+CcezwLr274I7dc4UGbegfiNEmILiv46YJAHjjtqMHufk
	 RLEKmy+FSRhTdTCpgjO76/RRqjJDhWD/fHpyPq4irNa+j6ZBS0U6MbWX3cgT7eGj2c
	 E1MpAeqMvxygCgTDyNRRk49QVVvMh13YfnKrc6mOt/ixWj6HTY0igOCPAp2NHBzLvf
	 CxR9/oF8dzPWaTsiUVSURSBL6iSwsgLYwEACVxtQiNwchCl4eFHb2v4U3LpHPAJ01f
	 HK+i9nt9v6puKDD5gjJkiUijyfocBRZJONcmqoEbLpKryUmjSN0n/WxK54RxMqBzog
	 0Yt548Q6n521Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8527C380CEF3;
	Thu, 19 Feb 2026 17:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v2 0/2] devlink: support default flag attr
 for param-get and param-set commands
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177152040832.2301686.9442715552350209457.git-patchwork-notify@kernel.org>
Date: Thu, 19 Feb 2026 17:00:08 +0000
References: <20260206-param-defaults-v2-0-1ce78e2c5a31@gmail.com>
In-Reply-To: <20260206-param-defaults-v2-0-1ce78e2c5a31@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: jiri@resnulli.us, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, donald.hunter@gmail.com, dsahern@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[resnulli.us,davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259518-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[dsahern.kernel.org:query timed out];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72F56160DF4
X-Rspamd-Action: no action

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Fri, 06 Feb 2026 13:11:28 -0800 you wrote:
> Add cli support for default param values introduced in the
> accompanying kernel series [1]. Here is some sample usage:
> 
> [1]: https://lore.kernel.org/netdev/20251119025038.651131-1-daniel.zahka@gmail.com/
> 
>  # dump params with defaults
> ./devlink dev param show pci/0000:01:00.0
> pci/0000:01:00.0:
>   name max_macs type generic
>     values:
>       cmode driverinit value 128 default 128
> ...
>   name swp_l4_csum_mode type driver-specific
>     values:
>       cmode permanent value default default default
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v2,1/2] devlink: Pull the value printing logic out of pr_out_param_value()
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=bbe2c8b3229d
  - [iproute2-next,v2,2/2] devlink: support displaying and resetting to default params
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=446dd2c18952

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



