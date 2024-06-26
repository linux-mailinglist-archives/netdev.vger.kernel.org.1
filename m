Return-Path: <netdev+bounces-106892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27891917FA8
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 13:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52ED51C20A19
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 11:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CADA17E479;
	Wed, 26 Jun 2024 11:29:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B224617D8B4;
	Wed, 26 Jun 2024 11:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719401377; cv=none; b=jNeIrJnksO+aOywAZ2W12ddEXUnPH/ggJentOIbnRgriHraidWGvYTyCTlWFtqZvlSvcpfOvGnuXlpd5/4VECuQtbooaTI7Pg6rG1YOk3tNz2lQ/D+q4h/37TULIGgmk6LX0zvjG7Ya5S97SE/9dQhmde7pN1enMbBUzv9j11PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719401377; c=relaxed/simple;
	bh=+9Gkc4qr4irOpAFTF3vqN/TYsfYENVUyC3iax2M2OTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2EUIz3YMmAsn0m81Ua2CbJV08aVyUcYiIUKICOQO/eEOZ9E+yCTPwK6bQRLfke6gHshNjGypmXAWifXg421LAsBcnMhjpNm+oH5yW14wnC8o/oxqsYVgPj+DPDvvE0xJKa50fRFgjZ6x9fN75xsEUdyCQjq5Wc6F5JxyF/2y/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.37.63] (port=53174 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1sMQq8-007rzC-VM; Wed, 26 Jun 2024 13:29:30 +0200
Date: Wed, 26 Jun 2024 13:29:28 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Ismael Luceno <iluceno@suse.de>
Cc: linux-kernel@vger.kernel.org,
	Michal =?utf-8?Q?Kube=C4=8Dek?= <mkubecek@suse.com>,
	Simon Horman <horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>,
	lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH] ipvs: Avoid unnecessary calls to skb_is_gso_sctp
Message-ID: <Znv7mLoGBZGSjT-X@calendula>
References: <20240523165445.24016-1-iluceno@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523165445.24016-1-iluceno@suse.de>
X-Spam-Score: -1.9 (-)

Hi,

I have placed this patch in the nf-next tree to be included in the
next pull request.

Thanks.

