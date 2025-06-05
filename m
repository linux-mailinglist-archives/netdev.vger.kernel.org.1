Return-Path: <netdev+bounces-195241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D82ACF001
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 15:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89871713CE
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 13:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92815221FC9;
	Thu,  5 Jun 2025 13:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="HsR4v8p8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I60eOZwF"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E2A20ADE6
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 13:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749128968; cv=none; b=mZmeCTW/5TLp+EvfKU3nXX2Yd6ytHkqklSJ/fmyr6iXJQ8L2MsQVy9O49GKGtvWamxG5Y1h46cTSxnjVBSUja7uzBDFG5wflVU4UdICPnOfQ4qmthKsgxtYSFZw8qIfemHS9RjtpdeHwwvfBjhCDRZDCD+qjesCdMD7VYvhr7JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749128968; c=relaxed/simple;
	bh=oc012CRErAlX/R19OO6y0h92lUfW7KVDwu5kvl8aVfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/oexEnsFBV4K2I7JTjC6qeQR845Lfp4OW4Ev+RtsnNZdihZxU/YLHt2/vo11/SKx/xhSoErOQxJcAY2C5L8FG6z1HmDoLaTvjqwX232QTlVlbmn2twc2Xm80KRPxSRk+NGJk0ipJ6urNFiWu/VIfrq6CbbEw/pQjzRzidVIqTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=HsR4v8p8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I60eOZwF; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 70A151380319;
	Thu,  5 Jun 2025 09:09:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 05 Jun 2025 09:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1749128964; x=
	1749215364; bh=rjq4DK1a9DCfmLlsa+T2JLVJDj403rswC3XC69HTW1U=; b=H
	sR4v8p8wajV+waW5NL7XewOo+Bb80BUbD5YHUm+w/zmwZdkc3DFgXlSCZDpBef2r
	LNvND+hQ9XdEGdnYfPLlg0jrnPR49Y0hRM9p9zWrYXAOFxWE/HI/G1LmeolD0Vvo
	yos7zlW8N6oPo2H0ombkMeTM+WEUBrWbBqeumUUKudzDHEAo+xcdoVxf2sDAYV8e
	DfCkAuSlErwnKJpgVH4bSMrE38jShcuhodZkiLrMOsQQljzJI1XpXMEkmHTfKpCP
	sFqBbjdygId71CzUSaTdrj1lXYNNlbe0PTcficbAW1ywDfPMpB9FJrzlK2L+s26l
	3lHUygs1VyI52GagkxagA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749128964; x=1749215364; bh=rjq4DK1a9DCfmLlsa+T2JLVJDj403rswC3X
	C69HTW1U=; b=I60eOZwF1aMgHRUybLowpWhhCPwpECfiKKXhFdvShAA1zuQMT/a
	/0fE3jI/Pc5P8CrmGvMORJmqfZ/dMFVBBfYYqLTYLv8s07Eqg6FCWbpsEr7TcoCh
	u/ukONpgSV0lunV9PxRpdWzDgzlL3oK9F5gzJ7fx4yLJt9PYgFdSZNXkc2agD9x1
	CYvXf8qq8MzFDfg7YEYlWlXo8w/Gn/r+kWN6fACO+PUZroR3D5T2JfS+oZlX0pA1
	rIH7tlPFtDH3vjLGYODfR72uifP+k2XM2kCCd0te+uHUjlBxElMSE3/19qgZlpRu
	uf9TR6QrwDMLfinO+qmMgD/3XLeaF8KaSqg==
X-ME-Sender: <xms:ApdBaJ9LOpGSm5fp6WUjnEc4kTEtN3J9urZOIcN7aTDCzNwci0bFfQ>
    <xme:ApdBaNsoTRYFMbCdhBp8mG8A_-PufbsrMgE5hpd2PjObxpqA_bNKkEcrAQYDWFxPI
    KqQ6hQ-diKhsDx-XYA>
X-ME-Received: <xmr:ApdBaHB_01z58kOo-jkhTjSUlVjyfy3yVdHlSapi50HjijbUA6fjpwVERTLj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeen
    ucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrg
    hilhdrnhgvtheqnecuggftrfgrthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfek
    geetheegheeifffguedvuefffefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvfhhfvg
    hnrdhklhgrshhsvghrthesshgvtghunhgvthdrtghomhdprhgtphhtthhopehlvghonhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvohhnrhhosehnvhhiughirgdrtghomh
    dprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohep
    vgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehhvghrsggvrhhtse
    hgohhnughorhdrrghprghnrgdrohhrghdrrghupdhrtghpthhtohepkhhusggrsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:ApdBaNdOr2qg5qj0eQ7L1O_TFAW9e4n7EXq94YF8BrSmWgc3SRi4Kw>
    <xmx:ApdBaON_8UnjlbHgXKR5L6ive-WyhPFb6azL-_49XFN0yMw5yHzLKA>
    <xmx:ApdBaPkB5LSchPyy-rhQvCP5_OSQPIdNfUkJyqLqGvNAXBBs9WUBZQ>
    <xmx:ApdBaIseBBE8cjuXXHnwulfOnNXX2k7wDF0MOJR3sIeorglG7vyULw>
    <xmx:BJdBaFcAAgHOJCXxzNuM3Nyt_56hwPp4bkcvOClFNy324sYiVRC8Obd_>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 09:09:22 -0400 (EDT)
Date: Thu, 5 Jun 2025 15:09:19 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Leon Romanovsky <leon@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH ipsec-next v1 1/5] xfrm: delay initialization of offload
 path till its actually requested
Message-ID: <aEGW_5HfPqU1rFjl@krikkit>
References: <cover.1739972570.git.leon@kernel.org>
 <3a5407283334ffad47a7079f86efdf9f08a0cda7.1739972570.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3a5407283334ffad47a7079f86efdf9f08a0cda7.1739972570.git.leon@kernel.org>

Hello,

I think we need to revert this patch. It causes a severe performance
regression for SW IPsec (around 40-50%).

2025-02-19, 15:50:57 +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> XFRM offload path is probed even if offload isn't needed at all. Let's
> make sure that x->type_offload pointer stays NULL for such path to
> reduce ambiguity.

x->type_offload is used for GRO with SW IPsec, not just for HW offload.

-- 
Sabrina

