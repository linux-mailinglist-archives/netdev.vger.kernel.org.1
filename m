Return-Path: <netdev+bounces-294999-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 85fTGJrRIGqv8AAAu9opvQ
	(envelope-from <netdev+bounces-294999-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 03:15:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE4863C2AF
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 03:15:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Yep+42oM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294999-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294999-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F38F304CB39
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 01:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8966E25B08F;
	Thu,  4 Jun 2026 01:14:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84982242D6C;
	Thu,  4 Jun 2026 01:14:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780535689; cv=none; b=L19uDOV3U5mCUdX5OoGjFT25RvKDzn5FOZy3u0jnyHbM1UKIrnHptjaAqfbPxW4gf47deGLsB6/NDcWlnyielr8y5cKzwADHx+wGPTK8N3/Y98AbOrQTM2qdrnu1xVrf1eFvj3omLOvyaCCG2YtF8+m2WxVrOAswF1IDsSY46sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780535689; c=relaxed/simple;
	bh=+RsHSChrt7fAoPrSeFLJwdweQMJFNvYEosMeS/yiqbU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YOdEu6Q/Mxahb91xblPLQnNRmpQmv67eX62Qrvz+TjoLUyAlcAmd4IV7Nuw/Z5A3hkWX/UOpI+CT6vnMzjnQckORW5XGBF1SxxaBIU727PL5Xw10GGNi/2QkelE8i1zY08EVUREP65PZ3XIeiX4cQ/eO7KAagOKJ0tUHEagoDV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yep+42oM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8301F00893;
	Thu,  4 Jun 2026 01:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780535688;
	bh=5nDD29ZjP7G2ov3LluBu1BoVCHK5EY8UQ9Amp1R2jpo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Yep+42oMlfvlKPKqVy6KsJbcaRKUyCkV5qIwogvWiho1keIMfFgf96PlGGRYIdPxc
	 E2C+Nvw5GwpXbUjNly3IB1Mp5JsK2IbCRqbXm+MsM/JBw/6Wlx6Oo/PX3dOdSwcD4r
	 NMlhapwyPodvfetO+nhP6IWWDVgJbgQ/PlnKibFpn+uPCVWcG6Uu4vujJ8nyN5kNIl
	 QMZmx6GILWmNAv4ZHGE3HYFW7y2Nm89lOzPP8EkGMLZ+iBhrTQ9nHxVbfLo4CfIbWn
	 BCc8jq+BjhmijDalC5fCVaoI8s4mYbLqcaXWR67HBMiDe8lfEdiqLzF1+z880WRZ+1
	 NSd8DkwluGmnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A4B39308DD;
	Thu,  4 Jun 2026 01:14:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: b44: use ethtool_puts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178053568939.2042071.9546147349629821109.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 01:14:49 +0000
References: <20260531000334.388351-1-rosenp@gmail.com>
In-Reply-To: <20260531000334.388351-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294999-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:netdev@vger.kernel.org,m:michael.chan@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EAE4863C2AF

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 30 May 2026 17:03:34 -0700 you wrote:
> There's a subtle error with the memcpy here, where b44_gstrings should
> not be dereferenced. Dereferening causes the following error with W=1:
> 
> In file included from drivers/net/ethernet/broadcom/b44.c:17:
> In file included from ./include/linux/module.h:18:
> In file included from ./include/linux/kmod.h:9:
> In file included from ./include/linux/umh.h:4:
> In file included from ./include/linux/gfp.h:7:
> In file included from ./include/linux/mmzone.h:8:
> In file included from ./include/linux/spinlock.h:56:
> In file included from ./include/linux/preempt.h:79:
> In file included from ./arch/powerpc/include/asm/preempt.h:5:
> In file included from ./include/asm-generic/preempt.h:5:
> In file included from ./include/linux/thread_info.h:23:
> In file included from ./arch/powerpc/include/asm/current.h:13:
> In file included from ./arch/powerpc/include/asm/paca.h:16:
> In file included from ./include/linux/string.h:386:
> ./include/linux/fortify-string.h:578:4: error: call to
> '__read_overflow2_field' declared with 'warning' attribute: detected read
> beyond size of field (2nd parameter); maybe use>
>   578 |                        __read_overflow2_field(q_size_field, size);
>       |                         ^
> 
> [...]

Here is the summary with links:
  - net: b44: use ethtool_puts
    https://git.kernel.org/netdev/net-next/c/a87533a80831

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



