Return-Path: <netdev+bounces-251731-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPr9NHg/cGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251731-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:52:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 730B6500BE
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4542076BC7C
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C163559ED;
	Wed, 21 Jan 2026 02:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6/fi3wT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0228C3559E7
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 02:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963809; cv=none; b=kcADopb6H+xzrT1dzsdl7EW/vd0JFrxhZbg1tzfvUqtnNJ/OqIVriMD6DlyGOA015jjJ51yPS2UlIXOT7cly59KOnOdWyqk0BXtlWa4hYxU1aeKVksqOivNwb2/8q9domFjcIZVlP9ypXhUVawXAhVhdxXFsTk8LUPjvOP4rG80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963809; c=relaxed/simple;
	bh=ZEBg/lA/mNZPS3ekcf/CD9650i3SBDw0lW9HjhSQT+k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aB3rho/1/sElVU90M1EEGeUqsZaUqC2CPS8Yc417sCM96agMzCRN13rMM5zY/foDPrTYHGkGVJ0ekBn1RqfelHIYgAp7Up2uobk6UyQkfvrI+W5f2QmluwTpIWTyXIEVJzLDlH4jsRwlZWo5ERJTehR6f6DZQ1J82DvT30j84qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6/fi3wT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D09CC16AAE;
	Wed, 21 Jan 2026 02:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768963808;
	bh=ZEBg/lA/mNZPS3ekcf/CD9650i3SBDw0lW9HjhSQT+k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H6/fi3wTvCgCA9lRarpVxqTHNGEW+NzA2ymIGv3XcyJYLVsbJKNcS1luQ36pxnE10
	 CT2ZGiscrVIgFssQV6/IFW8TFeBF5C+tRBsjILjq59LbZElF38Zvra2Ej9yPA1KyPN
	 CwBiiSD6FTO6vYgSQM93+HoyJ0GpNwsVV1vWg5Ae/jYoNLESLTJdsQrieTDnZB2WIL
	 k5Y9AhSJk+YrUWAVyX6a1IvpCkTQq9rQMr99lCpMtoN7hNNo+GTmK41AMtTPIDeQhZ
	 jEWjqAZg35BjuwKX2Qk+YEPvJeeCnmMgodGX1UGwq9n3hVGeRaOU2vkOWyoZ17txAo
	 uENBanJqgjUvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11C36380820D;
	Wed, 21 Jan 2026 02:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mISDN: annotate data-race around dev->work
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176896380585.703462.3776381750776785744.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 02:50:05 +0000
References: <20260118132528.2349573-1-edumazet@google.com>
In-Reply-To: <20260118132528.2349573-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,googlegroups.com];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251731-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 730B6500BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 18 Jan 2026 13:25:28 +0000 you wrote:
> dev->work can re read locklessly in mISDN_read()
> and mISDN_poll(). Add READ_ONCE()/WRITE_ONCE() annotations.
> 
> BUG: KCSAN: data-race in mISDN_ioctl / mISDN_read
> 
> write to 0xffff88812d848280 of 4 bytes by task 10864 on cpu 1:
>   misdn_add_timer drivers/isdn/mISDN/timerdev.c:175 [inline]
>   mISDN_ioctl+0x2fb/0x550 drivers/isdn/mISDN/timerdev.c:233
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:597 [inline]
>   __se_sys_ioctl+0xce/0x140 fs/ioctl.c:583
>   __x64_sys_ioctl+0x43/0x50 fs/ioctl.c:583
>   x64_sys_call+0x14b0/0x3000 arch/x86/include/generated/asm/syscalls_64.h:17
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xd8/0x2c0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [net] mISDN: annotate data-race around dev->work
    https://git.kernel.org/netdev/net/c/8175dbf174d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



