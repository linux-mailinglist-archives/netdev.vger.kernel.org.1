Return-Path: <netdev+bounces-48699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF947EF4C1
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 15:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF961C20902
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 14:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D0C35F02;
	Fri, 17 Nov 2023 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="z8sIuKyu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB10130;
	Fri, 17 Nov 2023 06:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=iAkHQGc9Edeyxcg4qVcHCYzdGc4W9iYw+dBZmqgXC2s=; b=z8
	sIuKyu0PZQo8Ea8EUYW/pA1XMaUR/Dj7Ns+M2Atb697BbHI47+Y6e1R5Kpemm41N/XJ/WRTtzwTJD
	GrXzQuwO8p2VlWiuQ6R0pPXyr6J/S8IPqkXMMFqw3sFQ2kpsmS6RToXS5Ui8+N1f15PCvBnMySOv7
	Z0C4Fa0ZDJkCBDE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r40AX-000Rpd-6D; Fri, 17 Nov 2023 15:50:05 +0100
Date: Fri, 17 Nov 2023 15:50:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 9/9] net: pse-pd: Add PD692x0 PSE controller
 driver
Message-ID: <18e7e893-8473-4417-93f8-c3b4ccf4b971@lunn.ch>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
 <20231116-feature_poe-v1-9-be48044bf249@bootlin.com>
 <8e077bbe-3b65-47ee-a3e0-fdb0611a2d3a@lunn.ch>
 <20231117122236.3138b45e@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231117122236.3138b45e@kmaincent-XPS-13-7390>

On Fri, Nov 17, 2023 at 12:22:36PM +0100, Köry Maincent wrote:
> Thanks for your review!
> 
> On Thu, 16 Nov 2023 23:41:55 +0100
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > > +struct pd692x0_msg {
> > > +	struct pd692x0_msg_content content;
> > > +	u16 delay_recv;
> > > +};  
> > 
> > > +	if (msg->delay_recv)
> > > +		msleep(msg->delay_recv);
> > > +	else
> > > +		msleep(30);  
> > 
> > > +	if (msg->delay_recv)
> > > +		msleep(msg->delay_recv);
> > > +	else
> > > +		msleep(30);  
> > 
> > > +	if (msg->delay_recv)
> > > +		msleep(msg->delay_recv);
> > > +	else
> > > +		msleep(30);
> > > +  
> > 
> > As far as i can see with a quick search, nothing ever sets delay_recv?
> > 
> > 	Andrew
> 
> In fact I wrote the driver taking into account that there are two commands (save
> and restore) that need a different delay response. As currently we do not
> support them I can indeed drop it for now and add it back when I will add their
> support.

When you add it back, maybe just arrange for delay_recv to be set to
30?

	Andrew

