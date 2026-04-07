Return-Path: <netdev+bounces-275836-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEy/Lydq1GletwcAu9opvQ
	(envelope-from <netdev+bounces-275836-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:21:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F98D3A8F9C
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E31A430474D9
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 02:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1917334F46D;
	Tue,  7 Apr 2026 02:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WChUrc0V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98F635893;
	Tue,  7 Apr 2026 02:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775528446; cv=none; b=oSa5hSxl4JvUoH+MD2gUANiGhoQBLGQLVF+pF1iDEKYHMZvIbS2BgG3nE3r10kvQnl1ZdbFErWa04EPeL4l6Q+mJbfNEFoI2VdEm+OSJHkAJzjuit7ke7aoss3xwMm+qiICOKJ6wKqClemS1D0pbk4iUeb9TZ2c60Do+TM2BX90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775528446; c=relaxed/simple;
	bh=05wv7UBxC6F1xpRjeHp3mezC2Pa262FFuui5eUoKY4A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dUfwHTOLy700yfDH+ApXZnNLYfSXe+9gz0kUDaJcYNoIw13a4t6HvTr9fTMIaMKJCjqB7pQd1/hlFq3cHNR/Gyk11k9KNvDIMf59CblsPnvlU1SoPgtyL8AilBku+BK6CornUB5sCXkErHFJx/Ljye9nmY2n89yEqv4F7Z9adcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WChUrc0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB32DC2BCB1;
	Tue,  7 Apr 2026 02:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775528445;
	bh=05wv7UBxC6F1xpRjeHp3mezC2Pa262FFuui5eUoKY4A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WChUrc0V/q1omU30QqKfIe3vj13c0Iv4eVgcD/PRHo1pdD+zhPGNQ4BunXIYAFwEH
	 7KIvUap7g/MMAQMCG+vS7AWbMO0QCCOgFzZrz13sL6GbAvR1gb+3wmA5MksoI2oSn9
	 PfVumZL9bZsNkJ4rT4BSRAGFyyzzorTfQSrynPNXCtSo0Z7n73HcNfwyW9C0rySExX
	 K8CmK+VKzpjDVmyWh9ZHtxQZjHuUHPKJxdV3nrJa7CvJSycOo9Bk7cwNgWMhdQeCqY
	 a6aeUVsCUW959PfaLio5H/VEpqSAzn8BMQebkOhDoWEmlmENfXTbwNzHuKpAtv68h4
	 KmYujJya5LJow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FED03809A28;
	Tue,  7 Apr 2026 02:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/3] [v4,
 net-next] net: ethernet: ti-cpsw:: rename soft_reset() function
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177552842404.3346653.1362966815028978410.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 02:20:24 +0000
References: <20260402184726.3746487-1-arnd@kernel.org>
In-Reply-To: <20260402184726.3746487-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 grygorii.strashko@ti.com, ilias.apalodimas@linaro.org, m-karicheri2@ti.com,
 s-vadapalli@ti.com, rogerq@kernel.org, vladimir.oltean@nxp.com,
 alexander.sverdlin@gmail.com, ioana.ciornei@nxp.com,
 linux-omap@vger.kernel.org, arnd@arndb.de, haokexin@gmail.com,
 daniel.zahka@gmail.com, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,ti.com,linaro.org,nxp.com,gmail.com,arndb.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-275836-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2F98D3A8F9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 Apr 2026 20:46:53 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> While looking at the glob symbols shared between the cpsw drivers,
> I noticed that soft_reset() is the only one that is missing a proper
> namespace prefix, and will pollute the kernel namespace, so rename
> it to be consistent with the other symbols.
> 
> [...]

Here is the summary with links:
  - [1/3,v4,net-next] net: ethernet: ti-cpsw:: rename soft_reset() function
    https://git.kernel.org/netdev/net-next/c/961f3c535608
  - [2/3,v4,net-next] net: ethernet: ti-cpsw: fix linking built-in code to modules
    https://git.kernel.org/netdev/net-next/c/df75bd552a87
  - [3/3,v4,net-next] dpaa2: avoid linking objects into multiple modules
    https://git.kernel.org/netdev/net-next/c/ede3136e5655

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



