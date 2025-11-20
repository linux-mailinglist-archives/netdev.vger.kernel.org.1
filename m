Return-Path: <netdev+bounces-240309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE3FC72A79
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 08:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1777F3459EC
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 07:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4B1280CC1;
	Thu, 20 Nov 2025 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mLA/kMFO"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025B729B8E5;
	Thu, 20 Nov 2025 07:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763625098; cv=none; b=Gx/L9NjLS09nzrHR7oypOSY9N3ot3JIzF67yB+vOH68Ap6Emme+pF/u2OWgNUbuQ521YPbH+vsWgqBGzEZ3QY7OXQA7RrXsIZhLru4BzRPhhmVUDvgSdj87yl8meG/M7fCQIlXSgo+vEjIcfVdiVWDryztCDl5bBbg51saEnzOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763625098; c=relaxed/simple;
	bh=6WeLNPzmOcXHftooSQWNIuFAJUMvdPcbNnVe5XBUAKo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffnIh76Ka0wx7bPvmurcYX28Hlfz6DoTr5lsotKKlW2m22uXj5sx96xwvxXnyIfDTz3NZcuYv9QLhRxlcW6vUVH6eItAiSljgaOvG9dlX0PMzKPDRNs4RwoLbNPNQMDzp4lCG8hK0zY9MLKA7+XZ7vDzAEsgdmQke/8WeaFIBCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mLA/kMFO; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1763625096; x=1795161096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6WeLNPzmOcXHftooSQWNIuFAJUMvdPcbNnVe5XBUAKo=;
  b=mLA/kMFOoIe5WkNCLb98AriTgvA+cPa+tkmZis3P2fmOU6y1c+1GohYq
   z9A2ty7f2uyvs0f+WCDGJIkgBib1tKfEMRN+JtNTdq20UIsUoSjz4JM5F
   IUM3tDDAojbBBGCIYG9MR1LAcNGFq/151ODmWLQ53EBa0ty1qgikn3dmP
   UuO0g2q22OrcLcwTTI0LGTtQ+XgHi0Y9CRm316TBcLRKEK2r7lVFYgJJs
   qnX+ugUZiX1JpCjiCUNrZ2EAHfaUAg03xrcLP6Y1oeIrqZ2eGcPQmvWvV
   skaQhlQp6Y6dLzEeiY2yxjXTGfqdc3SidIcLM0pGs89c5ef5BxTdneQbI
   g==;
X-CSE-ConnectionGUID: PcM37C81QYmn/42u/XMkmw==
X-CSE-MsgGUID: vSkbAs8FQbC6DUcE72NZ9g==
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="48779748"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 00:51:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 20 Nov 2025 00:50:55 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 20 Nov 2025 00:50:54 -0700
Date: Thu, 20 Nov 2025 08:50:57 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: <UNGLinuxDriver@microchip.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] net: lan966x: Fix the initialization of taprio
Message-ID: <20251120075057.dsjr4wgnunecgom6@DEN-DL-M31836.microchip.com>
References: <20251119172845.430730-1-horatiu.vultur@microchip.com>
 <ffa6ba0a-750e-4281-826d-f56c4f5ea433@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <ffa6ba0a-750e-4281-826d-f56c4f5ea433@lunn.ch>

The 11/19/2025 20:53, Andrew Lunn wrote:
> 
> > +#define LAN9X66_CLOCK_RATE   165617754
> 
> You add a #define
> 
> > +
> >  #define LAN966X_MAX_PTP_ID   512
> >
> >  /* Represents 1ppm adjustment in 2^59 format with 6.037735849ns as reference
> > @@ -1126,5 +1129,5 @@ void lan966x_ptp_rxtstamp(struct lan966x *lan966x, struct sk_buff *skb,
> >  u32 lan966x_ptp_get_period_ps(void)
> >  {
> >       /* This represents the system clock period in picoseconds */
> > -     return 15125;
> > +     return PICO / 165617754;
> 
> and then don't use it?

Argh... that is just a stupid mistake.
I will update in the next version.

> 
>         Andrew

-- 
/Horatiu

