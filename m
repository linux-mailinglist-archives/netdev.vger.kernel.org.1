Return-Path: <netdev+bounces-30422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BB17873E5
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 17:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6783E280E16
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BD712B67;
	Thu, 24 Aug 2023 15:19:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9198F125B4
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 15:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF29C433C8;
	Thu, 24 Aug 2023 15:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692890376;
	bh=dL3ZaFMplj04rQ1P0eBC8h0GfaGizXbacoBeHW6QBtg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KTBHpHJcJh7WMe+3/yaSQLKzhKc02PMLBrtWxvSsLPHSUKNZfZmk3PkydjI/6XIVQ
	 zmzK5QVRkY5PWnPNqyLvRnyhcifSIGexJXLRTLoXDw4elfYQLYeclgQhqhYsK/tCRE
	 z3VXVwUJuRyNFpIxBS47THayTjvqgXXJrZU4qKFpxalm51nCpF6ms48M5hRJ1fq80J
	 OHXbkkDZrHidHpDkTf1b0ZqH46D0POSDP1wbqtDnD4adFeY21X2mUFD0g1ExZqhWGQ
	 v57YFjsz87x2PB1987p75GfBUkNHpuOdYCQFfg4fIIIhYA2pWheygSpLHqV8lqiilp
	 aS7I5hDEsccXA==
Date: Thu, 24 Aug 2023 08:19:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, Sunil Kovvuri Goutham
 <sgoutham@marvell.com>, Geethasowjanya Akula <gakula@marvell.com>, Jerin
 Jacob Kollanukkaran <jerinj@marvell.com>, Linu Cherian
 <lcherian@marvell.com>, Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
 Naveen Mamindlapalli <naveenm@marvell.com>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [net-next Patch 4/5] octeontx2-af: replace generic error codes
Message-ID: <20230824081934.39523fab@kernel.org>
In-Reply-To: <PH0PR18MB4474038302489C10086DC1B5DE1DA@PH0PR18MB4474.namprd18.prod.outlook.com>
References: <20230817112357.25874-1-hkelam@marvell.com>
	<20230817112357.25874-5-hkelam@marvell.com>
	<20230818195041.1fd54fb3@kernel.org>
	<PH0PR18MB44744DCAE48DA4AAE1082A1DDE19A@PH0PR18MB4474.namprd18.prod.outlook.com>
	<PH0PR18MB4474038302489C10086DC1B5DE1DA@PH0PR18MB4474.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Aug 2023 05:41:01 +0000 Hariprasad Kelam wrote:
> > > The custom error codes are not liked upstream, they make much harder
> > > for people who don't work on the driver to refactor it.
> > >
> > > If you want debugging isn't it better to add a tracepoint to the checks?  
> >   
> > Hari>>  These error codes are added in AF mailbox handlers, user space tools  
> > like ethool ,tc won't see these since these are between pf netdev and AF.
> > During netdev driver probe/open calls, it requests AF driver to configure
> > different hardware blocks MAC/network etc. If there is any error instead of
> > getting EPERM, we will get block specific error codes like
> > LMAC_AF_ERR_INVALID_PARAM, NIX_AF_ERR_PARAM etc.  
> 
> Jakub,
> Any comments here?

Please learn how to use email correctly.

Hari>>

Makes the entire line rendered as a quote in many email clients,
because the gt than sign is a quote marker.

You should also wrap your lines.

If you want to return the block which failed to the caller you can 
do that, but not instead of the error code.

