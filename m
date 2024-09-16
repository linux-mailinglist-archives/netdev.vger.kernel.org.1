Return-Path: <netdev+bounces-128478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48910979BEF
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 09:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7EC11F21F68
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 07:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F7812D766;
	Mon, 16 Sep 2024 07:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zs25/H9H"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692D512BF02;
	Mon, 16 Sep 2024 07:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726471095; cv=none; b=f5vW2X4qbqdjQKR+Y82hcUMpcxRIKh5/D7bI6qTPdStB/gaEEEiH8lsmDXyISZNA4JMp7ivWT2DUP9DJkcT9d+VvU9c81aiJiEmhqsdzaLtBaBiYftO+P8cY7/R2ySkK/rjdDilWWtzRG2UcuJ55mGfMtZ3tlgiUMeqZHnS+liQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726471095; c=relaxed/simple;
	bh=waO65ggFJLPaJb/lwK7U9lOiGZMypBceS6NRyVDMBF0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBnmjjB2dX/I9ZYxi1PPbAfrYEZYn6BDfHNAbdMDRNjZu0wPcQKIEC0+xrpmUclC9ZHLXSPwg5hvDuD5UnazlZppLdOcXYWe5NTLdYWR5TfSK1L921m5NJb0i/fh3On2FWjwmObCCCKoCtHXrwiJnK64oTEbf4Jhe46jETZL0t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zs25/H9H; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726471093; x=1758007093;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=waO65ggFJLPaJb/lwK7U9lOiGZMypBceS6NRyVDMBF0=;
  b=zs25/H9HoqURrpU3bjdSwKV6ZA3O7JvfrC6IAGi5EaufbXDZnqeoDHPm
   d2a6g4zgE/RBlOU2DB9UNGXHFzpHC59sR63EvBErD0UB0q6hCGgs6Vooh
   YFUJ7n8/2GyUyKgq1RO6n/2QAln/LnuBWquNfQNkpt3GjTtKMwgv5tMdt
   zKTBmaQs/aE56PV0SBACphuR4pHAxHQvGMb4RCiM1RmYIX+s8xwPL5k5H
   edJi9m/o/jj5dPd0it6rRQvD3OWsIhQk9qyaulJiJOLdextwg58ungX2v
   B6DgzL0kAWo10CmoKYl7FbDnRkBP+d+xO0ZNlV/c86Vt5uwzBbR7wbKNg
   A==;
X-CSE-ConnectionGUID: C7s5bosdTSiNOn1u2oNcFw==
X-CSE-MsgGUID: t+0hO2hARjSHMKQiEnu6sQ==
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="262816168"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2024 00:18:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 16 Sep 2024 00:18:10 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 16 Sep 2024 00:18:09 -0700
Date: Mon, 16 Sep 2024 09:17:35 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Aakash Menon <aakash.r.menon@gmail.com>
CC: <daniel.machon@microchip.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <aakash.menon@protempis.com>,
	<horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: sparx5: Fix invalid timestamps
Message-ID: <20240916071735.54uhnzejos3ksnun@DEN-DL-M31836.microchip.com>
References: <20240914190343.rq3fhgadxeuvc5qb@DEN-DL-M70577>
 <20240916051804.27213-1-aakash.menon@protempis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240916051804.27213-1-aakash.menon@protempis.com>

The 09/15/2024 22:18, Aakash Menon wrote:
> [Some people who received this message don't often get email from aakash.r.menon@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Bit 270-271 are occasionally unexpectedly set by the hardware. This issue
> was observed with 10G SFPs causing huge time errors (> 30ms) in PTP. Only
> 30 bits are needed for the nanosecond part of the timestamp, clear 2 most
> significant bits before extracting timestamp from the internal frame
> header.
> 
> Fixes: 70dfe25cd866 ("net: sparx5: Update extraction/injection for
> timestamping")
> Signed-off-by: Aakash Menon <aakash.menon@protempis.com>

There are some small issues/comments with this patch:
1. The Fixes tag should still be on one line even if it is longer than
75 columns, so the robots can find it.
2. Please use GENMASK(5, 0) instead of 0x3f.

> ---
>  drivers/net/ethernet/microchip/sparx5/sparx5_packet.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
> index f3f5fb420468..a05263488851 100644
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
> +               ((u64)(xtr_hdr[2] & 0x3F) << 24) |
>                 ((u64)xtr_hdr[3] << 16) |
>                 ((u64)xtr_hdr[4] <<  8) |
>                 ((u64)xtr_hdr[5] <<  0);
> --
> 2.46.0
> 

-- 
/Horatiu

