Return-Path: <netdev+bounces-49422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3162C7F2003
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 23:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82CC928226A
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 22:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B1B39856;
	Mon, 20 Nov 2023 22:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="b1KIjbTv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E3F97;
	Mon, 20 Nov 2023 14:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Oz1szRIZelgpWpLqYCUSXAM3v9p92mCuoFgS4JdSE8Q=; b=b1
	KIjbTvMoM7PSdR5cFcjvUt8nXka1oMHQrGAooE3TCNJrlij2DWm/bbvwc1yTQZCE3vLUgKWkH8HLU
	6ZehboeaBcDHgVK/JjO2MZKu1uGEX4ngJ+NC01qizzz4yoD5KWUEHy+kQLDkWLzfo7/CumDcEnvbC
	6Js/xXq6gxq3eLU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r5CXI-000hFy-Dg; Mon, 20 Nov 2023 23:14:32 +0100
Date: Mon, 20 Nov 2023 23:14:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
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
Subject: Re: [PATCH net-next 2/9] ethtool: Expand Ethernet Power Equipment
 with PoE alongside PoDL
Message-ID: <887dbafe-def1-443f-8df2-b20b5ddc4db7@lunn.ch>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
 <20231116-feature_poe-v1-2-be48044bf249@bootlin.com>
 <04cb7d87-bb6b-4997-878d-490c17bfdfd0@lunn.ch>
 <20231120110944.66938859@kmaincent-XPS-13-7390>
 <20231120111008.GC590719@pengutronix.de>
 <2539b109-72ad-470a-9dae-9f53de4f64ec@lunn.ch>
 <20231120204221.GD590719@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231120204221.GD590719@pengutronix.de>

> > However, everything not PoDL PSE seems to be clause 33. So how about:
> > 
> > 	enum ethtool_podl_pse_admin_state podl_admin_control;
> > 	enum ethtool_c33_pse_admin_state c33_admin_control;  
> > 
> > At least inside the kernel we use c22, c45, c37 etc. I'm not sure they
> > are visible to userspace, but if we don't have a better name, maybe we
> > have to use c33 in userspace as well.
> > 
> > I do think naming like this makes it clear we are talking about two
> > parallel technologies, not a generic layer and then extensions for
> > podl.
> > 
> > What do you think?
> 
> I'm OK with it.

Great.

> 
> Köry, can you please include some kernel documentation in your patches?
> Something like this. I hope it will help to clarify things :) :

This is good. I'm just wondering where to put it. Ideally we want to
cross reference to it in both this header file, and in the netlink
UAPI.

	Andrew

