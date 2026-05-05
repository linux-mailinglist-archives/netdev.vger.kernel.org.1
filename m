Return-Path: <netdev+bounces-284180-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLKJNy9Z+Wk68AIAu9opvQ
	(envelope-from <netdev+bounces-284180-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:42:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BB84C60D9
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 303AF30432C9
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 02:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7D33A169F;
	Tue,  5 May 2026 02:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cU/GhPcL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBCE3A3E80
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 02:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777948870; cv=none; b=IPAJ00TdEtQ5DlSBntkZypm84trN4Fpnp+F0V7RjFzLbpy5DRai668KAq7QZiUJioTeqNnZkqNUZPlCJxM84t2O9N4ay/gz7jF029CRbLSwoQARQeSeg+06FVnP5JO7XvC7sREcCqoQrRFkMcXY5mg3BmZiIYxRsUcLEH/zEehk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777948870; c=relaxed/simple;
	bh=cz9PCzZLbGqRc2okSEJXwOQyt7dx65kZ5KjOSudA1Jk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gvsCh2ZWKZpQjvNwcqGU3LAkzeTbSDUmAIoPXrx4aqL50Vbew6mCYyAlcKV5lWVrOScq1+WCvG7IprDqlZTAanhMFmoSDKth1TJuUoCI9aGhGHjiyF66ybreqXFNuLqG6ESDEdl106/eQNitQJlJXDxqGYiYIlDuxpG/eM4Ud2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cU/GhPcL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6A5C2BCC4;
	Tue,  5 May 2026 02:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777948870;
	bh=cz9PCzZLbGqRc2okSEJXwOQyt7dx65kZ5KjOSudA1Jk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cU/GhPcLoOamlka9r0DQet3iRt8gZ2zjfr+DAQcwSdM6y2VkMIX5H2zjx1a4TJYVc
	 7vq2t+OFrD/+inDWqWn2COiXLLa6SzGymBBQe+q/Zkj55C2LRHkGaVSe5ufnNPW044
	 m6y7gVs9zb2UOTph6bL+t/3HF8vfx0jqwqUGCbSnQFY3Cj3ZS/dvsOm5X312KroaTT
	 fMH0i7KdUf++XpERCNAjtdl3AIZ6dig5q6kV8dVVrBWgOBNiaZm5xPLsXPKbnu4Amb
	 OtH2KyKUr2e3/UcATnuIyigbBwL+0RhQ0iOAvz1WWa48ApFevmvnmFMIosFejVaAnP
	 jlbE1Q9WLe1yA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE7739301A2;
	Tue,  5 May 2026 02:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: airoha: Introduce
 airoha_fe_get()/airoha_qdma_get() register read helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177794882129.1397274.6642429130537078994.git-patchwork-notify@kernel.org>
Date: Tue, 05 May 2026 02:40:21 +0000
References: 
 <20260501-airoha_fe_get-airoha_qdma_get-v3-1-126c6f647ccb@kernel.org>
In-Reply-To: 
 <20260501-airoha_fe_get-airoha_qdma_get-v3-1-126c6f647ccb@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
X-Rspamd-Queue-Id: 77BB84C60D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-284180-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 01 May 2026 09:49:11 +0200 you wrote:
> Add airoha_fe_get() and airoha_qdma_get() as utility routines for reading
> a masked field from a specified register.
> This is a non-functional refactor, no logical changes are introduced to
> the existing codebase.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: airoha: Introduce airoha_fe_get()/airoha_qdma_get() register read helpers
    https://git.kernel.org/netdev/net-next/c/98e490930de3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



