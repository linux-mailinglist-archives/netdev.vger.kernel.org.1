Return-Path: <netdev+bounces-21654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4447641D8
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 00:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C93B1C21419
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 22:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDDD19882;
	Wed, 26 Jul 2023 22:03:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3C61BF1C
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 22:03:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7E7C433C8;
	Wed, 26 Jul 2023 22:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690409000;
	bh=C20Mow0neMMeuRYiSo190mD7A1G4PRE8BGaMkwDg2Nk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OrU1p8aff1BhwuDL37y9QWdR/tg2EC8pWO7roLvxMgb+6wvgb+bLLdOFh/Bj2qk/h
	 iMnWB08R9zS6KyYw/4acY+QJMFo41F4wRxZ68hDdfhim72uvtP7hsR32tUqLwxsrWg
	 AUkFqiyzA+ndCC3p6Of/2GIJrqvUV5Y1Sw/uJhbtfNFmIyqxi5daQ+EYSoZeR0n3PI
	 Lmzzgs65NU8sdZR3HhVMK2yKr1YGwZzGiG+7usPtUXmW+paWLDkxwWaZB0NqXMEVo6
	 iGxRSgYxZXFoZHUzZok8oJkwqi32jxw7MDi8WfoGXrtv5f7zWHna4rrEoYxdFSBDs3
	 ioFclKY4riJ7w==
Date: Wed, 26 Jul 2023 15:03:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 1/3] doc/netlink: Add a schema for
 netlink-raw families
Message-ID: <20230726150319.251d2a7d@kernel.org>
In-Reply-To: <CAD4GDZy5BC6F_Asopz4WRnZ5KBasdHpchoseafcKwbBZ3ZLySQ@mail.gmail.com>
References: <20230725162205.27526-1-donald.hunter@gmail.com>
	<20230725162205.27526-2-donald.hunter@gmail.com>
	<20230726140941.2ef8f870@kernel.org>
	<CAD4GDZy5BC6F_Asopz4WRnZ5KBasdHpchoseafcKwbBZ3ZLySQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jul 2023 22:48:54 +0100 Donald Hunter wrote:
> > Other than that the big ask would be to update the documentation :)  
> 
> Do you mind if I update the docs as a follow up patch? I'm on holiday for
> the next 10 days - I should have time to respin this patchset but maybe
> not to work on docs as well.

Ugh, we had some issues with people posting stuff while / before taking
time off recently (napi netlink, sendpage, tcx). I'd rather wait until
you're back.

