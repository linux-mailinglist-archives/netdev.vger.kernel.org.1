Return-Path: <netdev+bounces-259796-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id G9ZeKUv6mGnPOgMAu9opvQ
	(envelope-from <netdev+bounces-259796-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 01:20:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 299E216B8DC
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 01:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B6A7302E0DE
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 00:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3A228725D;
	Sat, 21 Feb 2026 00:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJ2HDLuj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC66C28688D
	for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 00:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771633200; cv=none; b=GQ2n8Dje/0pX1OJRZV+eHcXbXtb2RVpxznJ8fqYywWaf+6PBw+ORIw4Fq6d+l88refsrvK6pEQm2CS0gShDcXGSJ1u6upravpog54i6MZC3tnYuTQpIn/eYC3ET+pP9LLGNVw5CEOT7w9ggqu2E/8YYTY4RLuTzVv4hYZwS3cOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771633200; c=relaxed/simple;
	bh=5LB5Fsm3VIyayPwHmPRsUuUJbTY830kGvwPT759lZL4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HHH9gE33E/MOW5OaAiB76N+NOPepbqOzkN3L3Y8ww5yQUd84SAiAHel4CyIAokYpuNqzfaGAnjy73ptjk9FVOdgD5tn+5D5VDT+w6kaccE2yjJPzCXj7JtbTZKkl77uAWQ4hwoBak6+QJgodoagk6RiJ1SZfox1mbkHFNuEec50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJ2HDLuj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A86C2BC86;
	Sat, 21 Feb 2026 00:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771633200;
	bh=5LB5Fsm3VIyayPwHmPRsUuUJbTY830kGvwPT759lZL4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cJ2HDLujK/cnXBXKSgSe2Ps0BTeuj+OzlWva1CYsWfDKQYpM5gd+xnzwthAdEkzMU
	 IhuzMp40wCvVQ8Hh1JSrtx52S07nQdzbVLHGiSaq7Gok9f+BJpWIlKzALvc1SOUK29
	 wx4LDUlvFYj6XqTwe6lJlBE7Znz12zdwTVF1PANi6SSd2/D41ymppdmZ0sK42ADlYa
	 1smevqk0hU6dBwkhNU8FoEkedK50Rg+C9+adGjpRjlVCmpYTly4jd/MkOgBfzJ4OlW
	 3O0LzHC5sz3o30HXwMaTHrhm9g+jvUigiq+rX4wDxyjB8KMoeTozILBz3s5m0RyldT
	 lTnz9HRKdYXHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD6B3808200;
	Sat, 21 Feb 2026 00:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: ethernet: xscale: Check for PTP support
 properly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177163320804.955402.12002423347542391820.git-patchwork-notify@kernel.org>
Date: Sat, 21 Feb 2026 00:20:08 +0000
References: <20260219-ixp4xx-fix-ethernet-v3-1-f235ccc3cd46@kernel.org>
In-Reply-To: <20260219-ixp4xx-fix-ethernet-v3-1-f235ccc3cd46@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 vadim.fedorenko@linux.dev, vladimir.oltean@nxp.com, jacob.e.keller@intel.com,
 netdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linux.dev,nxp.com,intel.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-259796-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 299E216B8DC
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Feb 2026 12:38:50 +0100 you wrote:
> In ixp4xx_get_ts_info() ixp46x_ptp_find() is called
> unconditionally despite this feature only existing on
> ixp46x, leading to the following splat from tcpdump:
> 
> root@OpenWrt:~# tcpdump -vv -X -i eth0
> (...)
> Unable to handle kernel NULL pointer dereference at virtual address
>   00000238 when read
> (...)
> Call trace:
>  ptp_clock_index from ixp46x_ptp_find+0x1c/0x38
>  ixp46x_ptp_find from ixp4xx_get_ts_info+0x4c/0x64
>  ixp4xx_get_ts_info from __ethtool_get_ts_info+0x90/0x108
>  __ethtool_get_ts_info from __dev_ethtool+0xa00/0x2648
>  __dev_ethtool from dev_ethtool+0x160/0x234
>  dev_ethtool from dev_ioctl+0x2cc/0x460
>  dev_ioctl from sock_ioctl+0x1ec/0x524
>  sock_ioctl from sys_ioctl+0x51c/0xa94
>  sys_ioctl from ret_fast_syscall+0x0/0x44
>  (...)
> Segmentation fault
> 
> [...]

Here is the summary with links:
  - [net,v3] net: ethernet: xscale: Check for PTP support properly
    https://git.kernel.org/netdev/net/c/594163ea88a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



