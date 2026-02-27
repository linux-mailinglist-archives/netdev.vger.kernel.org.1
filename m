Return-Path: <netdev+bounces-261692-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NzkHRsQoWlDqAQAu9opvQ
	(envelope-from <netdev+bounces-261692-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:31:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AE51B2460
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A59C731172A7
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697D132C932;
	Fri, 27 Feb 2026 03:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q47UTdnp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4639932C93B;
	Fri, 27 Feb 2026 03:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163015; cv=none; b=VmvFWMvXkkKeyiQiN0/J6v4C6qyhP6EQyXb3ds0SoWqPcqCJvJGD8f4ReaAfOLO2s61W/GRsLjm6aMk5EUjrAeFmYBgFTJBCWOJ68ksBeLFFGDEpThZTd4i8kc8wqvVYDTzCWkLNOh3gY1Dt0XXHwZ/ebFnUigLrrd9Y2+M2CIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163015; c=relaxed/simple;
	bh=Brxv5D+zBzlgOfX4ZnsTAzHnPDhRX2jYUb8TJ90+K5c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UuC6JwnwH7zi9Bpr6AqP6VgbEo3h4BuQ4eiMRLk8mVgKO6HjsRkkt9UgsAd/c2xDDg/lyDCv49Rg0ltgQ6uF/PUnJ3t8b2BzYk+Ce79/G3ADPWNZOd8X0byt8kFUKprWs2r8xi7G2LBPsmpJt42UhIrYHoVua1Dt/gcsTb9rfT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q47UTdnp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29A5C19423;
	Fri, 27 Feb 2026 03:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772163014;
	bh=Brxv5D+zBzlgOfX4ZnsTAzHnPDhRX2jYUb8TJ90+K5c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q47UTdnpZspyOD8a50Q4EiJymLognyRTK3p3egopN9ixidtB6Hy2KXXxC0G6Z+zl+
	 ZCDvoEDmv4TxbbiVArIVxjXekM32/0KBRsHwvwyn89Ufyb3cZZ7cddpiv1OLiVQfPI
	 Ywh+s+zelhmVskBOxmJ12c9+6IiWUdCpjti7TVWdHHsBU+ZyJG8AxzlNnw3BGlAK3n
	 bFwu1HPjW68nYB6hFnGT4dCfIp5JkdrKOjurb6Q4Pfa+yjQhww92/X8oVlnwqPDnW2
	 dOpZ+6OZRIJ7G3PjbBQ5G5Kdw1NCYlAlsSGBAE6Ti9syMc8GGoUGP2btURS859TJp1
	 I00UKLzm7GsKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD99393109B;
	Fri, 27 Feb 2026 03:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH net-next] net: airoha: fix typo in function name
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177216301879.1958105.4711894519325320873.git-patchwork-notify@kernel.org>
Date: Fri, 27 Feb 2026 03:30:18 +0000
References: <tencent_E4FD5D6BC0131E617D848896F5F9FCED6E0A@qq.com>
In-Reply-To: <tencent_E4FD5D6BC0131E617D848896F5F9FCED6E0A@qq.com>
To: Zhengping Zhang <aquapinn@qq.com>
Cc: lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, zhengping.zhang@airoha.com,
 upstream@airoha.com, horms@kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261692-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,lists.infradead.org,vger.kernel.org,gmail.com,collabora.com,airoha.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[qq.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qq.com:email]
X-Rspamd-Queue-Id: C8AE51B2460
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Feb 2026 10:37:08 +0800 you wrote:
> Corrected the typo in the function name from
>  `airhoa_is_lan_gdm_port` to `airoha_is_lan_gdm_port`. This change ensures
>  consistency in the API naming convention.
> 
> Signed-off-by: Zhengping Zhang <aquapinn@qq.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> [...]

Here is the summary with links:
  - [RESEND,net-next] net: airoha: fix typo in function name
    https://git.kernel.org/netdev/net-next/c/aebf15e8eb09

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



