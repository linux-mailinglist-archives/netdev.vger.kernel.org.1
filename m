Return-Path: <netdev+bounces-21171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E3D762A32
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 06:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5678280A68
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 04:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B145382;
	Wed, 26 Jul 2023 04:17:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053446ABD
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 04:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2708CC433C7;
	Wed, 26 Jul 2023 04:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690345035;
	bh=wQstHp+EcrlsHWWQOCouggFaFFoZZW+KsBl9YldoDUk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pDd51KKK+XBXqygcGzM/kZtZDiJSkS8Q+83ttVkHfEaU96MdfKLIqmsSNrVG5c4FR
	 TUigg0jRpdDSv64rvnPNYEdpRRRNeRfIoAcgiRFCzd/r6HLrKDrzFF4Aakb3/N9JWb
	 z6htCTBbvJP3fVNBbgxVci1muQck/ZJLX3ovfblhUH/jWixRZahe3u8K6IDs370c+f
	 c0Eyx9ZfZiVenV5KCaVTznkvWACkpU9Mrq+dE/cwmYa8lpQPRsY3kc5OX0suInRIWK
	 t9JhFtbYiahI5hK5zjXB0ZZmnFnEDWdzwrHt2BXuK1Aa9vQqRsV2Dm89+E7A4CewnL
	 MWMW6stg7mrDw==
Date: Tue, 25 Jul 2023 21:17:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yinjun Zhang <yinjun.zhang@corigine.com>
Cc: Louis Peens <louis.peens@corigine.com>, David Miller
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <simon.horman@corigine.com>, Tianyu Yuan <tianyu.yuan@nephogine.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, oss-drivers
 <oss-drivers@corigine.com>
Subject: Re: [PATCH net-next 00/12] nfp: add support for multi-pf
 configuration
Message-ID: <20230725211713.0b603f13@kernel.org>
In-Reply-To: <DM6PR13MB3705D2C63AC215F1BEC51BB7FC00A@DM6PR13MB3705.namprd13.prod.outlook.com>
References: <20230724094821.14295-1-louis.peens@corigine.com>
	<20230724170100.14c6493a@kernel.org>
	<DM6PR13MB3705B9BEEEE2FF99A57F8559FC03A@DM6PR13MB3705.namprd13.prod.outlook.com>
	<20230725115933.29171e72@kernel.org>
	<DM6PR13MB3705D2C63AC215F1BEC51BB7FC00A@DM6PR13MB3705.namprd13.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jul 2023 02:00:30 +0000 Yinjun Zhang wrote:
> > >   serial_number UKAAMDA2000-100122190023  
> >   
> > >   serial_number UKAAMDA2000-100122190023  
> > 
> > Since it's clearly a single ASIC shouldn't it have a single devlink
> > instance?  
> 
> But there're more than one PCI device now. Isn't it universal implementation
> to register a devlink for each PCI device?

It's only the prevailing implementation because people are too lazy to
implement things correctly, if you ask me. devlink doesn't have the
ability to bind to multiple bus devices, that would need to be
addressed.

