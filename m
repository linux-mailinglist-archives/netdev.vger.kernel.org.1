Return-Path: <netdev+bounces-292660-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN5YJZMiGGocdggAu9opvQ
	(envelope-from <netdev+bounces-292660-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:10:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7E35F112C
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7E1033008D60
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891E53C09FC;
	Thu, 28 May 2026 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8kEwjR9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE433612D8;
	Thu, 28 May 2026 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779966606; cv=none; b=t1FLEdWEZ3MZcp+ceXHuvAdrNa5INISxUwks67tLfs1dBBrWMQT4NxZx9oUBxBuBl7Vbcxw/0dljAsk/JusyW/LmfgmEIa3NWJxmRQKyOkSfFnnLGU/yD2hjzsMB12ziNSWPMb31VY8ajJ0wfS9+L7lk8ep1MDkJIcPnHWRJ74Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779966606; c=relaxed/simple;
	bh=4DU0LPN6EiPTGjyaeQ7BdEVhgnoVqInntesKuLz/OMw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LgxKrqmI5L+mgislTMy4slfADeZAcnTWz59udS5KgsDCHG/QmB6eKC1kkm2elqhvsE0JVbeKLjrM5OVvnfQjN+Oy5OLxPcd60WPza7JtChMqyj59hN2kfKWRpIpGlTM0JNE6KmvXiFY6xQVgIQBxdwMqZwzM30oHobY7i797mNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8kEwjR9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E401F000E9;
	Thu, 28 May 2026 11:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779966605;
	bh=IzT5A2fkf9wlb9L+8q2V/0+L4doE0luyZKlV8CQO7iM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=L8kEwjR9qpIZjaGyAz56yyu+OKRsqvJhyaApdIv9Q47kgSs+QZ9cjCfU4WR1ydMqZ
	 uu1wjguGMWOz+JyzjZk5cs5g6TVVGi+1819Ju+A0SdPpO7mOTY9NhofjHYC29AiHsS
	 QQYtXfm/nCFxTln9SN3r0GkRi9Jo5ghhrRmGXNtoh6zy+ajeBIvL+Oc6RK+DdM9LGd
	 eKT/jNfLxfGXf24ky2Icy++W1Xr60lQ9bPEXjCbTILgmNgXzFEWSO7visraRiEgWe3
	 yrLgE9pPC0u5cS/EtRbe8F+xw+naRcEennzKu92p07369zKqUhujyRUTnNYKgq35X7
	 10uwhH0f+t4vg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0D683811957;
	Thu, 28 May 2026 11:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V3 net 0/2] hibmcge: fix RX packet corruption issue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177996660939.876481.8290897040840990462.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 11:10:09 +0000
References: <20260525144525.94884-1-shaojijie@huawei.com>
In-Reply-To: <20260525144525.94884-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 huangdonghua3@h-partners.com, yangshuaisong@h-partners.com,
 shiyongbang@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292660-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2F7E35F112C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 25 May 2026 22:45:23 +0800 you wrote:
> This series fixes an RX packet corruption issue observed when SMMU is
> disabled on the hibmcge driver. The fixes include disabling PCI Relaxed
> Ordering and correcting the order of DMA barrier operations in the RX
> data sync path.
> 
> ---
> ChangeLog:
> v2 -> v3:
>   - Use pci_save_state () to ensure that Relaxed Ordering is disabled after the reset,
>     suggested Paolo.
>   v2: https://lore.kernel.org/all/20260518144253.1568118-2-shaojijie@huawei.com/
> v1 -> v2:
>   - Split original single patch into two independent patches,
>     suggested Jakub
>   - Remove MODULE_VERSION change, pointed out by Jakub
>   v1: https://lore.kernel.org/all/20260512123456.3786635-1-shaojijie@huawei.com/
> 
> [...]

Here is the summary with links:
  - [V3,net,1/2] net: hibmcge: disable Relaxed Ordering to fix RX packet corruption
    https://git.kernel.org/netdev/net/c/463a1271aa26
  - [V3,net,2/2] net: hibmcge: move dma_rmb() after dma_sync_single_for_cpu() in RX path
    https://git.kernel.org/netdev/net/c/b545b6ea1802

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



