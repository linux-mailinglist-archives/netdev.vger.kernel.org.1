Return-Path: <netdev+bounces-284413-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBXDKsHx+WmcFQMAu9opvQ
	(envelope-from <netdev+bounces-284413-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:33:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE014CE94E
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7179E3104018
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 13:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDE047D923;
	Tue,  5 May 2026 13:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="KkrvnZmR"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C173624B5;
	Tue,  5 May 2026 13:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987589; cv=none; b=sCPKShGbJXyloF++RozJOoHCpTaIFYj3rr39I1Qvlw9oUtPPytEjvbjlBjVu77pOvbEYad6OjkIhisjfFu5pHtmhPXemdCU3A0qkHlilxDw4iFIkBbXNHusowa7x6nkITB5NJ8D9YoWkZjjrIIk35b7N1My3oZN5tEHPX3+7gHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987589; c=relaxed/simple;
	bh=uN5TfjO/eFcjxzRWfc5OnHO5lC3GPJX1+kzRO2RSyec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvTMx06ndhjirEB4Wyspoz0eFY9lPcFTRm0FUTjPdLvOF61SFkHHkF7ERF4l5hZa//LlRv7eiii/eybCJZ6Uka10gRQLoPSmMO/yeedmPBJLH7UXjQWMi5Zwe5TLZ+Eie1tGhF2FMIC21LrDPwBUX/23LVsDpi1PVo3CLlAtRyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=KkrvnZmR; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4BDA81132B9;
	Tue,  5 May 2026 15:26:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1777987586;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=UQEbJp2AWp6dFe0TXBFnZilQ6TcdKm5OGLk2WA8Az64=;
	b=KkrvnZmRwKdXqondEKs4OF592HhDKL4PfnlcbZmne8KJplqEsNa8HpB1JYAgaLXm42dTA0
	9C7QVsBCxmMGmUHtbK1nISPA0jLa8HBGUNU57Bcth1IRyN7NlMVcsZ0meq2GYs+cWRO032
	PkQJi4Xal1gc2aV1gRyXXs3wzs8mBImalfEODjQiqUAYuJpkN7nDiBGCYUnus8dLYnBuaf
	ZxQ65jQcpiDdySDv65gjYYvKtVY8dPE+EMH2t25EvC8Dq0q8+Q8xlkUzpZ8fKQul6MXEWj
	tIx04ZgpggzxKtjypHn6X20L4ggxaY+3ZvItqpctw46rDuEnaER6jY+uc+XxeA==
Message-ID: <bdcaf457-6ede-4b41-9f63-f29eb50a4c87@nabladev.com>
Date: Tue, 5 May 2026 15:26:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] ksz87xx: add support for low-loss cable equalizer
 errata
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
References: <20260505-ksz87xx_errata_low_loss_connections-v5-0-da4002b21c42@exotec.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260505-ksz87xx_errata_low_loss_connections-v5-0-da4002b21c42@exotec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: EEE014CE94E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284413-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nabladev.com:dkim,nabladev.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 5/5/26 1:42 PM, Fidelio Lawson wrote:
> Hello,
> 
> This patch implements the “Module 3: Equalizer fix for short cables” erratum
> described in Microchip document DS80000687C for KSZ87xx switches.
Thank you for the V5, I only added a few basic trivial nitpicks.

