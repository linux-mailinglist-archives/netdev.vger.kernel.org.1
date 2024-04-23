Return-Path: <netdev+bounces-90527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A968AE645
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 14:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2CC1F2482D
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00A8127E1B;
	Tue, 23 Apr 2024 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="mQJACeAa"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCED12F374
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875759; cv=none; b=ViSK2r84vizryAxzKNoxMN1l9Xn4zUCHa+F/x/dI5UqViwYLAqwYh2GeR5Ae4QvQZ2/KEl0jqSn9Lwc3z2n/x3zI7BJyXxcRi3/avnjBdZ+eI/koMBCUM4zNgbh5hgwR2pL5MhO/3IMg0rO7bGMCA0Ug/E9pjgi8mOvapZjNo2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875759; c=relaxed/simple;
	bh=qN3DK+dqxc0w5Ckaeqsi+wqwPBM8dYUP3Q5yTKyvkIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyMCT4Ovpcg6bSKnSp5FFpzY54PSNeH2dydnWupfRMz7+++il+6enDSibO5xwSFEVjP97lWkZGjsF3WpoHPi32as3+DU7SVxnTCZPFqmbnxITTg2foqMP6qR3uShZUgDvAPPqI8dxyICHf1Hwo2C1vFX22O7T40FA+t4dc4zLk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=mQJACeAa; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: ab7b18e9-016d-11ef-bbc8-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id ab7b18e9-016d-11ef-bbc8-005056abad63;
	Tue, 23 Apr 2024 14:33:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=x1GonqVmjNR8FPaAm+4Ei6OxNjQUup7BZ/qmsStikjc=;
	b=mQJACeAaSE7hNnoHiE7bHCpcsDhGTqQyHcw1IxsEa8EyXgnZZLHHtS3qga17ivdBkfPpzqk/xyRrF
	 IqMAN5LuXBaqnKqQ/IUVKtQNws0z8cQbL7+ZjsjWSUpW278OtUa4ShaPlJemc0VomZOIWQrxO/AiZU
	 sPz2Cxy5zpeLqSZ8=
X-KPN-MID: 33|4NLh9EECG1GMX/SEEV8Vd4417tXEDOdbtLgDzplZt0CA+6R7JCfRaBfCjoJ85St
 WlB5ArWQ6VMDqVCsF3W7KL9Xs58lCIbdJjB9OS3Fl00w=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|IFli1I1gQzGba/NVIBVrwTUP3/9qAJqe4UEVymnQlq/IllJDJf54fpMuZUtZ/Gf
 1aaTuMeYKhJ75AFxca4PfKQ==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id dcbaf313-016d-11ef-a498-005056abf0db;
	Tue, 23 Apr 2024 14:34:45 +0200 (CEST)
Date: Tue, 23 Apr 2024 14:34:43 +0200
From: Antony Antony <antony@phenome.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org, Leon Romanovsky <leon@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH ipsec-next v11 0/4] xfrm: Introduce direction attribute
 for SA
Message-ID: <Zieq42gpRYoOFhgM@Antony2201.local>
References: <cover.1713737786.git.antony.antony@secunet.com>
 <20240422060538.466f8232@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422060538.466f8232@kernel.org>

On Mon, Apr 22, 2024 at 06:05:38AM -0700, Jakub Kicinski via Devel wrote:
> On Mon, 22 Apr 2024 00:23:58 +0200 Antony Antony wrote:
> > Hi,
> > 
> > Inspired by the upcoming IP-TFS patch set, and confusions experienced in
> > the past due to lack of direction attribute on SAs, add a new direction
> > "dir" attribute. It aims to streamline the SA configuration process and
> > enhance the clarity of existing SA attributes.
> > 
> > This patch set introduces the 'dir' attribute to SA, aka xfrm_state,
> > ('in' for input or 'out' for output). Alsp add validations of existing
> > direction-specific SA attributes during configuration and in the data
> > path lookup.
> > 
> > This change would not affect any existing use case or way of configuring
> > SA. You will notice improvements when the new 'dir' attribute is set.
> 
> This breaks the xfrm_policy.sh selftests.

I mised spd lookup use diffrent nla_policy array than xfrma_policy.
I fixed it in v12.


> -- 
> pw-bot: au
> -- 

