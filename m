Return-Path: <netdev+bounces-263177-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8K6TJ6rVpmnHWgAAu9opvQ
	(envelope-from <netdev+bounces-263177-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:35:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ABC1EF89D
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 778DA304600D
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 12:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45192DC334;
	Tue,  3 Mar 2026 12:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7yj0iZO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DA2280014;
	Tue,  3 Mar 2026 12:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772540404; cv=none; b=QWKxNLiZjxaoHC/NI9hh/vrHZuyfibIQycGV7eMn5J5y2sXQZF5tIUlT61Dt/9FpylBMcGV5KMCQPilfTXt4YaYrDPNH7gmBd+zDNjQ8hNiw5LM6ITd7wWPj/DeoHqmm01P3GvzfabHZLTmfgtkMrr2VW/7GH0gmmBdVBEVi3cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772540404; c=relaxed/simple;
	bh=X9Yzz90Zpq4mOekZKBYxDmCTFNx6eT1AmoNJbi8Gsuk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Hrosg6CdELpy1tGxFcpU9oByh7CwQLT7BjR6MCViHD7fDWQrxZ0g+6mX0xM8pKFYgAzPbJlRmT+5w63puNiM/QouNjC3U2w/wTbGufCzh60lJtPG+RPhw7uPCYBMupujthKjSQRT9s3VjaemuzvgQ2LpoCfXR4AZAwT5hbxzkrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7yj0iZO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E792C116C6;
	Tue,  3 Mar 2026 12:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772540404;
	bh=X9Yzz90Zpq4mOekZKBYxDmCTFNx6eT1AmoNJbi8Gsuk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H7yj0iZOQ797kKwXo/dJHHA0xZMXbbY7K8x6vFh60ZMwfs3waG61kvXDNAg/BgGfa
	 A5EMWrIVb7Rqd2m4A6wNuYGa1VlTFlgejgIKHBvclOSNpPVDwjeJ3pfDe2zq8ZPPZW
	 J9Jy79xQFp1EAOtbuP21XoyOaoJceWCyZjYHA+7tM2x57zcKeZo6Qf1SwV0oAIfKcM
	 RvaaJynPAAG941eUb5WDR+ccSJJvO9qjWFMp2YEDup8HdvQkL8KUOUsELTwBz4c250
	 iNIuXS7ssTg8eCobSDmst6D1x8sxwaSy6gQ/093qqyJv8Sl+mGmO/J5ffdoWA1CTDf
	 JEOOfgJhnSxRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DB3380A966;
	Tue,  3 Mar 2026 12:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ti: davinci_emac: stop using bus type
 mdio_bus_type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177254040580.847183.9926315246537701399.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 12:20:05 +0000
References: <cc8e83aa-48c3-4497-b6ad-760a7f9e25dc@gmail.com>
In-Reply-To: <cc8e83aa-48c3-4497-b6ad-760a7f9e25dc@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: s-vadapalli@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
 pabeni@redhat.com, edumazet@google.com, kuba@kernel.org, davem@davemloft.net,
 linux-omap@vger.kernel.org, netdev@vger.kernel.org
X-Rspamd-Queue-Id: 09ABC1EF89D
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
	TAGGED_FROM(0.00)[bounces-263177-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 27 Feb 2026 21:52:16 +0100 you wrote:
> This driver is the only user of mdio_bus_type outside phylib.
> Using mdio_bus_type isn't strictly needed here, so use an alternative
> approach. This will allow to make mdio_bus_type private to phylib
> in a follow-up series.
> 
> Compile-tested only.
> 
> [...]

Here is the summary with links:
  - [net-next] net: ti: davinci_emac: stop using bus type mdio_bus_type
    https://git.kernel.org/netdev/net-next/c/e07bd1f7161f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



