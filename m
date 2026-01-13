Return-Path: <netdev+bounces-249441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B59E0D1906B
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 14:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 37B7630042BE
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 13:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA473904E4;
	Tue, 13 Jan 2026 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdrGHKbC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B408338FF0B;
	Tue, 13 Jan 2026 13:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768309758; cv=none; b=eISODufpRSq7RkjYwwdOLGBpNCejGIFRn4/1aOrCpFfQXH4Q7fiJ6ezMFZ3kj0mxlOj6mOQgNjIyz3nJc4rcdtgL7NobziKJWV0fb7CjBbbjQ0W0YCCA2lYUTo83K75kCnh+0DDIsuQYjLtRhOAaASYPcjfB/jv6LoLGNhdc23Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768309758; c=relaxed/simple;
	bh=/sdxEgRgpIsKuwLdsB+gz2Y2g+rnDI4mnmM+bV5MHKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfRjkxuwmFxldzx6UCfwR3NVKVO/St0bitvfyTQSXwsacE68Zvb8qipS5y3H8W3lkR7vd6ovIXRk7JqrLyXzDht+21PSUix1TkE0/2rYO6voq6a+P0ZUP2mmypXHgLOSMVUBej0tG7uURNeuaoE92qVRZ+Zl6PXxYopJO8mWdSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdrGHKbC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A40C116C6;
	Tue, 13 Jan 2026 13:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768309757;
	bh=/sdxEgRgpIsKuwLdsB+gz2Y2g+rnDI4mnmM+bV5MHKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZdrGHKbC4SlbtUGTP/WJ3hy03vSHM9sncl0yGFQePY+aJN9SHggONTnrckxoZ5jNT
	 G1v/MmJ7zUY0Co15VoJ9yCwC3rYMED40XBOq7B1v07XFJ72Z/gmamSkegIDHZdjCbq
	 l86DniNM1fq3NcUUCSalzyZvgmZnKdrT2o3HtStqGmtcuKjQT4ypVzZba5VPZco4e5
	 h1rRbBqxrqUq1v6yi98M4AvolNpvhKzMFt+KwF8CmoNvmI6k2TIFrBdkSqRbQAyjmw
	 sn2tJ/JpirIGVmSVKMNOzVNAhad0+9IcM4nqGscj9ptSSlyPn/whx95EgqqUBWxpQ7
	 bOxU+UiI91VwA==
Date: Tue, 13 Jan 2026 13:09:13 +0000
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	sumang@marvell.com
Subject: Re: [PATCH net-next 01/13] octeontx2-af: npc: cn20k: Index management
Message-ID: <aWZD-bDON-wzfQHe@horms.kernel.org>
References: <20260105023254.1426488-1-rkannoth@marvell.com>
 <20260105023254.1426488-2-rkannoth@marvell.com>
 <20260108175357.GJ345651@kernel.org>
 <aWBqq9UKWD5ewKpA@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWBqq9UKWD5ewKpA@rkannoth-OptiPlex-7090>

On Fri, Jan 09, 2026 at 08:10:43AM +0530, Ratheesh Kannoth wrote:
> On 2026-01-08 at 23:23:57, Simon Horman (horms@kernel.org) wrote:
> > On Mon, Jan 05, 2026 at 08:02:42AM +0530, Ratheesh Kannoth wrote:
> >
> > > +		if (strlen(t1) < 3) {
> > > +			pr_err("%s:%d Bad Token %s=%s\n",
> > > +			       __func__, __LINE__, t1, t2);
> > > +			goto err;
> > > +		}
> > > +
> > > +		if (t1[0] != '[' || t1[strlen(t1) - 1] != ']') {
> > > +			pr_err("%s:%d Bad Token %s=%s\n",
> > > +			       __func__, __LINE__, t1, t2);
> >
> > Hi Ratheesh,
> >
> > FWIIW, I would advocate slightly more descriptive and thus unique
> > error messages
> ACK.
> 
> >and dropping __func__ and __LINE__ from logs,
> > here and elsewhere.
> ACK.
> 
> >
> > The __func__, and in particular __LINE__ information will only
> > tend to change as the file is up dated, and so any debugging will
> > need to know the source that the kernel was compiled from.
> ACK.
> 
> >
> > And I'd say that given the state of debugging functionality in the kernel -
> > e..g dynamic tracepoints - this is not as useful as it may seem at first.
> Since these represent valid error cases, they should be logged by default.
> Relying on dynamic trace points would require the customer to recompile the
> kernel and retest, which could lead to significant debugging delays and
> multiple rounds of communication.

FTR, I think that logging them is reasonable, it's just the __func__ and
__LINE__ portions that I question the usefulness of.

Also, in my experience, recompiling is not necessary to use dynamic trace
points. But YMMV.

...

