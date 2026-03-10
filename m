Return-Path: <netdev+bounces-265847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wL20Cfd8r2kXZwIAu9opvQ
	(envelope-from <netdev+bounces-265847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:07:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B182440A1
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AAB73010DA5
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 02:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3C627CCF2;
	Tue, 10 Mar 2026 02:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urFU0dli"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AB2299923;
	Tue, 10 Mar 2026 02:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773108011; cv=none; b=nlD8VkvQzi6SW9ImmAnFHGHsKdh36wbQPVwxKhBm+TnMAbKdMEgGaBsAB4M4fmm0JZi9SXrCybIMuKYDVIawCtMzyiY/IPxYmA6b1cKR2gHl9tR0wYYoK+Nsan3dHa0zcP1ykMVrfwq/axJm/FRupj5wOI05iyzhgreP0ZoHgPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773108011; c=relaxed/simple;
	bh=CVUfq0oNNmH8kOG8d/k2R/ykQyuI1k6FMGBw8esNogM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W3ZaCZzR5OAP5096+TmLbbRILjFppLs4k52vUtqnl1Q8CU+/ySd9AHjiE6Uwufb/Y1erMPf7Qr4MPjCxGqVKNV6F8SF0JGHOMu7Sms9c3rfh57U8zT24BlfOxMyw++j+T+3Q0H7Nq708x0BvpXYYEWsrQtso/eKsmAT55UghX7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urFU0dli; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED7EC4CEF7;
	Tue, 10 Mar 2026 02:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773108011;
	bh=CVUfq0oNNmH8kOG8d/k2R/ykQyuI1k6FMGBw8esNogM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=urFU0dli280CWEkChJxOD8QlH9xI5wGhVUi1yt6DJCP2venXDD02w6Ed8fXqx2PsK
	 IoL5IJ1dtDQGHz+gsNSyyK/O7fsW/BjvvnA7B7uaOPxlF1eCNp0YihYbnbSzp5J7xA
	 Jb6EJkBAXiX/8PV9kA11mxyrAAM+FuqYJ0kPd+RuG7rxMhlT7OZloxqGzFXBJO1ON+
	 FlJnl0wrcJjBmLdqFAcJZyHd6dippuI6f3/XoSbiw9Lu5BB5Zgg2rQO1MzE84Xvdz9
	 FWSoOJHcVP3R18Vrr/0BfMofm8prFTSC+IzjDoypuJKMbRwFrXICkRkK3g0rLu8O59
	 IysoyDdFUIKjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEA43808200;
	Tue, 10 Mar 2026 02:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: sfp: improve Huawei MA5671a fixup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177310800805.2022132.1612677637131215996.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 02:00:08 +0000
References: <20260306125139.213637-1-noltari@gmail.com>
In-Reply-To: <20260306125139.213637-1-noltari@gmail.com>
To: =?utf-8?q?=C3=81lvaro_Fern=C3=A1ndez_Rojas_=3Cnoltari=40gmail=2Ecom=3E?=@codeaurora.org
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mnhagan88@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 90B182440A1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:-];
	FREEMAIL_CC(0.00)[armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	TAGGED_FROM(0.00)[bounces-265847-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,codeaurora.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.543];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Mar 2026 13:29:55 +0100 you wrote:
> With the current sfp_fixup_ignore_tx_fault() fixup we ignore the TX_FAULT
> signal, but we also need to apply sfp_fixup_ignore_los() in order to be
> able to communicate with the module even if the fiber isn't connected for
> configuration purposes.
> This is needed for all the MA5671a firmwares, excluding the FS modded
> firmware.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: sfp: improve Huawei MA5671a fixup
    https://git.kernel.org/netdev/net/c/87d126852158

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



