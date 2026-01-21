Return-Path: <netdev+bounces-251719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPPsNGI9cGmgXAAAu9opvQ
	(envelope-from <netdev+bounces-251719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:43:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 710E04FF8A
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 75FADA2F5ED
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D1634B425;
	Wed, 21 Jan 2026 02:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AttnSJRZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ED434216B;
	Wed, 21 Jan 2026 02:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963224; cv=none; b=i2GJH0nsd4mhIE9+LhzzlGPX2LNw3Vqa0544chySMN4ddPCmJCK31DvVySaOLaqjCeFC+/tcJSt2W2ZNpcs4MFI1OMYbNJK4jmBw6wVhkwnB9cPvVsJmZE8eGarp+wLfQYExM2Wcc3JfuXHVQLYWka+3ci0dmA7tPBuMyz1pOr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963224; c=relaxed/simple;
	bh=WIqdDmxn6eIWjsCyVObWnnu2UaDoxNR+3w9tBmNYpCI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SGHCmnj0Uhl2TKXk9Qw6BHZR4Zim9ancAg8oTI8JGuqmcI9ChyeqIIiyNo1OXWZ+Ym0lTI8JSSoHj9ChAPXCbjbnigBbC+773PWsDB0DfBDi2MkPd2aXrPB8hCglL4fcqGy3zVb3U5hwSiUtE97ChpOh9uK/WGlnRCA2GR714o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AttnSJRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD84C16AAE;
	Wed, 21 Jan 2026 02:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768963224;
	bh=WIqdDmxn6eIWjsCyVObWnnu2UaDoxNR+3w9tBmNYpCI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AttnSJRZoMIo/VoftPUGPoqsh9MNiKfjUk72SJzHnuMMovRjZZY3JgurhmSKtRqlf
	 HoAQqCWjxc8xhG1QOVZpg8kj9e+mo+038M4WYoRQ58XBA1rx6uMuv2jp6FsKaz4Gsz
	 ehVeXO1Kj/aA2CXnchZ8+WXk7oY+rlakqoo2cFlQ5naiITQed/z53Vz8PItdbit4nF
	 v9L5gpjSbYxMbC+rj6N5ycbc6aq9OBPAIucwRV8JLm6KvDrE9KhVmlqWEDCRiJKfav
	 qxWG2aL3t/Zf5uYi5d3yXFrvqrmS1j4utAYbQHFx5v13scU29tx0+m0Tx+kUEoJwH4
	 Xgdd+vOuhbocg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11CB4380820D;
	Wed, 21 Jan 2026 02:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] fix some bugs in the flow director of HNS3 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176896322184.699622.7016339450452839446.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 02:40:21 +0000
References: <20260119132840.410513-1-shaojijie@huawei.com>
In-Reply-To: <20260119132840.410513-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 lantao5@huawei.com, huangdonghua3@h-partners.com,
 yangshuaisong@h-partners.com, jonathan.cameron@huawei.com,
 salil.mehta@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_FROM(0.00)[bounces-251719-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 710E04FF8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Jan 2026 21:28:38 +0800 you wrote:
> This patchset fixes two bugs in the flow director:
> 1. Incorrect definition of HCLGE_FD_AD_COUNTER_NUM_M
> 2. Incorrect assignment of HCLGE_FD_AD_NXT_KEY
> 
> Jijie Shao (2):
>   net: hns3: fix wrong GENMASK() for HCLGE_FD_AD_COUNTER_NUM_M
>   net: hns3: fix the HCLGE_FD_AD_NXT_KEY error setting issue
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: hns3: fix wrong GENMASK() for HCLGE_FD_AD_COUNTER_NUM_M
    https://git.kernel.org/netdev/net/c/d57c67c956a1
  - [net,2/2] net: hns3: fix the HCLGE_FD_AD_NXT_KEY error setting issue
    https://git.kernel.org/netdev/net/c/f87e034d16e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



