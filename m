Return-Path: <netdev+bounces-302031-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qJcxGnZVPWoM1ggAu9opvQ
	(envelope-from <netdev+bounces-302031-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 18:21:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F04CB6C76C4
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 18:21:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VQij92u3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302031-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302031-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98117303F4D9
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E5E3E9F9D;
	Thu, 25 Jun 2026 16:20:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B13E3E9C0D;
	Thu, 25 Jun 2026 16:20:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782404459; cv=none; b=YWaKILpD6TEd/iA+swy81JyXFXA1h9AJf4g8kGRpMih0xzxn5qaS54Rh8ncV52TDFchhHd7ZCF0I2/FL17AAy+Wa9DDm7rdZyWxFCuaWL3rQSSEGxrNVl+xxXSHML3ml1SWpnoj/iWhNkSzAtyvP18mZBcDaoUrIoQ1+7JlWx1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782404459; c=relaxed/simple;
	bh=PyA4plxj583nZMg8ywn3b/6u1umbzejsqv5xdNWZYyc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ImM18JA6WR0IqY4dmBt9aM9P84Y37kP+kq59WeECKPpZTZkhPQ5i+QCyJ7V20Lz6d9YiO+YzE50qMWqaUuSM2GUWEdViikP2WTwxHmyks7euIz99OMnCkSX+aF3T85CqW99KGYgKp28ptkBBLQvuXrtbukUS5EeV0acvAxiC9NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQij92u3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1F51F000E9;
	Thu, 25 Jun 2026 16:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782404458;
	bh=YnOEdrhE8PbeI5c0ZTwijZlZ0s9gdc7IcvrR/PDp1gw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VQij92u3t6jsWuhCsPSKXS3FIamMztGsI3QFMXwVVReQw7EQXLpQm1evV+nNmgL8z
	 JHny3O01YuVyBZIE+yRUmeaqSBwdDNSEyjYS4kb1t59clEoRA8WN43hSRlDzuIWzJQ
	 IHaxfrRnebK5G9Vfe1M7tFCD6sWWSCI/RPmUO+u8iVqWdSxwVLMJQBSOmxxZwWwo+L
	 RayGTdbmrR489w8YM4lj2H9ZhT4ps6Q7VqVduAV+/nBWMZc238jM79VEwppzc8Uy2m
	 f3EqA/+7h9BGzq8D6goQRPrPK7qmKaLXvz5GvNUNTSXASw7VXrUqGSmCKP9JA9pEtQ
	 xpcnC1NSX3DOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569303AD449A;
	Thu, 25 Jun 2026 16:20:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 net 0/4] net: hns3: fix configuration deadlocks and
 refactor link setup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178240444587.3803792.3747401243392694669.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 16:20:45 +0000
References: <20260624141319.271439-1-shaojijie@huawei.com>
In-Reply-To: <20260624141319.271439-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 huangdonghua3@h-partners.com, yangshuaisong@h-partners.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302031-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:shaojijie@huawei.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:shenjian15@huawei.com,m:liuyonglong@huawei.com,m:chenhao418@huawei.com,m:huangdonghua3@h-partners.com,m:yangshuaisong@h-partners.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F04CB6C76C4

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jun 2026 22:13:15 +0800 you wrote:
> This patch series addresses a sequence of link configuration deadlocks
> and parameter contamination issues in the hns3 network driver, which
> typically occur during hardware resets or driver initialization under
> specific user-configured scenarios.
> 
> The bugs root from asynchronous discrepancies between the MAC state
> machine and cached user requests during sudden hardware resets, leading
> to invalid parameter combos or frozen registers.
> 
> [...]

Here is the summary with links:
  - [V2,net,1/4] net: hns3: unify copper port ksettings configuration path
    https://git.kernel.org/netdev/net/c/d77e98f8b2b3
  - [V2,net,2/4] net: hns3: refactor MAC autoneg and speed configuration
    https://git.kernel.org/netdev/net/c/c01f6e6bdc1c
  - [V2,net,3/4] net: hns3: fix permanent link down deadlock after reset
    https://git.kernel.org/netdev/net/c/c711f6d1cee9
  - [V2,net,4/4] net: hns3: differentiate autoneg default values between copper and fiber
    https://git.kernel.org/netdev/net/c/d9d349c4e8a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



