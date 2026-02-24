Return-Path: <netdev+bounces-260505-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJfoIB+cnWnwQgQAu9opvQ
	(envelope-from <netdev+bounces-260505-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:39:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0415187135
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D43D30F57D2
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEBC395DBC;
	Tue, 24 Feb 2026 12:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OswL/s3w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB0E1FBEA8;
	Tue, 24 Feb 2026 12:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771936547; cv=none; b=K2u/mpqIExYDK3vwLo2XT6HaWllYsFPeB3tGsM+FelBA2GxZiM0yd1WfZFLW4w/Pbzm4yo6z3ilYDYV2xlKgmHLzXcDU7LEYeyI98KQatYqq3JlmMzk4vZ8peM/oaHVs9o3F8OJ01mvNwoi26Hj+klS3DhC4xjtdQZQ5cvQDbQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771936547; c=relaxed/simple;
	bh=c7/H9rFvsxPz0vis2VI7fGdOgOYNdN9dYKj6xkjxw+4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FDDig7fZAOhrrSdyMzn1Lke+JljYkkluxjg+4JqYWVqvPAWgFKobpZDvu0GRmmh333e5pYaWWJy6lWzzVqZk79r+FFTS9kyaOiSghhmrEJFOFFpht32M1R0KO1/hulnRvonCpJcsVDJQEzr3JfpKk2tMglSsuRmangy0yp2PXfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OswL/s3w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551CBC116D0;
	Tue, 24 Feb 2026 12:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771936547;
	bh=c7/H9rFvsxPz0vis2VI7fGdOgOYNdN9dYKj6xkjxw+4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OswL/s3wb1SvqH8SLPFW8C3PLWvyQLn+yTCeEPAAjHzeQ5pnQVFToTah8NEUj0tMU
	 FJ3n0SOz4Wul49YCKJYb8rspL7y4gE58bdhlfLLTcCLTd4/zvUOkVKXStkQvHeWQcz
	 Ze0HQlvx0FpJAI0utJI7bJZxx0dzwT5epaZiolJs+zCNR+TGIAY1Vu1hTtnUvm0fKz
	 zZnfdUFQrF4JV3SE7kH5UiRzmJfNYw2U9DjbSyPtETzQ3K7UG5snUd2vTF+c+/rOAY
	 OC8OLqO2a8bsFIPjABx/Adaibc6CQfifK3/x84VD+bpVHuH+G23lAHbTx3umx1M5Lt
	 tN4G29UE0An+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD4A3808200;
	Tue, 24 Feb 2026 12:35:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: Update AMD XGBE driver maintainers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177193655303.3521813.18379535924489505255.git-patchwork-notify@kernel.org>
Date: Tue, 24 Feb 2026 12:35:53 +0000
References: <20260223074020.1987884-1-Shyam-sundar.S-k@amd.com>
In-Reply-To: <20260223074020.1987884-1-Shyam-sundar.S-k@amd.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: Raju.Rangoju@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-260505-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: E0415187135
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 23 Feb 2026 13:10:20 +0530 you wrote:
> Due to additional responsibilities, Shyam Sundar S K will no longer be
> supporting the AMD XGBE driver. Maintenance will be handled by
> Raju Rangoju going forward.
> 
> Cc: Raju Rangoju <Raju.Rangoju@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> 
> [...]

Here is the summary with links:
  - MAINTAINERS: Update AMD XGBE driver maintainers
    https://git.kernel.org/netdev/net/c/fb73d0e19f12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



