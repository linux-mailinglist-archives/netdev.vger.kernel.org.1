Return-Path: <netdev+bounces-295939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EL3eKUgUI2o8hwEAu9opvQ
	(envelope-from <netdev+bounces-295939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 20:24:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CD564A928
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 20:24:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b=ozlRqFxB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295939-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295939-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA08C30434E8
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 18:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FE23B2FE4;
	Fri,  5 Jun 2026 18:16:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6932253340
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 18:16:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683376; cv=none; b=YvkopCjWIk9KDzutZR683v+arfvy37M5C9Wkk4u+zeCyKLTc9KLP+U1p/7nIfhSnVlCqYEFahDILl7TrNvQwF+q1qeNTrlAp3/Qs/DDlQXDQvuNVvCL21CnonMvf6DFL62aPXG6luHRz1Vjc4GlanLGpVl1FZrcRtT/rOm+nCmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683376; c=relaxed/simple;
	bh=Dvr3HuucUQy9MSoVPbMBM9jW04Hs2nygJoBIBZTKxyM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=klT3FzJ2ltvb4VD+KWkOwFu1nqZawNpKiIjO3uU4GbQmE9VB1g8rgwrh8iW8FP6LYGjCzA5DsL/e9AUPStmDYJGXWXdlUSaf0p7WRIaB3E3XGCwS6n/OFGH6zQF2CuBCCOY2lqSToG4brPTWeBssJ/+pLuUcVl+khTJppGnB3i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=ozlRqFxB; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8584BA4C3B;
	Fri,  5 Jun 2026 20:16:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780683368; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wrNglY5ViloEmNs9RRyqZPGCG3oTEJgSEbE0UVjOUck=;
	b=ozlRqFxBLDD+L0BZetFQ+Wo/u6kZCLjHHVtvN+ryTuzcsfQ4EaZW5rJF4s2T3iZSfpjgsP
	gZfU/ZDWlSW9rpZN7mKqNk226UuwUtDc0T1s4fCSFumYnYGWKdbC00nKBWQWiCoYccMKoC
	1Ha3nTkJiNWDZHqoemi+ydk65b9E85vIkeFm3/37ZVeQ4goT6LKxDLgHRO6rVrnuAFMMMr
	II6drYy5BSnA1Xdph6piul+0G18JDvai0nBmQ2o7nAQCu4Ui/Mlx7Fl2+uMviukBsW0gWW
	scXXLGBhQna2C6JPjvqO4/2h6dtfQsnePcuyudz9DsYP5seBVmNYAHM6uHnAAA==
Date: Fri, 05 Jun 2026 20:16:03 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Andrew Lunn <andrew@lunn.ch>,
 Janpieter Sollie <janpieter.sollie@kabelmail.de>
CC: netdev@vger.kernel.org
Subject: Re: SFP/MDIO/I2C: help requested unlocking a SFP+ MCU to expose PHY
User-Agent: Thunderbird for Android
In-Reply-To: <903daf32-aecd-4160-8f69-4fc329fdad3f@lunn.ch>
References: <ec5bd768-3f54-4c30-b5a2-1e0b43f789e3@kabelmail.de> <903daf32-aecd-4160-8f69-4fc329fdad3f@lunn.ch>
Message-ID: <49CA4531-3BDC-4054-8830-BA80775C2B68@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.65 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:janpieter.sollie@kabelmail.de,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295939-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tipi-net.de:mid,tipi-net.de:from_mime,tipi-net.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 11CD564A928



On June 5, 2026 6:51:56 PM GMT+02:00, Andrew Lunn <andrew@lunn=2Ech> wrote=
:
>On Fri, Jun 05, 2026 at 10:09:46AM +0200, Janpieter Sollie wrote:
>> Hi,
>>=20
>> This message is a follow-up on a previous request,
>> I reverse-engineered a lot of stuff,
>> and the question has become fundamentally different=2E
>>=20
>> I am trying to access the bcm84891 phy on a 10Gtek ASF-10G-T80 sfp+ tra=
nsceiver=2E
>> According to 10Gtek, these modules contain a bcm84891 phy=2E
>> The MDIO commands seem te be sent to a MCU, not the phy itself=2E
>
>Do you know what MCU is in the SFP? Is there a data sheet for it? Can
>you read out the EEPROM holding its code over the I2C bus? You can
>then disassemble/decompile the code and see what it is actually doing=2E

https://doc=2E10gtek=2Ecom/file/file/20240806/d6fa28f954989f74cde42c75353b=
5fe6=2Epdf

I2c address should be A0h

Nicolai

>
>	Andrew
>

