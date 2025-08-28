Return-Path: <netdev+bounces-217941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2C4B3A758
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 19:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97456207A90
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 17:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317A0334726;
	Thu, 28 Aug 2025 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="mQpbwAPY"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA68245006;
	Thu, 28 Aug 2025 17:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756401164; cv=none; b=R7ohoiCmpopSPLmSdM7n4G0ob4NM5WLQCgTtyKvI2oqRM+5mEwveye2uMeHwQB39KC5qkE5YRWmG6GiBSBn27u+MdKcS0+ksklXS3UND0ee0QFrzae5juX18ifGZJKEQbYQrQF7rzT2clkzac/v15tscfTuByyzSt0mk2yVflT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756401164; c=relaxed/simple;
	bh=607nQO2d/RCimAs/OiQ2CTUxEUa/slx1dU3exOvrtZ4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=TqtAkcxH8lO3cpGE6GvdM50dwDvDHacia+m8WYVqLuHgQ+gVKosPEewLSZ9T7GIvcGwcoBawg1lmrLQwTc/Ohra/qlUHICqwdSmmR644thaS+UmQU7wiSgmG8q8uXzo3ASrbtUuigLzCnScRM7ahuOIVJIrB5qLjcid1tzieiKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=mQpbwAPY; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3w+R1zOuJPY71/KjLfkxWemnLW1oSrZqC7s9lCEBRtY=; b=mQpbwAPYB1wWBpiNJnJ3ZURQRE
	g9G72BFuIZwI3WmiDEtPaj4u0YDZGLQ31Eo2Kv7TzHKJoJLg7xygkX+Tr2FerBdNV5G73iaGTx1Ar
	iZWNExlCxfCOSs8Fj2HiTADJ5OL8mL/969t6raSzp94ImYL9Bwm6YfX5wWgoRtS5Eu2MGi8yWL8uO
	IeCZGM58IQO8A2Tz/XKnMRIM77rwwDpxOnDgzGaBU1I8kxnf8cITNdyDYX/p+Lw96tNepoBx6bV7Q
	LCT3CQXb3/3OmY0VmPerkJ5tw4FvAbuYP3a+TG24osxDVFfkGgyDYtI6l7kJwjpndFmMHFlDRhl5f
	V9gxXWOw==;
Received: from [122.175.9.182] (port=8338 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1urgAi-00000006HIe-3TIO;
	Thu, 28 Aug 2025 13:12:25 -0400
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id 1C3841781C63;
	Thu, 28 Aug 2025 22:42:18 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id D57421781F94;
	Thu, 28 Aug 2025 22:42:17 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 33U0h1areI3V; Thu, 28 Aug 2025 22:42:17 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 796361781C63;
	Thu, 28 Aug 2025 22:42:17 +0530 (IST)
Date: Thu, 28 Aug 2025 22:42:17 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: kuba <kuba@kernel.org>
Cc: danishanwar <danishanwar@ti.com>, rogerq <rogerq@kernel.org>, 
	andrew+netdev <andrew+netdev@lunn.ch>, davem <davem@davemloft.net>, 
	edumazet <edumazet@google.com>, pabeni <pabeni@redhat.com>, 
	robh <robh@kernel.org>, krzk+dt <krzk+dt@kernel.org>, 
	conor+dt <conor+dt@kernel.org>, ssantosh <ssantosh@kernel.org>, 
	richardcochran <richardcochran@gmail.com>, 
	m-malladi <m-malladi@ti.com>, s hauer <s.hauer@pengutronix.de>, 
	afd <afd@ti.com>, jacob e keller <jacob.e.keller@intel.com>, 
	horms <horms@kernel.org>, johan <johan@kernel.org>, 
	m-karicheri2 <m-karicheri2@ti.com>, s-anna <s-anna@ti.com>, 
	glaroque <glaroque@baylibre.com>, 
	saikrishnag <saikrishnag@marvell.com>, 
	kory maincent <kory.maincent@bootlin.com>, 
	diogo ivo <diogo.ivo@siemens.com>, 
	javier carrasco cruz <javier.carrasco.cruz@gmail.com>, 
	basharath <basharath@couthit.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	netdev <netdev@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	ALOK TIWARI <alok.a.tiwari@oracle.com>, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	pratheesh <pratheesh@ti.com>, Prajith Jayarajan <prajith@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, pmohan <pmohan@couthit.com>, 
	mohan <mohan@couthit.com>
Message-ID: <1892122434.246137.1756401137255.JavaMail.zimbra@couthit.local>
In-Reply-To: <20250827090820.12a58d22@kernel.org>
References: <20250822132758.2771308-1-parvathi@couthit.com> <20250822144023.2772544-5-parvathi@couthit.com> <20250827090820.12a58d22@kernel.org>
Subject: Re: [PATCH net-next v14 4/5] net: ti: icssm-prueth: Adds link
 detection, RX and TX support.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - GC138 (Linux)/8.8.15_GA_3968)
Thread-Topic: icssm-prueth: Adds link detection, RX and TX support.
Thread-Index: 04+NkdyMJsTY7VdcDfyHFa/DcZsalw==
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

> On Fri, 22 Aug 2025 20:09:16 +0530 Parvathi Pudi wrote:
>> +	struct net_device_stats *ndevstats;
> 
>> +	ndevstats = &emac->ndev->stats;
> 
> Please don't use netdev stats, quoting the header:
> 
>	struct net_device_stats	stats; /* not used by modern drivers */
> 
> Store the counters you need in driver's private struct and implement
> .ndo_get_stats64
> 

sure, we will verify and use the suggested approach.

>> +	if (!pkt_info->sv_frame) {
> 
> sv_frame seems to always be false at this stage?
> Maybe delete this diff if that's the case, otherwise it feels like
> the skb_free below should be accompanied by some stat increment.
> 

Yes, We will remove this for now.

>> +		skb_put(skb, actual_pkt_len);
>> +
>> +		/* send packet up the stack */
>> +		skb->protocol = eth_type_trans(skb, ndev);
>> +		netif_receive_skb(skb);
>> +	} else {
>> +		dev_kfree_skb_any(skb);
>> +	}
> 
> The rest LGTM.


Thanks and Regards
Parvathi.

