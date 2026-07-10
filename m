Return-Path: <netdev+bounces-306489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i+AWGS3CUGqB4gIAu9opvQ
	(envelope-from <netdev+bounces-306489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:58:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F274739539
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:58:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JwzaLJzU;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306489-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306489-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4BC813018DB1
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 09:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165AE3F58F5;
	Fri, 10 Jul 2026 09:40:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E713F58EA;
	Fri, 10 Jul 2026 09:40:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676429; cv=none; b=DH34GxGfPwoDej/E4YPhKKnPEyIrylKl68Ee6DjrRtD+KOkALOigCLHvbZ85EA6dp7Nd6J6LyzhNQDLVqdLRD9AtOR89n0iFJI/xEqCSOz3VDsxGSMsiEFcssAFJgxMeyTN97eTFO1sEy8Na4PVUWOfWqLfE847Mt7YUJIEBx6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676429; c=relaxed/simple;
	bh=oRB0zKlLdf69FDvkbrNdoVMTaaxeJZcz2UccAKKznq0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=slRoyg3RSoah43FdW0A3N+VJP8c0mrFQNrhAjRaw3wkZTwrzZVNA200zyHOgLirzX4dDEtXck0C9ybQUtFSMTsSJRkSph1rh96+JlaSczlTWCBExdiR1JYyrNU7lEl+OCJFPtS87g/22AvmflCap0uC+ZHMLflwgKRDysMe0vJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwzaLJzU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9381F000E9;
	Fri, 10 Jul 2026 09:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783676427;
	bh=nz29ekxFdcJXgQjDUE+cKUTqVZJa2eE0Bzz7YxbbU/c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JwzaLJzU0uUtPconTAa9fcQR+AGQlP2NGGuyfKPeiMFOF3QT7v+dFTUzs4p6D8OuW
	 ZgT2NX8u3PjwP2d32AJUpqrZQehOBnAgcVmh+rwu3dKDAlkvSBelxWiOutnao600G1
	 St+Xg1RQsgvcTAalLyI7dSx/hEHHmEJvsQGuZiYP6VFPF9wYjCADn5vUKjqGRZwjtW
	 UY1mbUauxrfGYiCr7NwltldL94Ja/JsCyXcbgN9jbytUr05YG2ttl6ziAw4G87SkAJ
	 /NTouzRhbdD6jqBYHcJ54gARcu+ODbHQq3TBxixQPfRrWQ/mdznWlcWHBw1yeyQnrY
	 45RpDkCUN7tCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197E23924A75;
	Fri, 10 Jul 2026 09:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: qed: Fix spelling typo in qed_dcbx.c comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178367640589.147449.3997713431627199194.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jul 2026 09:40:05 +0000
References: <20260703143130.3685-1-praveenrajendran2009@gmail.com>
In-Reply-To: <20260703143130.3685-1-praveenrajendran2009@gmail.com>
To: Praveen Rajendran <praveenrajendran2009@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306489-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:praveenrajendran2009@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F274739539

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  3 Jul 2026 20:01:30 +0530 you wrote:
> Correct a minor spelling error inside a comment block of the QLogic
> Core module where "successfully" was misspelled as "successfuly".
> 
> Signed-off-by: Praveen Rajendran <praveenrajendran2009@gmail.com>
> ---
>  drivers/net/ethernet/qlogic/qed/qed_dcbx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - net: qed: Fix spelling typo in qed_dcbx.c comment
    https://git.kernel.org/netdev/net-next/c/832255a6df49

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



