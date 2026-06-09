Return-Path: <netdev+bounces-296974-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TnVNNtbRJ2ps2wIAu9opvQ
	(envelope-from <netdev+bounces-296974-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:41:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4436065DE4E
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:41:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b=bbs7nvkT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296974-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296974-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 123D9300A3B9
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 08:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC29F3DA7E4;
	Tue,  9 Jun 2026 08:32:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097B03E715E
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 08:32:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780993933; cv=none; b=KGiL8g4azoJTnLe/h9Rj9rt0NxLx6oQOQZeJGMu+GILAG25UMEqjxwamel/UJQdTVYOls5paQOEES7Ks6kjBkVELokQDLafTNSjFDwgl+f8hvhEEldVthaqGAqGEwW4rjhpdGU1nevNv4xYqdIOomc2aG9ZPetZMiprJX94qQZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780993933; c=relaxed/simple;
	bh=1+IAERIw/yXCjdjyCVhLGK4z9evSIoeRAneiijVgqN0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=I5WO2SLxRkN4Mr6kHEenQtXcKaG5ibChziSfnpBgClgpEygwPg1kjTAhvX6ZMW5ZAJkYj9otrANSPZ8O1DM1fXnaDtVuX7gF5+A786E5Mx4pkw3aHoOHiWPa3KHjNY8Z/e+C9MOd8CYL7QcOAwHk97VFkh7fiDgkIV4SBcAk8hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=bbs7nvkT; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D685DA01B5;
	Tue,  9 Jun 2026 10:32:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780993922; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1+IAERIw/yXCjdjyCVhLGK4z9evSIoeRAneiijVgqN0=;
	b=bbs7nvkTL+UGRXGtM/m88YL3j1heu6S/2DlW0cAPYcGUO4/Y6u4ifQPhhB7DPLlfeOIe6v
	g881nIN6aXd8U8C8DMM3QOBSc5nsL92agUQWdHIgbjJkdjjtlEg2oNa8PZBRYlqIQhu7Pf
	tmLWOcWi5mdSDdCSNGUTPCaTG1wCw64ZgugwUbpgSWTcoyqQ5p71vo+I0wtIR9x85/inwK
	wq0RB2mhFcffkn4dvSk5NALOrkk3mz67hBvvMMddWW6bHaDKIwyiO1vLBoSks3W6pBrA6V
	pVBy5kYfQAx0Tsgn9iAEYBUkZEWu/9C4QxfCUUGdejRQaXJPS/uq3On2LNBW5A==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 09 Jun 2026 10:32:00 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Andrew Lunn <andrew@lunn.ch>, Janpieter Sollie
 <janpieter.sollie@kabelmail.de>
Cc: netdev@vger.kernel.org
Subject: Re: SFP/MDIO/I2C: help requested unlocking a SFP+ MCU to expose PHY
In-Reply-To: <903daf32-aecd-4160-8f69-4fc329fdad3f@lunn.ch>
References: <ec5bd768-3f54-4c30-b5a2-1e0b43f789e3@kabelmail.de>
 <903daf32-aecd-4160-8f69-4fc329fdad3f@lunn.ch>
Message-ID: <582a4a1181bf110e97d8d2d249dbd42a@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296974-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:janpieter.sollie@kabelmail.de,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4436065DE4E

Hi Andrew + Janpieter

On 5.6.2026 18:51, Andrew Lunn wrote:

> [...]

> Do you know what MCU is in the SFP? Is there a data sheet for it? Can
> you read out the EEPROM holding its code over the I2C bus? You can
> then disassemble/decompile the code and see what it is actually doing.

It put up a bit of a fight, but in the end I managed to take it apart.
uC seems to be a GD32E230F8 [1] [2].

[1] https://www.keil.arm.com/devices/gigadevice-gd32e230f8/boards/
[2] https://odly.de/lkml/10gtek-sfp-phy.jpg

Regards
Nicolai

