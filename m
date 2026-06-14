Return-Path: <netdev+bounces-299116-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bTjZM9cBLmqfoQQAu9opvQ
	(envelope-from <netdev+bounces-299116-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 03:20:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2744D680297
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 03:20:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=W4OhhgHi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299116-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299116-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 613B13019B8E
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 01:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F042A17BEBF;
	Sun, 14 Jun 2026 01:20:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA737260D;
	Sun, 14 Jun 2026 01:20:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781400018; cv=none; b=TBut5j86ga6VGlq2esXl05HP9TauhTdOEtsOnWmI42WQR584abhVeFipDDZ/KfowGzioL4KP1GR79D7EdUQ+XfSO8rCCXYKc501LCOvSPNdIMINiM3RlKcYZqMblSQjjYoC2QHyBp7BAv+HyEGJnfgI640BQvVsrHXCtQzg42ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781400018; c=relaxed/simple;
	bh=/43PzuJMyfuMHg22rUnD2FFTNxHmtQj/Y4MyVJ3F5j8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z5DDjgVfdtFXNGOCFAB0ekuHYMjkl9dcW/Dl4ryqO8kpLZdkUQJDBNy9y5UjNLiH3/wOyURTnaudmUHoPjKyoMwq7Hf3JQw1ioHaTXmG7qPq2ADCF18/vcfwkvXVTZBXjKxu/RtU0FTadrdMluFQ876DkBAo5tu3JsrxT8jd6WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4OhhgHi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0661F000E9;
	Sun, 14 Jun 2026 01:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781400017;
	bh=b3Esgov9arx4w3GANBddYrbSJ4F407eld2P0iy9Jcy0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W4OhhgHiPYqtLhmfz7ZidVPc2JOkWATEUtISntIgoObW0PteP9ZROahEZXfmS3CWw
	 261gO8PhIkke2jllTHrLJNY0fee9yVDLqfs3D1IuAXaXilrfBRA/8CMcX6pL615rt7
	 87pziP/RgPrITWyYKyh8maz87fIPJP8Insj0HEXN3Y6tBsnmL5TQo2GIpR1V2Ecgw3
	 h67DsWziTwuNbU8BBNgVAsQHzU5STnzv5847hiJlDcXpi1e/UxPSG39bVwhNs5Eh6q
	 ELDqSSvdCilpFxZ4XMXU0Qmi1BfvB1lAGADgHc++WEqcKcvdcueCSpdqKn17+qqhiq
	 xrmCYyfIl0fwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09D73A54A32;
	Sun, 14 Jun 2026 01:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V4 net-next 0/6] net: hns3: enhance tc flow offload
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178140001364.1648568.12881701377976301927.git-patchwork-notify@kernel.org>
Date: Sun, 14 Jun 2026 01:20:13 +0000
References: <20260610060618.834987-1-shaojijie@huawei.com>
In-Reply-To: <20260610060618.834987-1-shaojijie@huawei.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299116-lists,netdev=lfdr.de,netdevbpf];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2744D680297

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jun 2026 14:06:12 +0800 you wrote:
> This patchset enhances the tc flow offload support for hns3 driver:
> 
> - Patch 1: Refactor hclge_add_cls_flower() to support more actions
> - Patch 2: Improve unused_tuple parameter setting for separate src/dst configuration
> - Patch 3: Add support for HCLGE_FD_ACTION_SELECT_QUEUE and HCLGE_FD_ACTION_DROP_PACKET actions
> - Patch 4: Add support for FLOW_DISSECTOR_KEY_IP and FLOW_DISSECTOR_KEY_ENC_KEYID dissectors
> - Patch 5: Add debugfs support for dumping FD rules
> - Patch 6: Move FD code to a separate file (hclge_fd.c) for better code organization
> 
> [...]

Here is the summary with links:
  - [V4,net-next,1/6] net: hns3: refactor add_cls_flower to prepare for multiple actions
    https://git.kernel.org/netdev/net-next/c/d7db57e3b42a
  - [V4,net-next,2/6] net: hns3: improve the unused_tuple parameter setting
    https://git.kernel.org/netdev/net-next/c/1ad6f1ff3e96
  - [V4,net-next,3/6] net: hns3: support two more actions for tc flow
    https://git.kernel.org/netdev/net-next/c/e6703605b47e
  - [V4,net-next,4/6] net: hns3: support IP and tunnel VNI dissectors for tc flow
    https://git.kernel.org/netdev/net-next/c/cc2c4dbb00fb
  - [V4,net-next,5/6] net: hns3: debugfs support for dumping fd rules
    https://git.kernel.org/netdev/net-next/c/6c586b3ab8b7
  - [V4,net-next,6/6] net: hns3: move fd code to a separate file
    https://git.kernel.org/netdev/net-next/c/d76612e4aacf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



