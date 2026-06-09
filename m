Return-Path: <netdev+bounces-297239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LiVRHiViKGosDAMAu9opvQ
	(envelope-from <netdev+bounces-297239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 20:57:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C9966374B
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 20:57:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kabelmail.de header.s=vfde-mb-mr2-23sep header.b=k0BcEpJq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297239-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297239-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=kabelmail.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3C0D63007A5E
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 18:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C513AEF30;
	Tue,  9 Jun 2026 18:55:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mr6.vodafonemail.de (mr6.vodafonemail.de [145.253.228.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B717D4B8DF8
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 18:55:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031351; cv=none; b=JiEIJ3oggJwsFe9SA8qOZvub5ukTCOPpQXRkSH5b0THWsU928hny0+PsCwLcDF932kd9oBixMXSeZv3mFNBeh0rXcqFA/vSG1Zu3eg+NiT7xshOSuTJGQ6j5N8s6ZtgVFH5uYHniVF8LUGxacUR45FTSinNhLS93OpOP56sU9+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031351; c=relaxed/simple;
	bh=YuvxwJJx0zt9zh5hZQrkkVLUdkpSh1EhkbFr2UpellQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SjzZQYLWfoYvVnAcOB86oCOv4IOX2lpVIW9oZ9TUBnwS34Am1rryfDlkAEf0RtVvVcW75HoYl58gV5lPqk6b4jRlalVnT+merD6nZvxyTJttAtimDuveqAYJZrpJLP336CITLaZTsud3AgKNBjmkSE5SPHC8Lo31UuPIAXOEmA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kabelmail.de; spf=pass smtp.mailfrom=kabelmail.de; dkim=pass (1024-bit key) header.d=kabelmail.de header.i=@kabelmail.de header.b=k0BcEpJq; arc=none smtp.client-ip=145.253.228.166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kabelmail.de;
	s=vfde-mb-mr2-23sep; t=1781030956;
	bh=YuvxwJJx0zt9zh5hZQrkkVLUdkpSh1EhkbFr2UpellQ=;
	h=Message-ID:Date:User-Agent:Subject:To:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:From;
	b=k0BcEpJqi7prqPyrPTVtZJc4owzCN1gBeb4b9TkC0HKEM+dKbmyLiIml3N3l0ABll
	 wJ1qEW4Vdop0nHv56SZFkGzZI3Y6mEXiiIH5Z50BmzzwDxuzPfx4b0UPD4FI67rauS
	 8Pp2yKMQoB/EQL1s3b/90jK+uW0Bn1JT+Uwc+GEM=
Received: from smtp.vodafone.de (unknown [10.0.0.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mr6.vodafonemail.de (Postfix) with ESMTPS id 4gZdHJ37MRz3sVxP;
	Tue,  9 Jun 2026 18:49:16 +0000 (UTC)
Received: from [192.168.177.95] (212.71.13.3.adsl.dyn.edpnet.net [212.71.13.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.vodafone.de (Postfix) with ESMTPSA id 4gZdH86p9lz8sbN;
	Tue,  9 Jun 2026 18:49:05 +0000 (UTC)
Message-ID: <d4eefa75-3902-4014-983a-dadb88ff7bfd@kabelmail.de>
Date: Tue, 9 Jun 2026 20:48:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SFP/MDIO/I2C: help requested unlocking a SFP+ MCU to expose PHY
To: Nicolai Buchwitz <nb@tipi-net.de>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org
References: <ec5bd768-3f54-4c30-b5a2-1e0b43f789e3@kabelmail.de>
 <903daf32-aecd-4160-8f69-4fc329fdad3f@lunn.ch>
 <582a4a1181bf110e97d8d2d249dbd42a@tipi-net.de>
Content-Language: nl
From: Janpieter Sollie <janpieter.sollie@kabelmail.de>
Autocrypt: addr=janpieter.sollie@kabelmail.de; keydata=
 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
In-Reply-To: <582a4a1181bf110e97d8d2d249dbd42a@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-purgate-server: smtpa05
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 987
X-purgate-ID: 155817::1781030955-36FE159A-F4BB0B61/0/0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kabelmail.de,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kabelmail.de:s=vfde-mb-mr2-23sep];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297239-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[janpieter.sollie@kabelmail.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:nb@tipi-net.de,m:andrew@lunn.ch,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[kabelmail.de:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[janpieter.sollie@kabelmail.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,arm.com:url,kabelmail.de:dkim,kabelmail.de:mid,kabelmail.de:from_mime,odly.de:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 62C9966374B

Op 9/06/2026 om 10:32 schreef Nicolai Buchwitz:
> Hi Andrew + Janpieter
>
> On 5.6.2026 18:51, Andrew Lunn wrote:
>
>> [...]
>
>> Do you know what MCU is in the SFP? Is there a data sheet for it? Can
>> you read out the EEPROM holding its code over the I2C bus? You can
>> then disassemble/decompile the code and see what it is actually doing.
>
> It put up a bit of a fight, but in the end I managed to take it apart.
> uC seems to be a GD32E230F8 [1] [2].
>
> [1] https://www.keil.arm.com/devices/gigadevice-gd32e230f8/boards/
> [2] https://odly.de/lkml/10gtek-sfp-phy.jpg
>
> Regards
> Nicolai
>
>
Thank you Nicolas for breaking out the module,

Does this mean, because it's a pretty complicated microcontroller,
that "transparent" is a no-go?
I could eventually try to make Rollball work after all,
but when I take a look at the microcontroller, I get the idea
"firmware will filter all non-vendor approved commands to phy"

Thanks,

Janpieter Sollie

