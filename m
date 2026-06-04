Return-Path: <netdev+bounces-295065-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VvE3NockIWqT/gAAu9opvQ
	(envelope-from <netdev+bounces-295065-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 09:08:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DD863D858
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 09:08:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b=EiZwVPya;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295065-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295065-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E0E663028AC4
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 07:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F90D3DE432;
	Thu,  4 Jun 2026 07:08:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41AD3DE42F;
	Thu,  4 Jun 2026 07:08:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780556932; cv=none; b=GwJEkQGqYKYgjVxpUL/CG5FqEA5KM8xL3oP8TaLD38Oi7/+gTBd3+MFjeAMQH9/HW+jJCqgIbKA8a7tIK/oQGjJ/5ttMTcCrSG1xJ74Q5PAKaqG8Pi7KF7qfte6H3nvGuuax9sPkiEbhVTslP0rioRNtnVfHagWNhqfG6MGlxP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780556932; c=relaxed/simple;
	bh=KxyJGkwPDoOBqy5XW77REpfneG4cVhH63Z/648+fpPc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=VX5UnCIv1WACx8bUEA+iCu3iWwN4r6GUq9GHA1xPUwd+enmrx+ZDIZDIL/h2FeBWlXeZZlzA0So6ZytdLT6y+jm0URwyeO0xMfgTWeuEpT+dIOw1GvXAqyM29blBVaPF0ipRFC9K4E/7iDJnFoiSnbZ7/7w0CAnxKUXXaBZK0vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=EiZwVPya; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 919B2A12E1;
	Thu,  4 Jun 2026 09:08:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780556924; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=VBkqgVxnrPw423JfYWcKCfXKl/tFbBF8vWm0ExUBrv0=;
	b=EiZwVPyaADsIVsBgsc593DKqKW6IGwIXOJwDa6xSzKHI7Pdw0kOUMlzQTWGhzf3ztr1Ldb
	GiSserTRH/KC7Njs7cUPdkR9KSf5gWe+YhTR2agbVU89klfosN5+E4MM9E4Sc/C07L5r09
	eO/oJ2O2r7WABpxrqGrWyJoJsKyn5w2R0DS4TrcpQ0XQ4NyY7/n606eqv1a4cM7a6NebBc
	7u17mVQ5ZrTDAL8KHZMLZ3szM35JsSFakHZZlD8VxWbpdCqlVJhhmCUehAbQFU6ru5JmAr
	o9yqMJUYVMdnF8cQ/QpmECQxlg/JZo7X+HTAjqfSaqoz4WklgIk1FaF0qDeASw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 04 Jun 2026 09:08:42 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Parthiban.Veerasooran@microchip.com
Cc: Selvamani.Rajagopal@onsemi.com, conor@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 Pier.Beruto@onsemi.com, andrew@lunn.ch, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor.Dooley@microchip.com,
 devicetree@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] dt-bindings: net: updated interrupt type to be
 active low, level triggered
In-Reply-To: <a5abb9b8-6ebf-4f95-a684-fc889b98acea@microchip.com>
References: <20260601-level-trigger-v3-0-da73e7010532@onsemi.com>
 <20260601-level-trigger-v3-2-da73e7010532@onsemi.com>
 <20260602-rebel-snide-5036c97e410d@spud>
 <CY8PR02MB92493D2E5491AAE5416C05A283122@CY8PR02MB9249.namprd02.prod.outlook.com>
 <a5abb9b8-6ebf-4f95-a684-fc889b98acea@microchip.com>
Message-ID: <16a277ff339663c52d57d290ca3ebe50@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-295065-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_RECIPIENTS(0.00)[m:Parthiban.Veerasooran@microchip.com,m:Selvamani.Rajagopal@onsemi.com,m:conor@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Pier.Beruto@onsemi.com,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Conor.Dooley@microchip.com,m:devicetree@vger.kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,microchip.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72DD863D858

Hi Parthiban

On 4.6.2026 08:29, Parthiban.Veerasooran@microchip.com wrote:

> [...]

> One possible alternative could be to use a threaded IRQ handler with
> IRQF_ONESHOT, where the IRQ line is disabled until the handler
> completes, and sleeping is allowed. In that case, we could perform the
> SPI transfer in the threaded handler to send the data header and
> deassert the interrupt, while deferring the remaining work to a 
> separate
> kthread (the current SPI thread). However, I have not yet tried this
> implementation, so I cannot comment on its behavior or effectiveness
> without implementing and testing it.

AFAIK both ks8851 and adin1110 request the IRQ as IRQF_TRIGGER_LOW | 
IRQF_ONESHOT
with a NULL primary handler and do everything in the threaded handler. 
SO
looking at these two drivers might be worth the inspiration.


> [...]

REgards
Nicolai

