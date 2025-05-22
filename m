Return-Path: <netdev+bounces-192648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DBCAC0A82
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 13:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AACB21BC69D8
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 11:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4670228A1C0;
	Thu, 22 May 2025 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="N9vJaIUX"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9379D28A408;
	Thu, 22 May 2025 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747912833; cv=none; b=ErkUC6Ai/ocEdrt8GJINr2mV7rtNcEIyuQAtdz8751jttkpv/BLvTtNlCIs1JrQhZNlhoPef8kB1tsDSnfCjN4bywW3BvB+ONLEjxsVK/XVUT1KxJBzz5FZVQLCfEIQD2TMxa/ASg5jErdTY6/6u7ZQn0iB36S1WLogtAEdzDE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747912833; c=relaxed/simple;
	bh=ISSgg2ni57m/DyPvzZYGJQINx6jPbdPqORJsDObz3x4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzGRJPJp/hf0VcW8rqUxsuIccZf2/4OZmB2CZGAb7i/jJS8RLedsWWz94RKxGeBL8v+afcJeI7HfbBcomu6mJa137Lh/8dyc/5njHOma0gYygVTUxc0Mcr6Tco7HL7IJNUqhhls97ukztp9bS/tHlY6OtHD3AeeWZJlX++rTbFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=N9vJaIUX; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1747912829; x=1779448829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ISSgg2ni57m/DyPvzZYGJQINx6jPbdPqORJsDObz3x4=;
  b=N9vJaIUXmxkhPfqgyt8YUSEXtklW6rTm42C+/V8LxQ09mUeLJZN7JWZX
   DMwl4PDl8nX5nAs3/+nqp/4/GUcwy/msO1macOIAuCw+KVxJNEoehQbiq
   xB4O3Flsr3ngFo/zPOAOnMeU/q2ruv/n92CWWNeLFuNOODCJc8O7KhXcj
   PfhnQbX6YNpVcnMjCyWwxbxap872R9OnpCJfuoB6Xfae9W6rHvwHgyo6B
   zZlEJTjqQx7haaccVFhbJITw5Kk1fVSHCZKYR7rHr5kWDILCiYci3i0e/
   Q4TZNdUHPcNFhqoN0PvUgu3qMSyNeTviWMTdcduMoxqMW2/peMKdhvLE8
   w==;
X-CSE-ConnectionGUID: RlPMJyqTQP+hBDG1surljg==
X-CSE-MsgGUID: fFeDH56rTpe7gLksoS26hg==
X-IronPort-AV: E=Sophos;i="6.15,305,1739862000"; 
   d="scan'208";a="273316516"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 May 2025 04:20:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 22 May 2025 04:20:18 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 22 May 2025 04:20:18 -0700
Date: Thu, 22 May 2025 13:18:39 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
CC: <UNGLinuxDriver@microchip.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: lan966x: Fix 1-step timestamping over ipv4 or
 ipv6
Message-ID: <20250522111839.tlieiy5s7qfrqxbb@DEN-DL-M31836.microchip.com>
References: <20250521124159.2713525-1-horatiu.vultur@microchip.com>
 <c770157f-4175-45b3-836e-ecf59f9ab8e0@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <c770157f-4175-45b3-836e-ecf59f9ab8e0@linux.dev>

The 05/22/2025 11:47, Vadim Fedorenko wrote:

Hi Vadim,


> > -static int lan966x_ptp_classify(struct lan966x_port *port, struct sk_buff *skb)
> > +static void lan966x_ptp_classify(struct lan966x_port *port, struct sk_buff *skb,
> > +                              u8 *rew_op, u8 *pdu_type)
> >   {
> >       struct ptp_header *header;
> >       u8 msgtype;
> >       int type;
> > 
> > -     if (port->ptp_tx_cmd == IFH_REW_OP_NOOP)
> > -             return IFH_REW_OP_NOOP;
> > +     if (port->ptp_tx_cmd == IFH_REW_OP_NOOP) {
> > +             *rew_op = IFH_REW_OP_NOOP;
> > +             *pdu_type = IFH_PDU_TYPE_NONE;
> > +             return;
> > +     }
> > 
> >       type = ptp_classify_raw(skb);
> > -     if (type == PTP_CLASS_NONE)
> > -             return IFH_REW_OP_NOOP;
> > +     if (type == PTP_CLASS_NONE) {
> > +             *rew_op = IFH_REW_OP_NOOP;
> > +             *pdu_type = IFH_PDU_TYPE_NONE;
> > +             return;
> > +     }
> > 
> >       header = ptp_parse_header(skb, type);
> > -     if (!header)
> > -             return IFH_REW_OP_NOOP;
> > +     if (!header) {
> > +             *rew_op = IFH_REW_OP_NOOP;
> > +             *pdu_type = IFH_PDU_TYPE_NONE;
> > +             return;
> > +     }
> > 
> > -     if (port->ptp_tx_cmd == IFH_REW_OP_TWO_STEP_PTP)
> > -             return IFH_REW_OP_TWO_STEP_PTP;
> > +     if (type & PTP_CLASS_L2)
> > +             *pdu_type = IFH_PDU_TYPE_NONE;
> > +     if (type & PTP_CLASS_IPV4)
> > +             *pdu_type = IFH_PDU_TYPE_IPV4;
> > +     if (type & PTP_CLASS_IPV6)
> > +             *pdu_type = IFH_PDU_TYPE_IPV6;
> 
> ptp_classify_raw() will also return PTP_CLASS_IPV4 or PTP_CLASS_IPV6
> flags set for (PTP_CLASS_VLAN|PTP_CLASS_IPV4) and
> (PTP_CLASS_VLAN|PTP_CLASS_IPV6) cases. Will the hardware support proper
> timestamp placing in these cases?

Yes, the HW seems to be working also in that case.
I just created a vlan interface and then start ptp4l on that interface
and I could see that the frames were updated correctly.

> 
> > +
> > +     if (port->ptp_tx_cmd == IFH_REW_OP_TWO_STEP_PTP) {
> > +             *rew_op = IFH_REW_OP_TWO_STEP_PTP;
> > +             return;
> > +     }
> > 
> >       /* If it is sync and run 1 step then set the correct operation,
> >        * otherwise run as 2 step
> >        */
> >       msgtype = ptp_get_msgtype(header, type);
> > -     if ((msgtype & 0xf) == 0)
> > -             return IFH_REW_OP_ONE_STEP_PTP;
> > +     if ((msgtype & 0xf) == 0) {
> > +             *rew_op = IFH_REW_OP_ONE_STEP_PTP;
> > +             return;
> > +     }
> > 
> > -     return IFH_REW_OP_TWO_STEP_PTP;
> > +     *rew_op = IFH_REW_OP_TWO_STEP_PTP;
> >   }
> > 
> >   static void lan966x_ptp_txtstamp_old_release(struct lan966x_port *port)
> > @@ -374,10 +395,12 @@ int lan966x_ptp_txtstamp_request(struct lan966x_port *port,
> >   {
> >       struct lan966x *lan966x = port->lan966x;
> >       unsigned long flags;
> > +     u8 pdu_type;
> >       u8 rew_op;
> > 
> > -     rew_op = lan966x_ptp_classify(port, skb);
> > +     lan966x_ptp_classify(port, skb, &rew_op, &pdu_type);
> >       LAN966X_SKB_CB(skb)->rew_op = rew_op;
> > +     LAN966X_SKB_CB(skb)->pdu_type = pdu_type;
> > 
> >       if (rew_op != IFH_REW_OP_TWO_STEP_PTP)
> >               return 0;
> 

-- 
/Horatiu

