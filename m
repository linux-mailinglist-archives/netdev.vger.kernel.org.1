Return-Path: <netdev+bounces-298394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VN/WEwA+K2ry4wMAu9opvQ
	(envelope-from <netdev+bounces-298394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 01:00:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C966675BD4
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 01:00:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gidQOxtY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298394-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298394-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24B26300DF76
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 23:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A191A377EDA;
	Thu, 11 Jun 2026 23:00:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C020B38F653
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 23:00:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781218813; cv=none; b=vGdu736WcBtmXrbHCs1e9NLu0G4Cm4rH7j9YeqI17COmfAif+P5trS4nvNTeCIKXJ2ieTcfw0+HQdLSRRhygz080XQ/yyjPU42XUcN7ye4QzefFSWHy7gTAvXhTDyYGelMt/7aAS8+1ZmJ2mu9X711jo7KrpgnXXNr7fO1OeNhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781218813; c=relaxed/simple;
	bh=9O1YskzpxESLF+ULTwJ6Phzrzx4TH08iVICrP/Sdl64=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Sfks0q3TwIDj+EeOhixEe39Fyg8ojliijs79AkmFWKUvaZc4KmqJDqKBSoA4dXWPo0Q9LYq7DtaRyWnaEt3crE/AzrAyHn76ZfpSYkGJDiuPDt9yRGISMs01w5tcfKlTgua4tOdxZeE6QNu1dAQGuKSVmcFy9ennLBALWOtqtCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gidQOxtY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1CF1F000E9;
	Thu, 11 Jun 2026 23:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781218808;
	bh=ttEuAiFKOLumhkb6P9TcgscWQyI1FaCS4vepa1KuZoM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gidQOxtYYwtjZI3vGZ2oEf5EUwbU8d36/9Vq/EMt1r8y3RPjVBhcN7fDBtY8wSP9o
	 0x0+VpaK2pPTMn9gYEVM4+xJPvhqSHVRdBwGRzT+aH6mdWFRAHdz5emLVueDXCEINk
	 UPTCSZup6savsNXA9GbzBLEchWga4K6RTgYPTJOJ+Eiip5+sbIG2G8PFVh62rrb37U
	 dSQW+TgLmKfJUCFusDSqUaAhXgq1CoxMy8q9elvR1JX1qiJGhnoDApU0X4Z+uy4ETr
	 iGgloiYfDUvdky15QiU4g09ejEGIBR2CvmbMaph2tEn0BlAAewYkgq87g0g+lvXQgx
	 96VdtJcMvyfjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09C03930FB3;
	Thu, 11 Jun 2026 23:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: Stop leased rxq before uninstalling its
 memory
 provider
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178121880538.398116.5613332341830051618.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 23:00:05 +0000
References: <20260609212240.677889-1-daniel@iogearbox.net>
In-Reply-To: <20260609212240.677889-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, razor@blackwall.org, ahmedabdelmoumen05@gmail.com,
 netdev@vger.kernel.org, bobbyeshleman@meta.com, dw@davidwei.uk
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298394-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,blackwall.org,gmail.com,vger.kernel.org,meta.com,davidwei.uk];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:kuba@kernel.org,m:razor@blackwall.org,m:ahmedabdelmoumen05@gmail.com,m:netdev@vger.kernel.org,m:bobbyeshleman@meta.com,m:dw@davidwei.uk,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C966675BD4

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jun 2026 23:22:40 +0200 you wrote:
> netif_rxq_cleanup_unlease() tears down the memory provider that was
> installed on a physical RX queue through a netkit queue lease. It
> currently revokes the provider's DMA mappings before stopping the
> physical queue:
> 
>   __netif_mp_uninstall_rxq(virt_rxq, p);            /* DMA unmap */
>   __netif_mp_close_rxq(phys_rxq->dev, rxq_idx, p);  /* queue stop */
> 
> [...]

Here is the summary with links:
  - [net-next] net: Stop leased rxq before uninstalling its memory provider
    https://git.kernel.org/netdev/net/c/37314c9dbe95

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



