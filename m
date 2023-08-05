Return-Path: <netdev+bounces-24638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 639E1770E6C
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 09:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB035282545
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 07:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6125687;
	Sat,  5 Aug 2023 07:25:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023491FDD
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 07:25:34 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C374EE6;
	Sat,  5 Aug 2023 00:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Xez5f813ZkGpJ9nnfDVitRCP7/A75yJ6R1BQz4vgmBo=; b=Qn7QBoeVit7h+ZkGV7/BSu6coy
	7btBZ9P/k7MTM8+UDhemjclBCDWPiMT3mpSk/eY6bxnkFS4dIbkO2VyriHVI5PaTWIZ5ctgZHCKqT
	bhLrC1GFGTgReFo4yxVUQpqkoNJ/2IjJHKcuyqU/51YSpqwtdotrPBC6hJtujE4CVzC0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qSBf9-003AfK-M5; Sat, 05 Aug 2023 09:25:23 +0200
Date: Sat, 5 Aug 2023 09:25:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nick Bowler <nbowler@draconx.ca>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: PROBLEM: Broken or delayed ethernet on Xilinx ZCU104 since 5.18
 (regression)
Message-ID: <c38e208b-4ffa-4310-ae00-412447fc4269@lunn.ch>
References: <CADyTPEzqf8oQAPSFRWJLxAhd-WE4fX2zdoe9Vu6V9hZMn1Yc8g@mail.gmail.com>
 <CAL_JsqLrErF__GGHfanRFCpfbOh6fvz4-aJv32h8OfDjUeZPSg@mail.gmail.com>
 <CADyTPEwgG0=R_b5DNBP0J0auDXu2BNTOwkSUFg-s7pLJUPC+Tg@mail.gmail.com>
 <CADyTPExgjcaUeKiR108geQhr0KwFC0A8qa_n_ST2RxhbSczomQ@mail.gmail.com>
 <CAL_Jsq+N2W0hVN7fUC1rxGL-Hw9B8eQvLgSwyQ3n41kqwDbxyg@mail.gmail.com>
 <CADyTPEyT4NJPrChtvtY=_GePZNeSDRAr9j3KRAk1hkjD=5+i8A@mail.gmail.com>
 <CAL_JsqKGAFtwB+TWc1yKAe_0M4BziEpFnApuWuR3h+Go_=djFg@mail.gmail.com>
 <CADyTPEwY4ydUKGtGNayf+iQSqRVBQncLiv0TpO9QivBVrmOc4g@mail.gmail.com>
 <173b1b67-7f5a-4e74-a2e7-5c70e57ecae5@lunn.ch>
 <CADyTPExypWjMW2PF0EfSFc+vvdzRtNEi_H0p3S-mw1BNWyq6VQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyTPExypWjMW2PF0EfSFc+vvdzRtNEi_H0p3S-mw1BNWyq6VQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > It was also commented out before that change. It could be that gpio
> > controller is missing. Do you have the driver for the tca6416 in
> > your kernel configuration?
> 
> I have CONFIG_GPIO_PCA953X=y which I think is the correct driver?

It does appear to be the correct driver. But check if it has
loaded. It is an i2c device, so maybe you are missing the I2C bus
master device?

       Andrew

