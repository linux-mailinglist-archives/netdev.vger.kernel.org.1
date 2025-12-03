Return-Path: <netdev+bounces-243374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EE8C9E42F
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 09:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DEA45347C00
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 08:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484272D5937;
	Wed,  3 Dec 2025 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="JuyGi7L9"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CCC2D4B71;
	Wed,  3 Dec 2025 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764751250; cv=none; b=CBMu5989Y15bavdSx4G+4bLA5WNgxinDPpjj4aSzVx7wGOLqmWCZy1ZHKFYozSNLhda9sXiQmo5Drh9EoxxgjOjdEk1iVJ9FN+HOuBXlT4RKOLHffRKVqa8QZD/HGtnWtKBBtxkkvK4XAC4HU1BnCPgmj0PaIIIe8rzSepk/TvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764751250; c=relaxed/simple;
	bh=zAWFdDCUc7FVBfE/OzA0hVguq1urTNMRL7pUnJTSU8I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=DDCOa/qy9Nze5WPPHNBdCgv4MIlFIPdKq0y98YUDKoOISTK+Dj9D9HJtrxlhw4T7OqNJ42r94bGIT9E6fGtfHGpwiiBlmmQnyYDrjMDpEUgL7WE85+6Oc9zFPRxUPS7go9WIhbDu55yut4+8+C4qVAJRyH0JtzLKFQmVAlv8ToQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=JuyGi7L9; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/c4X3Sg9mK9CRq2MBgU2yKHdubh7UouDbU2leoDMNXc=; b=JuyGi7L9fozo4eA1IjFJSmVGep
	Sj8guFkJYbm2pqpoZhSYv+LPz+zAT8lmWksSBDEefg+c5BRt8iddIcnPibuqQV0w6O6PkeUHd/wG7
	LdvDcc6R0LQCC6nblxMofHG/+XE0jrHtb99GuQw5ZoYr+biEgiJ8azllFP0ANRIvb3sSvS1syRnCC
	FRVTrzcJbijltMFiSnYUV4CiaWrf4Z2CveRLNtYsOMBTJjn951aC7frRWHcp1yxI0tnLanpgCcE0n
	UeasMhyWuWdTEcldxdVx/aISn4s2n6+RA0i9VFHoPv23iW4Z4itHnquKQ35p5doUWyV6ow9W3gZQs
	QJxG0vTw==;
Received: from [122.175.9.182] (port=24722 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1vQiPl-00000001czT-2Sfy;
	Wed, 03 Dec 2025 03:40:45 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 617EB1A655AA;
	Wed,  3 Dec 2025 14:10:41 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10032)
 with ESMTP id B7HvcGkoo9CQ; Wed,  3 Dec 2025 14:10:41 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 345D11A6575D;
	Wed,  3 Dec 2025 14:10:41 +0530 (IST)
X-Virus-Scanned: amavis at couthit.local
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Vdxto11muIzS; Wed,  3 Dec 2025 14:10:41 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 13FB61A655AA;
	Wed,  3 Dec 2025 14:10:41 +0530 (IST)
Date: Wed, 3 Dec 2025 14:10:41 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Parvathi Pudi <parvathi@couthit.com>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	pabeni <pabeni@redhat.com>, danishanwar <danishanwar@ti.com>, 
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
Message-ID: <1648322401.84640.1764751241037.JavaMail.zimbra@couthit.local>
In-Reply-To: <20251201141858.399fff62@kernel.org>
References: <20251126163056.2697668-1-parvathi@couthit.com> <20251126163056.2697668-2-parvathi@couthit.com> <20251201141858.399fff62@kernel.org>
Subject: Re: [PATCH net-next v8 1/3] net: ti: icssm-prueth: Add helper
 functions to configure and maintain FDB
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_ZEXTRAS_20240927 (ZimbraWebClient - GC138 (Linux)/9.0.0_ZEXTRAS_20240927)
Thread-Topic: icssm-prueth: Add helper functions to configure and maintain FDB
Thread-Index: eFQMmBav/YIGb0NrzZQd7Bcuvs/4Pg==
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

> On Wed, 26 Nov 2025 21:57:12 +0530 Parvathi Pudi wrote:
>> +	u8 hash_val, mac_tbl_idx;
> 
> Using narrow types is generally quite counter productive.
> It can easily mask out-of-range accesses and subtle errors,
> given that max is outside of the range of the u8 type:
> 
> +#define FDB_INDEX_TBL_MAX_ENTRIES     256
> +#define FDB_MAC_TBL_MAX_ENTRIES       256
> 
> You should consider changing all the local variables to unsigned int.

OK, we will update the code to use unsigned int for relevant local
variables to avoid any silent errors.

Thanks and Regards,
Parvathi.

