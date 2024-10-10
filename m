Return-Path: <netdev+bounces-134004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2629997A8A
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 04:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F76F28430B
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 02:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6338C6BB5B;
	Thu, 10 Oct 2024 02:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGvJ0mLD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AD3B646;
	Thu, 10 Oct 2024 02:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728527336; cv=none; b=gkjl92UrC2kMhAckaIVNvTyOP106+oFp8nHLewlzmUu3howCcuUt2rij3VqcXp1TlSWg1feBEoh+gB/1mVHs/9d8adP/i8tBJ18HSho55u9zBWZo/T673iDT127x7GWXEQvFEA7QAJHd1CNixoTj521DCPWzR9ghM6uSIzULp4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728527336; c=relaxed/simple;
	bh=5BzC8lqasY+MJL/iRnRtGdNnIQG08XRDajBe4Cza2mU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A6ieeuaNjesTYt5O+zFxrTYIT4qcCmNVW79yUlGQa6c4m9vAXD7Jw0t5MCLXrMa1Q2ZPDHdh2PCjA7t5MRKTh9MnJIAO48qTaeszyJHEnk+3chTncoVoP9uo8MrYGpUxhV8BqYI1Rl7utApagClleO5Fg5bYIU1GB0FDUVVpZ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGvJ0mLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4239BC4CEC3;
	Thu, 10 Oct 2024 02:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728527335;
	bh=5BzC8lqasY+MJL/iRnRtGdNnIQG08XRDajBe4Cza2mU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YGvJ0mLD5f+y3UWjYOAWfhOKNZO+1D9bZnoejivjIa2J+LMSXKRnsbtn8tLxmWwUb
	 jv9vtSF7N3KXRRSa9+2LGFXEicSgVRFuvTGB852JmT1OOAK7pv/NzKuaL7U3Sj31/o
	 QUVZP0aNKZSRGXOVLnVaeMIHcYxOhaz/PWQDI067irDnW1A51cGyx7jGAht1qLyMmR
	 wO/b8lg5/TwadTEL4cz7QRRPVb1RIZw3zl1KmadoqjhHDsTXSOcQ0UOnTWQGSKbilw
	 QmTZ+ZeFt9QBeVMM+LkgUSJ5gGB2k5xltjpUcZxtoOr5vYevrNd1P19X1o8gCX0nMz
	 HzL/oOF9PEiFg==
Date: Wed, 9 Oct 2024 19:28:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Jeff Johnson <quic_jjohnson@quicinc.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?=
 =?UTF-8?B?Zw==?= <u.kleine-koenig@baylibre.com>, David Gibson
 <david@gibson.dropbear.id.au>, Jeff Garzik <jeff@garzik.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 net] net: ibm: emac: mal: add dcr_unmap to _remove
Message-ID: <20241009192854.28fb1f41@kernel.org>
In-Reply-To: <20241009-precise-wasp-from-ganymede-defeeb@leitao>
References: <20241008233050.9422-1-rosenp@gmail.com>
	<20241009-precise-wasp-from-ganymede-defeeb@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Oct 2024 01:23:02 -0700 Breno Leitao wrote:
> Hello Rosen,
> 
> On Tue, Oct 08, 2024 at 04:30:50PM -0700, Rosen Penev wrote:
> > It's done in probe so it should be done here.
> > 
> > Fixes: 1d3bb996 ("Device tree aware EMAC driver")
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  v2: Rebase and add proper fixes line.
> >  drivers/net/ethernet/ibm/emac/mal.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
> > index a93423035325..c634534710d9 100644
> > --- a/drivers/net/ethernet/ibm/emac/mal.c
> > +++ b/drivers/net/ethernet/ibm/emac/mal.c
> > @@ -742,6 +742,8 @@ static void mal_remove(struct platform_device *ofdev)
> >  
> >  	free_netdev(mal->dummy_dev);
> >  
> > +	dcr_unmap(mal->dcr_host, 0x100);
> > +
> >  	dma_free_coherent(&ofdev->dev,
> >  			  sizeof(struct mal_descriptor) *
> >  			  (NUM_TX_BUFF * mal->num_tx_chans +  
> 
> The fix per see seems correct, but, there are a few things you might
> want to improve:
> 
> 1) Fixes: format
> Your "Fixes:" line does not follow the expected format, as detected by
> checkpatch. you might want something as:
> 
> 	Fixes: 1d3bb996481e ("Device tree aware EMAC driver")
> 
> 
> 2) The description can be improved. For instance, you say it is done in
> probe but not in remove. Why should it be done in remove instead of
> removed from probe()? That would help me to review it better, instead of
> going into the code and figure it out.
> 
> Once you have fixed it, feel free to add:
> 
> Reviewed-by: Breno Leitao <leitao@debian.org>

Good points, I'll fix when applying - I want to make sure this gets
into tomorrow's PR 'cause Rosen has patches for net-next depending 
on it.

