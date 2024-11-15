Return-Path: <netdev+bounces-145217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE979CDB7B
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 10:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCED21F21B87
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 09:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCD618F2D8;
	Fri, 15 Nov 2024 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MaskqfJ6"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC29A18CC1C;
	Fri, 15 Nov 2024 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731662590; cv=none; b=IPHkrS0l0P9D16BxsXKx2aEnlMapEYIwcXEgJtDlOp1xlsVmGylp8UFrZWDGOtFDXjgAcvwPWfQozVG5gF/XTwJGI08tk9XOWLa7ZFHiwhsXa7MvsuIvMDqvoPrISTfdw3n+VDv3dHHi4Ao3/sRhB6BjFU0QjG2rGWLxOc8iQ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731662590; c=relaxed/simple;
	bh=nbuhk+CaUW9mRbVIzoPXH9V8FF1V83ATXwEiP9WhI7A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBIYCNYnasEx1brar6uF6ABHrp/PEztpRROgZKmZAygbCra+rj2AyJOWOW8ze7U9w+fN40MJht7mwJuJ7YSpQmHga9tkNMR65RwHo4Ov7ZiAAb+DyplTNHOi9bS3X2qYOlJ17LrSj6M1VPJyiOvwX5Xa3bg2lcubN5XUpbnB/zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MaskqfJ6; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731662588; x=1763198588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nbuhk+CaUW9mRbVIzoPXH9V8FF1V83ATXwEiP9WhI7A=;
  b=MaskqfJ67K2+glak12R0FZIScSkTWIf2VDDFz5Xk7DNJEbGIErQVdTg5
   91cUxNRe8eidh9X58nPx8K/oPuOJmKyLXFWyl9uDMEaRBQrvec87wNVvV
   QAZ/4JaEyuKKZFQf0IzNPfzpWUukMWqoG1Ir1X8XOrLHt3ngtKZId0uD1
   jw+eQ6TV00cwq7sBkz5dWWdXFG+gv79dlVnisOqzst+kDtAaYcIZ5TAbp
   5OU9oNoYAlQJL7FnOBj+4pszq6ukcYzQysjOAS8PWFtpRKHROv65nipWq
   XeWpMpKWP1cRSjjwJ26R0DFc82J2SNk3JntBoAMY5SRk8GAqr1zAJHDdY
   g==;
X-CSE-ConnectionGUID: sSmUfU85Rbizj9448fniyw==
X-CSE-MsgGUID: sf/zJ0QfQIWXKVwBjtgE9A==
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="34091113"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Nov 2024 02:23:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Nov 2024 02:22:41 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 15 Nov 2024 02:22:38 -0700
Date: Fri, 15 Nov 2024 09:22:37 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lars
 Povlsen" <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Russell King <linux@armlinux.org.uk>,
	<jacob.e.keller@intel.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v2 8/8] dt-bindings: net: sparx5: document RGMII
 MAC delays
Message-ID: <20241115092237.gzpat4x6kjipb2x7@DEN-DL-M70577>
References: <20241113-sparx5-lan969x-switch-driver-4-v2-0-0db98ac096d1@microchip.com>
 <20241113-sparx5-lan969x-switch-driver-4-v2-8-0db98ac096d1@microchip.com>
 <29ddbe38-3aac-4518-b9f3-4d228de08360@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <29ddbe38-3aac-4518-b9f3-4d228de08360@lunn.ch>

Hi Andrew,

> > The lan969x switch device supports two RGMII port interfaces that can be
> > configured for MAC level rx and tx delays.
> >
> > Document two new properties {rx,tx}-internal-delay-ps. Make them
> > required properties, if the phy-mode is one of: rgmii, rgmii_id,
> > rgmii-rxid or rgmii-txid. Also specify accepted values.
> 
> This is unusual if you look at other uses of {rt}x-internal-delay-ps.
> It is generally an optional parameter, and states it defaults to 0 if
> missing, and is ignored by the driver if phy-mode is not an rgmii
> variant.

Is unusual bad? :-) I thought that requiring the properties would make
misconfigurations (mismatching phy-modes and MAC delays) more obvious,
as you were forced to specify exactly what combination you want in the
DT.  Maybe not. I can change it,  no problem.

/Daniel


> 
>         Andrew




