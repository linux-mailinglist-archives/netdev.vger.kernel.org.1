Return-Path: <netdev+bounces-90616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 835EC8AF3C3
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 18:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232441F23643
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 16:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA2113CAB5;
	Tue, 23 Apr 2024 16:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2tcZPud"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982B913C9DF
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 16:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889134; cv=none; b=uTP5vp2GiTvCF+WYyFmcv7csgPC2UtV3F2gPhUsIILkkWtocj8QmI1HLYnYqnXCCvGHRwvbuBl9kuqyzbuaTyvAjYHPrM4lF66Ga8a/ynQofaHeifeG5To7kYFFHwqlgUADa87ryXspjncc4im9QwgVpyifyjuRowyQf53Vgus4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889134; c=relaxed/simple;
	bh=JJPdZeRSB0G7BWjAMGmMubvKNrJMsm7LhBJ9zzq/Hfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDEhTtyfwdONOtM5vFpx2fzJC6qePJfylwZ91DLzrOpvWzBalJy8RsvVIhyTde9Xi+QYInK/L1zigar9GKR4B/xJvK2TG0cEIyC+EImQB5cUxW/+nxt4gg6UHnvOHVTO3kxTsmD4kEc7nZM2Dl2lrYVJB24OchhAfUmLaFT28bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2tcZPud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C6AC116B1;
	Tue, 23 Apr 2024 16:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713889134;
	bh=JJPdZeRSB0G7BWjAMGmMubvKNrJMsm7LhBJ9zzq/Hfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o2tcZPudzWK7CpfFi7IxJqaL2SdA5471xtcrRRGugct4rGMzS5cF+aeKHpVJ0iDXn
	 q+6PJ/A/EcngAsVrGDHgB06ISRRQPW3NsdYAZ7svncj4pQJx2X+TCDg0fb6LlcsyM/
	 LRnwEwZsNT7a2cDwfUy9yki5a5z+1xC62X88lObdYYJAtC1NS/iEphC4xiSEWlDqWu
	 eoIDAumbBMqm8bFsgRqVEVg+Ab0QfNVU6TUTqi3ikyMWfKvh6aUZ67vhvYq124DzDZ
	 2ZUbg26tonhU8ey7z4K13XJv4LRCvkx7+tidNV8jrdiTDzH/R/bD/8xpUYFqfbNLkf
	 ELVz7lg6uHriQ==
Date: Tue, 23 Apr 2024 17:18:49 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 4/4] net: sparx5: Correct spelling in comments
Message-ID: <20240423161849.GW42092@kernel.org>
References: <20240419-lan743x-confirm-v1-0-2a087617a3e5@kernel.org>
 <20240419-lan743x-confirm-v1-4-2a087617a3e5@kernel.org>
 <20240420192424.42z2aztt73grdvsj@DEN-DL-M70577>
 <20240422105756.GC42092@kernel.org>
 <20240423112915.5cmqvmvwfwutahky@DEN-DL-M70577>
 <20240423135417.GT42092@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423135417.GT42092@kernel.org>

On Tue, Apr 23, 2024 at 02:54:17PM +0100, Simon Horman wrote:
> On Tue, Apr 23, 2024 at 11:29:15AM +0000, Daniel Machon wrote:
> > > > Hi Simon,
> > > >
> > > > > -/* Convert validation error code into tc extact error message */
> > > > > +/* Convert validation error code into tc exact error message */
> > > >
> > > > This seems wrong. I bet it refers to the 'netlink_ext_ack' struct. So
> > > > the fix should be 'extack' instead.
> > > >
> > > > >  void vcap_set_tc_exterr(struct flow_cls_offload *fco, struct vcap_rule *vrule)
> > > > >  {
> > > > >         switch (vrule->exterr) {
> > > > > diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_client.h b/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
> > > > > index 56874f2adbba..d6c3e90745a7 100644
> > > > > --- a/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
> > > > > +++ b/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
> > > > > @@ -238,7 +238,7 @@ const struct vcap_set *vcap_keyfieldset(struct vcap_control *vctrl,
> > > > >  /* Copy to host byte order */
> > > > >  void vcap_netbytes_copy(u8 *dst, u8 *src, int count);
> > > > >
> > > > > -/* Convert validation error code into tc extact error message */
> > > > > +/* Convert validation error code into tc exact error message */
> > > >
> > > > Same here.
> > > 
> > > Thanks Daniel,
> > > 
> > > Silly me. I'll drop these changes in v2.
> > 
> > No reason to drop them just change it to 'extack' :-)
> 
> Thanks, will do.

Sorry, I am somehow confused.

Do you mean like this?

/* Convert validation error code into extact error message */

Or just leave things unchanged?

/* Convert validation error code into tc extact error message */

