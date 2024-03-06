Return-Path: <netdev+bounces-78087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC34874066
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 20:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33EECB214BF
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 19:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA3B13F01A;
	Wed,  6 Mar 2024 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="rB9UsV13"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6146692E6
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 19:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709753351; cv=none; b=nKmKQ0225QE0QJ65H9lyc3Wsfj8Isk8Xqjw7rV8oM5C229jqY75j8qQRK4GFB2H0niDi0xuY4B29LekKdSPEIbmghN4IpvZ+Qbq34nV/JOIhlcxYqZX/074eAqUXlK2o3PcSip+iwOzBVasGOJWLTx7RjToZw/7qa1/8RcMuZNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709753351; c=relaxed/simple;
	bh=zhsrGwuQxImnHPu9xgBudeJN7ysUC/JLeZ94xEXQtxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrI53d8Ll7MOD5I84jobr+NsPeV1kV4XWN/42WYOiulw9oknI8PsE6c9EXM34lQ2QdGcBVWqHuiUjXB0tWNoS0fucNmowibQe3x6OVLmoC1aNy/hjnaWau5A7m4cdnstyGsU9wskM3FAeaXfB3vLiOPxqmr7exbKCCIvFpBKAi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=rB9UsV13; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: be8742a8-dbef-11ee-bbc8-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id be8742a8-dbef-11ee-bbc8-005056abad63;
	Wed, 06 Mar 2024 20:28:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=hEpqZNxMLTMQfF7dTxVr917IlCjxR+nhc9FdS6Aqbuk=;
	b=rB9UsV13LvVNR3eAEMYvg6fuMAXJkhxFGLxPCgf9Jo0ORhpWnY+GyOQeZy2osAChkIro0NkLFZAkA
	 ru/+bU4Fw4tnGGWoxvCYroc47C7ZAN++ABC/HYvdzi2VcCHAEj9MDY5mHQP5EqB5OzB9pTtJ3tbUdW
	 +CdteDH8r8kv2uLQ=
X-KPN-MID: 33|BFEiUYTbgALovnuIvj/fl+Nivlpvs3VBzZ3QVU7w9UbB95yzseLxfFsegHXW6YF
 lf8KB1uLd4zdUIzVmOnvFVDN1yoSDxfB0vKpYa2IA5/E=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|qias74Y5yHBqEIaBt5EVpB5d7CmF8E0UwecPHsp/9RZmiv2iOQTvVmsA0BsBTpO
 rh+CuATrdYD3jm7hx8yeXHg==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id c702b19b-dbef-11ee-a208-005056ab1411;
	Wed, 06 Mar 2024 20:28:59 +0100 (CET)
Date: Wed, 6 Mar 2024 20:28:57 +0100
From: Antony Antony <antony@phenome.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Antony Antony <antony.antony@secunet.com>, netdev@vger.kernel.org,
	devel@linux-ipsec.org, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [DKIM] Re: [devel-ipsec] [PATCH ipsec-next] xfrm: Add Direction
 to the SA in or out
Message-ID: <ZejD-aDwyXS87ovP@Antony2201.local>
References: <d84a02e019ef188c4295089f6134af67ef7e7452.1709498351.git.antony.antony@secunet.com>
 <20240304074239.GB13620@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304074239.GB13620@unreal>

On Mon, Mar 04, 2024 at 09:42:39AM +0200, Leon Romanovsky via Devel wrote:
> On Sun, Mar 03, 2024 at 10:08:41PM +0100, Antony Antony wrote:
> > This patch introduces the 'dir' attribute, 'in' or 'out', to the
> > xfrm_state, SA, enhancing usability by delineating the scope of values
> > based on direction. An input SA will now exclusively encompass values
> > pertinent to input, effectively segregating them from output-related
> > values. This change aims to streamline the configuration process and
> > improve the overall clarity of SA attributes.
> > 
> > Signed-off-by: Antony Antony <antony.antony@secunet.com>
> > ---
> >  include/net/xfrm.h        |  1 +
> >  include/uapi/linux/xfrm.h |  8 ++++++++
> >  net/xfrm/xfrm_compat.c    |  6 ++++--
> >  net/xfrm/xfrm_device.c    |  5 +++++
> >  net/xfrm/xfrm_state.c     |  1 +
> >  net/xfrm/xfrm_user.c      | 43 +++++++++++++++++++++++++++++++++++----
> >  6 files changed, 58 insertions(+), 6 deletions(-)
> 
> <...>
> 
> > +enum xfrm_sa_dir {
> > +	XFRM_SA_DIR_UNSET = 0,
> > +	XFRM_SA_DIR_IN	= 1,
> > +	XFRM_SA_DIR_OUT	= 2,
> > +	XFRM_SA_DIR_MAX = 3,
> > +};
> 
> <...>
> 
> > +	if (attrs[XFRMA_SA_DIR]) {
> > +		u8 sa_dir = nla_get_u8(attrs[XFRMA_SA_DIR]);
> > +
> > +		if (!sa_dir || sa_dir >= XFRM_SA_DIR_MAX)  {
> 
> Netlink approach is to rely on attrs[XFRMA_SA_DIR] as a marker for XFRM_SA_DIR_UNSET.
> If attrs[XFRMA_SA_DIR] == NULL, then the direction is XFRM_SA_DIR_UNSET.

yes I aggree.
the above 'if' changed to

if (sa_dir != XFRM_SA_DIR_IN  && sa_dir != XFRM_SA_DIR_OUT)  {

> Also, why do you need XFRM_SA_DIR_MAX in UAPI?

Agree, I removed it.

thanks,
-antony

