Return-Path: <netdev+bounces-267770-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMz8A9GKtWkS1wAAu9opvQ
	(envelope-from <netdev+bounces-267770-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:20:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B2728DDD0
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5CA5E3008D03
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FBD225416;
	Sat, 14 Mar 2026 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNWTYKYK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52EF3B2BA;
	Sat, 14 Mar 2026 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773505227; cv=none; b=bfig+dO6mSDv4yRvc3RxTrOAtJMcxCw3TVeL4Cd+93Gb4VCYBbNIpV+m8VCroSHP/DIbzW4OWLJeKi/Twn0K/1l0ngOUMqODVAztdUbRgFYitE9TP/VupGVlUOhCLvUDU+K+dP84qXdPQX40qImt/QVjQA3GrWIn1hgQToGn7Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773505227; c=relaxed/simple;
	bh=BSdXDCCk8ELvcQzcfmVKL0N+wRZFKhwL/V7gS3g5Bq4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CkgQEFf4SrNUqOX/BvPUb11PbL8/mnBHr2r6AFduhjGFRIjNUoKkNqFkhITclIXF+gzov8OninMfJqITqYNkFJ48gDWCWmbegy6MbNQGMz6w4lwpkz9bYbE+iyKBRa2+Vc0w+Mrc2fcfpxvOLNXmT3v0MZmi53tkbvg99hrCQj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNWTYKYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510E5C116C6;
	Sat, 14 Mar 2026 16:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773505227;
	bh=BSdXDCCk8ELvcQzcfmVKL0N+wRZFKhwL/V7gS3g5Bq4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bNWTYKYKpwE1Vof1nE3D3Y+B7lDRol1N502sGBf54guGDyXR0/DKI/jCe4quSgS0P
	 jAWlGJuLDU9evU2NqyjQPjT+B3lC1Ba5zyXMqcjUSTccN8kcdjNkE/l6xLw3kOHHeq
	 AmUY5LsaGCoLLT0kmUa8zpD0JDM5ljmkgbQN78RmuFdd7GTN/0BHKl+9LFdGi3ivwG
	 0od8beX4lq7sykLL92WyBDoISykg9WPlelguBUhrWbbyt4+6jIqFMOS4D2lzo1nrhU
	 t7F/htK93xogHIh0WRMtDp4IGnG/Kj2GUL/bp5dRDcnRuMYzcneQOX6+EvDzc+6D0B
	 97NtbUKm1NPFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0663808200;
	Sat, 14 Mar 2026 16:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: enetc: remove stray semicolon
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177350522128.1725156.14815410959667583831.git-patchwork-notify@kernel.org>
Date: Sat, 14 Mar 2026 16:20:21 +0000
References: <20260313112454.427191-1-wei.fang@nxp.com>
In-Reply-To: <20260313112454.427191-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267770-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 16B2728DDD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Mar 2026 19:24:54 +0800 you wrote:
> Remove stray semicolon from ntmp_table_name().
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/ntmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: enetc: remove stray semicolon
    https://git.kernel.org/netdev/net-next/c/f4ce4922df8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



