Return-Path: <netdev+bounces-129594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8012984AC6
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 20:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E69E287820
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 18:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DC11AC8A5;
	Tue, 24 Sep 2024 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoGf1bi9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0C11AC893;
	Tue, 24 Sep 2024 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727201702; cv=none; b=Z1p/KQ7NI1wFlRgjOE1+Zwmp+eJQBVBAeokl/sNB+RFPAN3Jx+VdFFSI83auqLZD27Lb7MkAtARhv1Lz2WPoUJht7UOg1dJ8iEoS6U5DlH4IJIU/IeTTJ6OCmF1307WuP7uIP57Kd/Tb0ksIO9E8xOaCIBV3+SxRhplS2GozTXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727201702; c=relaxed/simple;
	bh=4NJYnhYjz8H6JcjJo0q0NaNrHHKGrQ0s1uLOHzKZJFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGmJvLrCG2cQhplJprVF9c+61DttLPl365+FhleLzufOFcX4mKHitA8iFVLfG0v7eWUR2TQM64fnBvnu5cDDupmIonzTpBK2A+CDI9rXW9DV0y6ZlLZBS+Yv598dzhjKVlUguJxY3Txp0lsTmJ1eD/2qpKY0rhyw3kcdMAUvfCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoGf1bi9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4A6C4CECD;
	Tue, 24 Sep 2024 18:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727201702;
	bh=4NJYnhYjz8H6JcjJo0q0NaNrHHKGrQ0s1uLOHzKZJFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OoGf1bi93XVUDaiUVdkPEIzks70L9pzREccheV1NS1RGBUBa0oFoWogXuSgpCcgDz
	 ORbJnaW18WagKlzKTZsiV+ZPerMCcurj6vq5mHVhYvKJ1+X2RkiVLRuSf1i7Ic7DvF
	 piEucDFBMacs7dGTYGM1HVGc+IYC4aPZjJmx/i+cwbK9GuHLLvjrejz0OPt86DLK5X
	 tcm6d3SeU8s4kmEGdP27eww6N1u1YeEcsd8EdwXpu2hT71cJJzIeINuj03Y8Rn6qHW
	 oT2NLGUkuqmfsTdPs5AvIlnCfhBSFDwakriTZgzoqaQONNhfOOyP7/QOGIYk2SqbO9
	 k6l0pKDupVM4w==
Date: Tue, 24 Sep 2024 19:14:58 +0100
From: Simon Horman <horms@kernel.org>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: marvell: octeontx2: nic: Add error
 pointer check in otx2_ethtool.c
Message-ID: <20240924181458.GT4029621@kernel.org>
References: <20240923113135.4366-1-kdipendra88@gmail.com>
 <20240924071026.GB4029621@kernel.org>
 <CAEKBCKPw=uwN+MCLenOe6ZkLBYiwSg35eQ_rk_YeNBMOuqvVOw@mail.gmail.com>
 <20240924155812.GR4029621@kernel.org>
 <CAEKBCKO45g4kLm-YPZHpbcS5AMUaqo6JHoDxo8QobaP_kxQn=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEKBCKO45g4kLm-YPZHpbcS5AMUaqo6JHoDxo8QobaP_kxQn=w@mail.gmail.com>

On Tue, Sep 24, 2024 at 11:42:58PM +0545, Dipendra Khadka wrote:
> Hi Simon,
> 
> On Tue, 24 Sept 2024 at 21:43, Simon Horman <horms@kernel.org> wrote:
> >
> > On Tue, Sep 24, 2024 at 08:39:47PM +0545, Dipendra Khadka wrote:
> > > Hi Simon,
> > >
> > > On Tue, 24 Sept 2024 at 12:55, Simon Horman <horms@kernel.org> wrote:
> > > >
> > > > On Mon, Sep 23, 2024 at 11:31:34AM +0000, Dipendra Khadka wrote:
> > > > > Add error pointer check after calling otx2_mbox_get_rsp().
> > > > >
> > > >
> > > > Hi Dipendra,
> > > >
> > > > Please add a fixes tag here (no blank line between it and your
> > > > Signed-off-by line).
> > > > > Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> > > >
> > > > As you have posted more than one patch for this driver, with very similar,
> > > > not overly complex or verbose changes, it might make sense to combine them
> > > > into a single patch. Or, if not, to bundle them up into a patch-set with a
> > > > cover letter.
> > > >
> > > > Regarding the patch subject, looking at git history, I think
> > > > an appropriate prefix would be 'octeontx2-pf:'. I would go for
> > > > something like this:
> > > >
> > > >   Subject: [PATCH net v2] octeontx2-pf: handle otx2_mbox_get_rsp errors
> > > >
> > >
> > > If I bundle all the patches for the
> > > drivers/net/ethernet/marvell/octeontx2/ , will this subject without v2
> > > work? Or do I need to change anything? I don't know how to send the
> > > patch-set with the cover letter.
> >
> > Given that one of the patches is already at v2, probably v3 is best.
> >
> > If you use b4, it should send a cover letter if the series has more than 1
> > patch.  You can use various options to b4 prep to set the prefix
> > (net-next), version, and edit the cover (letter).  And you can use various
> > options to b4 send, such as -d, to test your submission before sending it
> > to the netdev ML.
> >
> 
> I did not get this -d and testing? testing in net-next and sending to net?

I meant that b4 prep -d allows you to see the emails that would be sent
without actually sending them. I find this quite useful myself.

> 
> > Alternatively the following command will output 3 files: a cover letter and
> > a file for each of two patches, with v3 and net-next in the subject of each
> > file. You can edit these files and send them using git send-email.
> >
> > git format-patch --cover-letter -2 -v3 --subject-prefix="PATCH net-next"
> >
> 
> Should I send it to net-next or net?

Sorry for the confusion. I wrote net-next in my example,
but I think this patch-set would be for net.

...

