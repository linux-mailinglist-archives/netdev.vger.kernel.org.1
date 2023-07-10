Return-Path: <netdev+bounces-16540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC2174DBE1
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 19:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF10281085
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 17:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D290013AD4;
	Mon, 10 Jul 2023 17:04:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622AA13AC3
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 17:04:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5A3C433C9;
	Mon, 10 Jul 2023 17:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689008653;
	bh=W0fOnVrfUPuLA97cLlSy8icgO8jJpVMW7MVIKn0uyLM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tyaL5pGkd6zCGc1+ZpIBp+bAzsoVgazNapmVUB/LzFOaqMSTKlyxr2yqeLcrspjIb
	 xFk/LguyrWbtSHjtJsKDSm9C7CPR3lSpVun78DK+xPTMz5poI0H0GH2yKkErdGTHxP
	 pIBuN9J+CPttI2wSv/RRoCRdiAU9xdsDTxv5lmluwZ9CO0mq21ypR27B5Zr+R6W9CN
	 1pVVreae5dQeJJ4xfrL2mX79tSqrK/EMQBWvhIxOp4XXppXpIw9UmwwPvaNn+zROvH
	 DWafEpvJ1NmjpYl6C8ep3oejEO2L2Lp51RUr3cSiytTbvjNkZIjsYoOKHYFC3a0wkn
	 XexrLrlYy1xDA==
Date: Mon, 10 Jul 2023 10:04:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org, almasrymina@google.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, edumazet@google.com, dsahern@gmail.com,
 willemb@google.com, Andrew Gospodarek <gospo@broadcom.com>, Somnath Kotur
 <somnath.kotur@broadcom.com>
Subject: Re: [RFC 09/12] eth: bnxt: use the page pool for data pages
Message-ID: <20230710100412.2cf439ae@kernel.org>
In-Reply-To: <CACKFLikNuOgJPOd1xCcSkB9-BJczVZsfqUKy4EVhPLYTE5xbQQ@mail.gmail.com>
References: <20230707183935.997267-1-kuba@kernel.org>
	<20230707183935.997267-10-kuba@kernel.org>
	<CACKFLikNuOgJPOd1xCcSkB9-BJczVZsfqUKy4EVhPLYTE5xbQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 9 Jul 2023 21:22:50 -0700 Michael Chan wrote:
> > -       if (BNXT_RX_PAGE_MODE(bp)) {
> > +       if (PAGE_SIZE <= BNXT_RX_PAGE_SIZE || BNXT_RX_PAGE_MODE(bp)) {  
> 
> We have a very similar set of patches from my colleague Somnath to
> support page pool and it supports PAGE_SIZE >= BNXT_RX_PAGE_SIZE in a
> more unified way.  So here, we don't have to deal with the if/else
> condition. I should be able to post the patches later in the week
> after some more QA.

I should have made it clearer, I'm testing with bnxt because of HW
availability but I have no strong need to get the bnxt bits merged
if it conflicts with your work.

