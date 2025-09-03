Return-Path: <netdev+bounces-219658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DC6B4287F
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 20:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6567486628
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 18:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C67335E4C2;
	Wed,  3 Sep 2025 18:06:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E772EBDC0;
	Wed,  3 Sep 2025 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756922768; cv=none; b=JCkmNr32uysVAyyjPOI21hk6FSHsD9tHa104QXMyWyqw8WNJxTSkosGflq0HqtBAslUgBQnoNb5YiQbelVVq00L48MYex7g57Tn+zybTZGJsepU24MojQPdfab5FoH9UjozGVASOeG3iZEiq2MqwGBnodAdTVwz261SS7eXQ8zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756922768; c=relaxed/simple;
	bh=fww3ehX4//bBypexZT3unOOmv4CPVi/DOuYiuvac4Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2eLVXJagJlVOGQ7Zt4g02BlHMzcJseNNIFVs+09XpTHbPz7jwGHMyPQfcqjd+PIFHezSOyS9XBC9CU0vDsLtsl1d2Jr8jGjF22wBl+GzHc0ppKnY0y4Eprrk57Ztt0XMysW7byAVKiVZf2yAUK5iUUhnYNT9lQnPFWyQasIwII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1utrrn-000000006q3-35cG;
	Wed, 03 Sep 2025 18:05:55 +0000
Date: Wed, 3 Sep 2025 19:05:50 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Andreas Schirm <andreas.schirm@siemens.com>,
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
Subject: Re: [PATCH net-next v2 1/6] net: dsa: lantiq_gswip: move to
 dedicated folder
Message-ID: <aLiDfrXUbw1O5Vdi@pidgin.makrotopia.org>
References: <cover.1756228750.git.daniel@makrotopia.org>
 <ceb75451afb48ee791a2585463d718772b2cf357.1756228750.git.daniel@makrotopia.org>
 <20250828203346.eqe5bzk52pcizqt5@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828203346.eqe5bzk52pcizqt5@skbuf>

On Thu, Aug 28, 2025 at 11:33:46PM +0300, Vladimir Oltean wrote:
> On Wed, Aug 27, 2025 at 12:05:28AM +0100, Daniel Golle wrote:
> > Move the lantiq_gswip driver to its own folder and update
> > MAINTAINERS file accordingly.
> > This is done ahead of extending the driver to support the MaxLinear
> > GSW1xx series of standalone switch ICs, which includes adding a bunch
> > of files.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> > v2: move driver to its own folder
> > 
> >  MAINTAINERS                                 | 3 +--
> >  drivers/net/dsa/Kconfig                     | 8 +-------
> >  drivers/net/dsa/Makefile                    | 2 +-
> >  drivers/net/dsa/lantiq/Kconfig              | 7 +++++++
> >  drivers/net/dsa/lantiq/Makefile             | 1 +
> >  drivers/net/dsa/{ => lantiq}/lantiq_gswip.c | 0
> >  drivers/net/dsa/{ => lantiq}/lantiq_gswip.h | 0
> >  drivers/net/dsa/{ => lantiq}/lantiq_pce.h   | 0
> >  8 files changed, 11 insertions(+), 10 deletions(-)
> >  create mode 100644 drivers/net/dsa/lantiq/Kconfig
> >  create mode 100644 drivers/net/dsa/lantiq/Makefile
> >  rename drivers/net/dsa/{ => lantiq}/lantiq_gswip.c (100%)
> >  rename drivers/net/dsa/{ => lantiq}/lantiq_gswip.h (100%)
> >  rename drivers/net/dsa/{ => lantiq}/lantiq_pce.h (100%)
> 
> I don't have a problem with this patch per se, but it will make it
> harder to avoid conflicts for the known and unsubmitted bug fixes, like:
> https://github.com/dangowrt/linux/commit/c7445039b965e1a6aad1a4435e7efd4b7cb30f5b
> https://github.com/dangowrt/linux/commit/48d5cac46fc95a826b5eb49434a3a68b75a8ae1a
> which I haven't found the time to submit (sorry). Are we okay with that?

I've prepared a tree rebasing your tree

https://github.com/vladimiroltean/linux/commits/lantiq-gswip/

onto current net-next:

https://github.com/dangowrt/linux/commits/lantiq_gswip-fixes-for-vladimiroltean/

If you don't have time to submit the patches from this tree yourself I
can do that on your behalf, just let me know which of the patches you'd
like to submit as fixes, I'll find the causing commit, add the Fixes:-tag
and send them to netdev@ for the net tree after the next net-next -> net
merge.

Or, in case that makes more sense, send the patches to 'net' now and
then solve the conflicts at the next net-next -> net merge, what ever
works better.


