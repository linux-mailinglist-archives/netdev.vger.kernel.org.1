Return-Path: <netdev+bounces-299615-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PEKhHOdmMGrlSgUAu9opvQ
	(envelope-from <netdev+bounces-299615-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:56:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF23368A118
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:56:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BHS0SKlR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299615-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299615-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 792A0308661C
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 20:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF20C38B7AA;
	Mon, 15 Jun 2026 20:56:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB152F12A5;
	Mon, 15 Jun 2026 20:56:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781556963; cv=none; b=NuwoAlLIQf2kiCANOcqsByTsIO6gEPB5+tBk8f9OxBEvCBHiVkYbVymi1XcFdgPawvbHjN0L8GsbabFZsj2R/cpT1R365+CCj5n1bf/wSBmXl1Vn+BX8vbmEPCrtab/THVXiD1H7a50YXfSah93InXVH9pE42QNgzrVZoaz9hmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781556963; c=relaxed/simple;
	bh=b5h4Pf5UZTZELYw4rjmk1n4kIxoGdyisixoTQqbHfVc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZPln1YGoUrTyjJxAXmiS4WUe1u7ns80ngfNEMLVY5HbrR5XfbH3QbokgKS+PB2a6rCP7OBlZG3T7sy9oHgTrpQlvFN7zdj4v4E0p2mitutHAwEDxMDVAfH/+gtmg4ZeYLTKEIo1CE3VcsyDtWZDIbjr8hDIQjnJcd2xqyFctmSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHS0SKlR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C0E1F000E9;
	Mon, 15 Jun 2026 20:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781556962;
	bh=gwo8BfYbtWdTsD2kD2xvWmHwutXtNuD/7PfiuNBO8/k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BHS0SKlRs9BWTFHWG8jt45niVzZI0nXhyyWGo/j7SBSS4Y8iBZUhF8B278ofv82oZ
	 m5EAGBOl6+RXhwZ/zmQ8V9pU830ga8ZVlqpifn5p+kDgOWpsmnF2zy3tBFUbj/Bbb6
	 rgeJZHTPi5uKM6e4ZewyAhL0q6SvVj44dL3iQrTpijUyCJ0WHWKhJ+jLs2YOgtfJTF
	 Rt0xfQK+CrVme1gkHDCzM7yRMb8InGbyfvOSa+lMKdtYdKQqgQ0zAK/ao7L4RvLVJv
	 AF2qQIovOW67CQ3OdU5FMy0dmlE+C/9vNlys6llhcSC3mdzosAuuvcIAIbN3uNhlDO
	 LSW/zrfv+RTFg==
Date: Mon, 15 Jun 2026 13:56:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, danishanwar@ti.com, rogerq@kernel.org,
 pmohan@couthit.com, afd@ti.com, basharath@couthit.com, arnd@arndb.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, pratheesh@ti.com,
 j-rameshbabu@ti.com, vigneshr@ti.com, praneeth@ti.com, srk@ti.com,
 rogerq@ti.com, m-malladi@ti.com, krishna@couthit.com, mohan@couthit.com
Subject: Re: [PATCH net-next 3/3] net: ti: icssm-prueth: Support duplicate
 HW offload feature for HSR and PRP
Message-ID: <20260615135600.655e4be4@kernel.org>
In-Reply-To: <20260611123636.376577-4-parvathi@couthit.com>
References: <20260611123636.376577-1-parvathi@couthit.com>
	<20260611123636.376577-4-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299615-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:parvathi@couthit.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:danishanwar@ti.com,m:rogerq@kernel.org,m:pmohan@couthit.com,m:afd@ti.com,m:basharath@couthit.com,m:arnd@arndb.de,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:pratheesh@ti.com,m:j-rameshbabu@ti.com,m:vigneshr@ti.com,m:praneeth@ti.com,m:srk@ti.com,m:rogerq@ti.com,m:m-malladi@ti.com,m:krishna@couthit.com,m:mohan@couthit.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ti.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF23368A118

On Thu, 11 Jun 2026 18:03:28 +0530 Parvathi Pudi wrote:
> From: Roger Quadros <rogerq@ti.com>
> 
> In HSR and PRP modes each outgoing frame must be sent on both PRU slave
> ports.
> 
> Previously the driver was writing the frame into each port's transmit queue
> independently after updating the tags resulting in performing two OCMC
> buffer copy operations.
> 
> Frame duplicate offloading is implemented with a common shared queue
> between the two ports. The driver writes the frame once into OCMC RAM,
> each port reads from the shared queue and replicates the transmission to
> both PRU ports, synchronising between PRU ports are maintained within
> firmware with appropriate handling.
> 
> For HSR the driver inspects the encapsulated ethertype in the HSR tag.
> PTP frames (ETH_P_1588) are sent on the directed port only to avoid double
> duplication and all other HSR frames are duplicated to both ports.
> VLAN-tagged HSR frames are handled by advancing past the 4-byte VLAN header
> before reading the HSR tag.
> 
> For PRP the driver checks the 6-byte RCT trailer for the ETH_P_PRP suffix
> to identify redundancy-tagged frames. Frames without an RCT are sent on the
> originating port only.

Warning: drivers/net/ethernet/ti/icssm/icssm_prueth.h:113 struct member 'host_recv_flag' not described in 'prueth_packet_info'

Please note that net-next will be closed for the next two weeks.
-- 
pw-bot: cr

