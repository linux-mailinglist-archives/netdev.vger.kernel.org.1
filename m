Return-Path: <netdev+bounces-266403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOPDGLG+sGm4mgIAu9opvQ
	(envelope-from <netdev+bounces-266403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 02:00:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E3625A353
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 02:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 684DC3070DD0
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 01:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B551232AADA;
	Wed, 11 Mar 2026 01:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8qV5vjE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AAD293C4E;
	Wed, 11 Mar 2026 01:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773190818; cv=none; b=HHfLVjSfL82yPmh/bpVPa5Q9CzAIyCn2Ne71WN/P6E60uYWw5ESFDqszPC9/HYu6RXJLL86Thk3mZmY+Xgu8igEj+89dbaTVz8xjfi5+jQxB0hGeUN/cVY4s4IGOSxXoIC3TaIYBo1uoXIlyR05qkSXzI2x4TMXIi3sI+VHuzHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773190818; c=relaxed/simple;
	bh=JTYShTSRVxixRl7VlzLv6iFkoQaIKHyr0N2YONJrI8I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V4A96AU3l5DDzRcOLaVBVocjDzGTFVlSrPkUCk/cvhDC5l5xgmEf3thZPApeT7OJuShQGcFbzXx7yWqEWXpSoPkq+DpdqQB8ycPDSsG5SzoEb/HVFQc2RirzxnkBvwoIBkhtQSmuZsyjjbuZFmMrnEBfNs5U2KyTuCsswYHAIsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8qV5vjE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39292C19423;
	Wed, 11 Mar 2026 01:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773190818;
	bh=JTYShTSRVxixRl7VlzLv6iFkoQaIKHyr0N2YONJrI8I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H8qV5vjE/502ucX5EQxZN0HiLHYcCxbfI0E0aaEFmcffXrxhIuEDmtDnyq1Z6U3/s
	 8ZFbYtZhzIH1NU9o0rW8t36SntHH30hcqav5BMA/ouIlC0/tPrs5kBGjNh3bVuGbHX
	 cCyH8y7R37PY/UwmKKG8fgnzviyumfmNyNnrT7M/Lz1CnNsLKX/gjzJOgrOYuGGHKa
	 hIgs330xC06z89GTHzUmu3nYjcVS5uASWU1DWKEz1P4QHgB+6KsifESC5LOQeerTRk
	 ajqpeVqqndjU8TYeSSCtUiBmEcepfHomWKm2eRBqSAFJgxTdfwRaT2OKYclqudugqV
	 xOGX8gjyOzcgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D623808200;
	Wed, 11 Mar 2026 01:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/2] smc-sysctl formatting and missing entries
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177319081454.2986475.15812669905451358310.git-patchwork-notify@kernel.org>
Date: Wed, 11 Mar 2026 01:00:14 +0000
References: <20260309124541.22723-1-sawara04.o@gmail.com>
In-Reply-To: <20260309124541.22723-1-sawara04.o@gmail.com>
To: Kyoji Ogasawara <sawara04.o@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org
X-Rspamd-Queue-Id: E1E3625A353
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266403-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Mar 2026 21:45:38 +0900 you wrote:
> From: Kyoji Ogasawara <sawara04.o@gmail.com>
> 
> Hi,
> 
> this series updates SMC sysctl documentation in two small steps.
> 
> - patch 1 fixes indentation in the smcr_buf_type section
> - patch 2 documents missing sysctl parameters limit_smc_hs and hs_ctrl,
>   including values/defaults and hs_ctrl usage notes
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/2] net/smc: fix indentation in smcr_buf_type section
    https://git.kernel.org/netdev/net-next/c/4a51ac9056c1
  - [v2,net-next,2/2] net/smc: Add documentation for limit_smc_hs and hs_ctrl
    https://git.kernel.org/netdev/net-next/c/aa5ec9d03b9c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



