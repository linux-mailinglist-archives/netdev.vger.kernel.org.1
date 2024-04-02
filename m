Return-Path: <netdev+bounces-84074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8F989576D
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 16:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5892827D0
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 14:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E955512B16E;
	Tue,  2 Apr 2024 14:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xUa2OvTe"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D401312BF1A
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 14:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712069226; cv=none; b=W6ygggY7HefJ6B512i9xWOXJDufb6IlGW6qgbcw7nikdHNNRFuCP+pk4XgjLCtfRxBBT8My5Wzny1OJ2VU/DAkDVYNU2pxZN4TYDDpPQI/32mi2JCgdBIIG8EKSfXRUGmEoJcfrr0Wgw8QMl12VyD7Iw/IrJrW3g1R5FsaPeXEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712069226; c=relaxed/simple;
	bh=5gVABkMLIooki29CTEhk5ztVc0rTxa8efvz91lPk5rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MO3xuojtfqw0g58El8pLRHITohZvaaAb85UlN0lVQeJDLTP9jLW51qLWnmReHGflJyFNg/D2pjWnvAcdfDFjwatXNBmwamHGq0YiIvfJ0PQqPN15nYkM5qhziioEWohhQyOI6IGFeY5Vq82dTP6c0zEskFtTtRfuX0W9VBpmrvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xUa2OvTe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uGpqUoHSVCC5gRmLbiguK1uZTk9mnHjL1ZF9cg88S9E=; b=xUa2OvTenT3IZEgiEX95IO1VVf
	tcBk4H+OZPh5247FnsxvswV4+n4LzkmWWKNc9JDSQkjycnaeV7GeF8UW+9q7HE6QE1oSmfxHhnT13
	vImRyj/5zRYqSDCCKVtqClJTwX/dR0S8AHRtsVEVAtcjfecIg20pKDLMmmr808WmENGw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rrfPa-00BxIj-GK; Tue, 02 Apr 2024 16:46:54 +0200
Date: Tue, 2 Apr 2024 16:46:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, edumazet@google.com,
	marcin.szycik@linux.intel.com, anthony.l.nguyen@intel.com,
	kuba@kernel.org, intel-wired-lan@lists.osuosl.org,
	pabeni@redhat.com, przemyslaw.kitszel@intel.com
Subject: Re: [Intel-wired-lan] [PATCH net-next 0/3] ethtool: Max power support
Message-ID: <dc601a7c-7bb7-4857-8991-43357b15ed5a@lunn.ch>
References: <20240329092321.16843-1-wojciech.drewek@intel.com>
 <38d874e3-f25b-4af2-8c1c-946ab74c1925@lunn.ch>
 <a3fd2b83-93af-4a59-a651-1ffe0dbddbe4@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3fd2b83-93af-4a59-a651-1ffe0dbddbe4@intel.com>

On Tue, Apr 02, 2024 at 01:38:59PM +0200, Wojciech Drewek wrote:
> 
> 
> On 30.03.2024 22:57, Andrew Lunn wrote:
> > On Fri, Mar 29, 2024 at 10:23:18AM +0100, Wojciech Drewek wrote:
> >> Some ethernet modules use nonstandard power levels [1]. Extend ethtool
> >> module implementation to support new attributes that will allow user
> >> to change maximum power. Rename structures and functions to be more
> >> generic. Introduce an example of the new API in ice driver.
> >>
> >> Ethtool examples:
> >> $ ethtool --show-module enp1s0f0np0
> >> Module parameters for enp1s0f0np0:
> >> power-min-allowed: 1000 mW
> >> power-max-allowed: 3000 mW
> >> power-max-set: 1500 mW
> >>
> >> $ ethtool --set-module enp1s0f0np0 power-max-set 4000
> > 
> > We have had a device tree property for a long time:
> > 
> >   maximum-power-milliwatt:
> >     minimum: 1000
> >     default: 1000
> >     description:
> >       Maximum module power consumption Specifies the maximum power consumption
> >       allowable by a module in the slot, in milli-Watts. Presently, modules can
> >       be up to 1W, 1.5W or 2W.
> > 
> > Could you flip the name around to be consistent with DT?
> 
> Yea, I'm open to any name suggestion although I don't like the unit in the parameter name :) 

That is a DT thing. Helps make the units of an ABI obvious. However,
milliwatts is pretty standard with the kernel of user APIs, e.g. all
hwmon calls use milliwatts.

> >> minimum-power-allowed: 1000 mW
> >> maximum-power-allowed: 3000 mW
> >> maximum-power-set: 1500 mW
> > 
> > Also, what does minimum-power-allowed actually tell us? Do you imagine
> > it will ever be below 1W because of bad board design? Do you have a
> > bad board design which does not allow 1W?
> 
> Yes. in case of QSFP we don't support 1W, 1.5W is the minimum.

So if i plug in a 1W QSFP device, it will let the magic smoke out
because it is force fed 1.5W?

Looking at
https://www.optcore.net/wp-content/uploads/2017/04/QSFP-MSA.pdf table
7 it indicates different power budget classifications. Power level 1
is a Maximum power of 1.5W. So does your parameter represent this?  It
is the minimum maximum power? And your other parameter is the maximum
maximum power?

I agree with Jakub here, there needs to be documentation added
explaining in detail what these parameters mean, and ideally,
references to the specification.

Does

$ ethtool --set-module enp1s0f0np0 power-max-set 4000

actually talk to the SFP module and tell it the maximum power it can
consume. So in this case, it is not the cage, but the module?

Or is it talking to some entity which is managing the overall power
consumption of a number of cages, and asking it to allocate a maximum
of 4W to this cage. It might return an error message saying there is
no power budget left?

Or is it doing both?

Sorry to be picky, but at some point, somebody is going to want to
implement this in the Linux SFP driver, and we want a consistent
implementation cross different implementations.

	Andrew

