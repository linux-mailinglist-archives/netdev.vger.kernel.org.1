Return-Path: <netdev+bounces-49840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B86F7F3A66
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 00:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E8B2816C2
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 23:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC94655C2C;
	Tue, 21 Nov 2023 23:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBv7gFD1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D8754BF2
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 23:42:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AAAC433C7;
	Tue, 21 Nov 2023 23:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700610178;
	bh=xiJ3aGvurtyYVM2fFaasxew2n0tXrHgksh5a5t2r1YE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rBv7gFD1p2Vw0pG6DmkQ3c041ywJDa2sS63dsT4KqBvvLxCSfAPixi+yTtw9djfde
	 38lFZZ0bxT9Nti644+0kuz7DMrMmswUYDiZFB//zfAzf0XG6TugiloyFW+FNUC9NjK
	 VOOi2DaG95WdG6DHRiWk3n0h/QGfRTYnbvv/xzWNUivDhGkVHB3x8inMVfxvdiKiUp
	 5FoUPjckm+JDMWTZal+IH8Kq7mJHRnzb2gjwnBv4pvNQtkkuJNWPioQkNtNES+aU5j
	 rZ56YvaHLq+C076dWWCstdfETdN9Q409aWszkBNf45KlzCiacIz8RsF2USIHD0tMId
	 nl5/uFxokGRdg==
Date: Tue, 21 Nov 2023 15:42:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 almasrymina@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
 dtatulea@nvidia.com
Subject: Re: [PATCH net-next v2 08/15] net: page_pool: add nlspec for basic
 access to page pools
Message-ID: <20231121154256.5b264b3e@kernel.org>
In-Reply-To: <c6e47c66-46d9-4006-8311-fb2d2fef8f20@gmail.com>
References: <20231121000048.789613-1-kuba@kernel.org>
	<20231121000048.789613-9-kuba@kernel.org>
	<655cf5c7874bd_378cc9294f4@willemb.c.googlers.com.notmuch>
	<20231121123721.03511a3d@kernel.org>
	<655d22256ba8e_37e85c294c8@willemb.c.googlers.com.notmuch>
	<20231121140049.045b8305@kernel.org>
	<c6e47c66-46d9-4006-8311-fb2d2fef8f20@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Nov 2023 14:49:31 -0800 David Ahern wrote:
> > I remember discussing this somewhere in person... netconf?  
> 
> I asked why not blackhole_dev for just that problem.

Ack, but I don't see myself blabbering about the hidden objects
on that sub-thread now.

