Return-Path: <netdev+bounces-226086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1F1B9BD58
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 22:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00537380E4F
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 20:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519BA327A3D;
	Wed, 24 Sep 2025 20:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="NESutuBM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I+Wi1wBs"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E8D30BF55;
	Wed, 24 Sep 2025 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758745096; cv=none; b=J+ugFa8FGQEHh/f8BVyxlGw7KiFafMD/t7L9cptQi3/VqUDdVMOdlREah05vvWQ8HC0irrezoWo0+ZEnyQBqgAgBIrZT81IIJTo3/5myee8JjbNSOttzvmuIBcl14UjULXaClzxp+kzxPLyaex1L4rOz6QwJH1KFuTzf6SmZnYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758745096; c=relaxed/simple;
	bh=EqYtmV7TAcM2X9vdFPDPz8hYQ+v6LDf37ftyviq9hac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJNnZaq6DoqzXX1oQsIk71Q1ECbEr10xObYfEhBmVO1Hmr3Q9v84Dz2yVFKmSB6SBupVLW9J4oiDmIDNgoRj65fF9s8Gxq6otHsOXCJxne/OLWxvnWudlsWsGGSKJy0M8Ic7MY1hiOGKBeqE2kRQFmUbqYmexkuBWxTJMmjs1OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=NESutuBM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I+Wi1wBs; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 2FCEE1D0016F;
	Wed, 24 Sep 2025 16:18:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 24 Sep 2025 16:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1758745091; x=
	1758831491; bh=qIL7VdXNc2rL1a7aBbmlZN+TWI2aTIAh5NhrmccsOLI=; b=N
	ESutuBMKprzGKlasl7bB81yqy3kNgkqfZ/UrWV+AaOPeCVMUJdwZHbOfI91qWYmo
	pxSPQNPTMFT2rsMuegkN/lo5eI3spvBa1jvkr3FmCn1HgsUkPRJmD2w9YQZJJpg/
	pWlHu3m+revuwLWpcE7Sk2IHDS0xc6zFHxKYWJCzysPieOIMfcBqaYMx3iiSC010
	JKxN8d2czIlZjc6OUagwa5eRw2qH8BYlt7P2aW9lIxhdiRW0DD3jrMXSNc5ja/S7
	Vr0PabSaH4TOptfoJdh6m7ytatm2zT0fEk6G02ZIoMQKnxl3/knKRLswqGWYScLP
	C2hsryEmMEqhs71BlNTcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758745091; x=1758831491; bh=qIL7VdXNc2rL1a7aBbmlZN+TWI2aTIAh5Nh
	rmccsOLI=; b=I+Wi1wBsacBuJbno012P9WTIM0Cx3c71U2kTZGHV6/qcNvOFp3U
	ASiCDQhgrjPYLulxT1oGNRR8YhKuT6Pe5t4jhzYw3F6rNztxNkAqiIxivOQbicLQ
	ke/xUXK/TmUCuchdILH6DuMqQVKvE1yA0LJxBbvNHjmJN1HInJkN5H1rvkQNaf15
	xNlJEXEjqceQrZi3pA4Jm7aPLJxanJ24P7xjdp66MLmIVmDMs6jdF+BSkM3E3yVd
	z82mZ7oAkWyJnv0lmYiheRbOuSatpQQ7JGA11hMosVlPW54Crs8d/v/3UukTpVYm
	HPP7aV/0RaMXmZ+xZXAuy3YXy43gxD3xYdw==
X-ME-Sender: <xms:AlLUaGx5YXB7uYB5WWY8tRLHtkPWJJ-m3MxnVgtqVAMzSRJXlxIwMA>
    <xme:AlLUaIQyKt10OPXJ57PRh0betJur52udFVb3cRphm5iLJC5esTxLdlgDasJ-Z6HwW
    30a9qFehtFDmk8NNd9q12CtXzsySirVioZwFREo7OOIpL7j8Hgn9w>
X-ME-Received: <xmr:AlLUaDKDyrFU71yvBdqch4Nan_xSbZaynVrsKiK2RFq_RX3Bc4GAPyjIS8nm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehguhhsthgrvhhorghrsheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvg
    hmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohho
    ghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtg
    hpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghv
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:AlLUaPXYorV4qVyqlw1XAr2VdhCvVVutANTxN-0EVoa2uwx_J1mvmQ>
    <xmx:AlLUaHRAmaYAOa_CXD8gtWAVfVVtU3h44Hg1tfzaBMHn2fShAHr4wA>
    <xmx:AlLUaHAvkQRlISgtDaalEozoftsNbfBPpI46sN2MSIBv2cafBHjntQ>
    <xmx:AlLUaGIW_jSQWWfjv_0yquDg5o69PNOq2ryL-X1aKu7_n7tsRYQIfg>
    <xmx:AlLUaEzfnFaENQof4-wtZVQc70sNIK-rZjLPViKWRULNAKMtDCzOvzh2>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 16:18:09 -0400 (EDT)
Date: Wed, 24 Sep 2025 22:18:08 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] tls: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <aNRSACsf_h3ePDhf@krikkit>
References: <aNMG1lyXw4XEAVaE@kspp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aNMG1lyXw4XEAVaE@kspp>

Thanks for the updated patch.

A process nit: the correct subject prefix for this type of work within
networking would be [PATCH net-next v2] (indicating it targets the
"net-next" tree).

2025-09-23, 22:45:10 +0200, Gustavo A. R. Silva wrote:
> Remove unused flexible-array member in struct tls_rec and, with this,
> fix the following warning:
> 
> net/tls/tls.h:131:29: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Also, add a comment to prevent people from adding any members
> after struct aead_request, which is a flexible structure --this is
> a structure that ends in a flexible-array member.

Once that warning is enabled, re-adding a field after aead_req will
not be allowed by the compiler, right?  The comment is probably not
really needed, but since there are "must be first" comments all over
include/net, I guess it's useful.

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

