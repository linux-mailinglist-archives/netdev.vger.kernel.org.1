Return-Path: <netdev+bounces-175020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0412A626F2
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 07:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C9073B4450
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 06:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D031F5FD;
	Sat, 15 Mar 2025 06:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="WSxOlceU"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E0818DB17
	for <netdev@vger.kernel.org>; Sat, 15 Mar 2025 06:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742018906; cv=none; b=NgyYiFB74ngnzZZEUAQXF+x4iNMI5LJoHe+Y8ZlTWmAKdWo4nOmjq82FeJg0Qqe+m7H3qvoyJ0zqVI4qLogyTX9OYBNGm48O55drmzmrRaMoVmuGLPVgV0G1Rbkh1d94d29hKTVU6wf5Fa6+QUDJvwTCgQblQWh52bAd+f+n8qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742018906; c=relaxed/simple;
	bh=ulcrNgHy2DjG+5ry1Tea7lAyUSp1+TIl1YdAdS7obyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeYI13Nxit2TJdhhs31U8ML42nr9Of8rh54jZaNCkUXC7w7g/v87wjdWDK66/7IGVdAsJ9T5As0heuOqiOIky8fv2Jk/TNV4tBoNgKt2G0ER5BpuuZEj4VWRpjFV3f05CqhQd8Q/Gz6GYOoKUVzsl4wjr7eAka8NB/xUd9Wwr7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=WSxOlceU; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8HSBN3724vROGML2qPNZlyePBo0bbjk6tPUG8IDVj28=; b=WSxOlceUbWSxDLIlAPOy3w9n37
	uizIpASkfzGq1znClMX7eBZ2D1ncmtxrfb4onabALPaM/64v9HRnY75ygLpJgFtUJAAG5FwSOv4Px
	DUFtzW2n0gUOuzZFAPOX/PP1p0BL7Blh1JW71WO/ggv9ThQV1iMbaWYUppfHii0wIl/7imD3L7Zo1
	W4eEuVncLdRigUUcrVr0/yySweBloikJJz3Cy6mgTabUnBeMv+NHoKo3E/JzcBU2ggL9zre/VF40u
	ZUaZZUq0F3S9hFiw/Yt9LRh5u79Q7+Fvc+a8JAfJjtpO61P2+idY0e22CQqdnV2ZSgFn+y7N/gNO4
	k1KJZltQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1ttKh1-006mR3-1T;
	Sat, 15 Mar 2025 14:08:20 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 15 Mar 2025 14:08:19 +0800
Date: Sat, 15 Mar 2025 14:08:19 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] xfrm: ipcomp: Call pskb_may_pull in ipcomp_input
Message-ID: <Z9UZU6EGEF81OAYj@gondor.apana.org.au>
References: <Z9KTIYVFwEIYXgd7@gondor.apana.org.au>
 <Z9T3V/M0hXIiHsLB@gauss3.secunet.de>
 <Z9UUxb2dclH9hrWo@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9UUxb2dclH9hrWo@gondor.apana.org.au>

On Sat, Mar 15, 2025 at 01:48:53PM +0800, Herbert Xu wrote:
>
> Sure I can add it.  Do you mind if I push this through the crypto
> tree so I can base the acomp work on top of it?
> 
> I'll push this fix to Linus right away if you're OK with it.

Actually there is no need to push this right away because
xfrm_parse_spi has already done a check on the header length
so this should have no effect.

But if you're OK with this change and the xfrm_ipcomp/acomp change
I'd still like to push it through cryptodev.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

