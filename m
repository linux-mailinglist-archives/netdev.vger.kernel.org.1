Return-Path: <netdev+bounces-290152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBhzDodODmrL9gUAu9opvQ
	(envelope-from <netdev+bounces-290152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:15:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9567C59D36E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D85EE30B7E99
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22942249EB;
	Thu, 21 May 2026 00:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMw9/o2+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097A438D;
	Thu, 21 May 2026 00:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779321970; cv=none; b=M5groZlQhkl0CZO+tH7QPOKsjd2BytqHWU3CB0dDLL91/N0EHPBGap8sKPQb3RMEYWcF/Zs/d332YUixi2v8tMjlUdlx8nEb4AVDK8rNSfIPAV/Gv3cr1uc3lFYvK2rLr4ebRbBhiGirYPsRXO9du1RtY7ZpLsQO5nbnXjBbKP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779321970; c=relaxed/simple;
	bh=Bz6HQN+YnL+3G6x/SWASZhgdc8pTy6T+qPR2i9MWnhY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sf65ENr1XT5YYLNXbz1JViAQ4qeX8mI9bZtxeDwOJ0onUAt1XK6gu0kZ5XIxMlMf5PJBKPIYTUQQSCkU6pZmtYe0um1scQbFZ38gajMn+UJOZ98VzfAVMwCeC1Zgk9X4lofsw2DO2HIaLjCaWaL/3O3GiznGNRfkhPSYlt77PD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMw9/o2+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4692D1F000E9;
	Thu, 21 May 2026 00:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779321968;
	bh=IhBbc2t3QtWWS2RMtZIB+B6K0XKriGp6138zyHQilF0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aMw9/o2+2Cp/KurBT9LBJBMshVjIEfxEctfWDzh0M6n0hmNHm7Dvy7da193GmGe5n
	 n4DdI0Sm7N6tEu49cyBF/RaZD7x9oMXiZa3pYeTgr8gtILUACkfb1IJZjWFlvmzHmM
	 /PlhT/rlud7HyEJqaaO14IjgtE7C0Pp5ByMoMfA+s3SofoxmR3mYjvP9AVK5Tv1h8Z
	 5LFLlodsGQS8AYMLEJY9Nch6JucAnDlqFr4anagswHpVQhWyDq2NUgfqCCzTMaV6Dw
	 Y7MFFHo1zu23TIVsNhsOf8YiemyiZf5wSFLBgmeHPW31xEH2jfn+UWOdbs84He/JF2
	 THthG0bJETI1Q==
Date: Wed, 20 May 2026 17:06:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Joe Perches <joe@perches.com>,
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net] net: fec_mpc52xx: Fix resource size format
Message-ID: <20260520170607.27cdf572@kernel.org>
In-Reply-To: <20260518044047.1002235-1-rosenp@gmail.com>
References: <20260518044047.1002235-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290152-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9567C59D36E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 17 May 2026 21:40:47 -0700 Rosen Penev wrote:
> resource_size() is printed after casting to unsigned long,

This portion is confusing and irrelevant, you're touching the second
arg.

> but sizeof() returns size_t.
> 
> Use %zx for the sizeof() value so the format string matches the
> argument type so that 64-bit builds compile.
 
Not on 64-bit x86 builds apparently. Please provide more details
on which platform and compiler you see a warning and the warning.

> Assisted-by: Codex:GPT-5.5
> Fixes: 31b7720c8259 ("fec: Convert printks to netdev_<level>")

Not a fix.

> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/freescale/fec_mpc52xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_mpc52xx.c b/drivers/net/ethernet/freescale/fec_mpc52xx.c
> index 556f646073af..a770e7edb1dc 100644
> --- a/drivers/net/ethernet/freescale/fec_mpc52xx.c
> +++ b/drivers/net/ethernet/freescale/fec_mpc52xx.c
> @@ -834,7 +834,7 @@ static int mpc52xx_fec_probe(struct platform_device *op)
>  		goto err_netdev;
>  	}
>  	if (resource_size(&mem) < sizeof(struct mpc52xx_fec)) {
> -		pr_err("invalid resource size (%lx < %x), check mpc52xx_devices.c\n",
> +		pr_err("invalid resource size (%lx < %zx), check mpc52xx_devices.c\n",
>  		       (unsigned long)resource_size(&mem),
>  		       sizeof(struct mpc52xx_fec));
>  		rv = -EINVAL;


