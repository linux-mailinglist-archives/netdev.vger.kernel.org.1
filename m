Return-Path: <netdev+bounces-298423-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rJbdA+5cK2ok8AMAu9opvQ
	(envelope-from <netdev+bounces-298423-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 03:12:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E763A6760F6
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 03:12:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nabladev.com header.s=dkim header.b=XsOzRLD1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298423-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298423-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nabladev.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E48D630118E4
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 01:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849EA30C164;
	Fri, 12 Jun 2026 01:12:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6776267B89;
	Fri, 12 Jun 2026 01:12:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781226726; cv=none; b=bOqjA2Re/Zajyf9GR+8o2X3SvxoBiepxa0kNR9dqZA3qIdJ7PpXBtUpyUfYABtvjgYHZ4uP+2pFWgmZEeKmSusQe+/nqaxObmjy3h2eFJ7VZ2myjQobv+NYxWEzQlRjr+xREUBSAafywQQSCYqsB35amxg+gqcdxXZs+NOjq11k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781226726; c=relaxed/simple;
	bh=0s4x7I06JjDpHHL/AdHXiZ4kzNM1jephCdY2qRIIitc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qhu6MpBRZVoiYbM0tLBiVIlK4zteT1UYFjW3Hrh6ISD36bV7CLmpAZA+yuGWkHqwOB27OEkAx5+RiDvGEzRXczHCJJl2BIfIJAX0QuZt6aRa1qOa+KyRB6IS+lPU9yLmRqFV+VZDwrMd2qhcRz1WS3KIuo+pprHi1GWi8AVsUqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=XsOzRLD1; arc=none smtp.client-ip=178.251.229.89
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BCAE411722C;
	Fri, 12 Jun 2026 03:05:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1781226329;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=p7aILJyBYzvssioO/gJwVHbLCM0FoSbqpMKyKJJ9KK0=;
	b=XsOzRLD11Nw+clXacI4w774mqlkmkGkNXOMdT5jvC2In+rWsLUUiIsfptLbrMljM02vFbq
	GpAUsL1X0lVWcwMgTjJj3+oZm6//G6QGBnD28q+zhFvwRkQ5g2zdajuJZZ7MIhLAdKjCT2
	e1xSjXI1b/hRofsV7bLYrg38t14l03jukpQ5kzsUNekbJ9axC+BoO8dKEmL8PjtLabvSgG
	RSutQds9PzFbqF19I9XCuEbCtVGe7tKoBKbqB6Ep6ezVajwMO3Poy2ybokQCpZY54543dE
	aZzbTa9DliLlgsGDQh2yQ3NCo/vIcgU3e4zKyhMcXYB625I8h3d5mCrkbIIhvw==
Message-ID: <8d9fc953-0c59-4811-8273-016ba98089a3@nabladev.com>
Date: Fri, 12 Jun 2026 03:05:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 0/3] ksz87xx: add support for low-loss cable
 equalizer errata
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
 Nicolai Buchwitz <nb@tipi-net.de>, Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260609-ksz87xx_errata_low_loss_connections-v10-0-9ba4418cf3db@exotec.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260609-ksz87xx_errata_low_loss_connections-v10-0-9ba4418cf3db@exotec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lawson.fidelio@gmail.com,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:marex@denx.de,m:maxime.chevallier@bootlin.com,m:horms@kernel.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:Tristram.Ha@microchip.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nb@tipi-net.de,m:fidelio.lawson@exotec.com,m:lawsonfidelio@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER(0.00)[marex@nabladev.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298423-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[nabladev.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nabladev.com:dkim,nabladev.com:mid,nabladev.com:from_mime,microchip.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E763A6760F6

On 6/9/26 6:19 PM, Fidelio Lawson wrote:

Hello Fidelio,

> This patch implements the KSZ87xx short cable erratum
> described in Microchip document DS80000687C for KSZ87xx switches
> and the following support article:
> 
> Link: https://support.microchip.com/s/article/Solution-for-Using-CAT-5E-or-CAT-6-Short-Cable-with-a-Link-Issue-for-the-KSZ8795-Family

Have you also submitted the ethtool integration already ?
Is there a link to a patch for ethtool to operate these PHY tunables ?

Thank you for your help !

-- 
Best regards,
Marek Vasut

