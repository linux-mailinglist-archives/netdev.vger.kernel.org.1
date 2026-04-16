Return-Path: <netdev+bounces-279077-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKx+MGX74GlloAAAu9opvQ
	(envelope-from <netdev+bounces-279077-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 17:08:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5990141041D
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 17:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0E47307C744
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 15:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1E73BD64D;
	Thu, 16 Apr 2026 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="UjoO77VF"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D46390C90;
	Thu, 16 Apr 2026 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776351962; cv=none; b=oYyxGTdmRQpUL+iENhY075f+mBTJIVNsqLCJQndtwiAXZSLSUjitT10dv6HHRuHeteZ+JDbr9wfCWC5NIpNuKHXSngNo31FfIgQEQiAO8Rtvw0l/XY8ozFs6wMmFVYdS3VVanmVyugO8f5sRMv11TiLX3Xtz5vZEURQnXCXMZVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776351962; c=relaxed/simple;
	bh=RYjBsaCX5FGRMbHo2IU+rN/Vf34PxfelZn5maBghzhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ILKuvvYD4jYs6qdndTwtptoCmuZ3ePlRK1FI8WsQ3SYWSc9+IKowDMdoxY6zNghd3cbeCR+1FExroc+QqHYIgCL7+OmzOVjZAP6mvMUMiOpEOa+y9lBqu6Jn19h/2OZ7LFt+H9VlsL2Um54kUFOmBCQJhWnqC8o1v40ENy6ukA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=UjoO77VF; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1C318112C78;
	Thu, 16 Apr 2026 17:05:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776351957;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=YLtivqoKoPv08JBjkQ13scRaWTkbK1xbtNELG4btNs8=;
	b=UjoO77VF0Z0XwLHzPsMx4AsQSRsEJwdWuNep1KvB37f0l3lKmiRvxHWpspKCx6gV/wcl1B
	POZIp2OMm0G/G9hBn7wP+Ze48cBEwrtnUkgE4UiHFX+c+QTspDN6W5DMBYPFDwv9+CCjhB
	QaOw/xQDUFYRGpjvBbHImt5VGzOeVRCpt2hIuzPNw7X9WzRrOfohElREWYNxmCv9A4QVXd
	pt1u4HfrHyt0TyHssD5TmebKGkUEAvH/ooNvN3c0YrHNSS5EseoeXwhNW/ikOgwCt7HH4k
	2KB3YgagFWmIHGU7brHhdTisH+jsyfgLAztuNlOq+gMwnJkHFIzIzApEBiqFaA==
Message-ID: <22518939-c1ef-46ba-943d-256e135f74ca@nabladev.com>
Date: Thu, 16 Apr 2026 17:05:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
To: Andrew Lunn <andrew@lunn.ch>, Fidelio LAWSON <lawson.fidelio@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260414-ksz87xx_errata_low_loss_connections-v3-0-0e3838ca98c9@exotec.com>
 <20260414-ksz87xx_errata_low_loss_connections-v3-1-0e3838ca98c9@exotec.com>
 <ea90a671-70be-4d89-b842-1e54d687336f@nabladev.com>
 <d9b161dd-f698-4d7e-8ccb-9ec12411bf87@lunn.ch>
 <712cc46a-5ceb-4f0f-88bb-fa0a47002258@nabladev.com>
 <84e24758-2f59-44ca-a9b8-a46094578f83@gmail.com>
 <03040421-89e7-4422-9fb5-0367a34323e4@lunn.ch>
 <bf93f620-1288-46a3-8798-6d70aeb2c7c6@gmail.com>
 <6a8fc2e6-830f-4f57-869b-41efe70557e5@lunn.ch>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <6a8fc2e6-830f-4f57-869b-41efe70557e5@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279077-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nabladev.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,armlinux.org.uk,vger.kernel.org,exotec.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nabladev.com:dkim,nabladev.com:mid]
X-Rspamd-Queue-Id: 5990141041D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/16/26 4:30 PM, Andrew Lunn wrote:
>> With this model, we don’t need to return -EINVAL for combinations or
>> ordering, and userspace does not need detailed error reporting. The
>> tunables behave more like simple setters than a mode switch, which
>> keeps the API predictable and avoids the need for extack or netlink
>> ethtool support at this point.
> 
> Sounds good.
Fine by me too.

