Return-Path: <netdev+bounces-109462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF709288CD
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 14:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437581F24974
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 12:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D0214A616;
	Fri,  5 Jul 2024 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wuP2hoIB"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8F114A4D6
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 12:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720183157; cv=none; b=upmsWqIi8CPcwmljjWdgUIYh9BAFP0rEg2c9sypBdM/IPmNOkR7J+Kkb2u53dxtEpocgH1Cn8UlKvbi704Ci+e4r1oQcVjHmj2pclhbA83hNEshkY8ttUYTT78XNklbuwzpdjVE1vto0ERFM/DGPwxAkBL1PNVQSi37OCfbfDGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720183157; c=relaxed/simple;
	bh=tHnuoSRBgTcDZAChYCQ80oP8IRIcP8sWMJoLXFlrdpY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i3e4CnhsNIQxDdx/fcsdrc3Y6NeVeGAQpfq1xb0hgWYzgj60Abi2OXPAWqy/qSKk/2b8Ly9dybEGYcT4zzsmA8giLRdeO96xKsQZUdN6Ar6BORfUkPuKaz0+05Qhn6FHBrjDmN2ZUZcy9KyWfZPkU/Tvdb12AqBxO+rYQk6WCys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wuP2hoIB; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vdrKZBGhdtKLqEE4ka46r2w3LqV5jHzdvqJWhYctCBA=;
	t=1720183156; x=1721392756; b=wuP2hoIB2yWN9apDsuEpXRnuRg/LzTxcdkNfvdSF/VBeHmC
	KRLDBxuwORXUSyjMTzYQHg3VY21AkZ+42BvN6l7ldU384Y/kncxDGYKMyg8qdzEabcdnAPO10YACL
	ahJKPp4S5+MRm46uN9UTTu4e4qouzQiMuj39Zrgve6l64iteMV20p411N3rMM4iXrAuon4oixSIjP
	NwtgMyn9YrYeji81YHYVpo5xBtmgZ3oo0HFQrSoa6wziHBWvOp3WrDlG/luxwyTTwr+PNVyHyC2Q7
	TYAK9bnsOSkMAh9S6cCXFUwkC45m9ZADOJSpfMiWCR34cEbYidhVPzSxMXqq2tQQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sPiDV-0000000GNcv-1X2z;
	Fri, 05 Jul 2024 14:39:09 +0200
Message-ID: <b836eb8ca8abf2f64478da48d250405bb1d90ad5.camel@sipsolutions.net>
Subject: Re: [PATCH net-next] net: page_pool: fix warning code
From: Johannes Berg <johannes@sipsolutions.net>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Yunsheng Lin
 <linyunsheng@huawei.com>
Date: Fri, 05 Jul 2024 14:39:08 +0200
In-Reply-To: <228b8f6a-55a8-4e8b-85de-baf7593cf2c9@intel.com>
References: 
	<20240705134221.2f4de205caa1.I28496dc0f2ced580282d1fb892048017c4491e21@changeid>
	 <50291617-0872-4ba9-8ca5-329597a0eff5@intel.com>
	 <ac90ee8aa46a8d6dd9710a981545c14bf881f918.camel@sipsolutions.net>
	 <228b8f6a-55a8-4e8b-85de-baf7593cf2c9@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-07-05 at 14:37 +0200, Alexander Lobakin wrote:
> From: Johannes Berg <johannes@sipsolutions.net>
> Date: Fri, 05 Jul 2024 14:33:31 +0200
>=20
> > On Fri, 2024-07-05 at 14:32 +0200, Alexander Lobakin wrote:
> > > From: Johannes Berg <johannes@sipsolutions.net>
> > > Date: Fri,  5 Jul 2024 13:42:06 +0200
> > >=20
> > > > From: Johannes Berg <johannes.berg@intel.com>
> > > >=20
> > > > WARN_ON_ONCE("string") doesn't really do what appears to
> > > > be intended, so fix that.
> > > >=20
> > > > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> > >=20
> > > "Fixes:" tag?
> >=20
> > There keep being discussions around this so I have no idea what's the
> > guideline-du-jour ... It changes the code but it's not really an issue?
>=20
> Hmm, it's an incorrect usage of WARN_ON() (a string is passed instead of
> a warning condition),

Well, yes, but the intent was clearly to unconditionally trigger a
warning with a message, and the only thing getting lost is the message;
if you look up the warning in the code you still see it. But anyway, I
don't care.

The tag would be

Fixes: 90de47f020db ("page_pool: fragment API support for 32-bit arch with =
64-bit DMA")

if anyone wants it :)

johannes

