Return-Path: <netdev+bounces-96075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2248C43A9
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 17:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E4301F226B9
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 15:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5FE538A;
	Mon, 13 May 2024 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liT/pRUP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8F35240
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715612674; cv=none; b=s7GjTEnwqntSm9tdkEaNlfGH7m43a4020eecYilmuAo7aHUwv8s+Kr2qL7eddkEt9P7yEqq4XRiKxceZPXnwfe5hL+CAcrm9bp1vBz3QxLsk4Kx5ny/u3SCpeVBQcGHgJaCf8rGzrkinSXsUsLQUGifouebGWdnMJ9eGw1trFQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715612674; c=relaxed/simple;
	bh=4RCyo4NYUNxSLeaYVkeqj5ACUC1fJs5+84V9lAyy474=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EY8wzOWlxVqMrys4yH5cneqJ8681ChVSmm5dBTSW1y3GmlCBeOiMuOm6KXu2Q8Ptb7ToE2HbudfTdkqtoZStW0V8PmWHTK/EswRSJGbtNZ5AKOrn1IOSlHFAuCxqXTnb0BHCX0KDWqxE/1cPwwc9BCA3JrrHrZDLg+qtYzd71Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liT/pRUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7A5C113CC;
	Mon, 13 May 2024 15:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715612674;
	bh=4RCyo4NYUNxSLeaYVkeqj5ACUC1fJs5+84V9lAyy474=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=liT/pRUPH4mZRny7w8tlL5rz0GO/jrRYW5sNWmqOGP25G0kHOTckT5huXlYKF3MLF
	 YdsakxbH/AydM8SPRcWQmFzMDE1mVhjzJFzDOucHr/4i9FojHZ86qz0SaSxWppCb+g
	 cWw0baAHqMKhRUYeJzYQTbwtSFFT1tFXqqWj9hC4EV/Wbz7OefsXL5xDZH0bGzVPLt
	 WrXmUVvBfOUS4hFiBzPGuIhjn/y2qzt3a3aV76H5bufwPFk0ApUCHy2R0k5G+eJ5C6
	 VFNPpIqNFfgQMTiThmgZ40tc50LS7jnJ8Yd64Bg4aW90xxYuyKPF2slfsl5OnVP3W/
	 FTuRVWXx01GzQ==
Date: Mon, 13 May 2024 16:04:30 +0100
From: Simon Horman <horms@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 07/24] ovpn: introduce the ovpn_peer object
Message-ID: <20240513150430.GO2787@kernel.org>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-8-antonio@openvpn.net>
 <20240513100908.GK2787@kernel.org>
 <278eb5bf-0c47-4a34-94f6-ee62cd74ea1f@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <278eb5bf-0c47-4a34-94f6-ee62cd74ea1f@openvpn.net>

On Mon, May 13, 2024 at 12:53:09PM +0200, Antonio Quartulli wrote:
> On 13/05/2024 12:09, Simon Horman wrote:
> > On Mon, May 06, 2024 at 03:16:20AM +0200, Antonio Quartulli wrote:
> > > An ovpn_peer object holds the whole status of a remote peer
> > > (regardless whether it is a server or a client).
> > > 
> > > This includes status for crypto, tx/rx buffers, napi, etc.
> > > 
> > > Only support for one peer is introduced (P2P mode).
> > > Multi peer support is introduced with a later patch.
> > > 
> > > Along with the ovpn_peer, also the ovpn_bind object is introcued
> > > as the two are strictly related.
> > > An ovpn_bind object wraps a sockaddr representing the local
> > > coordinates being used to talk to a specific peer.
> > > 
> > > Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> > 
> > ...
> > 
> > > diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
> > > index ee05b8a2c61d..b79d4f0474b0 100644
> > > --- a/drivers/net/ovpn/ovpnstruct.h
> > > +++ b/drivers/net/ovpn/ovpnstruct.h
> > > @@ -17,12 +17,19 @@
> > >    * @dev: the actual netdev representing the tunnel
> > >    * @registered: whether dev is still registered with netdev or not
> > >    * @mode: device operation mode (i.e. p2p, mp, ..)
> > > + * @lock: protect this object
> > > + * @event_wq: used to schedule generic events that may sleep and that need to be
> > > + *            performed outside of softirq context
> > 
> > nit: events_wq
> 
> Thanks for the report. I fixed this locally already.
> 
> You don't know how long I had to stare at the kdoc warning and the code in
> order to realize that I missed a 's' :-S

It took me more than one reading too :)

