Return-Path: <netdev+bounces-24629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF43770E3F
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 09:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C23282596
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 07:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6593D82;
	Sat,  5 Aug 2023 07:03:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF63120F9
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 07:03:42 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF093C2D;
	Sat,  5 Aug 2023 00:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eNV9BJHzRKJBCMh2KS7xG2A2ieDViFw7iaV7Z866HoU=; b=SmYRgD9fHnbUw8sA4F3TkjVaWL
	04c2G2g7fDHqKZMQOrI9MqCFbE9+B2szxgdbrL+Byz8ahJJ2kMhKXCnVyEH/rJIkNCJkCv2ZGF0C6
	oM4WV7uA6DreaLPqmqk9YlFNFR3EJJbHEQAAuLONzG2q4PxcoBCkxYg9+n7lHfqiqraQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qSBK1-003AZW-93; Sat, 05 Aug 2023 09:03:33 +0200
Date: Sat, 5 Aug 2023 09:03:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nick Bowler <nbowler@draconx.ca>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: PROBLEM: Broken or delayed ethernet on Xilinx ZCU104 since 5.18
 (regression)
Message-ID: <bc983c94-6276-4282-8b59-7e706932f903@lunn.ch>
References: <CADyTPEzqf8oQAPSFRWJLxAhd-WE4fX2zdoe9Vu6V9hZMn1Yc8g@mail.gmail.com>
 <CAL_JsqLrErF__GGHfanRFCpfbOh6fvz4-aJv32h8OfDjUeZPSg@mail.gmail.com>
 <CADyTPEwgG0=R_b5DNBP0J0auDXu2BNTOwkSUFg-s7pLJUPC+Tg@mail.gmail.com>
 <CADyTPExgjcaUeKiR108geQhr0KwFC0A8qa_n_ST2RxhbSczomQ@mail.gmail.com>
 <CAL_Jsq+N2W0hVN7fUC1rxGL-Hw9B8eQvLgSwyQ3n41kqwDbxyg@mail.gmail.com>
 <CADyTPEyT4NJPrChtvtY=_GePZNeSDRAr9j3KRAk1hkjD=5+i8A@mail.gmail.com>
 <CAL_JsqKGAFtwB+TWc1yKAe_0M4BziEpFnApuWuR3h+Go_=djFg@mail.gmail.com>
 <CADyTPEwY4ydUKGtGNayf+iQSqRVBQncLiv0TpO9QivBVrmOc4g@mail.gmail.com>
 <ZM17VKzDBdm4uMNY@shell.armlinux.org.uk>
 <CADyTPEyqG7D-_iuo+5WFGhhidK7p_fmvDhbgz05xogSU042Uag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyTPEyqG7D-_iuo+5WFGhhidK7p_fmvDhbgz05xogSU042Uag@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> The result is the same for all six calls.  The macb_mdiobus_register
> function returns -EPROBE_DEFER, which comes from the topmost call
> to of_mdiobus_register within that function.  That is, this is the
> part that returns -EPROBE_DEFER:
> 
> 	child = of_get_child_by_name(np, "mdio");
> 	if (child) {
> 		int ret = of_mdiobus_register(bp->mii_bus, child);
> 
> 		of_node_put(child);
> 		return ret;
> 	}

So you need to keep going down and seeing where is EPROBE_DEFER is
coming from.

You are missing some resource somewhere, probably because you are
missing a driver. Sometimes it is worth running a distro kernel which
has nearly everything enabled as modules, so you can find out what you
actually need. Then use 'make localmodconfig' to reduce the
configuration down to just what you need.

	Andrew

