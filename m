Return-Path: <netdev+bounces-202428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F07B5AEDD80
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 002CF3BD0E9
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 12:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3730F2701DF;
	Mon, 30 Jun 2025 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAl2458W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A08B2CCC9;
	Mon, 30 Jun 2025 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287849; cv=none; b=aiLCr7ym3jjJngphjzvIGbkOlvT4SziAq+mX3fYIrDvggYvNwWDe54WZHTanw6q4GhHY9gEVHd5YiAnukoNsEkC8AlTHo6SEz429ufqTkSOE42iqoG/VMjL/msGXPK2Du6xhzhEHRFTFB2sc99Y2k/Df4pe9+8C/3vsbgrCW1S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287849; c=relaxed/simple;
	bh=hsHw6bpXmSZW6CwH1/RrZulsuZqOy0tW9oGHlgfUVF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clL8VfEWTv36E1BNHUvyK47K4Yt17WBgEIdXobZ4V1YAPunn9wsri45ngvg7Qhp4gcPaxSiwlGIzP1SEKZkZ3nHYq++qG5CD64+yZAmrK2wyKMBMlwhTGRyxcitfsfcm7LqJ2kPVIEH50S7hMo6fN4UV7c6UpUJ71SB+0eVVsGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAl2458W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898C7C4CEF0;
	Mon, 30 Jun 2025 12:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751287848;
	bh=hsHw6bpXmSZW6CwH1/RrZulsuZqOy0tW9oGHlgfUVF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EAl2458W9At11F1iMq/0Arwgs8CoZ/KopI5BQ1ETxc9T0+4fNyvIo0sGbCP7EWQpf
	 GXq669/I+ZNHd5LEzoINdfPJcoVLaFUyDXLuLYbeFBKyGys5HJhax1Vb9gSF6JwIyb
	 N8JAg2qEbTCHwRTdleww73xb3rDU7BwuWE6CBt2aftu37w1DdAx04qOYU+0vTiXftp
	 VmGCuG3LixSS7nDovbV/CEhEANKAN33tUuJmMEubnNxadcCW69foB1NWZHuIMBdOt5
	 6zg1ZgeZgBj2ThvFqt2iQ3am+qTk5piUt/cl3161U6Mq4pQFbYf58XqFQswlCQTdEE
	 NfAI2az8BBASA==
Date: Mon, 30 Jun 2025 13:50:43 +0100
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
Subject: Re: [PATCH 0/5] vsock/virtio: SKB allocation improvements
Message-ID: <aGKII2RcxMpBY3Zc@willie-the-truck>
References: <20250625131543.5155-1-will@kernel.org>
 <izmrcafyog7cxvef2nipk5f2vzxxptyc4fopnvl3heqslsp7q6@32ssw2piag6h>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <izmrcafyog7cxvef2nipk5f2vzxxptyc4fopnvl3heqslsp7q6@32ssw2piag6h>

On Fri, Jun 27, 2025 at 12:51:45PM +0200, Stefano Garzarella wrote:
> On Wed, Jun 25, 2025 at 02:15:38PM +0100, Will Deacon wrote:
> > We're using vsock extensively in Android as a channel over which we can
> > route binder transactions to/from virtual machines managed by the
> > Android Virtualisation Framework. However, we have been observing some
> > issues in production builds when using vsock in a low-memory environment
> > (on the host and the guest) such as:
> > 
> >  * The host receive path hanging forever, despite the guest performing
> >    a successful write to the socket.
> > 
> >  * Page allocation failures in the vhost receive path (this is a likely
> >    contributor to the above)
> > 
> >  * -ENOMEM coming back from sendmsg()
> > 
> > This series aims to improve the vsock SKB allocation for both the host
> > (vhost) and the guest when using the virtio transport to help mitigate
> > these issues. Specifically:
> > 
> >  - Avoid single allocations of order > PAGE_ALLOC_COSTLY_ORDER
> > 
> >  - Use non-linear SKBs for the transmit and vhost receive paths
> > 
> >  - Reduce the guest RX buffers to a single page
> > 
> > There are more details in the individual commit messages but overall
> > this results in less wasted memory and puts less pressure on the
> > allocator.
> > 
> > This is my first time looking at this stuff, so all feedback is welcome.
> 
> Thank you very much for this series!
> 
> I left some minor comments, but overall LGTM!

Cheers for going through it! I'll work through your comments now...

Will

