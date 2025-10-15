Return-Path: <netdev+bounces-229519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D30BEBDD729
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 10:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FB114E2D71
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 08:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8365E306487;
	Wed, 15 Oct 2025 08:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaFkkTkh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546C62D5419;
	Wed, 15 Oct 2025 08:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760517393; cv=none; b=oo65LF19JIGaCb+Xnb7QNWANwEhQXHsrdBpKjeyujbAhYCqbUIOW55mea68nzGOj3qWEZIBuSJxoVo8WghO7rfB1MNV6eOTCpiGSZlcl96+KoijAaOQSWCGvFpGJ1ZJLG189Lm+xWyGY+TQ6eJtJxjOM29TlqLBVY0VnLVEARuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760517393; c=relaxed/simple;
	bh=sOQyGjCqvYO/zzApnSRjFBnx7hjLIIizKGWS/lzHaFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELxkOZRtT0AmaV627B+JG7uPa4UMqzQ2hjkujVkL9phKzP512MDIbypxjnU7X0hMmshY0YpiWMbYdQwdbzGgzOrmSbjDJi+HjsIbL08Bat5W0LdzAn6YehV5OcFMRYjyzo5HBBrz9JWg3BkbrdRCxFZp4KxYu/7pUwcVE0/ioyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaFkkTkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72514C4CEF8;
	Wed, 15 Oct 2025 08:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760517391;
	bh=sOQyGjCqvYO/zzApnSRjFBnx7hjLIIizKGWS/lzHaFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eaFkkTkhdK9MKeBGqReNQv8acZU1mWF3MHshYB9C4WFFdEy7Jt+llNIlrbm+4NweR
	 cmFG2tolIw2xPWNCihXg1lWTQN+qiyYfAVXcJKDc/SfJSUpY7lldaw85SRW0jBe/w7
	 b6bTy9lZnxSyt8NqHtvThq+YnL0hcobWP52MRpLIJ3ZtP/mCz6SSO99mZ366TAohFP
	 nDuT3LpJc+Xely+EzlcAEx/3eFI6GQIlai+XYMeAPeMiD8AHFzts5zSbcMu99SDedz
	 YhvB9vIuKSDRSKb0BUVPsA992lA9FnI1bdiGkTnBIZD+GRHoq7DmvSZ+QifcpRzfMq
	 wMoER1hDC3D/Q==
Date: Wed, 15 Oct 2025 09:36:26 +0100
From: Simon Horman <horms@kernel.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nithya Mani <nmani@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
	kernel-janitors@vger.kernel.org, error27@gmail.com
Subject: Re: [PATCH] Octeontx2-af: Fix pci_alloc_irq_vectors() return value
 check
Message-ID: <aO9dClea18rk9Kdx@horms.kernel.org>
References: <20251014101442.1111734-1-harshit.m.mogalapalli@oracle.com>
 <ec88f0a0-12ee-4c16-bb0a-fb572d6e020b@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec88f0a0-12ee-4c16-bb0a-fb572d6e020b@oracle.com>

On Tue, Oct 14, 2025 at 03:50:47PM +0530, Harshit Mogalapalli wrote:
> Hi,
> 
> On 14/10/25 15:44, Harshit Mogalapalli wrote:
> > In cgx_probe() when pci_alloc_irq_vectors() fails the error value will
> > be negative and that check is sufficient.
> > 
> > 	err = pci_alloc_irq_vectors(pdev, nvec, nvec, PCI_IRQ_MSIX);
> >          if (err < 0 || err != nvec) {
> >          	...
> > 	}
> > 
> > Remove the check which compares err with nvec.
> > 
> > Fixes: 1463f382f58d ("octeontx2-af: Add support for CGX link management")
> > Suggested-by: Paolo Abeni <pabeni@redhat.com>
> > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> > ---
> > Only compile tested.
> > ---
> >   drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> > index d374a4454836..f4d5a3c05fa4 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
> > @@ -1993,7 +1993,7 @@ static int cgx_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >   	nvec = pci_msix_vec_count(cgx->pdev);
> >   	err = pci_alloc_irq_vectors(pdev, nvec, nvec, PCI_IRQ_MSIX);
> > -	if (err < 0 || err != nvec) {
> > +	if (err < 0) {
> >   		dev_err(dev, "Request for %d msix vectors failed, err %d\n",
> >   			nvec, err);
> 
> 
> Now that I think about it more, maybe we want to error out when err != nvec
> as well ? In that case maybe the right thing to do is leave the check as is
> and set err = -EXYZ before goto ?
> 
> Thanks,
> Harshit>   		goto err_release_regions;

Hi Harshit,

My reading of the documentation of pci_alloc_irq_vectors() is that
Because nvec is passed as both the min and max desired vectors,
either nvecs will be allocated, or -ENOSPC will be returned.

Maybe it is worth adding a comment about that to patch description
or the code. But I think the code in this patch is correct.

