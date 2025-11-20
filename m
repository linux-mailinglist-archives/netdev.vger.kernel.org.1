Return-Path: <netdev+bounces-240304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D903C7256C
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 07:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B2D24351282
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 06:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D365D2E0B58;
	Thu, 20 Nov 2025 06:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="f1tpEB+p"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A8D19FA93;
	Thu, 20 Nov 2025 06:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763619968; cv=none; b=QrEUee4TyMxFKO8fx0LIS9zK9Y+c7fCSQUnAXwN0qE94bJl8NmUgddhjqOL0STDSmPJ6eWv2bMMJWQloU3e110OrEgmz7gKH/620A8irVjdnj1tb/bsppuIk0RAUdacaF4RnW5U/qwfegRPrYc9MIjeNcc9iWRcERX3CXhEO9rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763619968; c=relaxed/simple;
	bh=vKwfarhR6jLUpQqtMoqAdKlj7LGHIrrJer6AUxIdpcE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=PZyWvfNV7cowv1C9bmwx4v2GUzl2/Dm1dkugO54aRqkGSqGXbPH8YKa1s2pQRydUWAp5m7CEz9Mi8grIfdo+WkhdIRO8HpA2wPIsRwJUqEOQdJBWEil9tCc+O6ZcukPLK+hGd44uG+hFhhCALG1aGLnCyqrboOn1X4N5ndwIGPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=f1tpEB+p; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kv50Yi92TJYc/2wkVx9y8CSyBdscL+zkddlWIcgDCos=; b=f1tpEB+pR0E4GIPzVPgwsc14aB
	KCdRzupP4uIs2M1M7T8+0kc++1vlU86QGC+rSRS5Nj6YrmSMSKsEva/m63Sn+MgqO9cwb8F9gulKq
	lA1lvXr9k0emQx2fmfaKnGkfQvhS2/1Ipq7ICZwdNx30hiP6/5zClj+znzkV3ZV30DiOfo0dX1Ijo
	x0fxLqqQu/LdrI0Wg272t138kY3qZYyOeOvvsT5JmSIpLF3ruFR+WJXbj6QNt+6nhXvKUeWAoWHzU
	QBvwqCQNURTPu9tqXENCEC98i3yjTi1q9TfJpLVlzdoK5rtKe/1BYRF2/nZh4l45ulyKbuFlPLmVe
	UJOeBLeg==;
Received: from [122.175.9.182] (port=39728 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1vLy7I-00000004wzo-1KXt;
	Thu, 20 Nov 2025 01:26:04 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 96FD51A681B6;
	Thu, 20 Nov 2025 11:55:51 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10032)
 with ESMTP id i_MBSIC7OPKA; Thu, 20 Nov 2025 11:55:51 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 4C7F51A681B4;
	Thu, 20 Nov 2025 11:55:51 +0530 (IST)
X-Virus-Scanned: amavis at couthit.local
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10026)
 with ESMTP id IclgSBfrVVcw; Thu, 20 Nov 2025 11:55:51 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 251461A681B6;
	Thu, 20 Nov 2025 11:55:51 +0530 (IST)
Date: Thu, 20 Nov 2025 11:55:51 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: Simon Horman <horms@kernel.org>
Cc: Parvathi Pudi <parvathi@couthit.com>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	kuba <kuba@kernel.org>, pabeni <pabeni@redhat.com>, 
	danishanwar <danishanwar@ti.com>, rogerq <rogerq@kernel.org>, 
	pmohan <pmohan@couthit.com>, basharath <basharath@couthit.com>, 
	afd <afd@ti.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	ALOK TIWARI <alok.a.tiwari@oracle.com>, pratheesh <pratheesh@ti.com>, 
	j-rameshbabu <j-rameshbabu@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, mohan <mohan@couthit.com>
Message-ID: <1355121310.5320.1763619951092.JavaMail.zimbra@couthit.local>
In-Reply-To: <aRuO-ib0us1JCrxc@horms.kernel.org>
References: <20251113101229.675141-1-parvathi@couthit.com> <20251113101229.675141-4-parvathi@couthit.com> <aRuO-ib0us1JCrxc@horms.kernel.org>
Subject: Re: [PATCH net-next v5 3/3] net: ti: icssm-prueth: Adds support for
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
Thread-Topic: icssm-prueth: Adds support for ICSSM RSTP switch
Thread-Index: 4DYZE/NR6J02f92V0LtZKAFjn//LuQ==
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

> On Thu, Nov 13, 2025 at 03:40:23PM +0530, Parvathi Pudi wrote:
> 
> ...
> 
>> @@ -1012,17 +1074,77 @@ static int icssm_emac_ndo_stop(struct net_device *ndev)
>>  	hrtimer_cancel(&emac->tx_hrtimer);
>>  
>>  	/* stop the PRU */
>> -	rproc_shutdown(emac->pru);
>> +	if (!PRUETH_IS_EMAC(prueth))
>> +		icssm_prueth_sw_shutdown_prus(emac, ndev);
>> +	else
>> +		rproc_shutdown(emac->pru);
>> +
>> +	/* free table memory of the switch */
>> +	if (PRUETH_IS_SWITCH(emac->prueth))
>> +		icssm_prueth_sw_free_fdb_table(prueth);
> 
> The conditional block above appears to open-code icssm_prueth_free_memory()
> which is also called below. I don't think this this duplication causes
> any harm, as it looks like the second, indirect, call to
> icssm_prueth_sw_free_fdb_table() will be a noop. But it does seem
> unnecessary.
> 

Sure. We will address this and remove the duplicate code.


Thanks and Regards,
Parvathi.

