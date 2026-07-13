Return-Path: <netdev+bounces-307145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BGQ4Fl3aVGp4fwAAu9opvQ
	(envelope-from <netdev+bounces-307145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:30:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC8F74AF3C
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:30:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=couthit.com header.s=default header.b=pBXFHGa7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307145-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307145-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=couthit.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 100443004C40
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 12:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C299737BE93;
	Mon, 13 Jul 2026 12:29:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC42C3B777C;
	Mon, 13 Jul 2026 12:29:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783945787; cv=none; b=XcbJY8kXmNweJLR9nwTrFOQfVADqD/NNgYgg8p07d+piq2oi9LTuH/WwSq7fBlyEjPRYaxIf4SmFK09/Rrvq3kZoHB2noMGJzQRiNu2xi0Qt+tp4cVjb7A1XSLTNdLK8FFCV00/cIll0w8XUFFgwRKmn2vE+lA3b89XhkauhQbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783945787; c=relaxed/simple;
	bh=oBgqATq3GIdMy7Ts6x9ygNGialkR1vzQ72PYG61yqxg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=fUPIMLI5wWu/DZFJ4n3t2qzTf1h58+XlsPSQiZQY64hE/+N6o3NtZUowVOaJyKZzJg/+9VWd690TA98xc8+SJxwktGY1BGrxBkK1ejXBXAm2GTJyujo4uj9PVeLCNhH7py2e+s+0NT7YJ5/aKFG49Y86IM2pnaqYUb7ESe0IM5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=pBXFHGa7; arc=none smtp.client-ip=162.240.164.96
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=MEoghO6DKcYJ3gtElMHXVzyQZsxc1IHoy0snnxngGUY=; b=pBXFHGa727XQvK5QZKaiQP5A8Q
	YlWaDcd1s93nCzhXL7+JPJ8nevHemGYdav5OVT0O3qILY+/BWd1PNseD+5z8DzioWlXMKMgKxXPOx
	I89hqOUmlMR41Agb6QeVh5xzyn7gwdN/17AL19DEY92aCOX0CuRD7+WrALbAYbEcUemdNfRtZnAz8
	QI6ptstuliRIrq1mfJefEKazxBrwAdYojlMEGBlhRSCim9AR7LYTzRVhURU3tbZUkDGQgDoZ32x//
	IzPWPpicxsEXn7iQpXLN0F3rHVljXmvfpr8snEH+AA4UyWwFslwUkS0Ps/kKJ/fgioLDnDT0qk2lq
	SZZ6Pn1g==;
Received: from [115.246.246.98] (port=25352 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <parvathi@couthit.com>)
	id 1wjFmx-00000001pHV-38Jt;
	Mon, 13 Jul 2026 08:29:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 2162819A8839;
	Mon, 13 Jul 2026 17:59:29 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10032)
 with ESMTP id lIDa7_A2Ll5o; Mon, 13 Jul 2026 17:59:25 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id DA83B19A8829;
	Mon, 13 Jul 2026 17:59:25 +0530 (IST)
X-Virus-Scanned: amavis at couthit.local
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10026)
 with ESMTP id qdqu0BYvnsEm; Mon, 13 Jul 2026 17:59:25 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id B54C919A8839;
	Mon, 13 Jul 2026 17:59:25 +0530 (IST)
Date: Mon, 13 Jul 2026 17:59:25 +0530 (IST)
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
Message-ID: <1899283663.1625256.1783945765645.JavaMail.zimbra@couthit.local>
In-Reply-To: <20260706091314.134721-1-pabeni@redhat.com>
References: <20260630124958.894360-2-parvathi@couthit.com> <20260706091314.134721-1-pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 1/3] net: ti: icssm-prueth: Add HSR and PRP
 HW offload mode support for AM57xx, AM437x and AM335x
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_ZEXTRAS_20240927 (ZimbraWebClient - GC138 (Linux)/9.0.0_ZEXTRAS_20240927)
Thread-Topic: icssm-prueth: Add HSR and PRP HW offload mode support for AM57xx, AM437x and AM335x
Thread-Index: hO9x2DXJcluP7d/Drv326ojJYclQBg==
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[couthit.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:parvathi@couthit.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:danishanwar@ti.com,m:rogerq@kernel.org,m:pmohan@couthit.com,m:afd@ti.com,m:basharath@couthit.com,m:arnd@arndb.de,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:pratheesh@ti.com,m:j-rameshbabu@ti.com,m:vigneshr@ti.com,m:praneeth@ti.com,m:srk@ti.com,m:rogerq@ti.com,m:m-malladi@ti.com,m:krishna@couthit.com,m:mohan@couthit.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,couthit.local:mid];
	HAS_X_AS(0.00)[smtp@couthit.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_X_GMSV(0.00)[smtp@couthit.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[parvathi@couthit.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307145-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3FC8F74AF3C

Hi,

> From: AI Reviewer <ai@example.com>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev/
> ---
> Subject: net: ti: icssm-prueth: Add HSR and PRP HW offload mode support for
> AM57xx, AM437x and AM335x
> 
> This commit introduces hardware offload support for the HSR and PRP redundancy
> protocols on TI PRU-ICSS Ethernet MACs. It enables firmware-based frame
> duplicate detection and L2 forwarding, treating PRU Ethernet ports as Link
> Redundancy Entity (LRE) slaves. The driver can now dynamically switch between
> dual-EMAC, switch, and HSR/PRP modes.
> 
>> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> [ ... ]
>> @@ -564,7 +592,7 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac *emac,
> [ ... ]
>>         /* update first buffer descriptor */
>>  	wr_buf_desc = (pktlen << PRUETH_BD_LENGTH_SHIFT) &
>>  		       PRUETH_BD_LENGTH_MASK;
>> +	if (PRUETH_IS_HSR(prueth))
>> +		wr_buf_desc |= BIT(PRUETH_BD_HSR_FRAME_SHIFT);
> 
> [Severity: High]
> Does padding small packets with eth_skb_pad() in icssm_emac_ndo_start_xmit()
> interfere with PRP trailer detection here?
> 
> When a short PRP frame is padded to 60 bytes in icssm_emac_ndo_start_xmit(),
> the zero-padding is appended after the RCT. Later, in
> icssm_prueth_tx_enqueue(), the driver attempts to read the RCT like this:
> 
>    struct prp_txopt_rct *rct =
>        (struct prp_txopt_rct *)(skb_tail_pointer(skb) - ICSSM_LRE_TAG_SIZE);
> 
> Won't this calculation point into the trailing zero-padding instead of the
> actual RCT? This would cause small PRP frames to bypass redundancy
> duplication.

No, eth_skb_pad() doesn't interfere with PRP trailer detection.

The kernel's HSR/PRP layer always pads a short frame to 60 bytes first, and only
then appends the 6-byte RCT trailer on top. So the trailer is always the last 6
bytes, and by the time this driver sees the frame it's already past 60 bytes.
This padding call never fires and the RCT read is always correct. Not an issue.

> 
> [ ... ]
>> @@ -912,6 +963,25 @@ static int icssm_emac_request_irqs(struct prueth_emac
>> *emac)
>>  	return ret;
>>  }
>>  
>> +static int icssm_emac_sanitize_feature_flags(struct prueth_emac *emac)
>> +{
>> +	netdev_features_t request_lre;
>> +
>> +	request_lre = emac->ndev->features & NETIF_PRUETH_LRE_OFFLOAD_FEATURES;
>> +
>> +	if (prueth_is_lre(emac->prueth) && !request_lre) {
>> +		netdev_err(emac->ndev, "Error: Turn ON HSR offload\n");
>> +		return -EINVAL;
>> +	}
> 
> [Severity: Medium]
> Is this check sufficient to handle partial feature toggling?
> 
> If a user disables NETIF_F_HW_HSR_TAG_RM via ethtool while leaving
> NETIF_F_HW_HSR_FWD active, request_lre will still evaluate to non-zero and
> bypass this validation. Since the firmware unconditionally strips the tag,
> could this mismatched configuration cause the software stack to misinterpret
> the inner IP header as an HSR tag?

We will address this in the next version.

> 
> [ ... ]
>> @@ -1079,6 +1162,9 @@ static int icssm_emac_ndo_stop(struct net_device *ndev)
>>  	else
>>  		rproc_shutdown(emac->pru);
>>  
>> +	if (prueth_is_lre(prueth))
>> +		icssm_prueth_lre_cleanup(prueth);
> 
> [Severity: High]
> Could this unconditionally cancel the global HSR/PRP duplicate table check
> timer while the other LRE port is still running?
> 
> If eth0 is brought down, the timer is canceled here, but if eth1 remains
> active, the duplication tables could silently fill up and drop legitimate
> frames because the check timer is never restarted.

We will address this in the next version.

> 
> [ ... ]
>> @@ -1122,7 +1208,8 @@ static int icssm_prueth_change_mode(struct prueth *prueth,
>>  		}
>>  	}
>>  
>> -	if (mode == PRUSS_ETHTYPE_EMAC || mode == PRUSS_ETHTYPE_SWITCH) {
>> +	if (mode == PRUSS_ETHTYPE_EMAC || mode == PRUSS_ETHTYPE_SWITCH ||
>> +	    mode == PRUSS_ETHTYPE_HSR || mode == PRUSS_ETHTYPE_PRP) {
> 
> [Severity: High]
> This is a pre-existing issue, but can the direct invocation of ndo_open() and
> ndo_stop() inside icssm_prueth_change_mode() cause a deadlock?
> 
> If ndev->netdev_ops->ndo_open(ndev) fails and returns an error, the function
> aborts without restoring the NAPI state. Later, when the interface is brought
> down, the kernel naturally invokes ndo_stop() again. A second napi_disable()
> call on an already disabled NAPI might trigger an infinite sleep waiting for
> NAPI_STATE_SCHED.

Yes, this is causing a deadlock. icssm_prueth_change_mode() already existed before
this series and this patch series only adds two more mode values to an existing check,
it doesn't touch the open/stop logic itself. We will fix it as its own separate
patch later, instead of mixing it into this HSR/PRP series.

> 
> [ ... ]
>> @@ -1360,6 +1465,8 @@ static void icssm_emac_ndo_set_rx_mode(struct net_device
>> *ndev)
> [ ... ]
>>  	/* It is a shared table. So lock the access */
>> -	spin_lock_irqsave(&emac->addr_lock, flags);
>> +	spin_lock_irqsave(mc_filter_tbl_lock, flags);
>>  
>>  	/* Disable and reset multicast filter, allows allmulti */
>>  	icssm_emac_mc_filter_ctrl(emac, false);
> 
> [Severity: High]
> Does this function corrupt the shared multicast hardware filter table in LRE
> mode?
> 
> By calling icssm_emac_mc_filter_reset() the shared table in DRAM1 is cleared.
> The code then repopulates the table by iterating only over the current
> net_device's multicast addresses. Could this silently drop multicast traffic
> for the other active slave port since its addresses are wiped out?

No, this is safe in LRE mode. Although icssm_emac_mc_filter_reset() clears the
shared multicast filter table in DRAM1, it is rebuilt right away from the current
net_device's multicast list. 

The HSR/PRP layer keeps the multicast lists of both slave ports in sync by copying
the master's list whenever it changes, so both ports always have the same multicast
addresses. That means rebuilding the shared table from either port's list restores
all the required entries and does not drop multicast addresses needed by the other port.

> 
> [ ... ]
>> +static int icssm_prueth_hsr_port_link(struct net_device *ndev,
>> +				      struct net_device *hsr_ndev)
>> +{
> [ ... ]
>> +	spin_lock_irqsave(&emac->addr_lock, flags);
>> +
>> +	if (!prueth->hsr_members) {
> 
> [Severity: Low]
> Is the per-port emac->addr_lock the correct lock to use when modifying the
> device-wide shared state in prueth->hsr_members and prueth->hsr_dev?
> 
> While the networking core's global rtnl_lock might serialize this path during
> NETDEV_CHANGEUPPER, using a local instance lock to protect global state could
> be a maintainability hazard.

We will address this in the next version.

> 
> [ ... ]
>> +free_hsr:
>> +	spin_lock_irqsave(&emac->addr_lock, flags);
>> +
>> +	prueth->hsr_dev = NULL;
>> +	prueth->hsr_members &= ~BIT(emac->port_id);
>> +
>> +	spin_unlock_irqrestore(&emac->addr_lock, flags);
>> +	return ret;
>> +}
> 
> [Severity: High]
> If adding the second HSR/PRP port fails (e.g., during
> icssm_prueth_change_mode), does this error path corrupt the bridge state?
> 
> Unconditionally clearing the shared prueth->hsr_dev pointer while the first
> port is still present in prueth->hsr_members appears to permanently break
> subsequent link attempts for the second port, because future links will fail
> on the earlier condition:
> 
>    if (prueth->hsr_dev != hsr_ndev)
> --

We will address this in the next version.

Thanks and Regards,
Parvathi.

