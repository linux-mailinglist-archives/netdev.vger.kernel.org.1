Return-Path: <netdev+bounces-189184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F20BFAB106A
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 12:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615E7172DB9
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 10:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFC128E599;
	Fri,  9 May 2025 10:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="qNLszmI3"
X-Original-To: netdev@vger.kernel.org
Received: from server.wki.vra.mybluehostin.me (server.wki.vra.mybluehostin.me [162.240.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5B021A434;
	Fri,  9 May 2025 10:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746786091; cv=none; b=VViw2gTlJcZogrUSoFiRddk4ybMgh3spwMrllKPj9lfhzAYauBzrk4iSgXgX76s+6eFuix4G7A2zK68UQt+qOAK+J4O6ZTzpPSit/9Ia1G3zQyQ+tIg3EV+wrE2Wtq6TDsclMfLOBzks3oskzC13t0ibmk2/dME2ybRf0yskKeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746786091; c=relaxed/simple;
	bh=wBXx2fOBLx6Gi6UVSEZmN4C62Har2S/fqhRp6eO3S8M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ioANZ5g3cQSzfhQHEvXKknM5cjN6RUR8kzT7i4bcv8w6qPtS3ATUu5GM9aPiSijAfK0VJvk6TMQUCb1P3RKXiZRYYORUkU2Y00I7k1YO3I3+8xO8sYD7w8qCysyXqKtTONOeOQzMWBX515Wr8SwBNepvz3Hahwj9CjOhCsmDJAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=qNLszmI3; arc=none smtp.client-ip=162.240.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5shS9aa9wXhOlBT7ksNlLhRZM4K9cenEEVtO8PY9I70=; b=qNLszmI3KfaEVfwHV4511bth5D
	BUy3yg9rpJXubGWsBsCbDUw+VxDPTk7OQjbj1JAflYE5iBN/GCEzzocg6krSa59K2cI4+mzEU+uil
	8qI4E6NfEPXfbq3UhItDbucG+CuARqBWyDPRU62BGanVHuFhJ15kgABXjWQgcmUZnaG8Z6sI15Jtk
	7Ri/Xl9y5Jq2FqjMAUQpXmr4G6l5xDyhJvRsr2KnbyahQFiBrYP90tDUDsNWwy227CZHe2+Y0iPRv
	Ptv0Ko3ItekA/8Yhh242YHjW1jItnoE0Op/h4/cKSbeg/Qoy7MjDRyuG4jUkGcXLCddQaimMdVF3E
	SZrFHE7g==;
Received: from [122.175.9.182] (port=48237 helo=zimbra.couthit.local)
	by server.wki.vra.mybluehostin.me with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1uDKqx-000000003Ob-0ndo;
	Fri, 09 May 2025 15:51:15 +0530
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id C16971783FF8;
	Fri,  9 May 2025 15:51:06 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 9E74B1781E1E;
	Fri,  9 May 2025 15:51:06 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id d32p2WIoMBEs; Fri,  9 May 2025 15:51:06 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 4DCB51783FF8;
	Fri,  9 May 2025 15:51:06 +0530 (IST)
Date: Fri, 9 May 2025 15:51:06 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: pabeni <pabeni@redhat.com>
Cc: danishanwar <danishanwar@ti.com>, rogerq <rogerq@kernel.org>, 
	andrew+netdev <andrew+netdev@lunn.ch>, davem <davem@davemloft.net>, 
	edumazet <edumazet@google.com>, kuba <kuba@kernel.org>, 
	robh <robh@kernel.org>, krzk+dt <krzk+dt@kernel.org>, 
	conor+dt <conor+dt@kernel.org>, ssantosh <ssantosh@kernel.org>, 
	tony <tony@atomide.com>, richardcochran <richardcochran@gmail.com>, 
	glaroque <glaroque@baylibre.com>, schnelle <schnelle@linux.ibm.com>, 
	m-karicheri2 <m-karicheri2@ti.com>, s hauer <s.hauer@pengutronix.de>, 
	rdunlap <rdunlap@infradead.org>, diogo ivo <diogo.ivo@siemens.com>, 
	basharath <basharath@couthit.com>, horms <horms@kernel.org>, 
	jacob e keller <jacob.e.keller@intel.com>, 
	m-malladi <m-malladi@ti.com>, 
	javier carrasco cruz <javier.carrasco.cruz@gmail.com>, 
	afd <afd@ti.com>, s-anna <s-anna@ti.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	netdev <netdev@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	pratheesh <pratheesh@ti.com>, Prajith Jayarajan <prajith@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, pmohan <pmohan@couthit.com>, 
	mohan <mohan@couthit.com>, parvathi <parvathi@couthit.com>
Message-ID: <1918420534.1246603.1746786066099.JavaMail.zimbra@couthit.local>
In-Reply-To: <ce36ce0e-ad16-4950-b601-ae1a555f2cfb@redhat.com>
References: <20250503121107.1973888-1-parvathi@couthit.com> <20250503131139.1975016-5-parvathi@couthit.com> <ce36ce0e-ad16-4950-b601-ae1a555f2cfb@redhat.com>
Subject: Re: [PATCH net-next v7 04/11] net: ti: prueth: Adds link detection,
 RX and TX support.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF113 (Linux)/8.8.15_GA_3968)
Thread-Topic: prueth: Adds link detection, RX and TX support.
Thread-Index: Yo3qDn3AUxHTr12WJKQJ6KqVwLl7QQ==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.wki.vra.mybluehostin.me
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.wki.vra.mybluehostin.me: authenticated_id: smtp@couthit.com
X-Authenticated-Sender: server.wki.vra.mybluehostin.me: smtp@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi,

> On 5/3/25 3:11 PM, Parvathi Pudi wrote:
>> +/**
>> + * icssm_emac_rx_thread - EMAC Rx interrupt thread handler
>> + * @irq: interrupt number
>> + * @dev_id: pointer to net_device
>> + *
>> + * EMAC Rx Interrupt thread handler - function to process the rx frames in a
>> + * irq thread function. There is only limited buffer at the ingress to
>> + * queue the frames. As the frames are to be emptied as quickly as
>> + * possible to avoid overflow, irq thread is necessary. Current implementation
>> + * based on NAPI poll results in packet loss due to overflow at
>> + * the ingress queues. Industrial use case requires loss free packet
>> + * processing. Tests shows that with threaded irq based processing,
>> + * no overflow happens when receiving at ~92Mbps for MTU sized frames and thus
>> + * meet the requirement for industrial use case.
> 
> The above statement is highly suspicious. On an non idle system the
> threaded irq can be delayed for an unbound amount of time. On an idle
> system napi_poll should be invoked with a latency comparable - if not
> less - to the threaded irq. Possibly you tripped on some H/W induced
> latency to re-program the ISR?
> 
> In any case I think we need a better argumented statement to
> intentionally avoid NAPI.
> 
> Cheers,
> 
> Paolo

The above comment was from the developer to highlight that there is an improvement in
performance with IRQ compared to NAPI. The improvement in performance was observed due to
the limited PRU buffer pool (holds only 3 MTU packets). We need to service the queue as
soon as a packet is written to prevent overflow. To achieve this, IRQs with highest
priority is used. We will clean up the comments in the next version.


Thanks and Regards,
Parvathi.

