Return-Path: <netdev+bounces-279547-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJ0HN5nZ42kHLgEAu9opvQ
	(envelope-from <netdev+bounces-279547-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 21:20:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FE14220C9
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 21:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0468B3019772
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 19:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6688433D4EC;
	Sat, 18 Apr 2026 19:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KR42lGXB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4443833CEA8;
	Sat, 18 Apr 2026 19:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776540045; cv=none; b=P0SdkKxC7EAE5zdR3MIyvtpAhy8GClfBRTQmmkDvk0SWPULFoqVrIiqgAlpox6y/o4PCZVXptZjr4MCJQntD10S2iX9L5UUlshbBjrY3yr3eLwx00u84K1nZwwRPR8aqIcJzhgRqmLVAKhxwpq6VxOpYxtKCI5h3mK9UiMmJPaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776540045; c=relaxed/simple;
	bh=s5SdtgrqQaWGvxyOocfvVTmGIyntRJLtgQ7WiZdv5dA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hZ8Hy5FIECKtE4wnuyUoB5Th0qMhREc0/R9+cfBUMdhluDteNbtC72Ged9pTWdsOiSimV18Z7r2Xg1Z1E+hp3nXKzdREcSOYWalYr18FICH282LWfGZfL3YMpxm9poS0T87/AKkb2LMM1jHym9mE6tEtL0yu+q0APRlEqoKv3Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KR42lGXB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4EAC19424;
	Sat, 18 Apr 2026 19:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776540045;
	bh=s5SdtgrqQaWGvxyOocfvVTmGIyntRJLtgQ7WiZdv5dA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KR42lGXBR2U6rgtVc+mVv2nfkFkQqXVvjj6lIs3eeP7BN6+pjMTpZoG2xmm4O2NxI
	 bCecK9lqwrDGr7x2UDoHNqhVZWziKmWUFuJXl+1wLTnEOr7rhdPErL7ND0EqBssiTE
	 QtUNdnZJJWaJoeVco4whegzjlHJ2SH7rfmdlNrZ9iqKSjTFiE7FjzRgXqC0zC3RDDH
	 uFMJDxFLJTRhtD3tJ6QkRQPMjL0qIdJbHEAes2uoHywvFt0ebdxhFn/XFl+7zVTLhc
	 V3JGnF31gHB4Bp3s+j1Ms6KOyfY0DiYlJxcCAHkLPSPYagoOCLoAK39QOFRqUtHv3i
	 Jq7vDs6YOxTag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA055380CEDD;
	Sat, 18 Apr 2026 19:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net,v3 1/1] net: stmmac: Update default_an_inband before
 passing value to phylink_config
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177654001129.508728.16812510297262829320.git-patchwork-notify@kernel.org>
Date: Sat, 18 Apr 2026 19:20:11 +0000
References: <20260416102609.7953-1-khai.wen.tan@intel.com>
In-Reply-To: <20260416102609.7953-1-khai.wen.tan@intel.com>
To: KhaiWenTan <khai.wen.tan@intel.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 yoong.siang.song@intel.com, hong.aun.looi@intel.com,
 khai.wen.tan@linux.intel.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279547-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,intel.com,linux.intel.com];
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
	TAGGED_RCPT(0.00)[netdev,kernel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B6FE14220C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Apr 2026 18:26:09 +0800 you wrote:
> From: KhaiWenTan <khai.wen.tan@linux.intel.com>
> 
> get_interfaces() will update both the plat->phy_interfaces and
> mdio_bus_data->default_an_inband based on reading a SERDES register. As
> get_interfaces() will be called after default_an_inband had already been
> read, dwmac-intel regressed as a result with incorrect default_an_inband
> value in phylink_config.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/1] net: stmmac: Update default_an_inband before passing value to phylink_config
    https://git.kernel.org/netdev/net/c/8cff9dbe89d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



