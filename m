Return-Path: <netdev+bounces-129574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1D19848F3
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 17:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778BB1C22AE6
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 15:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492331AB530;
	Tue, 24 Sep 2024 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g885dQ23"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233C219B3F3;
	Tue, 24 Sep 2024 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193499; cv=none; b=G+ft7l6GACgIrC3UK7Ck/S09HuiCrSVufdc+TvlxNkq1EVXMz1ZODmtD2W0eEtHrqBpQ88RqLXbZy1C2v/9lxgb6hkGujt+DQ7flqeziICHWMU2Tn+e7RbVsu8HLuXbCghLqwd0IiFXu3b4dZctoGNXccYqYJOeiTKktE2FZxhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193499; c=relaxed/simple;
	bh=PrDU0r5qgwugy9ISMu35of0gcKQmKy3/K4ukA80gwXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhFKDpJi1CpXfZQogS17heYqPWJ7/gARZYVhHKNB4TJ7x0qoEaXOojuZREkQzAyySZVMWJRf+3UKzFy/kyBHsvC8sr4Qi3w6Kl3ZIRWKk+EyD5WSHwwc2hp0L/KgKYLGp5uFI8Lsm1ovQMJVJUOLsFsoy8F2auIpgmi1QkMV/j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g885dQ23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7D2C4CEC4;
	Tue, 24 Sep 2024 15:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727193497;
	bh=PrDU0r5qgwugy9ISMu35of0gcKQmKy3/K4ukA80gwXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g885dQ237skZYaWx4dwAdSpg4p26u4moNDxKnnCl+TS46uRaqD1nn82Y0rL/T9pZV
	 uZocJOTdc9GQK/VJcsFyiwETvvly+DnVAUfOr5Hwvgyiy5q4eatlSuMjrneYcYs+Iz
	 Uy/aEQ2Z4m5OiXxrRPe9ADjIwzt0O+aRDgXjAWDHBJZYKYX9t86MWulyVWWed4Yrru
	 yEkJ0tu5Q/nPM2F27flMcN7HqyP0JcSkn/q0PeWqw7PLTVmEVTvv47u9zO3evXzsbw
	 m4CB0N08YERS1ltJyMyYsHfVW/4JIlonscUb1JUayUUjsWHSyf9b9s1tMFp05cCl0C
	 4lu2Vxp5WwI+g==
Date: Tue, 24 Sep 2024 16:58:12 +0100
From: Simon Horman <horms@kernel.org>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: marvell: octeontx2: nic: Add error
 pointer check in otx2_ethtool.c
Message-ID: <20240924155812.GR4029621@kernel.org>
References: <20240923113135.4366-1-kdipendra88@gmail.com>
 <20240924071026.GB4029621@kernel.org>
 <CAEKBCKPw=uwN+MCLenOe6ZkLBYiwSg35eQ_rk_YeNBMOuqvVOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEKBCKPw=uwN+MCLenOe6ZkLBYiwSg35eQ_rk_YeNBMOuqvVOw@mail.gmail.com>

On Tue, Sep 24, 2024 at 08:39:47PM +0545, Dipendra Khadka wrote:
> Hi Simon,
> 
> On Tue, 24 Sept 2024 at 12:55, Simon Horman <horms@kernel.org> wrote:
> >
> > On Mon, Sep 23, 2024 at 11:31:34AM +0000, Dipendra Khadka wrote:
> > > Add error pointer check after calling otx2_mbox_get_rsp().
> > >
> >
> > Hi Dipendra,
> >
> > Please add a fixes tag here (no blank line between it and your
> > Signed-off-by line).
> > > Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> >
> > As you have posted more than one patch for this driver, with very similar,
> > not overly complex or verbose changes, it might make sense to combine them
> > into a single patch. Or, if not, to bundle them up into a patch-set with a
> > cover letter.
> >
> > Regarding the patch subject, looking at git history, I think
> > an appropriate prefix would be 'octeontx2-pf:'. I would go for
> > something like this:
> >
> >   Subject: [PATCH net v2] octeontx2-pf: handle otx2_mbox_get_rsp errors
> >
> 
> If I bundle all the patches for the
> drivers/net/ethernet/marvell/octeontx2/ , will this subject without v2
> work? Or do I need to change anything? I don't know how to send the
> patch-set with the cover letter.

Given that one of the patches is already at v2, probably v3 is best.

If you use b4, it should send a cover letter if the series has more than 1
patch.  You can use various options to b4 prep to set the prefix
(net-next), version, and edit the cover (letter).  And you can use various
options to b4 send, such as -d, to test your submission before sending it
to the netdev ML.

Alternatively the following command will output 3 files: a cover letter and
a file for each of two patches, with v3 and net-next in the subject of each
file. You can edit these files and send them using git send-email.

git format-patch --cover-letter -2 -v3 --subject-prefix="PATCH net-next"

> 
> > As for the code changes themselves, module the nits below, I agree the
> > error handling is consistent with that elsewhere in the same functions, and
> > is correct.
> >
> > > ---
> > >  .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c    | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> > > index 0db62eb0dab3..36a08303752f 100644
> > > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> > > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> > > @@ -343,6 +343,12 @@ static void otx2_get_pauseparam(struct net_device *netdev,
> > >       if (!otx2_sync_mbox_msg(&pfvf->mbox)) {
> > >               rsp = (struct cgx_pause_frm_cfg *)
> > >                      otx2_mbox_get_rsp(&pfvf->mbox.mbox, 0, &req->hdr);
> > > +
> >
> > nit: No blank line here.
> >
> > > +             if (IS_ERR(rsp)) {
> > > +                     mutex_unlock(&pfvf->mbox.lock);
> > > +                     return;
> > > +             }
> > > +
> 
> If the above blank line after the check is ok or do I have to remove
> this as well?

Please leave the blank line after the check (here).

> 
> > >               pause->rx_pause = rsp->rx_pause;
> > >               pause->tx_pause = rsp->tx_pause;
> > >       }

