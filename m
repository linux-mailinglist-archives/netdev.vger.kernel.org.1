Return-Path: <netdev+bounces-302686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U3jALQuMQmoz9gkAu9opvQ
	(envelope-from <netdev+bounces-302686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:15:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8656DC858
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:15:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="D5G0t/vB";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302686-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302686-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A78E3021C80
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 14:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687DA3BB9F4;
	Mon, 29 Jun 2026 14:53:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B36379C31
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 14:53:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744815; cv=none; b=LsQ7GAizQseK7ZYmdrVv/7D6JlX0dwJi1B3hfZuTsj21LHWRUIVRwsYYOi41N6ml0wXD0zdgVOMQsN2N7u6wVw4VaCANkzJcCy7mBaTgLU75C0gw50ISMZWKS1MoEZyvTChZTMXuo5J0rJPg4F6ChKhd1Kn9vhzFKN71eJt/Tds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744815; c=relaxed/simple;
	bh=Y72gqGNVHFe3+cuRwpXUTv1Tzl0fD8KsqU0fDXq0uew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=idV/rySRmopYhrc+06kyReTcUeawAU0LsJDfmMXjfhXYqCrm71mxVwud8b8aU8rsDZDE78wLtqGHIUmpARwyNx863mpz/OD5S62RUZxLlrdqS+sL+G+KEwVl2td9hNYOmTichyMU8zU2P2OJ9KinJn4EWQ6RgUhDFRe0MJsLl1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D5G0t/vB; arc=none smtp.client-ip=91.218.175.179
Message-ID: <c6aff5f7-e087-4bd9-b159-7adeb82e19f4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782744802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SMg5iOCotoO/Qp4dK9T70Dm4LOFKVsF3oNMdT2D6Y60=;
	b=D5G0t/vBYmEM+WXKd1fZ6r3mbNnIFgXraE7nMxuzdr/ZfjKiz1pTBuOJ7wr7Nbwb40ARVK
	lW0HG5xBd/g4KmK7r16iP6fO271jSSZ0b9+cEkT1JoSuz3jdMn3GEXEvy5a94sw2EkhTE6
	+qYcXAvncs/DK9vrvjypoofTB/EIcgM=
Date: Mon, 29 Jun 2026 15:53:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] ptp: ocp: add I2C ISP support for ADVA TimeCard CPLD
To: Sagi Maimon <maimon.sagi@gmail.com>, jonathan.lemon@gmail.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260628053840.4305-1-maimon.sagi@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260628053840.4305-1-maimon.sagi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302686-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:maimon.sagi@gmail.com,m:jonathan.lemon@gmail.com,m:richardcochran@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:maimonsagi@gmail.com,m:jonathanlemon@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,spinics.net:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD8656DC858

On 28/06/2026 06:38, Sagi Maimon wrote:
> The ADVA TimeCard programs its on-board CPLD (Lattice MachXO3)
> via I2C using in-system programming (ISP).
> 
> The CPLD resides on a secondary I2C bus controlled by the
> embedded MicroBlaze. To allow programming, the driver must
> take ownership of this bus and expose it to userspace.
> 
> Add support to:
>    - enable the i2c-dev interface to expose /dev/i2c-N
>    - provide sysfs control over the secondary I2C bus
> 
> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> ---
>   Address comments from:
>    - Andrew Lunn: https://www.spinics.net/lists/netdev/msg1200997.html

I don't see anything regarding module_request() part.
It looks like you want to expose raw I2C access for user-space software
to do direct writes to the HW, which is not modeled as a device in
kernel. Exposure of /dev/i2c bus affects other Time Cards where we tried
to hide to avoid direct writes to EEPROM areas.

If you need some addresses of i2c bus to be accessible, it's better to
implement these accesses as sysfs or debugfs attributes and expose them
for ADVA cards.



