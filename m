Return-Path: <netdev+bounces-283443-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sF7lMyIw9mmdSwIAu9opvQ
	(envelope-from <netdev+bounces-283443-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 19:10:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE584B2F6E
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 19:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5263F3009034
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 17:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D381F35A387;
	Sat,  2 May 2026 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aq+sNesR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B162E1E633C;
	Sat,  2 May 2026 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777741854; cv=none; b=HMqci64CUIZ2ab1bpZI6kEw0YO/IsV4FtF9Bt0L/g/AHX91GrH8d7E70ZJ6g4KFq6Fg+H6EPK6tjhiOpjsV8ckdzufLc1Y9v+qpAi45g5VVpbBE6ImFKRyEctw5dZ9rHH3hQlgUZ8R/+aghpaZJH1oVwwkUG5w6i6w6zcr7ITiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777741854; c=relaxed/simple;
	bh=Q2UAvw0yGNcWrp8SQTns4X1NqSMN/8gpGltWrh/7v/Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XNPSpNAG0eTtvrgczGTjy0DioRGNjtfWLLm2P/mj7NHg4+sfvLtd/jglWbimhP15NntrKpMrbvZGZI0r9WIaJI1BTNTwn9ssS6WLiix1AI3Tu1MxBr9EmYj46+RAM8HwgUd6wxqNgV0GcmTy2H3Xg1ifuJqhSo1AiKbkGXXaWyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aq+sNesR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A4BC19425;
	Sat,  2 May 2026 17:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777741854;
	bh=Q2UAvw0yGNcWrp8SQTns4X1NqSMN/8gpGltWrh/7v/Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aq+sNesR/PyWpq0DW9hDbtyOl+Wdcir74VRXvlN5c4tbpJj4ke82ICc+HTfsntPwd
	 5A7hYXnnrLqGJiQymlxQQFNI/JWSt0R+vTaeexzriHILf0PskZDw8uRwkJwkzsAyUP
	 56lNhVMPfCTJmieMNH18YiLtemWWT2Kd09hf0mnWRJwvYkKv/R/+WYxW6vldwdYND7
	 vFVEV7ZjC5eHrbgAeYZTC4sS0a7uTCR+dIlgYu/lTV96EBxGj9T5hoqW+X5uRFcvKq
	 Roam+zI6wn4pJtk98NjH09pyzECavx/dm9DfMaQLGZUvzEptCy5KUsx/JSxv3fesEm
	 GfuO38GuLkBXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CC0380CEFF;
	Sat,  2 May 2026 17:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: MAINTAINERS: Add self for the DEC LANCE network driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177774180657.3887389.13042106508247378444.git-patchwork-notify@kernel.org>
Date: Sat, 02 May 2026 17:10:06 +0000
References: <alpine.DEB.2.21.2604271113520.28583@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2604271113520.28583@angie.orcam.me.uk>
To: Maciej W. Rozycki <macro@orcam.me.uk>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 4DE584B2F6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-283443-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,orcam.me.uk:email]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Apr 2026 11:23:35 +0100 (BST) you wrote:
> Like with the rest of DECstation and TURBOchannel hardware I have been
> handling the DEC LANCE network driver for some 25 years now anyway.
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> ---
>  MAINTAINERS |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> [...]

Here is the summary with links:
  - MAINTAINERS: Add self for the DEC LANCE network driver
    https://git.kernel.org/netdev/net/c/ddca6da148b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



