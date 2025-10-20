Return-Path: <netdev+bounces-230765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B476BEEED8
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 02:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9EA724E1A1D
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 00:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22ADF42049;
	Mon, 20 Oct 2025 00:23:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CCB28371;
	Mon, 20 Oct 2025 00:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760919819; cv=none; b=b083koyHU8VvnjREznO/udpYPP3C0gXew+1VT9+cHN3AHDFi2vQfFxUXe5j0mz6p3DsPseiPfZvo25meXmvtkLcpGRt7tjVTXlydD6BdVkX8yXxnbPyCPkyqOlH2cEl6oeMDV8Xw0+VY9ub5TOZpTyuyG4ilhYkh7o5tI6Q3bSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760919819; c=relaxed/simple;
	bh=HiIULQSuyslydFWpUxy0SQSmiRBnl+8P9lhWbi1iaPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEZ2/Y4ue1TlrAZxoN4FwrulkZy85oWi6WlsGwkRjW6u2QqoDCpx1tmG5qmzYIPcgqQFZf9IA7W/LCW8GbonjcNTerqQu1iml4e4R7dxsZ5TmWSLepgOLjo+xT0yZkBAzAnnBfSJt6E8ZhQhgiXk8xpaQnoDd30m6iQ2xc/ftT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vAdgL-000000000rQ-2ti0;
	Mon, 20 Oct 2025 00:23:25 +0000
Date: Mon, 20 Oct 2025 01:23:12 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v3 4/7] net: dsa: lantiq_gswip: manually convert
 remaining uses of read accessors
Message-ID: <aPWA8O_0kIkKEdQS@makrotopia.org>
References: <cover.1760877626.git.daniel@makrotopia.org>
 <b0cc75e63daffee27f5fdab35d49d7bfb10e48bb.1760877626.git.daniel@makrotopia.org>
 <20251019152545.524ac596@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251019152545.524ac596@kernel.org>

On Sun, Oct 19, 2025 at 03:25:45PM -0700, Jakub Kicinski wrote:
> On Sun, 19 Oct 2025 13:48:36 +0100 Daniel Golle wrote:
> > +	for (i = 0; i < ARRAY_SIZE(tbl->key); i++) {
> > +		err = regmap_read(priv->gswip, GSWIP_PCE_TBL_KEY(i), &tmp);
> > +		if (err)
> > +			return err;
> > +		tbl->key[i] = tmp;
> > +	}
> > +	for (i = 0; i < ARRAY_SIZE(tbl->val); i++) {
> > +		err = regmap_read(priv->gswip, GSWIP_PCE_TBL_VAL(i), &tmp);
> > +		if (err)
> > +			return err;
> > +		tbl->val[i] = tmp;
> > +	}
> >  
> > -	tbl->mask = gswip_switch_r(priv, GSWIP_PCE_TBL_MASK);
> > +	err = regmap_read(priv->gswip, GSWIP_PCE_TBL_MASK, &tmp);
> > +	if (err)
> > +		return err;
> >  
> > -	crtl = gswip_switch_r(priv, GSWIP_PCE_TBL_CTRL);
> > +	tbl->mask = tmp;
> > +	err = regmap_read(priv->gswip, GSWIP_PCE_TBL_CTRL, &tmp);
> > +	if (err)
> > +		return err;
> 
> Coccicheck points out we're holding a mutex here, can't return directly.

Correct. Thank you for pointing that out. I will fix this in v4.

