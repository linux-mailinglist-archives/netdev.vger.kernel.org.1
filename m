Return-Path: <netdev+bounces-275212-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FeCGzEk0Gmx3wYAu9opvQ
	(envelope-from <netdev+bounces-275212-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:33:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF63D3982F5
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DFBD30166DC
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 20:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7FE2BF00A;
	Fri,  3 Apr 2026 20:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Flrr+tcE"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8027123D7FB;
	Fri,  3 Apr 2026 20:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775248419; cv=none; b=rN+v9OX1bigyzQhjs+ucBBp07HDuEy3pGbvUSVMI9J2wK3NmEUvJHdUpWts0WNYKeg4jNQMhAVbtt2GE1chtYmJWBrplGqBeleoJxYxMTErkw9b++RMq1GV/UJzzyBtRzB7wqLzXK5RSptSm9aHmwAQ0pWbRL1shhtxJxnldGHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775248419; c=relaxed/simple;
	bh=6vJbR1HsZtoC0p63XY5ptLleNlmHW3vqNwMPaJERTvw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=kDUqXqFYw9czSdVChSxLKMUUUNllLRsiRHhlgw2nb9OcDIEJMN08Px8vFi9KEHXGSZFP4yAE+SBBfuxvozA87mgdOeXKEWtWffqyopNidb01T7LE8Qdtbu1q5GiiQZhxNCeSrvC/sy/MWslRoGKvQy1Bqbj/fhExs9fhcb5etaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Flrr+tcE; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AB2E5A26FD;
	Fri,  3 Apr 2026 22:33:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775248409; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NrRfeAuLNo+tfygkfYwSatv7Qnd9WNY817BfeKvVRDs=;
	b=Flrr+tcE6nb+n0N6JPOlSNW5Dpb0fKwaazKG8FIzpGheSpb/vFBTtpuDID4/sulvuf2Tuk
	g/2CRJd6xs9ayyoiV+bq6kgnXOveptCFRymIBD/uBRlw5s4GL/2qvvb7E/mVcl00l5lx3O
	Hf1euO5CeYAeeoQzDbYx247ydqt/1mBQct1Ojiqs7XyoGqyQC/eVh5kbgNlxSRDUhKcOLw
	UGLnnKo/BuNOor4MLY5KIzwXbZ1cF/ULFU4vTrDbykNromwTA8sITCdc8dpCIzzb7N68YX
	4kRGxijesAwsj8W4K2T267Hu+ElFdrCSBGuNNDrucYHJmZ8yfxT/F2G9oFBerg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 03 Apr 2026 22:33:26 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Thomas Richard <thomas.richard@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, Roger Quadros
 <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org
Subject: Re: [PATCH 0/2] Add USB Ethernet controller (LAN7500) node in
 VAR-SOM-OM44 devicetree
In-Reply-To: <20260403131801.359be561@kernel.org>
References: <20260403-b4-var-som-om44-lan7500-v1-0-0dadde850143@bootlin.com>
 <20260403131801.359be561@kernel.org>
Message-ID: <2f843cc38fce1c5df9291c2e4b064241@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-275212-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tipi-net.de:?];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.614];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_TEMPFAIL(0.00)[tipi-net.de:s=dkim];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tipi-net.de:mid]
X-Rspamd-Queue-Id: EF63D3982F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3.4.2026 22:18, Jakub Kicinski wrote:
> On Fri, 03 Apr 2026 21:02:22 +0200 Thomas Richard wrote:
>> The goal of this series is to add the USB Ethernet controller node in 
>> the
>> VAR-SOM-OM44 devicetree in order to allow the bootloader to patch the
>> devicetree and pass a MAC address to the smsc75xx driver. This was 
>> also a
>> good opportunity to create the schema file for LAN75XX devices.
> 
> But there's no driver for it yet, right?
> IDK what the best practices are here, just unusual to see a schema
> without a driver, is all.

The smsc75xx driver has been in the tree since 2010 (d0cad871703b) and
already reads local-mac-address/mac-address from devicetree via
platform_get_ethdev_address() in smsc75xx_init_mac_address(), so the
binding should be covered on the driver side.

