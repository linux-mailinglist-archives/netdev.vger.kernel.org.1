Return-Path: <netdev+bounces-273837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJXqC/OAzGkFTgYAu9opvQ
	(envelope-from <netdev+bounces-273837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:20:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF546373C6E
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C32E53037C44
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 02:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D713D2F39B5;
	Wed,  1 Apr 2026 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiVxmNPX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46A930FF08;
	Wed,  1 Apr 2026 02:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775010031; cv=none; b=UsAjfNeZrzeWE+s3YSYfH/Vwlp7cv0dEiiDiK/Ht+88ryHg6n16vJBvCCjUGdQajfnHhro+B5ekGfrLNPSVj6eIKxnlgTybDooJXNunOsa9uBfF0TI7uwkeFCUp44K8FAfD2C3FxJRQSr4UAZHJyfE012pYbWDFooNSepyGprwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775010031; c=relaxed/simple;
	bh=XirIjyxD/EYc2lVjGvvfb05URSnYMYzBqsD6w8hsFfQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RbxfSsJhJ8JFl57QHja8C3mLMqPaVCnwS9laEx3OWs03lyJQwLKp3qUpmgZXfwNEl4RDGoIqVsS+zRPk5JX3qn0y2+jY/4ecku1Ubx3cHBSQM2typlHFaIvPqxNq6ToBhF8KyREoE3e8TwoD2F+buz8ycJpeEGThxMO6Cu4F6Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiVxmNPX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76799C19424;
	Wed,  1 Apr 2026 02:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775010029;
	bh=XirIjyxD/EYc2lVjGvvfb05URSnYMYzBqsD6w8hsFfQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IiVxmNPXuOXmniY9mrXmBiGpHZrR+Bk4h8qatcihW0qB+N0bFTAOKapHPwGvOXEZV
	 zCdprxeGYjo1/Yl8ZP7aU2fBgNRObqtaU/YJHp4dwL2ztANJTDhkzO19C1nSivPM/W
	 j35M+F1P9VZ33+ZejeKjBi5u3rG8lM1aRSxlpzapY54O/DQXXzN0GyohdJeDcunSc1
	 TJQ0h3UbgdNwj1BOIPfCyu46TNC5glWTYNk4owJqtEF+qh7m6C4SI9vAcjGM9BCBMn
	 ngn2DhRes49X+zIvAqmyXQs8J4vs87ZVi0k1rsKovo/eGUIlvww9wMEhzwwSM5ak0p
	 VCADarpTpclpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CD93808203;
	Wed,  1 Apr 2026 02:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: mxl862xx: cancel pending work on probe
 error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177501001253.3035943.18343300945245213084.git-patchwork-notify@kernel.org>
Date: Wed, 01 Apr 2026 02:20:12 +0000
References: 
 <3fd163f5bb88de426ca9847549f94b4296170ef0.1774911025.git.daniel@makrotopia.org>
In-Reply-To: 
 <3fd163f5bb88de426ca9847549f94b4296170ef0.1774911025.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273837-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,makrotopia.org:email]
X-Rspamd-Queue-Id: AF546373C6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Mar 2026 23:52:09 +0100 you wrote:
> Call mxl862xx_host_shutdown() in case dsa_register_switch() returns
> an error, so any still pending crc_err_work get canceled.
> 
> Fixes: a319d0c8c8ce ("net: dsa: mxl862xx: add CRC for MDIO communication")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> Note that this targets net-next despite having a Fixes:-tag because the
> is still only in net-next.
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: mxl862xx: cancel pending work on probe error
    https://git.kernel.org/netdev/net-next/c/e9abf1da0af3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



