Return-Path: <netdev+bounces-52260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209917FE0C3
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 21:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8625D282742
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 20:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573DD5EE85;
	Wed, 29 Nov 2023 20:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rDra1acE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7AA10C0
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 12:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OF1yULBT96Wf5bwW/3L7ETE5R1ComjXs/+Aua4wz/qs=; b=rDra1acE3S3NsEar5zGCp9oeUF
	wxO0C09XY065fStCjnyhi17Yv367ZE/EMm1Xsr9LqJOhqCj+NNXZAsGoNHZQnMqSxAr99BddwPCwJ
	Nj56T+8XCeczDjJAerVavJIykpJS8h3EX5pA3ImN1krdWysmiLZuF01UhHSDnoytvp+w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r8Qpx-001bqm-Fx; Wed, 29 Nov 2023 21:07:09 +0100
Date: Wed, 29 Nov 2023 21:07:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Simon Horman <horms@kernel.org>
Cc: netdev <netdev@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH RFC net-next 4/8] dsa: Create port LEDs based on DT
 binding
Message-ID: <1328f773-76c6-4d46-9608-b366303817cb@lunn.ch>
References: <20231128232135.358638-1-andrew@lunn.ch>
 <20231128232135.358638-5-andrew@lunn.ch>
 <20231129194028.GH43811@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129194028.GH43811@kernel.org>

On Wed, Nov 29, 2023 at 07:40:28PM +0000, Simon Horman wrote:
> On Wed, Nov 29, 2023 at 12:21:31AM +0100, Andrew Lunn wrote:
> 
> ...
> 
> > +static int dsa_port_leds_setup(struct dsa_port *dp)
> > +{
> > +	struct device_node *leds, *led;
> > +	int err;
> > +
> > +	if (!dp->dn)
> > +		return 0;
> > +
> > +	leds = of_get_child_by_name(dp->dn, "leds");
> > +	if (!leds)
> > +		return 0;
> > +
> > +	for_each_available_child_of_node(leds, led) {
> > +		err = dsa_port_led_setup(dp, led);
> > +		if (err)
> > +			return err;
> 
> Hi Andrew,
> 
> I realise this is an RFC, but Coccinelle tells me that a call to
> of_node_put() is needed here.

Thanks. If you had not pointed it out, i would probably get it wrong
in the next version as well.

   Andrew

