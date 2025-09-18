Return-Path: <netdev+bounces-224275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFF2B83694
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 10:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0F811C81C84
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 08:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0D02EB85E;
	Thu, 18 Sep 2025 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qMDEwphS"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458BB2BE7BE;
	Thu, 18 Sep 2025 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758182503; cv=none; b=eSfb5QXFcteQnZMw9EMQzdO545AGoKA6vry5vA/mZdU13PAe/yNE4/UYUF2ZD3NGzjIQ7UEXHcTN0QYDaBuK205oqg+Yco8XWttIpZ9L8GD2Aa0Za/ClQo5FT6jQ/U5dD3ScsQINGI6VjZAfmpq2LaeKZ/Hmk0vwdf/tCpEa9gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758182503; c=relaxed/simple;
	bh=GitsJ9J2ZxRBpzFRs9d6d4RHKJvAuTWGEya7GTtLh3Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOGuJGGsOpSHKSA/BZ2UmM7L/NQGkfayyDjw6ISuriGBQgzf8b86XOJdYYmQNblizLH608SuDLcFIC2ITOvfb7s3Ll1jpkBxxoxSoo1iLtzWfU4VowtMNvbvzSJEl2iXJ3/wEm8oNTC3whGAYU4RuNHq5VutMRZKixd64Cw1roE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qMDEwphS; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758182501; x=1789718501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GitsJ9J2ZxRBpzFRs9d6d4RHKJvAuTWGEya7GTtLh3Y=;
  b=qMDEwphSj7uYkllYNTvjq+G2OIq5FOakF5PMJmSs2IymF+wIOYH9Gy/p
   MNv6+XkJCWW6kpl4+PM5tL1HeRgKzCTrM3vRREkSjvnTc88l3MH9Owv7a
   PzOvrQCR3jfNkyomj3DT9xT6BSWiDmFmSBQpZYOS/iACkndm0/gyvp29T
   ZJf9/6/NCwEv5jgfbvdt0QBKh1Bd3iYLlmhERE0p5QdR04x0liTXMBsMj
   px44CfBEAsoJJk6EGAGjd5N/NIES7zZv/lJNkoGg5o8aagP7yrHRSGfyg
   tXG+bA5rCbSmK5G7LiXl3duLV/1FndyXz9oXm7fgAh0TI11XABDvuA3Hc
   A==;
X-CSE-ConnectionGUID: hokfViyiR5iF+MmU87atWw==
X-CSE-MsgGUID: TamkIHysT26rgc6+80UfDA==
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="46084901"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2025 01:01:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 18 Sep 2025 01:01:04 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 18 Sep 2025 01:01:02 -0700
Date: Thu, 18 Sep 2025 08:01:01 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Robert Marko <robert.marko@sartura.hr>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <Steen.Hegelund@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<luka.perkov@sartura.hr>, <benjamin.ryzman@canonical.com>
Subject: Re: [PATCH net-next] net: ethernet: microchip: sparx5: make it
 selectable for ARCH_LAN969X
Message-ID: <20250918080101.ejpdio7bxary44rj@DEN-DL-M70577>
References: <20250917110106.55219-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250917110106.55219-1-robert.marko@sartura.hr>

> LAN969x switchdev support depends on the SparX-5 core,so make it selectable
> for ARCH_LAN969X.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  drivers/net/ethernet/microchip/sparx5/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/microchip/sparx5/Kconfig b/drivers/net/ethernet/microchip/sparx5/Kconfig
> index 35e1c0cf345e..a4d6706590d2 100644
> --- a/drivers/net/ethernet/microchip/sparx5/Kconfig
> +++ b/drivers/net/ethernet/microchip/sparx5/Kconfig
> @@ -3,7 +3,7 @@ config SPARX5_SWITCH
>         depends on NET_SWITCHDEV
>         depends on HAS_IOMEM
>         depends on OF
> -       depends on ARCH_SPARX5 || COMPILE_TEST
> +       depends on ARCH_SPARX5 || ARCH_LAN969X || COMPILE_TEST
>         depends on PTP_1588_CLOCK_OPTIONAL
>         depends on BRIDGE || BRIDGE=n
>         select PHYLINK
> --
> 2.51.0
>

Reviewed-by: Daniel Machon <daniel.machon@microchip.com> 

