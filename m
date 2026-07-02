Return-Path: <netdev+bounces-304229-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wM93NcmgRmoWagsAu9opvQ
	(envelope-from <netdev+bounces-304229-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 19:32:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 499A56FB6E6
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 19:32:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WZST56m1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304229-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304229-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDE383361ED3
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 16:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B8433F5BE;
	Thu,  2 Jul 2026 16:37:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C79830B53F;
	Thu,  2 Jul 2026 16:37:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010245; cv=none; b=t+9var2BPaSSn6Whxoqy7EzxCXMBvjaqFuuhgIW81QSr/MEPE4WgRCX5kSZBG7HvM5VYEhjbDpF5E3ulJFRNSnsuUUrvvLOCUQi5HE1ra71MWsA4/LKWdnqtnRt81mBR6y6ve8hh4Lhh6EZEM5aInznr29E92Gj8xRl+JJjjAr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010245; c=relaxed/simple;
	bh=OVh5hq9AqE98I+fD5XeI33KlTHSAGbbN7vCuIRJjZ0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRbfN1RPmEGvZYqsvFeZUH/Bt/6zCWF684g//zcN/0oIOOeBX6yKX0gsIFKbtNMlNWF+6Hk9cgroZb3ZHq6lFDax/hiFoRM2WkiZm8aWHoucTdP/ZmFa6EtY10dOfdMKCl+SAyoN9xSqWwKUwzhzsIyiL+skQr1Ecgzz4qU9gpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZST56m1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DE21F00A3A;
	Thu,  2 Jul 2026 16:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783010244;
	bh=JYz2t9rOB6Xr/OOk1r6hBAPIGizcFH6efsw9sdj+Wuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WZST56m12/dPfMnjxUmbQmp1RfAlmgKoAVEw4PIMZ4PlBncoDVOpPHLhXYP7UxCWh
	 w2WX+KHS3/yrMGg5LCd2XYhuAdJMjDQxwlHGKGw9jqZsaKzD+/KFXkvXy7F7G5Qsg3
	 knE0Vqs2EZSNPAXhvJCivRI9fSLzOrLQ269grsez37WOv08gbDiYAht7bRYkYFPRE6
	 ISdshM4ZM+9IRGOao127qU4ICBLcYBvu8TPw2ecv6dw6wdipSuAmq03smCaRYbYvJO
	 pDlvHdbEJApBzIrzmr/WVzeLXYTFZPdGSv7hCjscCBFhpbkozKXxQQAaUzW7F3vlOu
	 CltxHKPd6Du9A==
Date: Thu, 2 Jul 2026 11:37:23 -0500
From: Rob Herring <robh@kernel.org>
To: Manikandan.M@microchip.com
Cc: krzk@kernel.org, pratyush@kernel.org, mwalle@kernel.org,
	takahiro.kuwano@infineon.com, miquel.raynal@bootlin.com,
	richard@nod.at, vigneshr@ti.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, srini@kernel.org, Nicolas.Ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	linux@armlinux.org.uk, richardcochran@gmail.com, linusw@kernel.org,
	arnd@arndb.de, michael@walle.cc, linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 1/7] dt-bindings: mtd: jedec,spi-nor: allow the SFDP
 to be exposed via NVMEM
Message-ID: <20260702163723.GA227454-robh@kernel.org>
References: <20260630092406.150587-1-manikandan.m@microchip.com>
 <20260630092406.150587-2-manikandan.m@microchip.com>
 <20260702-utopian-termite-of-perfection-f1f3ec@quoll>
 <860213fd-6a4b-42d4-a8f7-7308e070f09e@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <860213fd-6a4b-42d4-a8f7-7308e070f09e@microchip.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,infineon.com,bootlin.com,nod.at,ti.com,microchip.com,tuxon.dev,armlinux.org.uk,gmail.com,arndb.de,walle.cc,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-304229-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Manikandan.M@microchip.com,m:krzk@kernel.org,m:pratyush@kernel.org,m:mwalle@kernel.org,m:takahiro.kuwano@infineon.com,m:miquel.raynal@bootlin.com,m:richard@nod.at,m:vigneshr@ti.com,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:srini@kernel.org,m:Nicolas.Ferre@microchip.com,m:alexandre.belloni@bootlin.com,m:claudiu.beznea@tuxon.dev,m:linux@armlinux.org.uk,m:richardcochran@gmail.com,m:linusw@kernel.org,m:arnd@arndb.de,m:michael@walle.cc,m:linux-mtd@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 499A56FB6E6

On Thu, Jul 02, 2026 at 06:55:15AM +0000, Manikandan.M@microchip.com wrote:
> Hi Krzysztof,
> 
> On 7/2/26 11:46 AM, Krzysztof Kozlowski wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Tue, Jun 30, 2026 at 02:54:00PM +0530, Manikandan Muralidharan wrote:
> >> Add an optional "sfdp" child node (compatible "jedec,sfdp") that
> >> describes the SFDP as a read-only NVMEM provider via nvmem.yaml, so its
> > 
> > What is SFDP?
> > 
> SFDP is the Serial Flash Discoverable Parameters -- a JEDEC-standardised
> (JESD216) read-only parameter table present in most SPI NOR flashes, the 
> table contents provide basic information about the flash. There are 
> standard tables which are specified by the JEDEC standard and there are 
> vendor tables.

Is SFDP present or not discoverable? Or we have a table of discoverable 
parameters that itself is not discoverable.

If it is discoverable, why does this need to be in DT?

Rob

