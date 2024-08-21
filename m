Return-Path: <netdev+bounces-120673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDC995A29C
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 18:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA421F22031
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 16:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9420714E2C1;
	Wed, 21 Aug 2024 16:18:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D2D15351A;
	Wed, 21 Aug 2024 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724257138; cv=none; b=M4geFTYBOfziZmXSHrcUySop1j3wzGBk0TAw0EP+82FZ5WFuKOf8V1fr+aOk8E4B85rgh0bMX3BHV4Z1DL2mF500fj9MG01w2zrQviw1VBZHdvDi9q96vsHLFfRucolsWzlaOAyf9UiQkUOWIAYtGu4dQfsXI7mGfmEYzRyFwfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724257138; c=relaxed/simple;
	bh=uI5XOxDKColPbfMT2OOYBtkew6KV8Urmmejp4pPH1Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9SR77gVUX2GKRtaIjRI4OQJ4bsIdLaEw6oJ+iACyQFoFcG667wVB8+Gk9nMd7wbXYjq1HJIRCcVM+Yzy6ikpXyPstigVN8K2yK31c18zswpG5g1sxDcCQey/ClxMw9APABLfbIJjOQR2TK+nsvILGK0yvPSc8W7GxUIyNUr2+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sgo2q-000000004qn-1LlN;
	Wed, 21 Aug 2024 16:18:48 +0000
Date: Wed, 21 Aug 2024 17:18:44 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Robert Marko <robimarko@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Chad Monroe <chad.monroe@adtran.com>,
	John Crispin <john@phrozen.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: phy: aquantia: allow forcing order of
 MDI pairs
Message-ID: <ZsYTZK4Ku2LoZ4SA@makrotopia.org>
References: <5173302f9f1a52d7487e1fb54966673c448d6928.1724244281.git.daniel@makrotopia.org>
 <ed46220cc4c52d630fc481c8148fc749242c368d.1724244281.git.daniel@makrotopia.org>
 <a59be297-1a55-4cce-a3e1-7568e3d4e66c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a59be297-1a55-4cce-a3e1-7568e3d4e66c@lunn.ch>

On Wed, Aug 21, 2024 at 06:07:06PM +0200, Andrew Lunn wrote:
> On Wed, Aug 21, 2024 at 01:46:50PM +0100, Daniel Golle wrote:
> > Normally, the MDI reversal configuration is taken from the MDI_CFG pin.
> > However, some hardware designs require overriding the value configured
> > by that bootstrap pin. The PHY allows doing that by setting a bit which
> > allows ignoring the state of the MDI_CFG pin and configuring whether
> > the order of MDI pairs should be normal (ABCD) or reverse (DCBA).
> > 
> > Introduce two boolean properties which allow forcing either normal or
> > reverse order of the MDI pairs from DT.
> 
> How does this interact with ethtool -s eth42 [mdix auto|on|off]
> 
> In general, you want mdix auto, so the two ends figure out how the
> cable is wired and so it just works.

It looks like Aquantia only supports swapping pair (1,2) with pair (3,6)
like it used to be for MDI-X on 100MBit/s networks.

When all 4 pairs are in use (for 1000MBit/s or faster) the link does not
come up with pair order is not configured correctly, either using MDI_CFG
pin or using the "PMA Receive Reserved Vendor Provisioning 1" register.

And yes, I did verify that Auto MDI-X is enabled in the
"Autonegotiation Reserved Vendor Provisioning 1" register.

