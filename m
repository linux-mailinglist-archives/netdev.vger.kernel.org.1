Return-Path: <netdev+bounces-167786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F593A3C46B
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 17:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435053B6B65
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 16:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5D71F3B83;
	Wed, 19 Feb 2025 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Xn5XdH8Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0k6/xkON"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7AA14A91;
	Wed, 19 Feb 2025 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981054; cv=none; b=dd/zDg3DvNzqnhKCClYWQJq+gqX6coxx5fnBRZ0P8qI9RH6tFyKTEFBSUBKRQKOUC5ZWvK+TkRpKM0cp8aOMq9h7dtBu0CVXGFHFpuyroy5Tm5dIwFpmZdKYjo+Mv5jk1MTiXqywyTsKqXi8LaxDuXEjGcXkOm1Tmopb3QpW7YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981054; c=relaxed/simple;
	bh=U9aatbgVh/VMCxNBWMgVD08XxuyfLbPpwBTGGpC9/Cc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DNfDb74PomfEnt8WS4g/5gG06BzJaMZkP4GxVJ+bdeGjDwrQETRhwb8870podkAkfVlDR/CvngtKK4UnVi3Zf9Oaa7huhpegZEcIoVpV7y/uVysYoT+suCrkOkDVYLabtSTG++ZIXz1pz4IrSAVp3Qb++h/JphaAYf0aVHJ/QUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Xn5XdH8Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0k6/xkON; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 453361140121;
	Wed, 19 Feb 2025 11:04:11 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Wed, 19 Feb 2025 11:04:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739981051;
	 x=1740067451; bh=Wepfq+N3jZTlBa40ZfQRXlCbCHPFRJLnW34nES6e8+c=; b=
	Xn5XdH8YQHgGhH+Bor16ARPxvCJHtEgpCXY3fGUJCQdCXm3eiJMHBqijsYNUwLWo
	i8WT2cQLQ5DUJMfjjFv8d7v0Cq3L1vS3VN1FlYZppf5Phl9RjdWJATZFrmCbXpNZ
	MySmvVLZcjX1CrfB08SBESlVVuJMh9ekrW7XAuKGMNSKPmkLWZPSSXv7uXXGnCrO
	F39vGqIm4OXkm2sSXnpUJkJdcxGRgnC/gpTx9uikkQj0sBLU5TF8F/nnzWE3arjA
	dETcTXQCvzxquOD7hjK0XTZEuQlUNHV7I5ovkhRzexDBRgLHDEvsAdsk1OrGiaWA
	2GIW3wahuJfrUTrXd54FuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739981051; x=
	1740067451; bh=Wepfq+N3jZTlBa40ZfQRXlCbCHPFRJLnW34nES6e8+c=; b=0
	k6/xkONKw0Qfjc8LB0UTfFqrwlHga+Ntk5rtqdpXZfkbffZ4xAM8VEBZrfjDjPDA
	ZDnmBcbeFkt4Igp071O6JBuWC4VI1gwFEf3fOCL4HR8GRLasC+7FvSZpU9hdz/bz
	cH/uwQxF4+pkf4shcI71FAl1+MhgUI++CP95ZnHAUhXwW622UPBeOyn5DtC6JNzX
	C7VegSuQwcEY7HfaYsGLXF17YUQtUjdcjCq1RQYcEiLlc03XM2l+XsQIqEgvpA9L
	zFYOgzOFgCuNn+0Oc0QmFsq8Mvp7VBLO755/sbi8lIUjxGofcW4VGY+gbNfntipg
	J4KpaIZLt5bD36ngJY2Yg==
X-ME-Sender: <xms:-gC2Z7G2Y87c__hqGNS_B4AmYZaWTaLIITtvJ5u_EJ7mv21dbbt68Q>
    <xme:-gC2Z4XruaeQLw9iXaKdXbJkordVSQKmUkhRMWZTue7x_dlkuaSK2ha0-F6JMf-Cc
    A32J5O3G_vFmRtG0m8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    jedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhloh
    hfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhr
    tghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhohhrmhhsse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhope
    gssghhuhhshhgrnhdvsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepghgrkhhulhgr
    sehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohephhhkvghlrghmsehmrghrvhgvlhhlrd
    gtohhm
X-ME-Proxy: <xmx:-gC2Z9Idv999dSXvscrirp437WD8o0zbQS-3qX_u0Gwng24BuIX71Q>
    <xmx:-gC2Z5HKpdcgHyVEWSFSPFQO_Tlz2KAr42U-bWtakXru49i8jx6qcg>
    <xmx:-gC2ZxVKhX1hcWGVQGgYTb0y2seT6etGOqKIrQ6NZx52U7I-MKJYPg>
    <xmx:-gC2Z0MFkjSbhLKPecczm8--VkjJc8IC5nB3akmjbSHw7AgvAX_yGg>
    <xmx:-wC2Z1nKDjPhoLXrE8h5SL57RjT4UR2aYddZCquRcn4bmtLls1-kGdmB>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 533772220073; Wed, 19 Feb 2025 11:04:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Feb 2025 17:03:49 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Arnd Bergmann" <arnd@kernel.org>, "Sunil Goutham" <sgoutham@marvell.com>,
 "Geetha sowjanya" <gakula@marvell.com>,
 "Subbaraya Sundeep Bhatta" <sbhatta@marvell.com>,
 hariprasad <hkelam@marvell.com>, "Bharat Bhushan" <bbhushan2@marvell.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 "Suman Ghosh" <sumang@marvell.com>,
 "Sai Krishna Gajula" <saikrishnag@marvell.com>,
 "Nithin Dabilpuram" <ndabilpuram@marvell.com>,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
Message-Id: <b7462eca-4900-4fb6-8ddc-7d27897ced7f@app.fastmail.com>
In-Reply-To: <20250219142433.63312-1-arnd@kernel.org>
References: <20250219142433.63312-1-arnd@kernel.org>
Subject: Re: [PATCH net-next] octeontx2: hide unused label
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Feb 19, 2025, at 15:24, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> A previous patch introduces a build-time warning when CONFIG_DCB
> is disabled:
>
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c: In function 
> 'otx2_probe':
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:3217:1: error: 
> label 'err_free_zc_bmap' defined but not used [-Werror=unused-label]
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c: In function 
> 'otx2vf_probe':
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c:740:1: error: 
> label 'err_free_zc_bmap' defined but not used [-Werror=unused-label]
>
> Add the same #ifdef check around it.
>
> Fixes: efabce290151 ("octeontx2-pf: AF_XDP zero copy receive support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sorry, this version caused a different build failure a few randconfig
builds in, please ignore and wait for v2.

      Arnd

