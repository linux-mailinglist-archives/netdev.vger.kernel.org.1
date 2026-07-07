Return-Path: <netdev+bounces-305407-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CHFjH/nXTGrqqgEAu9opvQ
	(envelope-from <netdev+bounces-305407-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 12:42:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D8971A884
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 12:42:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=couthit.com header.s=default header.b="ZURn/r+h";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=couthit.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305407-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305407-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8EBF3043997
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 10:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B403ED3C4;
	Tue,  7 Jul 2026 10:37:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8DE3B47D0;
	Tue,  7 Jul 2026 10:37:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420638; cv=none; b=SNzyHdzMixnBX8uIxa1PTUC4RPBu9hZF+vGtjkQMVvuNnSlq6KCG1JiqxwdiZ6kBWwzp4Twuaf35D1md4yzSz/tSLY6YuwDqK2OQwy/weSfntrn05FWnPTij22tj0Nr7Cm6cfSVt1ZUkqSUhf3VPgFEc/FRgUwLvjmeWjunRfxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420638; c=relaxed/simple;
	bh=En7h3cH/CWDfdQspXBNGjZDwZuDH1hplUscB14ZZogo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=KPkWf87EG313aNeEkxN510zg17YEG6Y6GVvnfcfA52g464qpqnZdaTguTgkSXg0UTFyVQmpqp5MnwqODS4HxZDRtI2N1QEOuEp7HA/oQeg+wk3AGGYxtanEjdGPOaHLoNNXW7YSNelmhgwP/T+NCcptr8H5iKCaEua9Y54Q/5Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=ZURn/r+h; arc=none smtp.client-ip=162.240.164.96
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pOL2LivOziEKOydGhyELrv4YvjM0xwsEQoaCeoympc0=; b=ZURn/r+hEiMd3lVJPe/lPjjAVo
	IdeS+ZWvzmh+2rYtf9zrbw/86Nt8ZO2bDKtQKVqjJhoWPervjLGwI+LJyisjySLsthlhu2qTdyMs9
	sMPzgBm7xc48QzEIXWy6QV18Wk01rri39Xsb9vwVJ8FcVoV/aUakNKIEi1jzBRcMysBY9cG7415RQ
	Aj81c6NXsjSQL9BiPfAWpmGAURaCqZI8Ojzz144z/JMtcYOFDd4RWve15J0JallqPRYhtoDrBF/X3
	lIthMKaxbw9CKjUa4ZqIDlORJKRbtKEiHYQy5WIKhNOAlbmuCH7izWz89QxEX/Dhn/iWwI31PUKPs
	/K9f7Dfg==;
Received: from [115.246.246.98] (port=38479 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <parvathi@couthit.com>)
	id 1wh3Am-0000000DcCE-2mia;
	Tue, 07 Jul 2026 06:37:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 75E8C1B071DC;
	Tue,  7 Jul 2026 16:06:56 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10032)
 with ESMTP id IJLnN744ezV4; Tue,  7 Jul 2026 16:06:52 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id D46861B071D0;
	Tue,  7 Jul 2026 16:06:52 +0530 (IST)
X-Virus-Scanned: amavis at couthit.local
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Xgrw10G8zfdZ; Tue,  7 Jul 2026 16:06:52 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id B07661B071DC;
	Tue,  7 Jul 2026 16:06:52 +0530 (IST)
Date: Tue, 7 Jul 2026 16:06:52 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: parvathi <parvathi@couthit.com>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	kuba <kuba@kernel.org>, danishanwar <danishanwar@ti.com>, 
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
Message-ID: <683548159.1585651.1783420612671.JavaMail.zimbra@couthit.local>
In-Reply-To: <20260706091338.134754-1-pabeni@redhat.com>
References: <20260630124958.894360-4-parvathi@couthit.com> <20260706091338.134754-1-pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 3/3] net: ti: icssm-prueth: Support
 duplicate HW offload feature for HSR and PRP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_ZEXTRAS_20240927 (ZimbraWebClient - GC138 (Linux)/9.0.0_ZEXTRAS_20240927)
Thread-Topic: icssm-prueth: Support duplicate HW offload feature for HSR and PRP
Thread-Index: 1L122pWSAIHcS+z+0TJ+oGlKhvBb9Q==
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
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:parvathi@couthit.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:danishanwar@ti.com,m:rogerq@kernel.org,m:pmohan@couthit.com,m:afd@ti.com,m:basharath@couthit.com,m:arnd@arndb.de,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:pratheesh@ti.com,m:j-rameshbabu@ti.com,m:vigneshr@ti.com,m:praneeth@ti.com,m:srk@ti.com,m:rogerq@ti.com,m:m-malladi@ti.com,m:krishna@couthit.com,m:mohan@couthit.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,couthit.com:from_mime,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	HAS_X_AS(0.00)[smtp@couthit.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_X_GMSV(0.00)[smtp@couthit.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[parvathi@couthit.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305407-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: C6D8971A884

Hi,

> From: AI Reviewer <ai@example.com>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev/
> ---
> net: ti: icssm-prueth: Support duplicate HW offload feature for HSR and PRP
> 
> This commit introduces hardware duplicate offload for HSR and PRP modes. It
> implements a common shared queue between the two ports, writing frames once
> to OCMC RAM and relying on the firmware to replicate the transmission.
> 
>> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> index 2ab78a98f8568..cbe666a212c3b 100644
>> --- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> @@ -97,6 +125,17 @@ static void icssm_prueth_write_reg(struct prueth *prueth,
>>  static enum pruss_mem pruss_mem_ids[] = { PRUSS_MEM_DRAM0, PRUSS_MEM_DRAM1,
>>  					  PRUSS_MEM_SHRD_RAM2 };
>>  
>> +struct prp_txopt_rct {
>> +	__be16 sequence_nr;
>> +	__be16 lan_id_and_lsdu_size;
>> +	__be16 prp_suffix;
>> +};
> 
> [Severity: High]
> Does this structure definition need the __packed attribute?
> 
> This struct consists of three 16-bit fields but lacks the __packed attribute,
> so it inherits a 2-byte alignment requirement.  Later in
> icssm_prueth_tx_enqueue, a pointer to this structure is derived directly
> from skb_tail_pointer.
> 
> If an ethernet frame payload has an odd byte length, wouldn't casting and
> dereferencing this pointer cause an unaligned 16-bit memory access, resulting
> in hardware traps or panics on architectures that do not support it?
> 
> [ ... ]
>> @@ -549,15 +588,24 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac
>> *emac,
> [ ... ]
>> +	other_emac = emac->prueth->emac[(emac->port_id == PRUETH_PORT_MII0) ?
>> +				PRUETH_PORT_MII1 - 1 : PRUETH_PORT_MII0 - 1];
>> +
>> +	if (prueth_is_lre(prueth) && (emac->link || other_emac->link))
>> +		link_up = true;
> 
> [Severity: High]
> Could this logical OR cause the shared transmission queue to stall completely
> if only one of the slave links goes down?
> 
> If one port loses its link, its emac->link is 0, but the other active port
> will still evaluate link_up as true. The active port would continue sending
> duplicate frames to the shared queue.
> 
> [ ... ]
>> @@ -605,6 +659,29 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac
>> *emac,
> [ ... ]
>> +		if (free_blocks_other_port < free_blocks)
>> +			free_blocks = free_blocks_other_port;
>> +	}
> 
> [Severity: High]
> Following up on the link_up logic above, since the available queue space is
> bounded by the slowest reader here, wouldn't the inactive port's read pointer
> remain frozen?
> 
> This appears to exhaust the free_blocks pool, causing the active port to
> eventually spin and return -ENOBUFS permanently, defeating the redundancy.
> 
> [ ... ]
>> +		} else {
>> +			/* Read PRP RCT to extract sequence number and LAN ID */
>> +			struct prp_txopt_rct *rct =
>> +				(struct prp_txopt_rct *)(skb_tail_pointer(skb) -
>> +							 ICSSM_LRE_TAG_SIZE);
>> +
>> +			if (rct->prp_suffix == htons(ETH_P_PRP)) {
> 
> [Severity: High]
> Is it safe to directly dereference rct->prp_suffix here?
> 
> As mentioned above regarding the struct definition, this might lead to an
> unaligned memory access on certain architectures. Perhaps using the
> get_unaligned_be16 helper would be safer here, or adding the __packed
> attribute to the structure definition.
> 
> [ ... ]
>> @@ -1341,18 +1516,30 @@ static enum netdev_tx icssm_emac_ndo_start_xmit(struct
>> sk_buff *skb,
> [ ... ]
>> +	raw_spin_lock(lock_queue);
>> +	ret = icssm_prueth_tx_enqueue(emac, skb, qid);
>> +	raw_spin_unlock(lock_queue);
> 
> [Severity: High]
> Does this need to use the irqsave variant to protect against cross-device
> deadlocks with netpoll?
> 
> The lre_host_queue_lock is shared between the two ports. If a hardirq
> preempts a CPU while it holds this lock during a transmission, and the
> interrupt handler invokes a printk that triggers netconsole over the second
> interface, netpoll might bypass the netif_tx_lock.
> 
> When the second interface calls into ndo_start_xmit, it would attempt to
> acquire the exact same lre_host_queue_lock, causing it to spin forever on
> the same CPU.
> --
> This is an AI-generated review.

We are in the process of reviewing the comments and will revert with additional
details.

Thanks and Regards,
Parvathi.

