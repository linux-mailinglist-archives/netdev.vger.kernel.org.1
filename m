Return-Path: <netdev+bounces-213204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1055B241CB
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 08:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8C75581028
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 06:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C522D3A72;
	Wed, 13 Aug 2025 06:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jVr1FhIL"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85012D3A71;
	Wed, 13 Aug 2025 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755067493; cv=none; b=AaDw2ujB1wXb+rgu/ujxw+O2IKaVtDd9qxRRWM7cUhHCK+2Wd6JYHWekIA09OUGw7lx7JPOHvuz8+jUoqsT1uGOz7A74HSioFWwtCukkKV0Xjf4IyTbGJG59d3ESc4omTT5AZ/NTgEy5lefnXhnPMFnzIgVp3jMrL1xLOdxwoOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755067493; c=relaxed/simple;
	bh=khe1kyOLTLqHanURZ0QPZ85ApkOL61hXCPyL1DcZ5Nk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oE+DsdCcVGd88NesBOHZFANkanHpf9obnprazNCs+3Uey8Uw41BbHFWkFxAQHKvlng8SN80+3Y1NPPR++SlgA+DBeZfewdPcpJcAeJbhBPW33Zn1fUw8Pc+QhlBrL4N8Z9xy/8xHW1OSLi24coHbF/tb7DHMVC/q9P9Hf/FEcy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jVr1FhIL; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755067492; x=1786603492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=khe1kyOLTLqHanURZ0QPZ85ApkOL61hXCPyL1DcZ5Nk=;
  b=jVr1FhILeM9urw3iyglXq+4oMLAWKpo6keYnPfDgakUUYfUVFgcze2tF
   7fTtL75aeDxhBJ13KD36CG5g10SOWp+evWkJ0eVQVCYZP1kb6AotJrLdu
   qi1Cbz3XMoosRV7+KTwtmDoBK/Kw6sq88VyeGq9yzuzypaVkzlLfQkYTg
   NaCneeB/c/dFLEzz/2olvwL4Qms8B2Cqqjji7exGohziMKgffRi1Jf6iH
   Sb34bOpKVPJv+d9yq9uDELcIgRmxgLhdBtNbMdCCPiCweuTRzz6+WiiDL
   Wr6v8cdVUR4lzhu0was1YJFUkHEsdYnN7KggsekON8jgHVI141tyvGydG
   Q==;
X-CSE-ConnectionGUID: 6UynvdLWQb6DdTNChSAD/g==
X-CSE-MsgGUID: OhtCcq2dR9Gm78YuH+qd7Q==
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="276526833"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2025 23:44:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 12 Aug 2025 23:44:49 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Tue, 12 Aug 2025 23:44:49 -0700
Date: Wed, 13 Aug 2025 08:41:33 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<richardcochran@gmail.com>, <viro@zeniv.linux.org.uk>, <atenart@kernel.org>,
	<quentin.schulz@bootlin.com>, <olteanv@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] phy: mscc: Fix timestamping for vsc8584
Message-ID: <20250813064133.ms6juf27oc7ykvpk@DEN-DL-M31836.microchip.com>
References: <20250806054605.3230782-1-horatiu.vultur@microchip.com>
 <a45afc9e-f508-4f87-9462-112f3439f110@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <a45afc9e-f508-4f87-9462-112f3439f110@redhat.com>

The 08/12/2025 11:55, Paolo Abeni wrote:

Hi Paolo,

> 
> On 8/6/25 7:46 AM, Horatiu Vultur wrote:
> > @@ -1567,6 +1592,7 @@ int vsc8584_ptp_probe(struct phy_device *phydev)
> >
> >       mutex_init(&vsc8531->phc_lock);
> >       mutex_init(&vsc8531->ts_lock);
> > +     skb_queue_head_init(&vsc8531->rx_skbs_list);
> 
> The aux work is cancelled by ptp_clock_unregister(), meaning the
> `rx_skbs_list` could be left untouched if the unreg happens while the
> work is scheduled but not running yet, casing memory leaks.
> 
> It's not obvious to me where/how ptp_clock_unregister() is called, as
> AFAICS the vsc85xxx phy driver lacks the 'remove' op. In any case I
> think you need to explicitly flushing the rx_skbs_list list on removal.

Yes, I will flush the rx_skbs_list on removal.
I will look also to see where/how ptp_clock_unregister() is called, but
this will be in a different patch if it is an issue.

> 
> Thanks,
> 
> Paolo
> 

-- 
/Horatiu

