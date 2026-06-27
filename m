Return-Path: <netdev+bounces-302369-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5fVVAd5TQGpIewkAu9opvQ
	(envelope-from <netdev+bounces-302369-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 00:51:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AFF6D2C74
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 00:51:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ICJ2pavM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302369-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302369-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1EF21300620B
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 22:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B731135B62C;
	Sat, 27 Jun 2026 22:50:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B26537DE8D
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 22:50:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782600652; cv=none; b=dDXHOQm967NvqJcuaOME7nQ4HnWR66pasUrzTgelKwR6QXBLtINZeZesVoC/FwFJ1oZVPrVZbt+JrlGjyjwyHACw3bncyx8IJAOSg+gI/SOFaIQGgJrZHmVd2w//WPJv8RpZBthWZLmysvCHw564G+F6Kabxat2sEYmc6NkI/fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782600652; c=relaxed/simple;
	bh=52WZHKffL/Td1hvw29mynhk4Ti+HY/RzHTOskX6w3/A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nte49XWhLBmQrnG9V9LaAnIlX/LWZp4XqyqxqQly7EDz5Ssb1fWIinaAOLWatUI+S6smRUotUXYV7toyAomYP7jfFD/Vr5M91pYNs7r4a1KwxY7LZt/mIFr7apHrO7O0lMqnBKrPOiiqmFjRQptkmlqCorNL/dSCzMFmph35Eng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICJ2pavM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501881F000E9;
	Sat, 27 Jun 2026 22:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782600651;
	bh=WUBEoH15RqIo4oFjBLLuDYUfLC4Rqnn2RSE89hLfxZc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ICJ2pavMSOSnqjG0tMQMLjrvwApy9T1MWm1vKfispbXS/6zXo1O2uzFS0Ugdm1T7M
	 j7ie0vtRfWX09Xq+e4B6fYE929MksJZ6/JMPFyjepVLZJnjG/cCc8dwu2LvA1+Io2A
	 Igyl6symkXW6vGiMiBDRYYkQF8qye/9TBzIygVCGCmlFCcSBWOnwxt6V/DDMuTGVp3
	 hdnhqP8dUJBtPe97jSsi50nOyMYD2csRMs3STAecLEZi0XSHym9QbrZGoPTgPIYh38
	 Zm8mJL6ZtKiMoty26gRKkUqBEPU5aex4/dfPRNO0KhXEuYOrrrVmVYj6ycClvkUClX
	 4k8Nu2efuw5BA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5686D3938452;
	Sat, 27 Jun 2026 22:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: dma map xmit frags with
 skb_frag_dma_map()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178260063683.1451849.7063958705946574115.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jun 2026 22:50:36 +0000
References: 
 <20260625-airoha-eth-skb_frag_dma_map-v1-1-31d9e460aae6@kernel.org>
In-Reply-To: 
 <20260625-airoha-eth-skb_frag_dma_map-v1-1-31d9e460aae6@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302369-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35AFF6D2C74

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Jun 2026 11:42:46 +0200 you wrote:
> Map xmit skb fragments using skb_frag_dma_map() instead of
> dma_map_single(skb_frag_address()). skb_frag_address() relies on
> page_address() to obtain a kernel virtual address, which is not
> guaranteed to work for all page types (e.g. highmem pages or
> user-pinned pages from MSG_ZEROCOPY).
> skb_frag_dma_map() maps the fragment directly via its struct page and
> offset through dma_map_page(), avoiding the need for a kernel virtual
> address entirely.
> Introduce an enum airoha_dma_map_type to track how each queue entry was
> mapped (single vs page), so that the matching unmap function is called
> on completion and in error paths.
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: dma map xmit frags with skb_frag_dma_map()
    https://git.kernel.org/netdev/net/c/32f1c2bbb26a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



