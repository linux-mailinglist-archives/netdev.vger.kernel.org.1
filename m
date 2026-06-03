Return-Path: <netdev+bounces-294731-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iA8jHTYZIGoOvwAAu9opvQ
	(envelope-from <netdev+bounces-294731-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 14:08:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E21C7637541
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 14:08:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=sAygn+tS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294731-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294731-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5CCA33014777
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 12:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6470346AEEF;
	Wed,  3 Jun 2026 12:08:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FF543DA55;
	Wed,  3 Jun 2026 12:08:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488499; cv=none; b=QTyXDRCSZgAeHeMZuCCzPZRoUBuHO2nZwEhiW9xCU4bSQiKFzhycAkeb9jnntT1S+3q17WsLHK+4rMY5s4tl7+vMX/wJ/XymBXMm/UVdvvKMJAWetfM3enOIa10CeZa7NXiTCEB/97XWG8lHjpRTkYlguLjmtEMgegjUNROtKyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488499; c=relaxed/simple;
	bh=Axd3T5EtTpeKX89cIuDcWt3eJW6gimujwhgPGi3v71o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SW4PZSajIHWAsN7DAve2f5EffKCfU38ohrUx/ReSKg8/8V1C1cYCWF2K70STi4L6/yHesyfYt3V10PV8s7PHHbQdX/db0/EhP4LbTv+cEwgCn+xuxNxkziCdt80kQuqBxAyGHDSwV43rMSdMlXHLjgo6J2+hu9wqLvdIvEnhU5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sAygn+tS; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YLF8GW/tlgmSg5/2vd2tN6DCfDEyCsoNS2uxwmxKnl4=; b=sAygn+tSZYd3n5jXreNuQw1od7
	dU452LsyDZtLSfYYs8CEpMnrKlBhSbS5yXC9BqDZnZY5O1Twev2fEF3oarxa5OWiVAmlZhrirndW4
	WZyO1qQxKrxn5ahDDlK7AfTIw9JnV89w2Mz+veg8kyLuLGXkOchIxOTiPArkIfSRSisg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUkOE-005s7J-3w; Wed, 03 Jun 2026 14:08:06 +0200
Date: Wed, 3 Jun 2026 14:08:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: george.moussalem@outlook.com
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next-next] net: dsa: qca8k: Add support for force mode
 for fixed link topology
Message-ID: <593931bc-abc6-4bc8-8f80-19cc11bf2757@lunn.ch>
References: <20260603-qca8337-force-mode-v1-1-caf7670ffab3@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-qca8337-force-mode-v1-1-caf7670ffab3@outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294731-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:george.moussalem@outlook.com,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:email,lunn.ch:mid,lunn.ch:dkim,lunn.ch:from_mime,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E21C7637541

On Wed, Jun 03, 2026 at 11:57:39AM +0400, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> A fixed link topology is commonly used to connect this switch (on port
> 0 or 6) to a SoC's MAC over SGMII. When inband negotiation is not used,
> the switch needs to be configured to operate in force mode. As such,
> enable support for force mode.
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

