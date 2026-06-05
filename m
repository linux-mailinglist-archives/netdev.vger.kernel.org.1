Return-Path: <netdev+bounces-295993-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lt5KGn5WI2oMqAEAu9opvQ
	(envelope-from <netdev+bounces-295993-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 01:06:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B766464BBEA
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 01:06:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b=Y7W3Vu7G;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295993-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295993-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F13A03029AC1
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 23:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1EE3F9F3D;
	Fri,  5 Jun 2026 23:04:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06CD3CFF69
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 23:04:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780700682; cv=none; b=Q/Mor2WOm3+XmbtpJAyk0a/vymidq1f4hY5LnBmO4F5U2tjE31pC/p6Z/gTExvlcqMQE1MAyBTSfaQ5uJ2WcsTLRPzIIOOMFCh7sVS7hk+FTOPRqc6tddi8rBQPlbxz46AyPZIYORDFdW7IHslAkOIxSH5sdkX9pfSV044kNGHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780700682; c=relaxed/simple;
	bh=7Uwp+iLp+2o7FGr7TVfd72HI+0sHcUOFTnlziZ3O69E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=WQgSiv3SGGlipNceUQnXIX2qEjdYAG4Q1lHj4bW9eBRY3QJIANbY49wfDVn+tyk65gEJDnlyP0BynSAIIQ3LOGDUoxCilhap6t+0wt809GyOk6fZLJnfODX6iEnk+iIvEiFDC9COayNi5Rh0ocHCbbCJO28NPVqBo+OdiJPk2RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Y7W3Vu7G; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DC31BA4B81;
	Sat,  6 Jun 2026 01:04:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780700670; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CsNwhC0oH5i8bWZdrSp/c5rIJ5+ne35p/uH1hnHnnHI=;
	b=Y7W3Vu7GRuv0/I0q7CGsQbeUfZD7W74nLicPf5nBdrdJ4qPiXGGDNqk7AGDFd5uF8J50Z6
	sJkB9m5RzxrsmDELlQZsOYwp2o2Tn+UsK1FmrcrnNUtcTRmYmJbMBzm7NX3v3AO1RECUDZ
	6TUtH5/g55QubDvg3r0WxxuoYABMVS5ocMt1fqAKBpBCmlGOAfEG9ffpWIFslPw/yHsRsD
	ZvJK0QFNayEkzrklJMxkMqcM7DJyhxS3owhrT1NOeQfTq+/E/6P5zn9E0ujePzD25GzRJE
	N93mk61FDcBz+h8WwG5GE/6RSu5+/5pWJHY/6RyZO4Tbf8ziTxrMtaxo8NkhSw==
Date: Sat, 06 Jun 2026 01:04:25 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Andrew Lunn <andrew@lunn.ch>
CC: Janpieter Sollie <janpieter.sollie@kabelmail.de>, netdev@vger.kernel.org
Subject: Re: SFP/MDIO/I2C: help requested unlocking a SFP+ MCU to expose PHY
User-Agent: Thunderbird for Android
In-Reply-To: <dc641872-9ac5-407b-b1c4-04cac5f0ef8a@lunn.ch>
References: <ec5bd768-3f54-4c30-b5a2-1e0b43f789e3@kabelmail.de> <903daf32-aecd-4160-8f69-4fc329fdad3f@lunn.ch> <49CA4531-3BDC-4054-8830-BA80775C2B68@tipi-net.de> <dc641872-9ac5-407b-b1c4-04cac5f0ef8a@lunn.ch>
Message-ID: <42B61948-B34B-4A63-B560-34AED03F1649@tipi-net.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-295993-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B766464BBEA



On June 5, 2026 11:34:51 PM GMT+02:00, Andrew Lunn <andrew@lunn=2Ech> wrot=
e:
>> >Do you know what MCU is in the SFP? Is there a data sheet for it? Can
>> >you read out the EEPROM holding its code over the I2C bus? You can
>> >then disassemble/decompile the code and see what it is actually doing=
=2E
>>=20
>> https://doc=2E10gtek=2Ecom/file/file/20240806/d6fa28f954989f74cde42c753=
53b5fe6=2Epdf
>>=20
>> I2c address should be A0h
>
>That is the usual address for an SFP=2E However, MCUs sometime have ways
>to program them, etc=2E That is why i asked if you know what the MCU

Right=2E If I read the sparse datasheet correctly, this is a branded winto=
p module=2E AFAIR these wintop modules do plain i2c, even with their mcu=2E=
=20

A while ago a friend gifted me a mixed box with copper sfp+ modules from f=
s and other second source vendors=2E If I recall it correctly there was a s=
imilar/same=2E

If I can find it, I will check the i2c interface next week=2E=2E=2E

>is=2E I guess you have not taken one apart to see what is actually in
>it=2E
>
>	Andrew
>

Regards
Nicolai

