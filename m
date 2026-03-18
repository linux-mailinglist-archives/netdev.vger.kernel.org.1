Return-Path: <netdev+bounces-268861-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJu6B/kZumm1RgIAu9opvQ
	(envelope-from <netdev+bounces-268861-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 04:20:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D6E2B572B
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 04:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C8173026A87
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 03:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A610233439F;
	Wed, 18 Mar 2026 03:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZErRmz9o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDFF33343B;
	Wed, 18 Mar 2026 03:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773804022; cv=none; b=H4N6v2AEE/bOfDsiwuZwIwmP77cvTCAJssGlN20y6tBizwRtlyeOGnVftaAXs6p++YbttlnBdXwuKiEC23lnJVmdZDiqSbAXBjSo7Qeik2yUa3uxXSxjj6nJ8kusD4nGI6MFMeWwRt2w6mKzLvU/TOyfWiREeVQbKoCcdehhfaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773804022; c=relaxed/simple;
	bh=KdIR50igbptkAD6q8WTViMPPAuJJluLl0TZGJGizjxg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ipNICaTVyLiqu2lksXhUnN+ya86/8CNHMwrXUsYO/rWP2O26fv0/Nxtj6y0w4HTnHuyvLKGFWB48ifIXLliGCx8QUkMLW5gw5wqDOd7JWTlxSFL0aiuViDS/XzySzQVuB8rn+Rsg3NALy6w6qPz5MyJ4qnhcYzEnS09MYbfy/gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZErRmz9o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B838C2BC86;
	Wed, 18 Mar 2026 03:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773804022;
	bh=KdIR50igbptkAD6q8WTViMPPAuJJluLl0TZGJGizjxg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZErRmz9oP7cNXXN/1YyrG9+pUfe+JSTptjhXP1qKvEL7qD3AGNpt45c3SXlVG/Rv/
	 vAKTT4hDejJdKWLzCPtThmst6dXs/FcVtc5iXXTrqrypUOOYXr7m5sr50d2oTH08Aq
	 s2u4/M++Dd9Pkik4PGEfhOHGyZif41ZkRl2o59tT8BLBrOQrnyrbG0LEo13vm+0Im1
	 bUTr93SS+0DMeQUa8pXP0nIIA/0cXJR+7W9qpHxuDFQlPM+0uEGwexBc1QlTCtITgn
	 kSw9VvAg42CjpZeQwiXvqoKwdW0pe03kViPKsxcB8rVsA97im8IYSQyxrO/2clEXfX
	 otHYlQdEcjfUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0A03808200;
	Wed, 18 Mar 2026 03:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] ptp: vmw: Convert to a platform driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177380401428.109214.13001276771153710383.git-patchwork-notify@kernel.org>
Date: Wed, 18 Mar 2026 03:20:14 +0000
References: <12883468.O9o76ZdvQC@rafael.j.wysocki>
In-Reply-To: <12883468.O9o76ZdvQC@rafael.j.wysocki>
To: Rafael J. Wysocki <rafael@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, richardcochran@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-268861-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email]
X-Rspamd-Queue-Id: E8D6E2B572B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 14 Mar 2026 12:43:33 +0100 you wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> In all cases in which a struct acpi_driver is used for binding a driver
> to an ACPI device object, a corresponding platform device is created by
> the ACPI core and that device is regarded as a proper representation of
> underlying hardware.  Accordingly, a struct platform_driver should be
> used by driver code to bind to that device.  There are multiple reasons
> why drivers should not bind directly to ACPI device objects [1].
> 
> [...]

Here is the summary with links:
  - [v1] ptp: vmw: Convert to a platform driver
    https://git.kernel.org/netdev/net-next/c/6829f90906aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



