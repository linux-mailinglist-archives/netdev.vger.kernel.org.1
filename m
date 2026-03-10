Return-Path: <netdev+bounces-265875-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLilOZiJr2lvaAIAu9opvQ
	(envelope-from <netdev+bounces-265875-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:01:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6037E2448D5
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA38F30FA378
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A593A357A3F;
	Tue, 10 Mar 2026 03:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3yv+jr5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837CA18AE3
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 03:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773111638; cv=none; b=Wc5pUR/F/tLFPvnzyHWZxH1L6H3QtZD6GycJZv2+vdxkWGrizVPNXjAB0v32Ksl5IGWIRZCjepKUPAzYV61pmDtPxgI16sWUfV28Fx/dYttOfoOPWGhTFB3Fs85Z8PEh58Fx8FBz1jklylK/NVpjiOjZ/JxBXI2VSMicaQVbO+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773111638; c=relaxed/simple;
	bh=0Cds6kc09BVIRVjCoSPKhdBQsuXH0Iml0FDgoBrHwWw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VljbtKMX43F9BePoPTSka1+0rlHaD6MmtFfLuteT7DsxYPJp3TPYKasmPAWSG6neyNhr6oH+2/xiDrnw4DH1sQh3gZ/0CE+CemRyoBwtPLaW6lTuaBsyvr1GxaY+1XLWoNGnExPz2l887AdL5aBpxqFXWQUTQgVBPIhQ/fX/9NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3yv+jr5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD9EC19423;
	Tue, 10 Mar 2026 03:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773111638;
	bh=0Cds6kc09BVIRVjCoSPKhdBQsuXH0Iml0FDgoBrHwWw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n3yv+jr5PBzgHxFh9U6Z63J3WEC7wrixS11Co244TfLFocCf8sEUkmggqFyrqfJRX
	 VsBFMEhcx6eENrMKibiJvD0WRBFqfmwEjqWxCzLmFr3QOAzQ0Mj/AeU+vDtyrIY16U
	 t57l01dwH7nE+gDijjkg9s+unb+f3/rx6h06n3g4PWhyhkJ3x2xvFKzDyg5PvSjmQt
	 7G4+BqeFJ6FeULNDTFr8tD5ZOfTTLGh6mR9gLujLk8y/ULYPMT+KAlIgu+JM+LsuME
	 E+8sT21I6ynzFJYdkeMWo2EIBq5QHZOjVsGldaJ+5SGaa8rDCkhqQ3bp08dh7UwjIc
	 68XAcBzf+7tOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEDD3808200;
	Tue, 10 Mar 2026 03:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: stmmac: further ptp cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177311163503.2039470.12160246560923313829.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 03:00:35 +0000
References: <aawDiK7DjcSXSs1X@shell.armlinux.org.uk>
In-Reply-To: <aawDiK7DjcSXSs1X@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 pabeni@redhat.com
X-Rspamd-Queue-Id: 6037E2448D5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265875-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 7 Mar 2026 10:52:56 +0000 you wrote:
> Hi,
> 
> A couple of extra PTP cleanup patches.
> 
> The first uses a local variable when setting n_ext_ts which is a minor
> simplification of the code. The second removes the now unnecessary
> "available" flag for the PPS outputs.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: stmmac: ptp: rearrange n_ext_ts initialisation
    https://git.kernel.org/netdev/net-next/c/b560d4434f98
  - [net-next,2/2] net: stmmac: ptp: remove redundant priv->pps[].available
    https://git.kernel.org/netdev/net-next/c/687e7863f027

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



