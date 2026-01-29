Return-Path: <netdev+bounces-254552-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIAGLrHkemn5/AEAu9opvQ
	(envelope-from <netdev+bounces-254552-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 05:40:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CADABB7F
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 05:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 66D2B300440C
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 04:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40D82D193F;
	Thu, 29 Jan 2026 04:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNIQX73V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BE22BF3E2;
	Thu, 29 Jan 2026 04:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769661612; cv=none; b=NlIIVoxQDbtxCfhcahSDDUP3hVTof6aVzRFL/Bm44nNsOI5uqRn79VI/FcwMHhbEn45qpmkV0F3bbn2X4ZIJf08wgx4qFmvuHkvd2+8y7Y9F24Px/+I6PkTMboLlZEc73NXEc3adpNP+lDP7eJ0R0qQW03KflQ+xmmcAPV4ekro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769661612; c=relaxed/simple;
	bh=/bcjNS9+oXzTvU7F2k28K0z+PbtHDmoK+wwOioZkOhQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D6nsKNSD1vkTo/Fg165/wQoKJndME3tH7UZukZvdRdT49Yr38AwlnkCMP80xmN9MfsRqV6uLkme02OiEv4BpX/DgshstRL3Z0jxaLkyk1/kK6TwxZIvscYi5ec1jJ4mcCcLAb9jlBPoFRWerTOUGWC2tJI/Xd7c3kn0z9j/+pv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNIQX73V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC4EC116D0;
	Thu, 29 Jan 2026 04:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769661611;
	bh=/bcjNS9+oXzTvU7F2k28K0z+PbtHDmoK+wwOioZkOhQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SNIQX73VOK/nKnahkTQxfewnetmfCDQBTxAlr96uhSZu6ILFzzgkAFbDGMOP57RrN
	 eQFtwEzOIq16oi8MacStKhTZxhAcggDg8fzb4TxGSqXwrmAGsEPLpP6L+6367WYhSA
	 Sy1avPJYOyhumrxcVai7jKHcbUSVo5ucg/pwQOUuaQUSY9DMp3rQjSVf5wtJe12INj
	 a64oBIvq0PemAoh/QF/npQHKeO0UkQ0Ruv352t8cK48/E7z6BGuAvPsEF1+GsWWIHg
	 2PFC3lTsie+irSASWzvQiuKSDpgc5nw6hd3k9Fa3d3Au0jK4UcE8HrWKjuWQ8O0pkC
	 a46fmOD+02VJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EA5B380AA69;
	Thu, 29 Jan 2026 04:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: micrel: fix clk warning when removing the
 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176966160511.2349661.14928382440812259568.git-patchwork-notify@kernel.org>
Date: Thu, 29 Jan 2026 04:40:05 +0000
References: <20260126081544.983517-1-wei.fang@nxp.com>
In-Reply-To: <20260126081544.983517-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 florian.fainelli@broadcom.com, imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-254552-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C8CADABB7F
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Jan 2026 16:15:44 +0800 you wrote:
> Since the commit 25c6a5ab151f ("net: phy: micrel: Dynamically control
> external clock of KSZ PHY"), the clock of Micrel PHY has been enabled
> by phy_driver::resume() and disabled by phy_driver::suspend(). However,
> devm_clk_get_optional_enabled() is used in kszphy_probe(), so the clock
> will automatically be disabled when the device is unbound from the bus.
> Therefore, this could cause the clock to be disabled twice, resulting
> in clk driver warnings.
> 
> [...]

Here is the summary with links:
  - [net] net: phy: micrel: fix clk warning when removing the driver
    https://git.kernel.org/netdev/net/c/2aa1545ba8d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



