Return-Path: <netdev+bounces-264851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LpuJkfyqmncYwEAu9opvQ
	(envelope-from <netdev+bounces-264851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:27:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8601E223C77
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 20184301DF49
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 15:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9284839F19D;
	Fri,  6 Mar 2026 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qb3VX0Gl"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FE539903D;
	Fri,  6 Mar 2026 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772810780; cv=none; b=RyVHjn+cn08Rv861mfPnHFOkUhTEIQC/MaWTIRchFc3JdEVn08CrIVWvfMJXOuXzvftt9z00/YfIqiLtwOwBz/BFPKeTzAF8v2zLZaMZrJzLHnkhwE5xLpZGjCqZZ6M7I9LiANW6Z+7422Ma+wLV4iKsXBL38CNSNdD3zZH6n0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772810780; c=relaxed/simple;
	bh=qiABN6m1k9LOGbUrfqnjBgOX07AhRsDYCYIXNOJwowE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aN+ZovdlP7Z14xi0PCqHTIN/xHpG6WLIfaD+l8Kfo+1dc0RJpIpzo5zgIeMzwA2t6t6GvGqXAvTKLowc5z7FCIvL778Empz0NUH+CHUISDHNIt223oVLPoWVixESRltxbOFBYGhqJ+/W5vvCSLpStkEq0ZgXZoSwVXK+uFwinKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qb3VX0Gl; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772810777; x=1804346777;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qiABN6m1k9LOGbUrfqnjBgOX07AhRsDYCYIXNOJwowE=;
  b=qb3VX0GlwnVGFe4dX9oS6IJSeTDCN6P0yJeJlIt9KyV0y3JAumRs9xNK
   qzCarOyfE7CU0EV+D3tTcE0XslIFWIlnhe4yo6FekMl1llcQqcbFYcFjp
   GnklXTZnfs/owAsjEJq4paKPdKC+4A5n3+WKlLhzct13b/QJFSxsTzp0U
   lAkFaGaILozOw/rBtnScdUTadrGc/+OWpX3dwgt4xTlNmYq3ZGCbz+YJr
   3wwp75YCVTQgjuGIlJbT6+jBI6Fr48pasgMEQkrJfV8HK0qTELemjaco5
   W7m/fVmu1zaKrHqhMbcxSkY6KbM0kaHYit+PhqZ/syN7cCi8hptmibFlc
   g==;
X-CSE-ConnectionGUID: wO5DHGa6TM+9jOTWtJbq4A==
X-CSE-MsgGUID: lldLq4CZSwem9Acc4a3lGw==
X-IronPort-AV: E=Sophos;i="6.23,105,1770620400"; 
   d="scan'208";a="61833322"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 08:26:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Fri, 6 Mar 2026 08:25:37 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Fri, 6 Mar 2026 08:25:37 -0700
Date: Fri, 6 Mar 2026 07:25:35 -0800
From: Charles Perry <charles.perry@microchip.com>
To: Simon Horman <horms@kernel.org>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, "Claudiu
 Beznea" <claudiu.beznea@tuxon.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <charles.perry@microchip.com>
Subject: Re: [PATCH net-next 3/4] net: macb: add safeguards for jumbo frame
 larger than 10240
Message-ID: <aarx70c8gbzGs/KS@bby-cbu-swbuild03.eng.microchip.com>
References: <20260303180318.1814791-1-charles.perry@microchip.com>
 <20260303180318.1814791-4-charles.perry@microchip.com>
 <20260305114010.GD90938@kernel.org>
 <aamSGKwG4i+7zBqV@bby-cbu-swbuild03.eng.microchip.com>
 <20260306130426.GA461701@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260306130426.GA461701@kernel.org>
X-Rspamd-Queue-Id: 8601E223C77
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264851-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:dkim,microchip.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 01:04:26PM +0000, Simon Horman wrote:
> On Thu, Mar 05, 2026 at 06:24:24AM -0800, Charles Perry wrote:
> > On Thu, Mar 05, 2026 at 11:40:10AM +0000, Simon Horman wrote:
> > > On Tue, Mar 03, 2026 at 10:03:17AM -0800, Charles Perry wrote:
> > > > The RX buffers for GEM can have a maximum size of 16320 bytes
> > > > (0xff in the RXBS field of the DMACFG register means 255*64 =
> > > > 16320 bytes).
> > > > 
> > > > The "jumbo_max_length" field (bits 0..13) of the DCFG2 register
> > > > can take a value of up to 16383 (0x3FFF). This field is not used
> > > > when determining the max MTU, instead an hardcoded value
> > > > (jumbo_max_len) is used for each platform. Right now the maximum
> > > > value for jumbo_max_len is 10240 (0x2800).
> > > > 
> > > > GEM uses one buffer per packet which means that one buffer must
> > > > allow room for the max MTU plus L2 encapsulation and alignment.
> > > > 
> > > > This commit adds a limit to max_mtu and rx_buffer_size so that
> > > > the RXBS field can never overflow when a large MTU is used.
> > > > 
> > > > With this commit, it is now possible to add new platforms that
> > > > have their gem_jumbo_max_length set to 16383.
> > > > 
> > > > Signed-off-by: Charles Perry <charles.perry@microchip.com>
> > > 
> > > Hi Charles,
> > > 
> > > I am sorry if this question is a bit naïve.
> > > 
> > > I understand the need to clamp the max_mtu to avoid overflowing RXBS.
> > > And that this hasn't been an issue up until now due to the maximum
> > > value of jumbo_max_len used in the driver.
> > > 
> > > But I'm unclear on the relationship between DCFG2 and the max_mtu.
> > > Why does it need to be set to a value larger than that corresponding to
> > > the maximum mtu and RX buf size?
> > > 
> > 
> > Hello Simon,
> > 
> > The DCFG2 register is the max_mtu value, there's some public documentation
> > for this for AMD versal [1]. "gem_jumbo_max_length" is a define in the RTL
> > code, the hardware designer probably makes a tradeoff between gate count
> > and the max_mtu. The maximum value for this is 0x3FFF (16383).
> > 
> > The maximum buffer size is 255 * 64 = 16320
> > 
> > The GEM driver, in its current state, uses one buffer per frame, so the MTU
> > needs to be clamped at the maximum buffer size.
> > 
> > We could just set 16320 instead of 16383 into the "jumbo_max_len" of
> > "struct macb_config" but it would mix information about what the hardware
> > supports vs what the software support. My approach is to put what the
> > hardware support in "struct macb_config" and clamp it later when
> > calculating max_mtu because we know we have a software limitation.
> 
> Hi Charles,
> 
> Thanks for the explanation. I agree that it is best not to conflate
> software and hardware support. And that the approach you have taken
> here makes sense.
> 
> I do think it would be nice to add a bit more detail to the commit message,
> along the lines of the text above. But I'll leave that call up to you.
> 

Ok, I'll clarify what is hardware specific vs software specific.

Thank you for the review,
Charles

> Overall, this looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

