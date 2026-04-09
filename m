Return-Path: <netdev+bounces-276934-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA1VLs1/12kLPAgAu9opvQ
	(envelope-from <netdev+bounces-276934-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 12:30:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA693C92AB
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 12:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64064300D940
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 10:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0517F3B4EB5;
	Thu,  9 Apr 2026 10:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bu/oHVKK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37D63B2FC4;
	Thu,  9 Apr 2026 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775730632; cv=none; b=uh8eR+ydUOR8zXiDx/D52Nf7w4qx09jFv1k09h2taX4ndl+xLGTh8qqnzqcNvnZb2ggSb6RPhkhHXklOWqjLmWapU8GvTycqZU3+xj5lCZwqwO7bIvMglZoaQv4WXHsATE2mhdiBSbk+Hj8zDE20C8YsZ9mzz21o2kXV1hRAh+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775730632; c=relaxed/simple;
	bh=/+m5cHDh2SgATV0wc4VKWqSJKXseZ7fS0aRcXifm+gY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cyoRQPpnMES5iSLgB8coDRmTXk7xzGdqvXaowtpMRreUokkEpQfar2ovWyZc/8hH27OLB+wogQ/Byj9uuYml7PSFRgPJridON7QS3QV9PkHQI2Lzk4RzPJArGwTln0DtGeavxX4ynuc/9OPOFssQ27k3Bza1BzrXKs0YRv8Je/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bu/oHVKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6624CC4CEF7;
	Thu,  9 Apr 2026 10:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775730632;
	bh=/+m5cHDh2SgATV0wc4VKWqSJKXseZ7fS0aRcXifm+gY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Bu/oHVKK88nx8fAdr8FPznbkKClYGd1N6lXk9Xk2ZJXZfr7EBMuXVXEDpOYBJVzS9
	 cVUPjJaZKqHwzHIZN1v5jtZHCaKxly8vKiPo/J2fnDf2dZ+8Y/YFJBwSU/wdsjvgXQ
	 eXT1jUTyZsZYZnPs8tq/qtue0zRvCCpixMaa5zzJfpld3Op+FeaL1tSD4KDVKxlaT8
	 OYCASdYi5i9qnbBYNHchnTTIdZ2DnUKh+NVWPdUJkLB7yayBqby9altvhlae9pHck8
	 v+xU9rehzGU3Z3mFyF891q8SkmUKAI35KklXAYCDEkWg9s8MKPSG7JVysBD562v0yj
	 ZaIBLaOuYpCRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE6C39307B8;
	Thu,  9 Apr 2026 10:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/2] r8152: Add support for the RTL8157 5Gbit
 USB Ethernet chip
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177573060829.1113011.1073124687073176218.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 10:30:08 +0000
References: <20260404-rtl8157_next-v7-0-039121318f23@birger-koblitz.de>
In-Reply-To: <20260404-rtl8157_next-v7-0-039121318f23@birger-koblitz.de>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 hsu.chih.kai@realtek.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276934-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1FA693C92AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 04 Apr 2026 09:57:41 +0200 you wrote:
> Add support for the RTL8157, which is a 5GBit USB-Ethernet adapter
> chip in the RTL815x family of chips.
> 
> The RTL8157 uses a different frame descriptor format, and different
> SRAM/ADV access methods, plus offers 5GBit/s Ethernet, so support for these
> features is added in addition to chip initialization and configuration.
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/2] r8152: Add support for 5Gbit Link Speeds and EEE
    https://git.kernel.org/netdev/net-next/c/ebe5fd2ed20a
  - [net-next,v7,2/2] r8152: Add support for the RTL8157 hardware
    https://git.kernel.org/netdev/net-next/c/fd3c7d080df5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



