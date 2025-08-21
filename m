Return-Path: <netdev+bounces-215583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E201B2F5A4
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 12:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E66AA47AA
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 10:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DC6308F11;
	Thu, 21 Aug 2025 10:50:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F86308F1D;
	Thu, 21 Aug 2025 10:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755773459; cv=none; b=LjDp22E3lxCObEraaF5IskTlUFoKmAak6iH8fL8m0UxwvbadMuWqNTsZKFuKdSX9js3PTD8TyLDvUVbF/OMtfaZC5xUOJ/Q6Q5Dj2Oj6vId8hdyKfrjj47EOsi2hmLNWPsnCp5+cWaay13SDizNmrhW6r5BNh5/Roku4BqgPASw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755773459; c=relaxed/simple;
	bh=WblN97EhwZ90OMk+WFVY1KIpIdh+xdsyfDca1cFFfls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFn1ktpqbc1baPydKFDEKLq1xSKwxIdM7k8Kim+nANXoUkPRlWJmHyT+AEIs2HMKU9Taw5I46m+ko40BZ32KMEW66XGVV+zm9CKM+sB09Tt3KR/1WOCk8Tj7Dd1PIqG1ZhCmSmOSW3FxnTpDdYVtK/c3P2JG59kyJmeMKy6m72s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1up2sR-000000006IT-48NG;
	Thu, 21 Aug 2025 10:50:40 +0000
Date: Thu, 21 Aug 2025 11:50:30 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Andreas Schirm <andreas.schirm@siemens.com>,
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
Subject: Re: [PATCH net-next v3 7/8] net: dsa: lantiq_gswip: store switch API
 version in priv
Message-ID: <aKb59jMfDIJIK0KP@pidgin.makrotopia.org>
References: <cover.1755654392.git.daniel@makrotopia.org>
 <88e9ca073e31cdd54ef093053731b32947e8bc67.1755654392.git.daniel@makrotopia.org>
 <aKZg3TviLUDgKgLz@pidgin.makrotopia.org>
 <58d31b56-8145-419e-b7be-1fd48cfeda88@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58d31b56-8145-419e-b7be-1fd48cfeda88@lunn.ch>

On Thu, Aug 21, 2025 at 04:58:23AM +0200, Andrew Lunn wrote:
> > > +	priv->version = le16_to_cpu((__le16 __force)version);
> > 
> > I've researched this a bit more and came to the conclusion that while the
> > above works fine because all Lantiq SoCs with built-in switch are
> > big-endian machines it is still wrong.
> > I base this conclusion on the fact that when dealing with more recent
> > MDIO-connected switches (MaxLinear GSW1xx series) the host endian doesn't
> > play a role in the driver -- when dealing with 16-bit values on the MDIO
> > bus, the bus abstraction takes care of converting from/to host endianess.
> 
> I agree that all MDIO bus registers are host endian, 16 bit. The shift
> register in the hardware is responsible for putting the bits on the
> wire in the correct order for MDIO.
> 
> > Hence I believe this should simply be a swab16() which will always result
> > in the version being in the right byte order to use comparative operators
> > in a meaningful way.
> 
> How is this described in the datasheet? And is version special, or do
> all registers need swapping?

The (anyway public) datasheets I have access to don't describe the VERSION
register at all. In the existing precompiler macros, however, you can see
that most-significant and least-significant byte are swapped. REV is
more significant than MOD:

#define GSWIP_VERSION                   0x013
#define  GSWIP_VERSION_REV_SHIFT        0
#define  GSWIP_VERSION_REV_MASK         GENMASK(7, 0)
#define  GSWIP_VERSION_MOD_SHIFT        8
#define  GSWIP_VERSION_MOD_MASK         GENMASK(15, 8)
#define   GSWIP_VERSION_2_0             0x100
#define   GSWIP_VERSION_2_1             0x021
#define   GSWIP_VERSION_2_2             0x122
#define   GSWIP_VERSION_2_2_ETC         0x022

Now I'd like to add
#define   GSWIP_VERSION_2_3             0x023

and then have a simple way to make features available starting from a
GSWIP_VERSION. Now in order for GSWIP_VERSION_2_3 to be greater than
GSWIP_VERSION_2_2, and GSWIP_VERSION_2_1 to be greater than
GSWIP_VERSION_2_0, the bytes need to be swapped.

I don't think the vendor even considered any specific order of the two
bytes but just defines them as separate 8-bit fields, considering it a
16-bit unsigned integer is my interpretation which came from the need for
comparability.


