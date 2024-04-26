Return-Path: <netdev+bounces-91580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B668B31B0
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 09:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2921F2206A
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 07:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0A213BAFA;
	Fri, 26 Apr 2024 07:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="dMVRGtTp"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B758042040
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 07:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714117836; cv=none; b=guF6OV3+7RrS68P/W7ZNQOTt8Q//MV2vNGFt7cN2rR2Qs1FEAsnwitpVbhmxID9x0lbFEuUxF9U7cMy2cqcfBSSwhlVy1THlGiRIh5z5gfH4nB6YI9JHyiyein3dO/tLREtthUJ9/ajnvCCHzzfn7u9eVpujZnKei8jW4VGz2aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714117836; c=relaxed/simple;
	bh=8B+NkcS88Dam+ZeDyOiF7ik5STlyYmltX5cqdlrC/5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKvY6sj/wWUHndu+90XbewfzZoJ4GdXXRrrQo5/YQ3NOf6iQYQZwWXnbhrBQTZqzKn/dnNyzyKaDxkZd7F0CZJsx4N9JmUxzWXaFdYB6zd0JrBsfd73DVmstVyWxTPoR9C4d60VoKy5qn5r6wjlHT1JRdXjgO24/XZCI9XBxcgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=dMVRGtTp; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: a7c3d253-03a1-11ef-93a7-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id a7c3d253-03a1-11ef-93a7-005056abbe64;
	Fri, 26 Apr 2024 09:50:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=VHtynP9p4uH/co+X3WiM/HSeB2+JYqKFVV7xIl05mmQ=;
	b=dMVRGtTpOOiiVjZOr9XSkgOpH1MrUg2lHT9gJfWjb4WOaeFjSD3Q5f8JNfsFNXf2eTg1l+GhhcDgn
	 rU7HP3WG8PwaWTRXiJqfKOh0zY9g3OEK7tIbVqhqU+OBOKyJZTBiP2mbjgxIP4TVJvOVBpslYaCZ2x
	 Yz4SXBrCpJPY8w3Y=
X-KPN-MID: 33|9PkQMbDk7J/+0jgdienvRg3EG21wlk2Vi+RrTbjQqtGt1X73lgm4+47rnBIkOR6
 NX5b4zRF7xFhQvc4vyJ4oaosI6mKPEvNmgc9mEW60HUI=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|9FF/v8eutZAU3tCHGZdl6JrEnQFOt5zec5ofuE62uHh4xtXDDg1G/kr9A8J7QBY
 Bk3YxqnI5IMWFpAM4nTsy/g==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id a754992d-03a1-11ef-8d63-005056ab7447;
	Fri, 26 Apr 2024 09:50:31 +0200 (CEST)
Date: Fri, 26 Apr 2024 09:50:30 +0200
From: Antony Antony <antony@phenome.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Antony Antony <antony.antony@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org, Leon Romanovsky <leon@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH ipsec-next v12 4/4] xfrm: Restrict SA direction attribute
 to specific netlink message types
Message-ID: <ZitcxrkIaOtatSdA@Antony2201.local>
References: <cover.1713874887.git.antony.antony@secunet.com>
 <718d3da5f5cd56c2444fb350516c7e5e022893c4.1713874887.git.antony.antony@secunet.com>
 <ZisyYt6nO9QTf4WC@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZisyYt6nO9QTf4WC@gauss3.secunet.de>

On Fri, Apr 26, 2024 at 06:49:38AM +0200, Steffen Klassert via Devel wrote:
> On Tue, Apr 23, 2024 at 02:51:21PM +0200, Antony Antony wrote:
> > Reject the usage of the SA_DIR attribute in xfrm netlink messages when
> > it's not applicable. This ensures that SA_DIR is only accepted for
> > certain message types (NEWSA, UPDSA, and ALLOCSPI)
> > 
> > Signed-off-by: Antony Antony <antony.antony@secunet.com>
> > ---
> > v11 -> 12
> >      - fix spd look up. This broke xfrm_policy.sh tests
> > ---
> >  net/xfrm/xfrm_user.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> > index d34ac467a219..5d8aac0e8a6f 100644
> > --- a/net/xfrm/xfrm_user.c
> > +++ b/net/xfrm/xfrm_user.c
> > @@ -3200,6 +3200,24 @@ static const struct xfrm_link {
> >  	[XFRM_MSG_GETDEFAULT  - XFRM_MSG_BASE] = { .doit = xfrm_get_default   },
> >  };
> > 
> > +static int xfrm_reject_unused(int type, struct nlattr **attrs,
> > +			      struct netlink_ext_ack *extack)
> 
> Maybe call that function xfrm_reject_unused_attr to make it clear
> what is unused here?

good idea. Fixed in v13

