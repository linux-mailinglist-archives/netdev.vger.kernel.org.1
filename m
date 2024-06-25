Return-Path: <netdev+bounces-106684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B9A917417
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 00:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E9F282DD9
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 22:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87491178CEA;
	Tue, 25 Jun 2024 22:07:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from norbury.hmeau.com (helcar.hmeau.com [216.24.177.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4ED8F48;
	Tue, 25 Jun 2024 22:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.24.177.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719353264; cv=none; b=g1K2VqADzs8RXKtxjrk80nTTlwb0t7zOIhnsVoNwXyaZoYXecKbr5w9pVsTeZ6NqNo5dfWLtYf6lnJ3WIboXIf1toYdRIu3MdCBf/55//W0F0WCX5Ur4Wz6xPX/lcj6wQ9P/w1vVqKG6dQl/3XrONr2wJJLxqnpvODaSF4EhAgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719353264; c=relaxed/simple;
	bh=Mzkt2PXwayNA2PZ4qKtuw1egnCGoGC/DyUXBj8i3Jh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCYfk3lwp1LdqIOgsu0/dDyUJtxpPfuJ7mhXasMBqhcRxgI4E3ofv3PSiIrleJH2ZaajZ3/dfEMYwALT5nVLbD9Vn8g49Ecw1k4EIbHDx4an1Qhsz1j7KNS3NWx5E2Xph83DEj1/pYeUKf55XuPFlBZYpGJSCvqFvNC5+xWlhVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=216.24.177.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
	by norbury.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sMEJN-003cFI-0Q;
	Wed, 26 Jun 2024 08:06:50 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 26 Jun 2024 08:06:49 +1000
Date: Wed, 26 Jun 2024 08:06:49 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	horms@kernel.org, Roy.Pledge@nxp.com,
	open list <linux-kernel@vger.kernel.org>,
	Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Gaurav Jain <gaurav.jain@nxp.com>
Subject: Re: [PATCH 1/4] soc: fsl: qbman: FSL_DPAA depends on COMPILE_TEST
Message-ID: <Zns/eVVBc7pdv0yM@gondor.apana.org.au>
References: <20240624162128.1665620-1-leitao@debian.org>
 <20240625073926.15591595@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625073926.15591595@kernel.org>

On Tue, Jun 25, 2024 at 07:39:26AM -0700, Jakub Kicinski wrote:
> On Mon, 24 Jun 2024 09:21:19 -0700 Breno Leitao wrote:
> > As most of the drivers that depend on ARCH_LAYERSCAPE, make FSL_DPAA
> > depend on COMPILE_TEST for compilation and testing.
> > 
> > 	# grep -r depends.\*ARCH_LAYERSCAPE.\*COMPILE_TEST | wc -l
> > 	29
> 
> Cover letter would be good..
> 
> Herbert, (Pankaj | Gaurav | Horia) - no rush but once reviewed can we
> take this via netdev (or a shared branch)? As Breno linked we want to
> change the netdev allocation API, this is the last chunk of drivers
> we need to convert.

Sure, please feel free to take this via netdev.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

