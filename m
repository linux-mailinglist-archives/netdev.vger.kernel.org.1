Return-Path: <netdev+bounces-253295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id s2KiKYmndmnLTwEAu9opvQ
	(envelope-from <netdev+bounces-253295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 00:30:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B7B83237
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 00:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 56856300107A
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5467830FF2A;
	Sun, 25 Jan 2026 23:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htCrqEsP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3070030E0CC;
	Sun, 25 Jan 2026 23:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769383811; cv=none; b=oFp9gG0QrFWsDzoYuQv3CEdgSCBo/s0g8CwjzL4YOHOELF/zhKAV/tZzdXg7Bm7rKRkOhiuiTvOydrPKVB1IizsftNcDSAcpUIZ5NifYl1gaJIZi7pfp32b6iLcug7AEBJ8xRSvaCfjliMucRq9d4XuxaSks7TxcKyxwbskU+xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769383811; c=relaxed/simple;
	bh=Rj5sC8bf8dIRUDluKMP7VcYwIjcC6Qi5QvUU9BIKa3M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gb4UE+JTU1JxZUXBSiDY23friMs+0FCzjdU8msW1dKN/Rwe4lcYixVl3IifghOKOqDATtnUcZnNVP1CITySgYYMt4uOVHkCp+cWJ+KAZ0pRSuuXDJct/0ocoBlMEv36Z75/97itkifK3pQnqR9jfbq9YPpXFoBMYcwZybsEUOco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htCrqEsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB648C4CEF1;
	Sun, 25 Jan 2026 23:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769383810;
	bh=Rj5sC8bf8dIRUDluKMP7VcYwIjcC6Qi5QvUU9BIKa3M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=htCrqEsPPdpZ/m7/irgOPomhdmzo3BRh0KR0zePnD+eTh93Z/M7G1qxvkkjDTn8zb
	 /5d3mJCKpzvXoluejGFoV2qgi0/0fILnrTZpeT9DLKMKdYtwaipz8XUMtecWpPPwvL
	 BMexrd792SvIlOg2jTm5riSOC1G/UrH7gjwWwmkzv+tZQZcKl7U9FMh54OtuXLzGpi
	 79BHFgzhX3DgUHdy6oFKD5ku7w5XHESSt6m4fO0EK2CZnWOyXHwkKIybA9KwdFvlYN
	 knTWIc7OCD7tHaINVEPJ7skH0lohiqY4Pk5grepDidUhk4DDLCH0VfclYOpFdW9miO
	 uXtKrO6AEq7DA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8B223809A15;
	Sun, 25 Jan 2026 23:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v6] net: dsa: yt921x: Fix MIB overflow wraparound
 routine
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176938380561.4011909.7698131395251407118.git-patchwork-notify@kernel.org>
Date: Sun, 25 Jan 2026 23:30:05 +0000
References: <20260122170512.2713738-1-mmyangfl@gmail.com>
In-Reply-To: <20260122170512.2713738-1-mmyangfl@gmail.com>
To: Yangfl <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, dan.carpenter@linaro.org,
 david.laight.linux@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linaro.org,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-253295-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email]
X-Rspamd-Queue-Id: B0B7B83237
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Jan 2026 01:05:09 +0800 you wrote:
> Reported by the following Smatch static checker warning:
> 
>   drivers/net/dsa/yt921x.c:702 yt921x_read_mib()
>   warn: was expecting a 64 bit value instead of '(~0)'
> 
> Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/netdev/aPsjYKQMzpY0nSXm@stanley.mountain/
> Suggested-by: David Laight <david.laight.linux@gmail.com>
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net,v6] net: dsa: yt921x: Fix MIB overflow wraparound routine
    https://git.kernel.org/netdev/net/c/709bbb015538

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



