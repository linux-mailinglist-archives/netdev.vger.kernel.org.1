Return-Path: <netdev+bounces-55971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A4480D017
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 16:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702F028215F
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEA54BAB9;
	Mon, 11 Dec 2023 15:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZrDV1J6B"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D94BD;
	Mon, 11 Dec 2023 07:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=P9gG83qx8aR9uLdUcuIWFCkioCtRZaO43g3YwL30w+E=; b=ZrDV1J6Bl/sRJwDj17If6GhPTE
	+sJqL2xe0aqq2qDLjWdejUOg6VokCSQ8KDOk410SvVABH9PdZhqVxt/ydXNn3FdVoJWKZeTD7liI1
	fsK3IeCLrgK97YzbFys1oSh/S7FW1xMaT8M4taa+4Cb+1hRNFHY/6nXSr37umRTn5mMc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rCiZY-002dTF-R2; Mon, 11 Dec 2023 16:51:56 +0100
Date: Mon, 11 Dec 2023 16:51:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/2] dt-bindings: Document QCA808x PHYs
Message-ID: <6fce1c46-f7ae-4729-b9d4-763af45f6146@lunn.ch>
References: <20231209014828.28194-1-ansuelsmth@gmail.com>
 <242759d9-327d-4fde-b2a0-24566cf5bf25@lunn.ch>
 <65772f6f.050a0220.8a2bb.80c7@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65772f6f.050a0220.8a2bb.80c7@mx.google.com>

On Mon, Dec 11, 2023 at 04:49:00PM +0100, Christian Marangi wrote:
> On Mon, Dec 11, 2023 at 04:44:06PM +0100, Andrew Lunn wrote:
> > > +properties:
> > > +  qca,led-active-high:
> > > +    description: Set all the LEDs to active high to be turned on.
> > > +    type: boolean
> > 
> > I would of expected active high is the default. An active low property
> > would make more sense. It should also be a generic property, not a
> > vendor property. As such, we either want the phylib core to parse it,
> > or the LED core.
> >
> 
> Also sorry for the double email... Any help for the problem of the
> missing link_2500 define in net-next? (merged in Lee tree?)

You need to email Lee and Jakub, ask for a stable branch which can be
pulled into net-next.

       Andrew

