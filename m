Return-Path: <netdev+bounces-292032-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wK64KMJEFmqUkAcAu9opvQ
	(envelope-from <netdev+bounces-292032-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:11:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7B45DE28C
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9B603034B38
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 01:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06243128CA;
	Wed, 27 May 2026 01:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOuimU4/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C0F30E82E;
	Wed, 27 May 2026 01:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779844209; cv=none; b=TEmEKzGOsFqx+Q7QuXNHVA7Mmz32PPM6mkDgv32kibtDiAPO4dda4pbZiFBN03yDifuyWhqAS1rB0NcWGzJ5vO3mNaYJYY63kUhnxqorZILJrHbdVv7LnDe47tc56LxWt2zvUzPGc9NV2Hiapq1nOUcFp9Ru4u36HImwxl38Nl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779844209; c=relaxed/simple;
	bh=PJsXQ7Q+hByx3CYpx0YTuO9WlFP+Os0v58hTxUIM/mA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g+pME/GumhqtyLXwieF2nOloysfcO3t8bCn6T8Is5dA2hu0IsaHEbpIRfvEafiP7fzVUpF0OOg0CehqjOXdRT+p3HnFAoZlh6KjyQuS+AjdL6MYOAyB66sTVOrJE+HSDTL+hS0AJufD7MEMUVCtvwx+J7p/K/oK/t/IRfuLMaLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOuimU4/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBEE1F000E9;
	Wed, 27 May 2026 01:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779844207;
	bh=NDbHHPta2+zBJB3r3+875MWvki4Zbdc1HS67e4km8hI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MOuimU4/2UKKoldOv6bQnJYsjpBgIr5Qh02EYm8rR1vixcUC7RoORXZOLlJmj/lLC
	 eaHnbOtnEeCMDMWYabZZCM51PTisrB4m/PijlxWDgUvM/H7tA5+5Rv43GxJLxYfjdQ
	 t5YPayZx+PJS5311j0jhROR/m5BxJseP/hBZtwB6H9BcjZD3LgEELXbvVVDeQVFb2v
	 lfcdTztCPPR45tC2JjH10Z05J6zljPAMTfH4brijsViIDRmHsgz/u9NUxKez4wvB39
	 oqHlPeFPJXoJ5TRgtHb9khaVlqAtaLGBWGRbO7gpqW2Pa8hcZGDQudpEOf8hNhMSLJ
	 O6Co6fSBnEOMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C67380CEED;
	Wed, 27 May 2026 01:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netconsole: Constify struct
 configfs_item_operations
 and configfs_group_operations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177984421339.4036929.9007988324188560740.git-patchwork-notify@kernel.org>
Date: Wed, 27 May 2026 01:10:13 +0000
References: 
 <7ff56bdb0cee826a56365f930dcdf457b44931df.1779711734.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: 
 <7ff56bdb0cee826a56365f930dcdf457b44931df.1779711734.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: leitao@debian.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 netdev@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292032-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[wanadoo.fr];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0B7B45DE28C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 May 2026 14:23:00 +0200 you wrote:
> 'struct configfs_item_operations' and 'configfs_group_operations' are not
> modified in this driver.
> 
> Constifying these structures moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> [...]

Here is the summary with links:
  - [net-next] netconsole: Constify struct configfs_item_operations and configfs_group_operations
    https://git.kernel.org/netdev/net-next/c/eca539e6619e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



