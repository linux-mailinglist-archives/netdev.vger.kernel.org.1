Return-Path: <netdev+bounces-273409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFyIHp4Zy2lrDwYAu9opvQ
	(envelope-from <netdev+bounces-273409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:47:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1987362D14
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACA11301C5AB
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92C92741C9;
	Tue, 31 Mar 2026 00:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhhIe0w2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69432690EC
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 00:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774917622; cv=none; b=NS0BcAevFlvBz1vCOB87eImhtwUTH5W2+R3wXZotTC/l/oxckJUx4Gct/XzymfFZIN6tx/wvoQ/rhEzGo8wjETaGblUyUn4llSpj+Bi9m2gJxWJoPJysJp40eHNssXxgywTcXqESHoEoIzUBmbbk/HH34e8eset4uEHHto/JMz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774917622; c=relaxed/simple;
	bh=SnqxddBoXoBmehVOiUBc8GVDbNOokz/IBaub1S9sjsU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R13O46hCLec0V/l4iXCMpUXZRYaE0Mi375nlvC5JORIrr0WDqDrHA1hDDcAnuMbaBAC1ZmiYVkwOU7dMPBg9mflDnpJFyjpbFYJ+MGIF/nN5pq67WDYdyJU/J7nkXAx58FLcWTnBwE6FkdyRSrS5hxgxzJGa0msWJll7OiM865w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhhIe0w2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701DDC4CEF7;
	Tue, 31 Mar 2026 00:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774917622;
	bh=SnqxddBoXoBmehVOiUBc8GVDbNOokz/IBaub1S9sjsU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nhhIe0w26OgsypzfTdlJhEilu4hpMx0S0nXbBfRLf2LmfwzkRH0+yQAcAtRzaYzZz
	 SIwaO8FghCVnLLpInORMwC/5vhKjhO4FpqCfH3nZLXI59hR4RqRM5KtXdsKJVLUuAb
	 P4VPg7MDlJNsh6jUPCwDt9sRt70V2zngYFMHIDqRrCwM/C+j0xf8VYNiB84pV48ZSU
	 CELINMw+jkmVhpwV5C6SYZnLgEkZY6XX71QTTkdpm8Vzm3u+al285rrfl08zF/2A2c
	 9xb0/XdQ6XK8UIYQ00rBBjEoRvw1e1g/2TZVbYCgM85pbXUkKdH9G2D9rydfgZqfTa
	 RHLJ4c0bvjuew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDAA392FF85;
	Tue, 31 Mar 2026 00:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: Add missing cleanup bits in
 airoha_qdma_cleanup_rx_queue()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177491760629.2032642.16020894977460400063.git-patchwork-notify@kernel.org>
Date: Tue, 31 Mar 2026 00:40:06 +0000
References: 
 <20260327-airoha_qdma_cleanup_rx_queue-fix-v1-1-369d6ab1511a@kernel.org>
In-Reply-To: 
 <20260327-airoha_qdma_cleanup_rx_queue-fix-v1-1-369d6ab1511a@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 Madhur.Agrawal@airoha.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273409-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,airoha.com:email]
X-Rspamd-Queue-Id: D1987362D14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Mar 2026 10:48:21 +0100 you wrote:
> In order to properly cleanup hw rx QDMA queues and bring the device to
> the initial state, reset rx DMA queue head/tail index. Moreover, reset
> queued DMA descriptor fields.
> 
> Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> Tested-by: Madhur Agrawal <Madhur.Agrawal@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: Add missing cleanup bits in airoha_qdma_cleanup_rx_queue()
    https://git.kernel.org/netdev/net/c/514aac359987

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



