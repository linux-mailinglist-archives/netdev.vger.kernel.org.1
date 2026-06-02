Return-Path: <netdev+bounces-294204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DjLyCGfPHmqQVQAAu9opvQ
	(envelope-from <netdev+bounces-294204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 14:41:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F90262E1AA
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 14:41:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=KiB+8Gzc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294204-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294204-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C40430C5548
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 12:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35E733711D;
	Tue,  2 Jun 2026 12:34:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54EE2EB5CD
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 12:34:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780403696; cv=none; b=DY2KhQ/n+geC1DjcKY2vCK8mSlQZUGqG3QK+Wa7r+l7bskv5y5XfdJMGxYCfORXD2GXvQxFuHNDvrd+RT3LiqJC+vda3Q+L3Zc76Q7NNPapCPUO+HZAD7H94ima+QpvBdsFb1r7usW2mkdiziXHyph4HA/8zADaw2jrmrvl0awI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780403696; c=relaxed/simple;
	bh=A9ytQBDZ0jBjEJZ4WuHizZfXMvpyh9Y01dEtgv7qEPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PsqbD7lh7T4W7lqrvG04ry12XgFcCt3oMqCMhoTmg4kGlp94y5MBdIz21DwK2OOGZEfPrEDVfghZCXAHdpljb4lYEPRImVB4LouT1unDfAxcgaWnLQXlSuotdJHDWJEvxMqPilrxRfGzHDcd1HLGt8u76C7tC0YJt1z4bbgQH7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KiB+8Gzc; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D2562C6220A;
	Tue,  2 Jun 2026 12:34:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 69147603BC;
	Tue,  2 Jun 2026 12:34:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E53FA1088838A;
	Tue,  2 Jun 2026 14:34:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780403692; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=zFVWU+aDsuv90mtYSp/sliGlcrwj1MbrwkExwX4mBKk=;
	b=KiB+8GzcyAXxIs155T8gOxdRZd0/De30sH/M1rFpPeVOpwzL6AmtXNzN8qS+JhO698Sq+C
	kAu3VIoJGuxncX2WbbreffRpkWD078LHkzJ9BQO/1Zw1vnttmkPZQlGaC79gjxOhBFm7uj
	Wg2AeZ3xqr/H0HZmo6mKaHC+ZwuHkC5ZJGhr0D+ybyA6yCp1n6l83Ky6lfDdJBMN2zifGm
	+4zP6wxL8wEkDpd/On+YARX1/3WkIBe6QsXfeVwkOAi17vFWgGARmG+FvrxzcYMvmdnzGF
	3dzRNn/XWadw+ZXZHIQNupYvX9PqQ44yGMWmiLUoGQz2GHM5fOtvAKV+H63KnQ==
Message-ID: <fc2c75a1-a325-4238-b695-be6a7daff95b@bootlin.com>
Date: Tue, 2 Jun 2026 14:34:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/9] net: dsa: microchip: implement
 .{get/set}_wol only if needed
To: Paolo Abeni <pabeni@redhat.com>, Woojung Huh <woojung.huh@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260526-clean-ksz-3rd-v1-0-5b63e732149a@bootlin.com>
 <20260526-clean-ksz-3rd-v1-6-5b63e732149a@bootlin.com>
 <d50bb4c0-285d-4e77-b534-2891c9df3cd3@redhat.com>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <d50bb4c0-285d-4e77-b534-2891c9df3cd3@redhat.com>
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
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux@armlinux.org.uk,m:pascal.eberhard@se.com,m:miquel.raynal@bootlin.com,m:thomas.petazzoni@bootlin.com,m:tristram.ha@microchip.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294204-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:from_mime,bootlin.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F90262E1AA

Hi Paolo,

On 6/1/26 10:59 AM, Paolo Abeni wrote:
> On 5/26/26 11:47 AM, Bastien Curutchet (Schneider Electric) wrote:
>> @@ -3798,9 +3795,6 @@ int ksz_set_wol(struct dsa_switch *ds, int port,
>>   	if (wol->wolopts & ~(WAKE_PHY | WAKE_MAGIC))
>>   		return -EINVAL;
>>   
>> -	if (!is_ksz9477(dev) && !ksz_is_ksz87xx(dev))
>> -		return -EOPNOTSUPP;
> 
> Sashiko noted there is still a ksz_is_ksz87xx(dev) check in
> ksz_wol_pre_shutdown() which would probably keep WoL broken for the
> newly enabled switches.
>

Good catch from Sashiko here. I'm going to replace the is_ksz() checks 
in ksz_wol_pre_shutdown() with a if (ds->ops->get_wol && 
ds->ops->set_wol) (as done here in ksz_port_set_mac_address()) to ensure 
consistency in the WoL handling.


Best regards,
Bastien

