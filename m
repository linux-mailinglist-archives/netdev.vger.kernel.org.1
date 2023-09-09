Return-Path: <netdev+bounces-32690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ACB7995F4
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 04:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 920411C20BDF
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 02:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A4F1365;
	Sat,  9 Sep 2023 02:27:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA05D1101
	for <netdev@vger.kernel.org>; Sat,  9 Sep 2023 02:27:41 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534451FEF;
	Fri,  8 Sep 2023 19:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OE+AIxlFdRyZcA4Gag1i4gJe884pcRWVjakLn4CplzA=; b=30rG5BMChfpid4nfM6SSkqxXpT
	y5HHdpI0Wt3J6p7gbZ0V8RZfdC8/HYmsehA1xtW1ZO0PFPQUUnQer13DL7VhZXkItWMWDciP+svtf
	pVuMuCZhIpxTxxuHNINTHGw71C5igSptNHdmRLCifjKf8XCr8zhViUMRMrOrJ90xjP6c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qenh5-00636R-Gx; Sat, 09 Sep 2023 04:27:31 +0200
Date: Sat, 9 Sep 2023 04:27:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: netdev@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH] net: phy: dp83867: Add support for hardware blinking LEDs
Message-ID: <6c8f5cc5-0b8b-42e0-ac86-91ddcb35389f@lunn.ch>
References: <20230907084731.2181381-1-s.hauer@pengutronix.de>
 <2239338.iZASKD2KPV@steina-w>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2239338.iZASKD2KPV@steina-w>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> This works as intended so far. Unfortunately this driver and the PHY LED 
> framework do not support active-low LEDs (yet).

Polarity is something which i've seen a few PHY devices have. It also
seems like a core LED concept, not something specific to PHY LEDs. So
i think this needs to be partially addressed in the LED core.

  Andrew

