Return-Path: <netdev+bounces-272596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFJNGm+bxmnrMQUAu9opvQ
	(envelope-from <netdev+bounces-272596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:59:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B94803466B3
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCC6E3019935
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 14:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812EB3F880C;
	Fri, 27 Mar 2026 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="NVUt3fDw"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5843F99DF;
	Fri, 27 Mar 2026 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774623322; cv=none; b=ftCJIL70y/FOviEgPPWpWCNKFPBrktQ9OuYD82qFIpx8K+ZcwBg8gU6xhoPf8NBj9m29fT8kNjR0zyhy78SsID3+JubQWUYzsrj0wEE+DRI5yIvzMsZ99KdNcCnHWr1wqsGgEE5HGwAObSbEvRsLDy2s8EkSG3Ij0V9IMa1CpHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774623322; c=relaxed/simple;
	bh=T+KQ37jHwWtYw3vucW7+wu32h2LngUqMA4j4rk4dfyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lrh/BQYw0rJG7Ucxuc/wz9y/o0eLL2jPF4cfJW+bzx2AYhnRZML5pz+l06wtUcjrkvvuVgAxECnAN8tprM9QH+BTqlazVR2KyJZ/SgLgu1/cLqBa4SlClJg+d3kE/rI135ZXloe+/J1ojA45TVyjJYR96QjTXdigX2gfbCJvFOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=NVUt3fDw; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E68BA108582;
	Fri, 27 Mar 2026 15:55:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1774623317;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=O3U6KBp5eEItdm326gyDQSusCSAfn1puIfEFX1XPUdk=;
	b=NVUt3fDwRABcutDS7WJf5ejKhiImODoNwU89rycq8ImOEeRghCk4mHysUjpxLN+JdLxrAD
	YysQpaCV5wz9GErd08aZm92Sjtx7Hyxe4xkrz2m19gQ8HejFS6dmM/wmRVgfvGoR7qJFYt
	9TLOjEb2UZmwRRfo7dzMn43E/2jJUrbMMFa6m7VSthcZ5rTn1uRBwPgaX5ARIYUpmCZ01L
	d7tU4T5XCqnTgL129b541YEVYG9auPJ5sNTZJ/7PeMCKHQPA3fTkrE0/jxYepIHpm93mzm
	csG7ctMpvOfcfyZSqRo4jk2bPoksajsq13/wzLL28DcUNhtZu0GDQPy8KTTgsQ==
Message-ID: <80e21085-84b9-4ebd-9a60-1d7acfc1a56b@nabladev.com>
Date: Fri, 27 Mar 2026 15:55:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
To: Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 Fidelio Lawson <lawson.fidelio@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260326-ksz87xx_errata_low_loss_connections-v1-0-79a698f43626@exotec.com>
 <20260326-ksz87xx_errata_low_loss_connections-v1-0-79a698f43626@exotec.com>
 <20260326-ksz87xx_errata_low_loss_connections-v1-3-79a698f43626@exotec.com>
 <20260326-ksz87xx_errata_low_loss_connections-v1-3-79a698f43626@exotec.com>
 <20260326094211.hdaf4tz7lbjyjznn@skbuf>
 <2848158c-a807-4d26-be87-248d4107c5b4@bootlin.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <2848158c-a807-4d26-be87-248d4107c5b4@bootlin.com>
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
	TAGGED_FROM(0.00)[bounces-272596-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.931];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nabladev.com:dkim,nabladev.com:mid]
X-Rspamd-Queue-Id: B94803466B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/27/26 3:47 PM, Bastien Curutchet wrote:

Hello Bastien,

>> FYI, the driver is in a restructuring process. The ksz88xx_switch_ops
>> will be split out of the common ksz_switch_ops. This will conflict with
>> your series, so you should rebase on top of that much larger set.
>> You can coordinate with Bastien Curutchet to see what is the status:
>> https://lore.kernel.org/netdev/20260313153849.qkfzv5c2u6fepjku@skbuf
> 
> Indeed, I'm currently polishing a first iteration for it. I'll send it 
> ASAP.
I would argue that this low-loss cable errata is a bugfix, so maybe that 
should have a priority over restructuring ?

