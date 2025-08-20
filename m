Return-Path: <netdev+bounces-215259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C040CB2DD62
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 15:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626E15E804A
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 13:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E24C3093CB;
	Wed, 20 Aug 2025 13:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="CU2fgwUW"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5097242D9E;
	Wed, 20 Aug 2025 13:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755695320; cv=none; b=bxWWKQZIHf6DiLwpi7l2bW59tNOxSBIcd0Knmcsf5A5lDk209gw8SXGxPj09tKlrS54TGIOiosvPv8ifxtow+3FvpSiHnKHbAqyp2qmg2MevFxOcrWdedEZKlseCkHqnhTvAKITKyOKEXDMNf5qANBgFWk8nLg+dROldAkzzQeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755695320; c=relaxed/simple;
	bh=tYLXLwBiTvj3SVfvw7xo/j++DN4t6QK+4GQmepz/7aw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=QuCG6kPdmnU6rMdlxOGVYoRgJr3y9V2VQ8UpI7y8IBCdJbHZkKrs5GJ/9g4704fqxHrbaoK/U5Y4zhX9PHHiu8QCTU2A1V8kaErctOifCiEHzJo6CaBA2eZ7IUFnaDrGBTkeEuRuFwPa9dKpWSdXlrn2ZBgp1cNWhab+gLru19I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=CU2fgwUW; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Kjyyibg+wnsB9xvjdEV1H8HvE9Jnw2qmWLH9c5mLoEg=; b=CU2fgwUW+jWZmeRnhjwoWTpuFM
	ABZ7xClo+oMu9gFyv3so9YBfaiwHpECY8HzfCgyBGmWYNrdnTiJwgkOs9DQ8G2KC/fUMKMoYIOGhj
	RE187O8Y4wl0BRCg6uu8SWDRJOo/ZLk+GUFImIfQuVJuJm8DX22f9G7XRsl5XRhtm1UeEpOa0hYNE
	8k+ZSCX4fk/rnyD0goX1zuBsLgT/raxu/nDlaqqXmN/gwP0MGkb6TSQ5B2F6DrlRJJF8N8gvpRqdg
	rUUHOc17XgFUG9//riERJikPBR/qwT8OrwEbhj2x9XkgiJLpWphsPYtGnzvXff/sFaWh6iw6vlyy+
	nfyhragw==;
Received: from [122.175.9.182] (port=64641 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1uoiYC-0000000GE8f-2wAe;
	Wed, 20 Aug 2025 09:08:24 -0400
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id 5878E1781A82;
	Wed, 20 Aug 2025 18:38:18 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 32FE417823F4;
	Wed, 20 Aug 2025 18:38:18 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ygfb58BmiwQo; Wed, 20 Aug 2025 18:38:18 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id D5D421781A82;
	Wed, 20 Aug 2025 18:38:17 +0530 (IST)
Date: Wed, 20 Aug 2025 18:38:17 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: kuba <kuba@kernel.org>
Cc: parvathi <parvathi@couthit.com>, danishanwar <danishanwar@ti.com>, 
	rogerq <rogerq@kernel.org>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	pabeni <pabeni@redhat.com>, robh <robh@kernel.org>, 
	krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>, 
	ssantosh <ssantosh@kernel.org>, 
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
Message-ID: <1714979234.207867.1755695297667.JavaMail.zimbra@couthit.local>
In-Reply-To: <20250818084020.378678a7@kernel.org>
References: <20250812110723.4116929-1-parvathi@couthit.com> <20250812133534.4119053-5-parvathi@couthit.com> <20250815115956.0f36ae06@kernel.org> <1969814282.190581.1755522577590.JavaMail.zimbra@couthit.local> <20250818084020.378678a7@kernel.org>
Subject: Re: [PATCH net-next v13 4/5] net: ti: prueth: Adds link detection,
 RX and TX support.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - GC138 (Linux)/8.8.15_GA_3968)
Thread-Topic: prueth: Adds link detection, RX and TX support.
Thread-Index: rWG3COPtPBb60rDF6O1ULILOZDFtmA==
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

> On Mon, 18 Aug 2025 18:39:37 +0530 (IST) Parvathi Pudi wrote:
>> +       if (num_rx_packets < budget && napi_complete_done(napi, num_rx_packets))
>>                 enable_irq(emac->rx_irq);
>> -       }
>>  
>>         return num_rx_packets;
>>  }
>> 
>> We will address this in the next version.
> 
> Ideally:
> 
>	if (num_rx < budget && napi_complete_done()) {
>		enable_irq();
>		return num_rx;
>	}
> 
> 	return budget;

However, if num_rx < budget and if napi_complete_done() is false, then
instead of returning the num_rx the above code will return budget.

So, unless I am missing something, the previous logic seems correct to me.
Please let me know otherwise.


Thanks and Regards,
Parvathi.

