Return-Path: <netdev+bounces-211215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3679B172E5
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 16:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B94054170F
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 14:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCACC2BE62C;
	Thu, 31 Jul 2025 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="RvDagKch"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B98921CC5B;
	Thu, 31 Jul 2025 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753971085; cv=none; b=HErxlDe4aMt+9hgePaqMaz81hPPLzuBr9fR/Re8qjYzSu/g9kd7bb5oLIS2ERwvPRR2g0oJqJAq6WAGOBpypxDqwu19puwcFCdmrLaHRC9LLxBKgrWKR4Ts2t+SC0Ty+R2P+6tiwRl/dINorHXUatRlo3WRCsg7WrTtVrkkPyLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753971085; c=relaxed/simple;
	bh=WctS3TBZBfxHFoxgWiuUQ1YaaNSMG3iHX0kksiAuv0I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=gegnOLX/iT/VVnMsUl7ABZYkDmzfoK1BM0E68mpDBPCI3WuM82GSTt1zSpcce/GVlKmSu9piFzdw2DPXP1SvBZsi8g8OBq83+smqtYLO/DDFr0WrhBjQbQ8exooJQrEJIqIOTw7czgpYmittCS8o4rud42zS9nYy/plEAT+eMoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=RvDagKch; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=dgpIYA1X3JY/hFPKIDfOS0L7idr7TKT6OBuNKuxgpM0=; b=RvDagKchEHmC4Ohnvrd5X4rHZh
	ZRwgwTS1WLBLNUGSdhpOKJ6ciErX4Oy4+FsGuJlmMA0otp9j/MJKstfLThqDqcZb3GBuOr3QSke5X
	DcTq1roXkeaza/POMx0wg5jChjGZj48LDOFEzu7IYBpemkuaaV37N6DnuXu1QZdpBcPflrlv2WhJe
	vJaRhV0ZqbnqdesZ6/0rnLU+KdlD1t8gIwWBTSUV1F5MfBIGtKNLYTmL5NCHHCYpacyAx1gojB0Ts
	eGxRd9bviVbDhlUmcGUoDPSN1Z7giUusyeg8t8Jf/upl9g1UF1hjxuIXtE58Q9Jyx0qJJ+q6LTxTU
	QcH/28sQ==;
Received: from [122.175.9.182] (port=5734 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1uhU05-0000000EGZB-1GGq;
	Thu, 31 Jul 2025 10:11:17 -0400
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id 124C81781F30;
	Thu, 31 Jul 2025 19:41:10 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id D14491783F55;
	Thu, 31 Jul 2025 19:41:09 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KDcsVC7gPY0O; Thu, 31 Jul 2025 19:41:09 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 775C11781F30;
	Thu, 31 Jul 2025 19:41:09 +0530 (IST)
Date: Thu, 31 Jul 2025 19:41:09 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: parvathi <parvathi@couthit.com>, danishanwar <danishanwar@ti.com>, 
	rogerq <rogerq@kernel.org>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	kuba <kuba@kernel.org>, pabeni <pabeni@redhat.com>, 
	robh <robh@kernel.org>, krzk+dt <krzk+dt@kernel.org>, 
	conor+dt <conor+dt@kernel.org>, ssantosh <ssantosh@kernel.org>, 
	richardcochran <richardcochran@gmail.com>, 
	s hauer <s.hauer@pengutronix.de>, m-karicheri2 <m-karicheri2@ti.com>, 
	glaroque <glaroque@baylibre.com>, afd <afd@ti.com>, 
	saikrishnag <saikrishnag@marvell.com>, m-malladi <m-malladi@ti.com>, 
	jacob e keller <jacob.e.keller@intel.com>, 
	kory maincent <kory.maincent@bootlin.com>, 
	diogo ivo <diogo.ivo@siemens.com>, 
	javier carrasco cruz <javier.carrasco.cruz@gmail.com>, 
	horms <horms@kernel.org>, s-anna <s-anna@ti.com>, 
	basharath <basharath@couthit.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	netdev <netdev@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	pratheesh <pratheesh@ti.com>, Prajith Jayarajan <prajith@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, pmohan <pmohan@couthit.com>, 
	mohan <mohan@couthit.com>
Message-ID: <1942226614.78018.1753971069296.JavaMail.zimbra@couthit.local>
In-Reply-To: <743eddd9-1f63-4c6c-8ba3-5007bd897ae1@oracle.com>
References: <20250724072535.3062604-1-parvathi@couthit.com> <20250724072535.3062604-4-parvathi@couthit.com> <743eddd9-1f63-4c6c-8ba3-5007bd897ae1@oracle.com>
Subject: Re: [PATCH net-next v12 3/5] net: ti: prueth: Adds PRUETH HW and SW
 configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - GC138 (Linux)/8.8.15_GA_3968)
Thread-Topic: prueth: Adds PRUETH HW and SW configuration
Thread-Index: Bgd3ThmGCBL4ZbqhqpbvPS3WfmfZ0A==
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

>> +/* NRT Buffer descriptor definition
>> + * Each buffer descriptor points to a max 32 byte block and has 32 bit in size
>> + * to have atomic operation.
>> + * PRU can address bytewise into memory.
>> + * Definition of 32 bit descriptor is as follows
>> + *
>> + * Bits		Name			Meaning
>> + *
>> =============================================================================
>> + * 0..7		Index		points to index in buffer queue, max 256 x 32
>> + *				byte blocks can be addressed
>> + * 6		LookupSuccess	For switch, FDB lookup was successful (source
>> + *				MAC address found in FDB).
>> + *				For RED, NodeTable lookup was successful.
>> + * 7		Flood		Packet should be flooded (destination MAC
>> + *				address found in FDB). For switch only.
>> + * 8..12	Block_length	number of valid bytes in this specific block.
>> + *				Will be <=32 bytes on last block of packet
>> + * 13		More		"More" bit indicating that there are more blocks
>> + * 14		Shadow		indicates that "index" is pointing into shadow
>> + *				buffer
>> + * 15		TimeStamp	indicates that this packet has time stamp in
>> + *				separate buffer - only needed of PTCP runs on
> 
> only needed if PTCP runs on host
> 

Sure, We will address this.

>> + *				host
>> + * 16..17	Port		different meaning for ingress and egress,
>> + *				Ingress: Port = 0 indicates phy port 1 and
>> + *				Port = 1 indicates phy port 2.
>> + *				Egress: 0 sends on phy port 1 and 1 sends on
>> + *				phy port 2. Port = 2 goes over MAC table
>> + *				look-up
>> + * 18..28	Length		11 bit of total packet length which is put into
>> + *				first BD only so that host access only one BD
>> + * 29		VlanTag		indicates that packet has Length/Type field of
>> + *				0x08100 with VLAN tag in following byte
>> + * 30		Broadcast	indicates that packet goes out on both physical
>> + *				ports,	there will be two bd but only one buffer
>> + * 31		Error		indicates there was an error in the packet
>> + */
>> +#define PRUETH_BD_START_FLAG_MASK	BIT(0)
>> +#define PRUETH_BD_START_FLAG_SHIFT	0
>> +
>> +#define PRUETH_BD_HSR_FRAME_MASK	BIT(4)
>> +#define PRUETH_BD_HSR_FRAME_SHIFT	4
>> +
>> +#define PRUETH_BD_SUP_HSR_FRAME_MASK	BIT(5)
>> +#define PRUETH_BD_SUP_HSR_FRAME_SHIFT	5
>> +
>> +#define PRUETH_BD_LOOKUP_SUCCESS_MASK	BIT(6)
>> +#define PRUETH_BD_LOOKUP_SUCCESS_SHIFT	6
>> +
>> +#define PRUETH_BD_SW_FLOOD_MASK		BIT(7)
>> +#define PRUETH_BD_SW_FLOOD_SHIFT	7
>> +
>> +#define	PRUETH_BD_SHADOW_MASK		BIT(14)
>> +#define	PRUETH_BD_SHADOW_SHIFT		14
>> +
>> +#define PRUETH_BD_TIMESTAMP_MASK	BIT(15)
>> +#define PRUETH_BD_TIMESTAMP_SHIT	15
> 
> typo PRUETH_BD_TIMESTAMP_SHIT -> PRUETH_BD_TIMESTAMP_SHIFT
> 

Sure, We will address this.


Thanks and Regards,
Parvathi.

