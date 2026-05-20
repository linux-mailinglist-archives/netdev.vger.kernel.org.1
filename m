Return-Path: <netdev+bounces-289983-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNJlIPrSDWpP3gUAu9opvQ
	(envelope-from <netdev+bounces-289983-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:27:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D302F590D25
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 17:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A0AE30AF144
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 15:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA683FBEDA;
	Wed, 20 May 2026 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="GInqunYF"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47343351C3D;
	Wed, 20 May 2026 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289712; cv=none; b=uNymhj23IGioVp/dHWldCYOIvmtVVqgQDFwfHvD1FdTA0ntlsuQvilgi5d/j+HarFFIdGLS5KteeHdT09W3nc/5vRRww+D/VgvpFKfG5irNzme73iSgdReZuZpHqK3Hsb4NrJFYXOhyD27q9ydaqL6B8EQAflhvRm0kuWhMVbyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289712; c=relaxed/simple;
	bh=FN49JQ/90Rm3OBnfY5y2M53FCIUUiZNT9CeGOKOAhkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KEi2YuGiq4MGmtagrhr5aUByeg5fMHy7fnF8c5VOIkR11fKXy5Sg4vOAEMqpQLMpfMPOWdZeXedUyTHj09fzP1zrpZfEXh8ZVxrzApbz1KsfUTVvo2I5pnfIN/2p+XpWCyjOc5IhdCF4SMcXpjKkGgVrXzXVrMr0GwD6p2OXjbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=GInqunYF; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 31D04115786;
	Wed, 20 May 2026 17:08:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1779289704;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=tK9xzBMZUQfFxGGr0FVRb83qyvbMCEUNrkUqA8QZSQI=;
	b=GInqunYFc3VqqY7ZMp7ojj7PnQlKclEZBTmy8qH/BcsLGbTtf2Ss0tz1f3J9775G3T0Ffi
	kDfAGE+pc5oWtVHggao60XYSpcM+y5fPAEI2/qo7OxwgeyeByWAI1493R0lDawTPM9aIY+
	JlmHVhfvEWXzl7FUwY/MuB25cOQCrBG+1Hr5GQSCBIeCVBH8CttYw7oWzAvJzmqlWTzx24
	wut4kl3JynKlJuMQf4UrXBM+16fxwXYUFWVl4x9OYv78sihETmaFgZcpgB+9zs/IPVcQXR
	7Lz7v3k28xEBV+GRaFTT1UaGxfUyX4ZkNgE856/2ULzqCQaKwJvim4Q1qW+1Rg==
Message-ID: <26199882-dfcd-4ed4-b657-d640f4ea7cc3@nabladev.com>
Date: Wed, 20 May 2026 14:00:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] net: phy: micrel: expose KSZ87xx low-loss cable
 tunables
To: Fidelio Lawson <lawson.fidelio@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Marek Vasut <marex@denx.de>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Tristram Ha <Tristram.Ha@microchip.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260520-ksz87xx_errata_low_loss_connections-v6-0-43f33d4aaf0f@exotec.com>
 <20260520-ksz87xx_errata_low_loss_connections-v6-3-43f33d4aaf0f@exotec.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260520-ksz87xx_errata_low_loss_connections-v6-3-43f33d4aaf0f@exotec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289983-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D302F590D25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/20/26 10:48 AM, Fidelio Lawson wrote:
> Add support for the KSZ87xx low-loss cable PHY tunables in the Micrel
> PHY driver by implementing get_tunable and set_tunable callbacks.
> 
> These callbacks expose vendor-specific PHY tunables used to control the
> KSZ87xx embedded PHY receiver behavior when operating with short or
> low-loss Ethernet cables. The tunables provide:
> 
> - a boolean short-cable preset applying known good settings;
> - an integer LPF bandwidth control;
> - an integer DSP EQ initial value control.
> 
> The Micrel PHY driver forwards these tunables via standard phy_read() /
> phy_write() operations, which are virtualized by the KSZ8 DSA driver and
> translated into the appropriate indirect switch register accesses.
> 
> Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
Reviewed-by: Marek Vasut <marex@nabladev.com>

