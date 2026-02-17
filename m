Return-Path: <netdev+bounces-259017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cI8PD61alGmUDAIAu9opvQ
	(envelope-from <netdev+bounces-259017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 13:10:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9981814BCB5
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 13:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82C2E300BC89
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 12:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271263382DE;
	Tue, 17 Feb 2026 12:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/0F7BHH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036C83382DB;
	Tue, 17 Feb 2026 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771330217; cv=none; b=MBlMIL2v7b6X2+LuQz5jLbBTOz+3HOTUQHbSSNIzIdVSbeGG/O3zv6/dK0Tbwz3eFGSxEXm+coOA880HP1kKr/OJwke19FR20IT949B0ETPqyBqO378H6+H40KYptMtWKv6CnmtlqkJW3TUftgz7H4JiVxGiD3dxXSED1D/vNJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771330217; c=relaxed/simple;
	bh=ERGO6JuhEZyB1huL9C5sTkyyh23fq2fWJssM/6FjXts=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rS1bdUKGbg5hi+sInZROS23iP6MMzRcZEihbsqo/kaOr/klc15AIOv9ORU6D0uvTR6ZX0gDN/s99wqy+VDxGVpMwO+Q2DmGbr5Fl56PuKtDKx1VdecdLxDY4mMXfNURx5BnBBlaPWExyhl7zc/GWVZ10XQdkMtoV/xt3O2gBEL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/0F7BHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E727C4CEF7;
	Tue, 17 Feb 2026 12:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771330216;
	bh=ERGO6JuhEZyB1huL9C5sTkyyh23fq2fWJssM/6FjXts=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p/0F7BHHN7yTs9+MaStCTKqeI8GS/hIlU5FmJsOA+/1/W2MZC2BNInBmqWrqZGCKX
	 d7k5YzDfSsrrHbe7/3Z5LqO9XthHB1IbHYPXZkU3X95aGdRgnDMMCxY/efikO16A/l
	 TOb9nzgQmSr8qrF6prg4gpT8e+ReX4E/gafBcAkkhT++1TnNVobGskvcL0REau+6wp
	 fX475eyUDcfzcQFAsJ9YjoHBX0BObuSN56SdrEpS+RKhoZDr7Jaxa2g41ppGAsoo/V
	 Js+UxOMaOUfFIYc5l8r8pZCvO08J6fVf4ENuUpJKUTNmBeMCiQeylX04fKJoDccIqC
	 lDnG8vHmMBDYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C2273380AAD0;
	Tue, 17 Feb 2026 12:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] printk: add CONFIG_PRINTK dependency for netconsole
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177133020858.47903.4844168446254101967.git-patchwork-notify@kernel.org>
Date: Tue, 17 Feb 2026 12:10:08 +0000
References: <20260213074431.1729627-1-arnd@kernel.org>
In-Reply-To: <20260213074431.1729627-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, pmladek@suse.com,
 john.ogness@linutronix.de, leitao@debian.org, arnd@arndb.de,
 antonio@openvpn.net, sd@queasysnail.net, ebiggers@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-259017-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9981814BCB5
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 13 Feb 2026 08:44:00 +0100 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The 'select PRINTK_EXECUTION_CTX' line now causes a harmless warning
> when NETCONSOLE_DYNAMIC is enabled but PRINTK is not:
> 
> WARNING: unmet direct dependencies detected for PRINTK_EXECUTION_CTX
>   Depends on [n]: PRINTK [=n]
>   Selected by [y]:
>   - NETCONSOLE_DYNAMIC [=y] && NETDEVICES [=y] && NET_CORE [=y] && NETCONSOLE [=y] && SYSFS [=y] && CONFIGFS_FS [=y] && (NETCONSOLE [=y]!=y [=y] || CONFIGFS_FS [=y]!=m [=m])
> 
> [...]

Here is the summary with links:
  - printk: add CONFIG_PRINTK dependency for netconsole
    https://git.kernel.org/netdev/net/c/636fd32d4015

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



