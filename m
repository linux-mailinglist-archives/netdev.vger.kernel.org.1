Return-Path: <netdev+bounces-268395-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKp6F8K8uGmxigEAu9opvQ
	(envelope-from <netdev+bounces-268395-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 03:30:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EF42A2D39
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 03:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80C153015B6B
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 02:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688FF347BB9;
	Tue, 17 Mar 2026 02:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3sPrDHg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC04734D4E3;
	Tue, 17 Mar 2026 02:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773714617; cv=none; b=CgCxoNAvm3bFvQmmxZqL9p2OC7nkRX1/FO0KGs6tpBoQSZnHg2iQbNHerX6b189xWG3LYUzoialhgjNQWPDW2sI5pmGKD2QOpGBEh6F52lRUMA+VfbC01IvQb2fdTM3cz9+ozXmFFOOS2/+cV4vYDs0ZRdX9z2SqJs3EkJWodfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773714617; c=relaxed/simple;
	bh=FTK3Ck0Vm2mylMVdtNZsM8W3IIsqFHcFgNrL9TyWz9g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i495aqouSzgbC99inXADg+nrc4/Yy4wDyaYVp3kJ5oNBSR/Abm9yMd8IlIFY2q1oNnx7sGlGGrucoz6H3KMtikHyhIDYx8PehlNWeMAHsb6b63hanmM9OX4tOx53LStdL/AXiVpD0QnaHr8/6o168zjJQsg3ibMxlYegjza/8lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3sPrDHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E06C19421;
	Tue, 17 Mar 2026 02:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773714616;
	bh=FTK3Ck0Vm2mylMVdtNZsM8W3IIsqFHcFgNrL9TyWz9g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K3sPrDHg/kgZtjxvnCHbPYXiD08AgRwtIvUhSXtz3ugrQdYc8ncq6hXxf5IGzXBRR
	 RXjqGIrHsxS9BPFXFVArIxaPEF7O7BXLkIPG5oRbYKvwbfGeHx4K5MTnBOH1D5VhjW
	 76f6VgVPNR8FzzekZrH86h2ochJd78Oezr7xsg+tU48/crGBz5zQ1pmqkHU6xyvGVH
	 8AkE1e5lgeIeQxnFFTY7r0psjDNrd0jFhokKZtEWjSq0UaVoPkEForJgmJeBirG4hl
	 7NBOz1nfaf/uSkQF9hHk1XlH/xohCcEEEDeTCAGgROF6wbWjeqtMl3DnCOqpvPyQl7
	 3wdq2ie40cLbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF643808200;
	Tue, 17 Mar 2026 02:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v11] virtio_net: add page_pool support for buffer
 allocation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177371460929.3397946.4827611096206644305.git-patchwork-notify@kernel.org>
Date: Tue, 17 Mar 2026 02:30:09 +0000
References: <20260310183107.2822016-1-vishs@meta.com>
In-Reply-To: <20260310183107.2822016-1-vishs@meta.com>
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dw@davidwei.uk,
 technoboy85@gmail.com, ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268395-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 32EF42A2D39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Mar 2026 11:31:04 -0700 you wrote:
> Use page_pool for RX buffer allocation in mergeable and small buffer
> modes to enable page recycling and avoid repeated page allocator calls.
> skb_mark_for_recycle() enables page reuse in the network stack.
> 
> Big packets mode is unchanged because it uses page->private for linked
> list chaining of multiple pages per buffer, which conflicts with
> page_pool's internal use of page->private.
> 
> [...]

Here is the summary with links:
  - [net-next,v11] virtio_net: add page_pool support for buffer allocation
    https://git.kernel.org/netdev/net-next/c/24fbd3967f3f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



