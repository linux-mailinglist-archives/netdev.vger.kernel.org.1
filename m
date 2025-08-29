Return-Path: <netdev+bounces-218279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 240FCB3BBE9
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 15:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3315587918
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 13:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB66F305E2E;
	Fri, 29 Aug 2025 13:03:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDA91D61BB;
	Fri, 29 Aug 2025 13:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756472633; cv=none; b=IrlbAv4UIA6CUPwJXWJPwlnLesOySB+8PqJkw7hrQIgUxypthboH2AAxqp+OYifOrOzMIrvrFnrd3HdC4T1iSgtrZ9NFhtkHMANq73hnHq7kLwkoUJje3ThJBMNTwHgjBTdWrxpZ3s2pp8kY0+GatSr8XBmuBrFENPdq3MyoqL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756472633; c=relaxed/simple;
	bh=+0nKPb5sGlb5K3Y7fpssRwaLfF6xDFh17CMAcNt4u3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dO/qaPGeXydbbVHywg5cjQdAmaSgw/z4leA5ui9R0WkuOGqzw0h7B0ny/IxhXpDwOeySSl2WLUUCnRni4EMdA99ALOLBaP58QX6wzkAx6AgTnjSKdADMbTh3/6p5u8xXBk/oja5a3jfxViWj1AmLGFP+/HrSkMhD3RwABWbaAeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1urylg-000000002Bv-0S5Q;
	Fri, 29 Aug 2025 13:03:48 +0000
Date: Fri, 29 Aug 2025 14:03:44 +0100
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
Subject: Re: [PATCH v3 0/6] net: dsa: lantiq_gswip: prepare for supporting
 MaxLinear GSW1xx
Message-ID: <aLGlMJcEe7ZAfPFy@pidgin.makrotopia.org>
References: <cover.1756472076.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756472076.git.daniel@makrotopia.org>

On Fri, Aug 29, 2025 at 02:01:36PM +0100, Daniel Golle wrote:
> Continue to prepare for supporting the newer standalone MaxLinear GSW1xx
> switch family by extending the existing lantiq_gswip driver to allow it
> to support MII interfaces and MDIO bus of the GSW1xx.
> 
> This series has been preceded by an RFC series which covers everything
> needed to support the MaxLinear GSW1xx family of switches. Andrew Lunn
> had suggested to split it into a couple of smaller series and start
> with the changes which don't yet make actual functional changes or
> support new features.
> 
> Everything has been compile and runtime tested on AVM Fritz!Box 7490
> (GSWIP version 2.1, VR9 v1.2)
> 
> Link: https://lore.kernel.org/netdev/aKDhFCNwjDDwRKsI@pidgin.makrotopia.org/
> 
> v3: explicitly initialize mii_port_reg_offset to 0
> v2: move lantiq_gswip driver to its own folder
> 
> Daniel Golle (6):
>   net: dsa: lantiq_gswip: move to dedicated folder
>   net: dsa: lantiq_gswip: support model-specific mac_select_pcs()
>   net: dsa: lantiq_gswip: ignore SerDes modes in phylink_mac_config()
>   net: dsa: lantiq_gswip: support offset of MII registers
>   net: dsa: lantiq_gswip: support standard MDIO node name
>   net: dsa: lantiq_gswip: move MDIO bus registration to .setup()

The whole series is intended for net-next, I messed up putting that into
the subject line. Let me know if I should resend another time for that or
if it is fine to go into net-next like that.


