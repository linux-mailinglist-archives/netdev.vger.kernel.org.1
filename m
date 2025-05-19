Return-Path: <netdev+bounces-191529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CCCABBD5F
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 14:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A233BB5EB
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 12:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C0D276032;
	Mon, 19 May 2025 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFa7YAI2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6FC26F453
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747656637; cv=none; b=m1QrWTmWA4uG0TBkqbz4WX/5+xApWfsbApWHiswHsJ4cIh8T75afylZUImjm6UA4MfG6nD4+pWnKEv9QRdp1fQ3nTHhdSIKi4lZs3ETflDnK78OuEiXBUghqVzHDkKOlY9YDnM4jIi7XDQQ5pFjS7a49jE5vMCf8j9xff7aXcSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747656637; c=relaxed/simple;
	bh=iSx71zZiXEdCfJvPVC/dxwl7y6YEpL4pKp+tSRhGjSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YiarZ0hk9V55K/h60nhQUpCuBY/JDhCH+5uOom6bEU4nbQyXNS221JR8o3vJpb2ZHenK16XmsD3kaLhJt+QsxQkfhoxIeNKyuMqmTPzKV8h0BR/g+IF5N/jUgY2FRicBz8Ud5KhC+pda9jmbBUkkYVwEt4jJVNFLsCWT0sUyS7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFa7YAI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB21C4CEE4;
	Mon, 19 May 2025 12:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747656636;
	bh=iSx71zZiXEdCfJvPVC/dxwl7y6YEpL4pKp+tSRhGjSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XFa7YAI26weKMKIVPZgB4z0Th8+zwWeqaPOyA/K7FN+uOmLdhEQUZ8pkFOlsm9MVV
	 740cgXLshUxXiFbL2JWQiyFXyIQeqmt6yny3LQS01eAuJwVZvWTfNU2xbQFADt1v4D
	 Huf3B+4giSIg2BK2JptSLNEVZ3MZZoyux34cffHGs9qvCcLzyIGK2KcyZr/l+CoLDs
	 u8ycl/0DK7FVk1hxSdJyyY2WPG3Oj59hZvaTPsg3Gz7cW6zioAUkak4Giyr31IxIb5
	 kR07cjNyttKz32d/e0ibtubexqBdfoNdnOQTfeId/5eTwkA6Eucz2BsBxXHExgzR/5
	 jAx8yrYZDPvFw==
Date: Mon, 19 May 2025 13:10:32 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: airoha: Add FLOW_CLS_STATS callback
 support
Message-ID: <20250519121032.GF365796@horms.kernel.org>
References: <20250516-airoha-en7581-flowstats-v2-0-06d5fbf28984@kernel.org>
 <20250516-airoha-en7581-flowstats-v2-2-06d5fbf28984@kernel.org>
 <20250519094637.GE365796@horms.kernel.org>
 <aCsAItPcz_9CuxaP@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCsAItPcz_9CuxaP@lore-desk>

On Mon, May 19, 2025 at 11:55:46AM +0200, Lorenzo Bianconi wrote:
> On May 19, Simon Horman wrote:
> > On Fri, May 16, 2025 at 10:00:00AM +0200, Lorenzo Bianconi wrote:
> > 
> > ...
> > 
> > > @@ -1027,6 +1255,15 @@ int airoha_ppe_init(struct airoha_eth *eth)
> > >  	if (!ppe->foe_flow)
> > >  		return -ENOMEM;
> > >  
> > > +	foe_size = PPE_STATS_NUM_ENTRIES * sizeof(*ppe->foe_stats);
> > > +	if (foe_size) {
> > 
> > Hi Lorenzo,
> > 
> > It's unclear to me how foe_size can be zero.
> 
> Hi Simon,
> 
> foe_size will be 0 if you disable CONFIG_NET_AIROHA_FLOW_STATS since in this
> case PPE_STATS_NUM_ENTRIES will be 0.

Thanks,

I see that now but for some reason it escaped me earlier.

With that cleared up this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>



