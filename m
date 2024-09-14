Return-Path: <netdev+bounces-128367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81354979318
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 21:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F721C21093
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 19:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A71D1B978;
	Sat, 14 Sep 2024 19:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Xwqc7nsf"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB53BBA49;
	Sat, 14 Sep 2024 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726340632; cv=none; b=PgAosQpVMYACO90aoGbwzATnXGiRd3oHWHRYu3Hf3bd8DOKrrQaXlvw7Xjl2PpGGnwsTD9uYsnYfDCGWQLXSJTYhgo0NGrFaGRkX+8E5RowhAdjbOty9YopwDfiptyQhi435O/speXKNfk8VNC/aC+StRGdTnlwNfeaghklCXvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726340632; c=relaxed/simple;
	bh=ME7sk2AmCoCHu/rkVug9j87MuQpxKkQkN3VLinh7z4I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZpzwrZOGm4gBfiYccOwQZOFDrmtsXyo1RWJyYVrp5Yo7WZJDcET/zAbGD2OBZ+w7470BFanyR56e2jON+xW+KIBg2M6fiNYKge7hCiyEx2uEzorpZaWz28NxsLsxAo7wp2/49Zr41i6B6lq0mDEW+XOJnYA+QDGxZWBBjib7P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Xwqc7nsf; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726340629; x=1757876629;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ME7sk2AmCoCHu/rkVug9j87MuQpxKkQkN3VLinh7z4I=;
  b=Xwqc7nsfJQthU5DRJcfQwlLaHu7x5DfrQ8u0VU2CraqKXeOoykj3gOmj
   dGr89t8nIfWthfoNIOe1KFNoSJLx8vvpbndc2J/aI+CYGnGTfQYOBtqDa
   nzfAUjkfEVWgQfE9fVlNu784eFW9l1zODX7Rdg01N0TbQW2BnChU2/LDb
   9XIhTAFrK4qlrcytdpN8m4ntoCVsTcOE5nHASP4lNulIvfLipabrrC7sE
   PjmH5cVWsv69+OWI6H02Og/9TpAXqADzdFGnfFrj78qKhWgOkbZ9YTiCU
   GNfFLcNEft3ggF0BQCi3BdueVH3VL1K63tc+XM77lbkD8eQAJAs38tuqV
   Q==;
X-CSE-ConnectionGUID: 7QGG7ucfREGEfXw/1IAUpw==
X-CSE-MsgGUID: pg4eQ+CyQ6KPIJB9iSKGLg==
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="31675481"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2024 12:03:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 14 Sep 2024 12:03:46 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Sat, 14 Sep 2024 12:03:44 -0700
Date: Sat, 14 Sep 2024 19:03:43 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Aakash Menon <aakash.r.menon@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <lars.povlsen@microchip.com>,
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<aakash.menon@protempis.com>, <horms@kernel.org>,
	<horatiu.vultur@microchip.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: sparx5: Fix invalid timestamps
Message-ID: <20240914190343.rq3fhgadxeuvc5qb@DEN-DL-M70577>
References: <20240913193357.21899-1-aakash.menon@protempis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240913193357.21899-1-aakash.menon@protempis.com>

> Bit 270-271 are occasionally unexpectedly set by the hardware.
> 
> This issue was observed with 10G SFPs causing huge time errors (> 30ms) in PTP.
> 
> Only 30 bits are needed for the nanosecond part of the timestamp, clear 2 most significant bits before extracting timestamp from the internal frame header.
> 
> Signed-off-by: Aakash Menon <aakash.menon@protempis.com>
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

Hi Aakash,

I will (or somebody else) try to reproduce and test this at the
beginning of the next week.

Meanwhile, you can address the issues that Simon mentioned.

Thanks.

/Daniel

