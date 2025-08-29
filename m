Return-Path: <netdev+bounces-218319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74197B3BEE5
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 17:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B656C1C82DFC
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 15:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A13A322521;
	Fri, 29 Aug 2025 15:11:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E192135CE;
	Fri, 29 Aug 2025 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756480300; cv=none; b=ap2CUOvds+CMh7FSW8kG6KFjn+k1cOkdft2HLHn9+iqEJCIwRiTrAFXspzMY+cKr8WdAvixeJ2O9U0XYj/2lXe1parto1tJVbvfxJjYkBTkVGZD9/hG/tVZlwOUNpgk2buWi9d6XmvAzOJXAwip1JW2XZYrix/VIsA6s/Yeie0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756480300; c=relaxed/simple;
	bh=cPsnRheiY6qhu7s/fOGrllQCxeJSjbDMRwYV5cJ/Zmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyhcWbi5JfhIFCfnkW0Se5qtsE62b0lVONXt/Tlm8jKeCeG8DWRhb1IRw5tBABWIufITYtQYh6fL8WZimXjyySc773DCXJVS7E0DvdstVFTgEa1+tTCymGTemoTglI9cn12rjannz8p913OGl1JEi/sLxIga3yinIMs5I+N5xN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1us0lF-000000002sN-0iyL;
	Fri, 29 Aug 2025 15:11:29 +0000
Date: Fri, 29 Aug 2025 16:11:25 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH v3 4/6] net: dsa: lantiq_gswip: support offset of MII
 registers
Message-ID: <aLHDHbdBYTLzCMiL@pidgin.makrotopia.org>
References: <cover.1756472076.git.daniel@makrotopia.org>
 <ece46fdecbfb75ade8400f96f8649d04b4f1a2f7.1756472076.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ece46fdecbfb75ade8400f96f8649d04b4f1a2f7.1756472076.git.daniel@makrotopia.org>

On Fri, Aug 29, 2025 at 02:02:16PM +0100, Daniel Golle wrote:
> The MaxLinear GSW1xx family got a single (R)(G)MII port at index 5 but
> the registers MII_PCDU and MII_CFG are those of port 0.
> Allow applying an offset for the port index to access those registers.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Reviewed-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
> v3: no changes
> v2: no changes

I forgot to include the change I made upon Hauke's request, and it's even
wrong. Sorry for the noise. I will send v4 tomorrow...


> @@ -2027,6 +2035,7 @@ static const struct gswip_hw_info gswip_xrx200 = {
>  	.max_ports = 7,
>  	.allowed_cpu_ports = BIT(6),
>  	.mii_ports = BIT(0) | BIT(1) | BIT(5),
> +	.mii_port_reg_offset = 0;
>  	.phylink_get_caps = gswip_xrx200_phylink_get_caps,
>  	.pce_microcode = &gswip_pce_microcode,
>  	.pce_microcode_size = ARRAY_SIZE(gswip_pce_microcode),
> @@ -2037,6 +2046,7 @@ static const struct gswip_hw_info gswip_xrx300 = {
>  	.max_ports = 7,
>  	.allowed_cpu_ports = BIT(6),
>  	.mii_ports = BIT(0) | BIT(5),
> +	.mii_port_reg_offset = 0;
>  	.phylink_get_caps = gswip_xrx300_phylink_get_caps,
>  	.pce_microcode = &gswip_pce_microcode,
>  	.pce_microcode_size = ARRAY_SIZE(gswip_pce_microcode),

Both above will triger compiler error, should be ',' instead ';'.


