Return-Path: <netdev+bounces-128653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C09DF97AB4D
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 08:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43664B243CF
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 06:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADC94594D;
	Tue, 17 Sep 2024 06:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zboyY7Q8"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B131B5AA;
	Tue, 17 Sep 2024 06:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726553645; cv=none; b=cBIzmzMSGccP7pXD0HjoqE60QmlRA0fKZV8YSfomBbSVfL16pI9Q181TobYd5Me5y17FBFRXhcGu4Zb/m499fv5bPJav8gepgFTJt3YaLOa2kr23N/aZVCV7LU7v2NWM/oAhyU0j+4B2T0D3xVZKr14NZuSkS4TiyfAI4klQix0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726553645; c=relaxed/simple;
	bh=1UhkNKfUndxWsU+go6ytaT8csVNZ5E84V18UPAAE3r0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F95BDNvrSsWoRXeGYc2AXNFqgBvnanG975Xqjho3eEODASGtjmoPWxFEAls2xL5EkE78UYCFSQjho6VRXJ3rzmcJXxHUTR85P168S78CJfvIjg1xDvzEkWojmbiotuF+ZS9l5fMDBwwH99IjP8/1v/Td78nOIJLmlnj/OVV6wUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zboyY7Q8; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726553643; x=1758089643;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1UhkNKfUndxWsU+go6ytaT8csVNZ5E84V18UPAAE3r0=;
  b=zboyY7Q8rVCYev39XGHs3n9oFsJ26bCQjaLy6NcCzlun22bY3BZNNnsm
   DF5NxnzXbXEVWC5s/NW0/ZeS62Cs2Rfnx/Qh2Muin6IkMUVguVAQ6WB/8
   qsGkAwvRVxwenhkPZllOohF0aP2NAeTTYYpMT0jFVAgAgLxgKuJiw0XbO
   sbSbFbAxY0UhtIXcsWlo7ZulGzlFnD3teIfZW9KiAmooOX1OiL2igmLTG
   OUYYkgVeSYvJMG/fG112jXsdjFnkxOoHERZ5Me0xRiqqmdQ3fRDUxyseJ
   6C/G16g8zRKllcimin4p19ugzu8ujiiMNWzW0rY5KiyU4+cETz0Ze7W2y
   g==;
X-CSE-ConnectionGUID: s7NP2PV/RvGiT0Z8I2cSNg==
X-CSE-MsgGUID: 699qZaIpR3OgmeWprxqujA==
X-IronPort-AV: E=Sophos;i="6.10,234,1719903600"; 
   d="scan'208";a="262873114"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2024 23:14:02 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 16 Sep 2024 23:13:41 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 16 Sep 2024 23:13:41 -0700
Date: Tue, 17 Sep 2024 08:13:05 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Aakash Menon <aakash.r.menon@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <lars.povlsen@microchip.com>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <aakash.menon@protempis.com>,
	<horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] net: sparx5: Fix invalid timestamps
Message-ID: <20240917061305.47x26cdfv3fr7rzh@DEN-DL-M31836.microchip.com>
References: <20240917051829.7235-1-aakash.menon@protempis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240917051829.7235-1-aakash.menon@protempis.com>

The 09/16/2024 22:18, Aakash Menon wrote:
> 
> Bit 270-271 are occasionally unexpectedly set by the hardware. This issue
> was observed with 10G SFPs causing huge time errors (> 30ms) in PTP. Only
> 30 bits are needed for the nanosecond part of the timestamp, clear 2 most
> significant bits before extracting timestamp from the internal frame
> header.

Thanks for changes. I think it look good.
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>

> 
> Fixes: 70dfe25cd866 ("net: sparx5: Update extraction/injection for timestamping")
> Signed-off-by: Aakash Menon <aakash.menon@protempis.com>
> ---
> v2:
> - Wrap patch descriptions at 75 characters wide.
> - Use GENMASK(5,0) instead of masking with 0x3F
> - Update Fixes tag to be on the same line
> - Link to v1 -https://lore.kernel.org/r/20240913193357.21899-1-aakash.menon@protempis.com
> drivers/net/ethernet/microchip/sparx5/sparx5_packet.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
> index f3f5fb420468..70427643f777 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
> @@ -45,8 +45,12 @@ void sparx5_ifh_parse(u32 *ifh, struct frame_info *info)
>         fwd = (fwd >> 5);
>         info->src_port = FIELD_GET(GENMASK(7, 1), fwd);
> 
> +       /*
> +        * Bit 270-271 are occasionally unexpectedly set by the hardware,
> +        * clear bits before extracting timestamp
> +        */
>         info->timestamp =
> -               ((u64)xtr_hdr[2] << 24) |
> +               ((u64)(xtr_hdr[2] & GENMASK(5, 0)) << 24) |
>                 ((u64)xtr_hdr[3] << 16) |
>                 ((u64)xtr_hdr[4] <<  8) |
>                 ((u64)xtr_hdr[5] <<  0);
> --
> 2.46.0
> 

-- 
/Horatiu

