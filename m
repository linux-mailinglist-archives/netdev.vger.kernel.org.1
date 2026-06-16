Return-Path: <netdev+bounces-299835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 538mDxtFMWoKfwUAu9opvQ
	(envelope-from <netdev+bounces-299835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:44:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9243968F781
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:44:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=couthit.com header.s=default header.b=eK+jspAT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299835-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299835-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=couthit.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48AA331CF933
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728DC360EEA;
	Tue, 16 Jun 2026 12:38:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35291FFC59;
	Tue, 16 Jun 2026 12:38:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613520; cv=none; b=heuZ69DY1R47P5OdaZyKLLVAHSh5SEMqTFPgnRWNsnGJvZAB0JptS5SdpSVOVVm+2RzmwqBZAKLgKNq4kCK9QgmNKJ+xh0wiwb3JvsH0zCkf+7xl3w8670c5RvWyViRbnmhUz54ay71KxJ/YZVDA8HeEyvyk5eoDoA20momvFLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613520; c=relaxed/simple;
	bh=1HZnf3YOIZr3sNa+UAJiKFcAZfuOWvElho0ZtXxTpxo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=XJSd85yuRWwln6xBeLWB7XVclGsZmFTzVo1W+iET9cfC0h46GZS3qdOa/2mrfeuY+Xp09+hp5dCHphyFBsXsUElS1Ulbek4s6H+C2Bb2Y/INM7Je7EOIxxT9DWJbifuI7M0IF8Sha6Tq5CC1eqsGe75RCwyALPgTGXSpwHfA0I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=eK+jspAT; arc=none smtp.client-ip=162.240.164.96
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=wckBC5c3hxxozy+99Tfp2OGtxZAPUj+u4sggN2dYdKM=; b=eK+jspATY35msdfbuS2bfO/vxH
	OZuCLaX+VbPQhCNfNtpbJrTL++QtTQhLKXAFZzNzTHQ/6c58GsivezfOCQxXFrdFTq0DeYk0REgZu
	keS/0lhiHJE/08PPtO7MdVfKV00ZaU7AiZLYpv48lk5TH2Fx/EfNFORQ8MkYNKJQ0A/uEMhy9p5Ql
	nvZc24kPzEv6QaRK5f2JOQudf0+cmAjgFV02yv9kS0xMqN967tMqcB87dIKmEPPJWCFGT+MtBPSuv
	WDM+hEfxUMNWpAoH5DBUQNbD3Ie+zP3VkdaS/lIMiZQR7LsFGMkgBdhvaF4M0mm1BoaS9XgY0od08
	l95aaJOQ==;
Received: from [115.246.246.98] (port=64590 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <parvathi@couthit.com>)
	id 1wZT3k-0000000At2L-2NQa;
	Tue, 16 Jun 2026 08:38:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id BBE2119A7F6F;
	Tue, 16 Jun 2026 18:08:20 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10032)
 with ESMTP id I02UczKp5CFk; Tue, 16 Jun 2026 18:08:19 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 4213E19A7F69;
	Tue, 16 Jun 2026 18:08:19 +0530 (IST)
X-Virus-Scanned: amavis at couthit.local
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 0To_K82wJQZa; Tue, 16 Jun 2026 18:08:19 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 25E6F19A7F6F;
	Tue, 16 Jun 2026 18:08:19 +0530 (IST)
Date: Tue, 16 Jun 2026 18:08:19 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Parvathi Pudi <parvathi@couthit.com>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	pabeni <pabeni@redhat.com>, danishanwar <danishanwar@ti.com>, 
	rogerq <rogerq@kernel.org>, pmohan <pmohan@couthit.com>, 
	afd <afd@ti.com>, basharath <basharath@couthit.com>, 
	arnd <arnd@arndb.de>, linux-kernel <linux-kernel@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	pratheesh <pratheesh@ti.com>, j-rameshbabu <j-rameshbabu@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	m-malladi <m-malladi@ti.com>, krishna <krishna@couthit.com>, 
	mohan <mohan@couthit.com>
Message-ID: <358063548.1400426.1781613499101.JavaMail.zimbra@couthit.local>
In-Reply-To: <20260615135600.655e4be4@kernel.org>
References: <20260611123636.376577-1-parvathi@couthit.com> <20260611123636.376577-4-parvathi@couthit.com> <20260615135600.655e4be4@kernel.org>
Subject: Re: [PATCH net-next 3/3] net: ti: icssm-prueth: Support duplicate
 HW offload feature for HSR and PRP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_ZEXTRAS_20240927 (ZimbraWebClient - GC148 (Mac)/9.0.0_ZEXTRAS_20240927)
Thread-Topic: icssm-prueth: Support duplicate HW offload feature for HSR and PRP
Thread-Index: kRQq2cZyjwWaZc+5ja0kIgdhxnV0YQ==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: smtp@couthit.com
X-Authenticated-Sender: server.couthit.com: smtp@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[couthit.com:s=default];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[couthit.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:parvathi@couthit.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:danishanwar@ti.com,m:rogerq@kernel.org,m:pmohan@couthit.com,m:afd@ti.com,m:basharath@couthit.com,m:arnd@arndb.de,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:pratheesh@ti.com,m:j-rameshbabu@ti.com,m:vigneshr@ti.com,m:praneeth@ti.com,m:srk@ti.com,m:rogerq@ti.com,m:m-malladi@ti.com,m:krishna@couthit.com,m:mohan@couthit.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ti.com:email,couthit.local:mid,vger.kernel.org:from_smtp,couthit.com:from_mime];
	HAS_X_AS(0.00)[smtp@couthit.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_X_GMSV(0.00)[smtp@couthit.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[parvathi@couthit.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299835-lists,netdev=lfdr.de];
	HAS_X_SOURCE(0.00)[];
	DKIM_TRACE(0.00)[couthit.com:-];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[parvathi@couthit.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	HAS_X_ANTIABUSE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9243968F781

Hi,

> On Thu, 11 Jun 2026 18:03:28 +0530 Parvathi Pudi wrote:
>> From: Roger Quadros <rogerq@ti.com>
>> 
>> In HSR and PRP modes each outgoing frame must be sent on both PRU slave
>> ports.
>> 
>> Previously the driver was writing the frame into each port's transmit queue
>> independently after updating the tags resulting in performing two OCMC
>> buffer copy operations.
>> 
>> Frame duplicate offloading is implemented with a common shared queue
>> between the two ports. The driver writes the frame once into OCMC RAM,
>> each port reads from the shared queue and replicates the transmission to
>> both PRU ports, synchronising between PRU ports are maintained within
>> firmware with appropriate handling.
>> 
>> For HSR the driver inspects the encapsulated ethertype in the HSR tag.
>> PTP frames (ETH_P_1588) are sent on the directed port only to avoid double
>> duplication and all other HSR frames are duplicated to both ports.
>> VLAN-tagged HSR frames are handled by advancing past the 4-byte VLAN header
>> before reading the HSR tag.
>> 
>> For PRP the driver checks the 6-byte RCT trailer for the ETH_P_PRP suffix
>> to identify redundancy-tagged frames. Frames without an RCT are sent on the
>> originating port only.
> 
> Warning: drivers/net/ethernet/ti/icssm/icssm_prueth.h:113 struct member
> 'host_recv_flag' not described in 'prueth_packet_info'
> 

We will address this in the next version.

> Please note that net-next will be closed for the next two weeks.

Also noted regarding the net-next closure. We will post the updated series
once the tree reopens.

Thanks and Regards,
Parvathi.

