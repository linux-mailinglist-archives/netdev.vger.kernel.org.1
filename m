Return-Path: <netdev+bounces-207187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AB3B06260
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 17:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9AD165535
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B951FF7C5;
	Tue, 15 Jul 2025 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxYFAXm/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F381DB356;
	Tue, 15 Jul 2025 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591929; cv=none; b=S6X2xkvYBSyzdXVYPAH/3nHjo4QDjyk+kiym4CZfGwDc+M+5Dwi3+fTyam8HTqp6iRe1CZuZfJWKfIcUTx40fgHTj329xDIyXd8I+jL1fO2CBtEL6sZ9QS16KbpSK3Tw8mcJwuQeHGkGlzuNvXC/9IC69qyd8za1IGRLOmgqBhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591929; c=relaxed/simple;
	bh=lgROUkvjWbyE08UZT1hcvbF/FTSB+9YiCW1KfjgFGS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uw1hvsylSV4VcSxT0hUAz2rKCJ3Anaw8HkDYJht4LKHwjRvp2gsmcUYbEyy3GXpjCxf1vBaQWQuJ0vvlYqamm2AoSjSi9x7vfkRvrIC1+mN+5ctxbC71By+x+LiwQWwNlOdkjeZ4mKkPLLqANxyVlMUiUcb65VwXYl1y7PqULY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxYFAXm/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4642EC4CEE3;
	Tue, 15 Jul 2025 15:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752591929;
	bh=lgROUkvjWbyE08UZT1hcvbF/FTSB+9YiCW1KfjgFGS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uxYFAXm/ODsz1WbtuznEgAO9wXLnriJtTYZukWI+eroLZazVtAQllUyXeHnY5yX/B
	 lfsgoWOBhNUVIGND8VNlgq0KTst2syUIPJffySd0Gdj2adKQ34Ndc5yXNxUFWQmBQm
	 f4SIf+CWequ9fK2slabXziXzBZO9pwNHmffFbtjxyh2+UoyCvoP8pdao8pJT2L87zc
	 nSa4BINURd/ZspHipVV/z2aQbAt+VdPaEziTNscYJZbVBzeNREAJLiAyu1u8TLRDMz
	 X3aiUF+QHnnOQJh8CM/0IOKLiwxljWBqeneKMf11VkRpg+js1BlV/nOFTX+KtfmldP
	 6M5pd79Q0wUEg==
Date: Tue, 15 Jul 2025 16:05:24 +0100
From: Will Deacon <will@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>,
	Steven Moreland <smoreland@google.com>,
	Frederick Mayle <fmayle@google.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v3 0/9] vsock/virtio: SKB allocation improvements
Message-ID: <aHZuNFIYR1g8h_-F@willie-the-truck>
References: <20250714152103.6949-1-will@kernel.org>
 <opdsodne4zsvgdkp4v3q2xggjzwjtk22j3knvpntlo63h6t767@jsuxmvgucatu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opdsodne4zsvgdkp4v3q2xggjzwjtk22j3knvpntlo63h6t767@jsuxmvgucatu>

On Tue, Jul 15, 2025 at 12:01:56PM +0200, Stefano Garzarella wrote:
> On Mon, Jul 14, 2025 at 04:20:54PM +0100, Will Deacon wrote:
> > Hi folks,
> > 
> > Here is version three of the patches I previously posted here:
> > 
> >  v1: https://lore.kernel.org/r/20250625131543.5155-1-will@kernel.org
> >  v2: https://lore.kernel.org/r/20250701164507.14883-1-will@kernel.org
> > 
> > Changes since v2 include:
> > 
> >  * Pass payload length as a parameter to virtio_vsock_skb_put()
> > 
> >  * Reinstate VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE based on a 4KiB total
> >    allocation size
> > 
> >  * Split movement of bounds check into a separate patch
> > 
> > Thanks again to Stefano for all the review feedback so far.
> 
> Thanks for the series!
> I left just a small comment on a patch, the rest LGTM!
> 
> I run my test suite without any issue!

Thank, Stefano. I'll send a v4 later this week with your R-b tags and
an unlikely() in the second patch.

Will

