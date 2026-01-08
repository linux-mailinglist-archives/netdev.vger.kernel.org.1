Return-Path: <netdev+bounces-248016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F1FD02475
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 12:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3BCAE3001636
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 11:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425AE43530C;
	Thu,  8 Jan 2026 09:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="R+vNtJUu"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E204366ED;
	Thu,  8 Jan 2026 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864204; cv=none; b=N4P5HTdLealui4fFlZKBbuhhbAkg7QTLAPyu/0KU2cU6Y050RrvnEqlTRkSKO6K9cHreAk15pEg7yl69S2V9CYt6g6dDsF6n6zOLIEjMdtZWA4RsOJ6Qw3ww/txFTX8JsDuir2qpqiuvt2tJNkCSnLNyNL+1wsO7LFF6f5ofuGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864204; c=relaxed/simple;
	bh=T6ODENUXXRk+WwiW0UQcfJyWXcsELYis0y45Qs/7hMk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WS4g27KqWJRzuOgYZHWsal9hvzxpAFnNzYnrx++8dnFBSbnNwnGuD/icn/Nw6WhED/rXwiVnV5JLrSCZ6RGp+OuWmH0AhA+mNWPJUTigLXHpgJ75l7Ytmd/oqUuDydPsWQN4WWTLjvnCnhoJoydGeWdyhcm0hHIb0TtQK0cy7gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=R+vNtJUu; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 607MKSKI1059551;
	Thu, 8 Jan 2026 01:23:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=bWwu8cfUEeAT1XNq1HbUAkafD
	ALxf8PrG5YcA2bFXMc=; b=R+vNtJUuJgWbVLfmosN6iOf5tcRHHwcYz82dyO6zr
	K94zRQuBsg83M0G7dNJWp+egbq9uuvQZq5A9EjbhcD5F+Vt5agDrl+C0bC3rWHPa
	/PnEkECrQEnxJSo4f+lmO7lbAIdKBS3m+MlZ8JAIbz1HKBP2oRhZWk1ynEM+ZaWC
	KwapWMMdftXKKdJGPF6q74wrL6Mo2oK55f6IkuLGPuN92xYICgjDwfViaEa8cclY
	ZvPcQFawctIU7r5ASktKIwarVlal8oLdOUizi5cEPFuO7/0yLeNn0Rs8/WE0O+mz
	iFCeIx5bNIugz8de5vqAdxEyI6KY2Azyghz0uH9raHVuw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bgf3fyhfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Jan 2026 01:23:04 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 8 Jan 2026 01:23:18 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 8 Jan 2026 01:23:18 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 0252A3F70B3;
	Thu,  8 Jan 2026 01:23:00 -0800 (PST)
Date: Thu, 8 Jan 2026 14:52:59 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andrew+netdev@lunn.ch>, <sgoutham@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 01/10] octeontx2-af: switch: Add AF to switch
 mbox and skeleton files
Message-ID: <aV93c1PNk_t3Qsni@rkannoth-OptiPlex-7090>
References: <20260107132408.3904352-1-rkannoth@marvell.com>
 <20260107132408.3904352-2-rkannoth@marvell.com>
 <ea4fc014-251c-4d5f-adc6-0e3aa562862a@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ea4fc014-251c-4d5f-adc6-0e3aa562862a@oracle.com>
X-Authority-Analysis: v=2.4 cv=PLgCOPqC c=1 sm=1 tr=0 ts=695f7778 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=nZhaFKFgNW1-scjISb8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA2MiBTYWx0ZWRfX4yJvDHzUdIf/
 2dlpqyAJyVSiSn6PaKcbdhTd0ix5nL4BupVmeiQlDh0IWySCCHFXri/iMp7rJKEFO7NfTsYy/kj
 bC8C+fQY5BWJ3I2TbwAG5zg4NPm2l0/BffIMhNXMQ80lGsIA66hmhTyrPD+7vyAydiMikyq/ttX
 6pv+h0CWDXA053D4tI9NMLjW6vo+mbY4FYTpbrLwK5RRr2fb/lWelE+e7JcO3xSR669yyyAiC57
 72IDSP0/rU5IabqP8woy73VIu/rhWL90kIS37MC15kf2M5PJrsBzwgATkP00INOWz1i8JObPvSv
 k8uAw6DtCA0plMnPt3FYDBma0JJArbwOZOXjYOYyRQZI7Xrt0+Mu2jHXTzN/zSCI0yeCUHUXGzZ
 8zIWdqaPVQ1McgAEcHDdIRL2QwC3619NvluBRQsx1BaLbQj9tckDiFs7LilSrX3Q4OXrDivx6ft
 bD6ThYjtE1v0Sx2lCzg==
X-Proofpoint-GUID: FQAS55kLHLMw62wZC7T0EPUcM-iNV3XA
X-Proofpoint-ORIG-GUID: FQAS55kLHLMw62wZC7T0EPUcM-iNV3XA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01

On 2026-01-08 at 14:32:33, ALOK TIWARI (alok.a.tiwari@oracle.com) wrote:
>
>
> On 1/7/2026 6:53 PM, Ratheesh Kannoth wrote:
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
> > @@ -4,6 +4,7 @@
> >   #
> >   ccflags-y += -I$(src)
>
> redundant include path
>
> > +ccflags-y += -I$(src) -I$(src)/switch/
> >   obj-$(CONFIG_OCTEONTX2_MBOX) += rvu_mbox.o
> >   obj-$(CONFIG_OCTEONTX2_AF) += rvu_af.o
ACK.

