Return-Path: <netdev+bounces-306455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CZ/8EIOnUGrO2wIAu9opvQ
	(envelope-from <netdev+bounces-306455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 10:04:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C27E738419
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 10:04:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=RgeWRIny;
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306455-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306455-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F34E30265AA
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 07:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF2B3DB64A;
	Fri, 10 Jul 2026 07:55:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6081D3DA7E0
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 07:55:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783670136; cv=none; b=ubQP4uRc5fex1DJrKXvnJEBAyGwgUHgs9XZuWeOSTbs56I2D4zYIr+R8ftAhUGxWN5cAxhpJyvjB8voJER0TF0WKF2SWYAKG/v0v4dvEn9DTKih6NcA0irkkXtK7ZQRcd3/Fkpgw6RK/K/Dpkh/oTgMwc51rF1+l99AJAIE3vlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783670136; c=relaxed/simple;
	bh=wS+SWyniFauIJVB7lAgJku9ullKRz+aJuro6iP0XJ3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TgZ4ecZDFRgRfJkrXCJg/OoOaAE57LVRjclonP5Lv2eNjvq98mFCPe79NBoYF7Jg+B11V7BW7U5DYNtObV2+BNVDAtRx20c/ZHGY7QN7J+U/Uxf4V6e5wh0J8JW1lWxF0Dd4TlBsUL4rXxoM18GxV4oPC4jZJwowXSSdqFEj9Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RgeWRIny; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C19F34E40D3B;
	Fri, 10 Jul 2026 07:55:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 872DD60341;
	Fri, 10 Jul 2026 07:55:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8B96011BD25EA;
	Fri, 10 Jul 2026 09:55:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783670124; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=MurWrrJf+gTtRqfWpt4rSJsv5jYUIeOi9Ka+haA90Es=;
	b=RgeWRInyxGw8N+hnf0MqNZIPY4BbKbxVYDxS99yNr6zdehq2nx9K9ho1PIk2ay5CtKzgDW
	oP81R0hh9tn7R7pCyFb+Rpvh5OK5YsWR9xJXha2DZZ8fLe/eIibQxykxz5TZWM11p4ILDc
	a3D/9Kl7hMZJqWIN72ZXWEd0sWlpPPiUycwPrXuIT3DhzPCvdHM3aA8IvnQWgqzQ4zPNyO
	vWS11uFaELE4l/+H33z2OEgChaMRkpM00rJTBaCLAWHIOS87SPESpfECz995Y0pM35GQCC
	kIuyxZyARwZsQ2V616nvjxqUaRqaqxGSmlrxkJPe/9ccvIersDokY1bcx2Zxxw==
Message-ID: <0e88052e-b36b-4655-98b8-ce9abc0d8061@bootlin.com>
Date: Fri, 10 Jul 2026 09:55:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/10] net: dsa: microchip: implement
 ksz8463_setup()
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260709-ksz-new-ptp-v1-0-344f02fe739e@bootlin.com>
 <20260709-ksz-new-ptp-v1-1-344f02fe739e@bootlin.com>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260709-ksz-new-ptp-v1-1-344f02fe739e@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,bootlin.com];
	FORGED_RECIPIENTS(0.00)[m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:horms@kernel.org,m:maxime.chevallier@bootlin.com,m:pascal.eberhard@se.com,m:miquel.raynal@bootlin.com,m:thomas.petazzoni@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306455-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:from_mime,bootlin.com:dkim,bootlin.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C27E738419

Hi all,

On 7/9/26 8:42 AM, Bastien Curutchet (Schneider Electric) wrote:
> KSZ8463 uses the ksz8_setup() as setup() callback for its DSA
> operations. Its behavior is quite different than other KSZ8 switches,
> especially its interrupt scheme.
> 
> Remove from the ksz8_setup()/ksz8_reset_switch() everything that is
> ksz8463-related.
> Create a dedicated ksz8463_setup() and a ksz8463_reset_switch() function.
> This new ksz8463_setup() is widely inspired from ksz8_setup, it has
> following differences:
> - it doesn't configure drive strength (not supported on KSZ8463)
> - it uses the ksz8463_reset_switch()
> - it doesn't configure IRQs

Sashiko said "Can this cause a probe failure or interrupt corruption 
when a hardware interrupt is configured in the device tree?"

It doesn't cause a probe failure on my setup. However, I think it's 
right when it says that the IRQ setup could lead to 'erroneously return 
an active Linux IRQ belonging to another hardware device'.

I'll change the patch order in next iteration and put this one after the 
KSZ8463 interrupt support to avoid this issue.



FYI, Sashiko made two other comments on this patch about bugs that would 
be triggered when 'the DSA master netdev is rebound'. I'm not sure to 
understand how these bugs can be triggered and the comments start with 
'This isn't a bug introduced by this patch' so I don't plan to 
investigate it further.


Best regards,
Bastien

