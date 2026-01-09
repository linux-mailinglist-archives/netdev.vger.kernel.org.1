Return-Path: <netdev+bounces-248513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 039D7D0A77D
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 14:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA553304A8C6
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 13:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B18350A37;
	Fri,  9 Jan 2026 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="YTAL0+Ca"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CAC32BF21;
	Fri,  9 Jan 2026 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767965913; cv=none; b=afIFaU/zSlRyYC1PzsiiHWU5IPbysG3CkRwDIraEhimogYMR+b0AHJ4nIfVk8XZJjbdPMrj0TCpa3GJiSZanhNpgVKBzMNDjbi/R4NzgPM1YHRkcoLhRsbFHKWzWwfnfXZELJwD2DVfpukRmbdQbOm+21Fwuq5mE6XliyyQgcF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767965913; c=relaxed/simple;
	bh=n6n0GxvxhFH5FiFRsBLmMGo0bgOfZDK+zLx4X3KlIxA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=p6QJqeeBxMIcEhMkb5Es8+hD7KdcGv7EdU797PbYkicoDYLqmL+9UQ5Z1lLk1xjxifumrcdNVTbY/yCx8L1ZSwWcVnZl5QwhBM23jJoSI1tBDeMevl2v3aexkP7vFp6qXscBapVvKrmAYcQkkUR8SgL1gKnB2GGyCZvkMXatQKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=YTAL0+Ca; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=jzCNQyXXMi5hwZ8PwrIomidmWToeGC4NRFpddV19ges=; b=YTAL0+CaomnDGZZ5XBWL5NPrlN
	J98hNz9x0nLokf6b5sEeR0FcyxWu+NXbR+T/Sg4e0Oxh2bnu4hgITrgq9xDDMKSs0FK/3DozVK6NX
	72DO+xPw1hVqBWYPAqx40CdN8tB1Fo/flLZAxxqQFyefMc2bWCNurz+85U8Eqn7Li3uQW9ahDkcU+
	ZKtTiNTcm4CE1ZxOsPJop0nLPgJ04BNXnM7Ht0CD0FodXGLTljqCSM5VRfxfWGf26wxmCZQIoDXbQ
	/najW2O76qgQr0GxZvl/AamGy2noMicAjn+0qsxuO586jD1/s4AIPjU4K5qmCgFMb3aDDC3f80wnL
	8xmRMpWA==;
Received: from [122.175.9.182] (port=48590 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1veChA-00000000ymB-0Ssm;
	Fri, 09 Jan 2026 08:38:28 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id D68891A87E0F;
	Fri,  9 Jan 2026 19:08:21 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10032)
 with ESMTP id btYwLIfbUPGt; Fri,  9 Jan 2026 19:08:20 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 462241A87E0D;
	Fri,  9 Jan 2026 19:08:20 +0530 (IST)
X-Virus-Scanned: amavis at couthit.local
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10026)
 with ESMTP id stijPET9I-S2; Fri,  9 Jan 2026 19:08:20 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 24E7E1A87E0E;
	Fri,  9 Jan 2026 19:08:20 +0530 (IST)
Date: Fri, 9 Jan 2026 19:08:20 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Parvathi Pudi <parvathi@couthit.com>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	kuba <kuba@kernel.org>, danishanwar <danishanwar@ti.com>, 
	rogerq <rogerq@kernel.org>, pmohan <pmohan@couthit.com>, 
	basharath <basharath@couthit.com>, afd <afd@ti.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	ALOK TIWARI <alok.a.tiwari@oracle.com>, horms <horms@kernel.org>, 
	pratheesh <pratheesh@ti.com>, j-rameshbabu <j-rameshbabu@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, mohan <mohan@couthit.com>
Message-ID: <951229905.101031.1767965900074.JavaMail.zimbra@couthit.local>
In-Reply-To: <a1341a4b-3ad0-43dd-adff-66d7d90be471@redhat.com>
References: <20260105122549.1808390-1-parvathi@couthit.com> <20260105122549.1808390-4-parvathi@couthit.com> <a1341a4b-3ad0-43dd-adff-66d7d90be471@redhat.com>
Subject: Re: [PATCH net-next v11 3/3] net: ti: icssm-prueth: Add support for
 ICSSM RSTP switch
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_ZEXTRAS_20240927 (ZimbraWebClient - GC138 (Linux)/9.0.0_ZEXTRAS_20240927)
Thread-Topic: icssm-prueth: Add support for ICSSM RSTP switch
Thread-Index: 2yq6qhM507at40oktu8mVZ/W/fKYfA==
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

Hi,

> On 1/5/26 1:23 PM, Parvathi Pudi wrote:
>> +static int icssm_prueth_ndev_port_link(struct net_device *ndev,
>> +				       struct net_device *br_ndev)
>> +{
>> +	struct prueth_emac *emac = netdev_priv(ndev);
>> +	struct prueth *prueth = emac->prueth;
>> +	unsigned long flags;
>> +	int ret = 0;
>> +
>> +	dev_dbg(prueth->dev, "%s: br_mbrs=0x%x %s\n",
>> +		__func__, prueth->br_members, ndev->name);
>> +
>> +	spin_lock_irqsave(&emac->addr_lock, flags);
>> +
>> +	if (!prueth->br_members) {
>> +		prueth->hw_bridge_dev = br_ndev;
>> +	} else {
>> +		/* This is adding the port to a second bridge,
>> +		 * this is unsupported
>> +		 */
>> +		if (prueth->hw_bridge_dev != br_ndev) {
>> +			spin_unlock_irqrestore(&emac->addr_lock, flags);
>> +			return -EOPNOTSUPP;
>> +		}
>> +	}
>> +
>> +	prueth->br_members |= BIT(emac->port_id);
>> +
>> +	ret = icssm_prueth_port_offload_fwd_mark_update(prueth);
> 
> More AI generated feedback here that still looks valid to me:
> 
> """
> ndo_stop() can sleep (e.g., via rproc_shutdown()). This function appears
> to be called while holding a spinlock via the call chain:
> 
>  icssm_prueth_ndev_port_link()
>    -> spin_lock_irqsave(&emac->addr_lock)
>      -> icssm_prueth_port_offload_fwd_mark_update()
>        -> icssm_prueth_change_mode()
>          -> ndo_stop() / ndo_open()
> 
> Is this intentional? The ndo_open() path also calls
> icssm_prueth_sw_init_fdb_table() which does kmalloc(GFP_KERNEL) and
> rproc_boot(), both of which may sleep.
> """
> 
> There are other similar cases; for the full report see:
> 
> https://netdev-ai.bots.linux.dev/ai-review.html?id=ce23f731-f25b-4082-a5d0-c1261ab829ed
> 
> /P

Sure, we will review them and address the applicable changes in the next version.

Thanks and Regards,
Parvathi.


