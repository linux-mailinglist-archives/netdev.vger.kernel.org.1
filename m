Return-Path: <netdev+bounces-304603-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vR5FEknlR2rxhAAAu9opvQ
	(envelope-from <netdev+bounces-304603-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:37:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 924F37044D1
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:37:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=C2wkDCKY;
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304603-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304603-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60A3B301E3FB
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 16:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237D830676C;
	Fri,  3 Jul 2026 16:32:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888282D5937;
	Fri,  3 Jul 2026 16:32:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783096339; cv=none; b=Y5Zyj32ZF2xKutPSnoXx/VDHlHv9u+/6YX5CgKYFFQ4xqnOvN5U46M2MJ/mZMET0ShGmC6MnG3fnfFhH3EqLVsQF4LCSChkUKbopwIyXdnfr/m/oBojq0WW/4qHGfjP+0GVAap54ls0xrWYOkkuF+5ODCBDt8bAriQLW2STlHl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783096339; c=relaxed/simple;
	bh=pFq7qXlGoKSF9E+1OFt+CR/1KmxFtBay4rL6A+5TbvM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=EAz2rOL02UJuWIAmXbbE91Iu+8mme8b5EA9i7IvNAMdnb9CX+uHUzgSfXssQmvowkH3Q0kV3vZmEOXfvrHgA3L5TT28lEehQaOlCqxgmtWQYY2dGvZ5j/f6hj2ro72X2OknsPwdvwEMzR89670Wx+RiBsSUJjfHfk/kMOttrTmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=C2wkDCKY; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EC1511A0E0E;
	Fri,  3 Jul 2026 16:32:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AE5EB60300;
	Fri,  3 Jul 2026 16:32:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6DE46102F0D61;
	Fri,  3 Jul 2026 18:32:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783096333; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RLDscj7WzG84K9lSPYBqKCc45pcOPXuAsdlAYE6GaCE=;
	b=C2wkDCKYpR9mki7vl7MiNfHDxhacdAO8ppWqQ3C8BS4rLqa/MWXJP5Lscdkk3KMouDqEmQ
	eJUWL0c292xTl7OZ2fW05WnsqNEz5RK1HO8OGxwNFsRvc+vLBHtPRcP12nCmkyi6uLoiES
	EdN02l8R6Zy1eTI8CaITQHGjzQTE9BBQGcFskNpuop+mDzFeKAhKOd2FfGpyq7jaQrwHH5
	Q2PZFd9fF6tjvnxjQAb62VEcvtFkDGRuZPZBCEc7M+x25vK60D5AVp5B732wwzRy+QSlyJ
	5Q3jqjEy4H8cpLLSjslGGnYvwedWO0xgP8Mf9IKhRgzPRUB8NKS7Ze+yGuvlbw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 18:32:08 +0200
Message-Id: <DJP2W90JJK0G.1DBR4RMJKJO2Z@bootlin.com>
Subject: Re: [PATCH net-next v3 01/15] net: macb: drop "consistent" from
 alloc/free function names
Cc: "Conor Dooley" <conor.dooley@microchip.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Richard Cochran" <richardcochran@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 "Paolo Valerio" <pvalerio@redhat.com>, "Nicolai Buchwitz" <nb@tipi-net.de>,
 "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?utf-8?q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Maxime Chevallier"
 <maxime.chevallier@bootlin.com>
To: "Conor Dooley" <conor@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
 <20260701-macb-context-v3-1-00268d5b1502@bootlin.com>
 <20260703-stucco-broadly-d9393f789868@spud>
In-Reply-To: <20260703-stucco-broadly-d9393f789868@spud>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304603-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org,tuxon.dev,tipi-net.de,mobileye.com,bootlin.com];
	FORGED_RECIPIENTS(0.00)[m:conor.dooley@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:pvalerio@redhat.com,m:nb@tipi-net.de,m:vladimir.kondratiev@mobileye.com,m:gregory.clement@bootlin.com,m:benoit.monin@bootlin.com,m:tawfik.bayouk@mobileye.com,m:thomas.petazzoni@bootlin.com,m:maxime.chevallier@bootlin.com,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,bootlin.com:from_mime,bootlin.com:url,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 924F37044D1

Hello Conor,

On Fri Jul 3, 2026 at 1:28 PM CEST, Conor Dooley wrote:
> On Wed, Jul 01, 2026 at 05:59:04PM +0200, Th=C3=A9o Lebrun wrote:
>> Since commit 4df95131ea80 ("net/macb: change RX path for GEM") those
>> functions have not been only allocating or freeing consistent memory
>> mappings.
>>=20
>> Rename from macb_alloc_consistent() to macb_alloc() and
>>        from macb_free_consistent()  to macb_free().
>
> What does "consistent" even mean? Is it intended to be analogous to
> coherent?

That's my guess. We used to have pci_alloc_consistent(), being an alias
to dma_alloc_coherent().

This alias has been present since forever (since Git):

   git show 1da177e4c3f4:include/asm-generic/pci-dma-compat.h

The alias got removed in commit 7968778914e5 ("PCI: Remove the
deprecated "pci-dma-compat.h" API", 2022-03-09).

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


