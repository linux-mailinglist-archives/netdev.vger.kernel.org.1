Return-Path: <netdev+bounces-251738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPA+AZhDcGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:10:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6329B50412
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 04:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39E634E78E0
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB593563FF;
	Wed, 21 Jan 2026 03:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+Z0oN32"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9973557EE;
	Wed, 21 Jan 2026 03:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768965010; cv=none; b=mPaeMRv5ewV5DTBJ4D4wi+94+0AL1ghJ7GNzbAeBvnMMzc2QAtItI88zD/oGVHrv9tZpturztTiIbnIlYwobDGwsNUuRl20IyQ0C/KqBteWjcQ/VE709nbiG7D5vxpl7E/gyoQb+8sthWhV906stRgEEbICnHuC+LuAI4/dmm/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768965010; c=relaxed/simple;
	bh=SJiPph6K7kfHdOadyKUmMSgjNa3vYudNdwVHfyp0Gpo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f1msOoekPr4ngIIfeNjs8YvGirbseJc21L8Y6GrD8Xfm/UDvhT8GaGCHAeUCSRwhcnYrprHUpcVe1iAeoYf0iM2NnSFgVOPxquXl7S8B9a9k+zT2IxPIEWh7C0zcZmzR46bbNRQmB9RASQbwilZlkgrLobHTpM6N9d6A7W7Spag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+Z0oN32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08BEC16AAE;
	Wed, 21 Jan 2026 03:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768965009;
	bh=SJiPph6K7kfHdOadyKUmMSgjNa3vYudNdwVHfyp0Gpo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q+Z0oN32VOD5W+VRlAzncYLXannKynKkiM7qB7AUN2J8MHHVhlVYGV/jWV8nrqutz
	 dbKiPHlfgbdvDgjgWEZlz4mamnJf6HQJ4STwQdRMdedHRfwWQHpkSgdTW2o0GMAlJ8
	 KAp3VvNFx3e5G8hPI4DEp7rkeo/mMkkQ7FlneV8LkroN3h7OAtLtNS4YyBfb9DoQjq
	 fCYpbvp+VS59fBXxzHKjRTMKTf1YLXfnD/i4daeWhaLjexdeJ/AnLd+vy2ZW+jEJg+
	 DTTsBJaGrRfq1PL3ntFyEVZiiAvYzS2isIx0NwbLeOYRK8Ji8Z4SlkNR5q1nDwui8N
	 eArvaneJQUN3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8B9EA380820D;
	Wed, 21 Jan 2026 03:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net Patch] Octeontx2-pf: Update xdp features
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176896500635.707355.1206740654082331598.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 03:10:06 +0000
References: <20260119100222.2267925-1-hkelam@marvell.com>
In-Reply-To: <20260119100222.2267925-1-hkelam@marvell.com>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 bbhushan2@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, sumang@marvell.com, horms@kernel.org,
 gerhard@engleder-embedded.com, memxor@gmail.com, alardam@gmail.com
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,engleder-embedded.com];
	TAGGED_FROM(0.00)[bounces-251738-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,marvell.com:email]
X-Rspamd-Queue-Id: 6329B50412
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Jan 2026 15:32:22 +0530 you wrote:
> In recent testing, verification of XDP_REDIRECT and zero-copy features
> failed because the driver is not setting the corresponding feature flags.
> 
> Fixes: efabce290151 ("octeontx2-pf: AF_XDP zero copy receive support")
> Fixes: 66c0e13ad236 ("drivers: net: turn on XDP features")
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net] Octeontx2-pf: Update xdp features
    https://git.kernel.org/netdev/net/c/cdf8de9c6bfe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



