Return-Path: <netdev+bounces-215577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CDCB2F536
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 12:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04DA6600666
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 10:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37922F8BEE;
	Thu, 21 Aug 2025 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="qz2uZROb"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F69C2F7477;
	Thu, 21 Aug 2025 10:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755771742; cv=none; b=C6bOmI7ZTEVVjimOgpZC28aJuRK+Iym5Nlof7tc7uX55PDa8GexWyNuPKGVqqrgWq3JQCzgBDlRxD/mClC2WDYCurMwZpz/FTdIQRfje4jJTbAd3KYKgD5V/x1ReQWEax7eGp4LVEdYTxwbpPaBMi5zrGH4moVBcSCgsVTwQ3+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755771742; c=relaxed/simple;
	bh=ke0Mxr0+ImBybm5HcDHtBUz1ItD/FtBXs42PEiftTSA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Le0cTAnlfnIHeznNRxgzxn1A41EKD4iy14PKSlWKcAfYy5xj+BuELLo0lt63vyJUT/492eYR7ezR571VT++8SV4uXzJa00OZ8+Av1SqplzimWSG1A71gZXpHIFPxQ7SABlpdtic8H9kRFRSrex9zBJ0uRBRBXGssTymAuMtrRF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=qz2uZROb; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=MP8TZmTt1aO0rpPA1VlRUx+vlzVRWV5nJEBr4K4uwl0=; b=qz2uZRObXNze480DbNKjv5VPkW
	YLo9HqggwTP8dZEICRHFewux8E07N0TBIU5w/8BTYnnffMxo8cFxSMQFe0SRy9oSEaxi33XTtOKtD
	MXsL7ZvbvzkoMQYLm5d2nbOthDU6MHPR8kSuPTI3yQuzWT8GkpbXSWiUCvVqntGKF7aH2P4+q3DuV
	adYAf3QzqqcjC1YUQOpxbnTpoKJ+Z+3WI1XiCM4BD0b4/U1AtS3fi294mb62emLGR83Ewao7/o8CF
	df38ChQn9qVjHEm113uAnE4dV0i+WJSPVN53eKbVrxm3ofBKaJ/BUInqskoCT4DRcQBP/SPyl1qSX
	Azz7/mmg==;
Received: from [122.175.9.182] (port=17203 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1up2Qu-0000000H5N8-2MGl;
	Thu, 21 Aug 2025 06:22:13 -0400
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id 3ECC81781F9F;
	Thu, 21 Aug 2025 15:52:06 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 159FC17823D4;
	Thu, 21 Aug 2025 15:52:06 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vjuA_uO9NEBg; Thu, 21 Aug 2025 15:52:05 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id B84611781F9F;
	Thu, 21 Aug 2025 15:52:05 +0530 (IST)
Date: Thu, 21 Aug 2025 15:52:05 +0530 (IST)
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
Message-ID: <641170813.212171.1755771725482.JavaMail.zimbra@couthit.local>
In-Reply-To: <20250820081713.2d243c55@kernel.org>
References: <20250812110723.4116929-1-parvathi@couthit.com> <20250812133534.4119053-5-parvathi@couthit.com> <20250815115956.0f36ae06@kernel.org> <1969814282.190581.1755522577590.JavaMail.zimbra@couthit.local> <20250818084020.378678a7@kernel.org> <1714979234.207867.1755695297667.JavaMail.zimbra@couthit.local> <20250820081713.2d243c55@kernel.org>
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
Thread-Index: 0Ddp1f2DlVt3suYoV83jhextCZCwAQ==
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

> On Wed, 20 Aug 2025 18:38:17 +0530 (IST) Parvathi Pudi wrote:
>> > On Mon, 18 Aug 2025 18:39:37 +0530 (IST) Parvathi Pudi wrote:
>> >> +       if (num_rx_packets < budget && napi_complete_done(napi, num_rx_packets))
>> >>                 enable_irq(emac->rx_irq);
>> >> -       }
>> >>  
>> >>         return num_rx_packets;
>> >>  }
>> >> 
>> >> We will address this in the next version.
>> > 
>> > Ideally:
>> > 
>> >	if (num_rx < budget && napi_complete_done()) {
>> >		enable_irq();
>> >		return num_rx;
>> >	}
>> > 
>> > 	return budget;
>> 
>> However, if num_rx < budget and if napi_complete_done() is false, then
>> instead of returning the num_rx the above code will return budget.
>> 
>> So, unless I am missing something, the previous logic seems correct to me.
>> Please let me know otherwise.
> 
> IIRC either way is fine, as long as num_rx doesn't go over budget.

Sure. We will address this in the next version.


Thanks and Regards,
Parvathi.

