Return-Path: <netdev+bounces-305794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SdPGLmBFTmrgJwIAu9opvQ
	(envelope-from <netdev+bounces-305794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 14:41:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AE806726613
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 14:41:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="WXY/msMd";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305794-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305794-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7937A3002B6D
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 12:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A7844212E;
	Wed,  8 Jul 2026 12:40:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5281E449ECB
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 12:40:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783514443; cv=none; b=jJv/mTnSVHKJTXlUzs1mq00VPsr/62hv3zpYDrE82F3xOoGAIMeF64+o34R0Fd5TqxSpnsFqt9eUbncteUfL4jkRXw7WOEy1itAs2S2DahS8kJKEePgiYuq5rdd0C9WS4YuxPftxzmtF+y61d5blCLEe+St79p1LL4Dn/8aNU2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783514443; c=relaxed/simple;
	bh=Rf0of+Q3tLrD0mzL1fVMuQplssF0gH5DqAqaplySbFg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CAd/kGftzFBi7bO6LYIDBZ7fdFoYv9Gc3kEVEiHuWHjcoo/6YoiVKXc9tvHu1oWEWf0rWCfX9fbN4o3HJxYAn2t/8FAIu74nuEeGC5zyu2lI8n7tn0krQ+cHwq962KQxQX5MvWlaEzQlyQ48EbE1YMYPvkNEsOFLiBrdnDZ9Ino=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXY/msMd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FE71F000E9;
	Wed,  8 Jul 2026 12:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783514441;
	bh=FUo9b+9FoBbsLn3317d+k19kmmeqMysjUpHIoR1cSuk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WXY/msMdkHLLjOnaDNSKaKLkQ7IUtX2XkDYYUj2yMJb3uyfXyfw977x8TaveQVUBC
	 ZnLVed77j3rhhfXFI+3DrdJzxxxnWMDIiOxQZj+AiNfWXLzf+T4ScOcidgYjoAcONz
	 2OoU+yWXizMKvNGQwPcSdKJhazQTv0JTi8jyHXVUkFiCiIsewvujo4+QpTxFeMSKVT
	 qF+V68Y4Tfkx8CPyIyb8nKtt5MbMeHw7vlpqGvuKNaPNH3o8EltfQdRVoN6fX+cigo
	 dBBO+1s+fssVQZWibmvpjA84orDAdjg3Qt3MBoW+t2qelPFejqkkecfnZKFMs28vhw
	 r9vMUa7Jc5H/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56C483927044;
	Wed,  8 Jul 2026 12:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/11][pull request] Intel Wired LAN Driver
 Updates
 2026-07-01 (igc, igb)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178351442114.2482258.15820086308090785003.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jul 2026 12:40:21 +0000
References: <20260701210303.1745310-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260701210303.1745310-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 horms@kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305794-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:horms@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE806726613

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed,  1 Jul 2026 14:02:49 -0700 you wrote:
> Kohei Enju adds ethtool support for get/set hash key on igc and adds
> setting of skb hash type based on values from Rx descriptor on igb.
> 
> Takashi Kozu adds ethtool support for get/set hash key on igb.
> 
> Faizal adds support for forcing link speed via ethtool when
> autonegotiation is disabled on the igc driver.
> 
> [...]

Here is the summary with links:
  - [net-next,01/11] igc: prepare for RSS key get/set support
    https://git.kernel.org/netdev/net-next/c/66731a51b1fb
  - [net-next,02/11] igc: expose RSS key via ethtool get_rxfh
    https://git.kernel.org/netdev/net-next/c/f243be8edeab
  - [net-next,03/11] igc: allow configuring RSS key via ethtool set_rxfh
    https://git.kernel.org/netdev/net-next/c/3fc4c1ee5f84
  - [net-next,04/11] igb: prepare for RSS key get/set support
    https://git.kernel.org/netdev/net-next/c/dfaf57ef99cf
  - [net-next,05/11] igb: expose RSS key via ethtool get_rxfh
    https://git.kernel.org/netdev/net-next/c/1ae67b2b28bc
  - [net-next,06/11] igb: allow configuring RSS key via ethtool set_rxfh
    https://git.kernel.org/netdev/net-next/c/e3c94e9782a7
  - [net-next,07/11] igb: set skb hash type from RSS_TYPE
    https://git.kernel.org/netdev/net-next/c/17cd41a9733d
  - [net-next,08/11] igc: remove unused autoneg_failed field
    https://git.kernel.org/netdev/net-next/c/1ee93ee2e085
  - [net-next,09/11] igc: move autoneg-enabled settings into igc_handle_autoneg_enabled()
    https://git.kernel.org/netdev/net-next/c/c731361cfef9
  - [net-next,10/11] igc: replace goto out with direct returns in igc_config_fc_after_link_up()
    https://git.kernel.org/netdev/net-next/c/fa7315482f58
  - [net-next,11/11] igc: add support for forcing link speed without autonegotiation
    https://git.kernel.org/netdev/net-next/c/acb138b8235c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



