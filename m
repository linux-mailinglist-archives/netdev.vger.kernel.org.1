Return-Path: <netdev+bounces-29370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C1A782F50
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 19:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68621280E58
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 17:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403AC8C07;
	Mon, 21 Aug 2023 17:21:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E702F2B
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 17:21:50 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F8D100;
	Mon, 21 Aug 2023 10:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=21ttcASDit1/izQa88pggG+/P1z9FA9nVd9gaOmu3SE=; b=jt11wQeV+vzprrJafgV+HsB7wB
	dvWl1Taokhk77L27avBNIVApE7ZPwNq1J/a15/7PSa9VWYLGv+3avcevw82wN0H0HK3QqrKFz2B25
	lJUx6DiKWu9MlGffYR+02cC961K+j+obzv5FTADvLOk99PuZGXEwHKDmwHQmZ6TPxobM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qY8av-004hwA-W0; Mon, 21 Aug 2023 19:21:37 +0200
Date: Mon, 21 Aug 2023 19:21:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Lai <justinlai0215@realtek.com>
Cc: "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/2] net/ethernet/realtek: Add Realtek
 automotive PCIe driver code
Message-ID: <3e5b2f0a-3661-4147-bc4e-784eecf41364@lunn.ch>
References: <20230815143756.106623-1-justinlai0215@realtek.com>
 <20230815143756.106623-2-justinlai0215@realtek.com>
 <95f079a4-19f9-4501-90d9-0bcd476ce68d@lunn.ch>
 <4955506dbf6b4ebdb67cbb738750fbc8@realtek.com>
 <eb245c85-0909-4a75-830d-afb96ccd5d38@lunn.ch>
 <4951391892534eaeb2da96f052364e4c@realtek.com>
 <4b630aeb-3098-4108-b8dc-7da6e55a7cf1@lunn.ch>
 <6d35d56f78b7452b9330c3257748fa3c@realtek.com>
 <97f3744d-afbf-4562-9168-5b9e211fac1f@lunn.ch>
 <4db3248874d64418b63fdf5c5e8a0f79@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4db3248874d64418b63fdf5c5e8a0f79@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> But I2C, SPI, MDIO are connected to the SoC through this chip's
> external pins, not on the PCIe bus.

Thanks, that was the information i was trying to get at.

> Actually, there is the other function in the PCIe GMAC(Multiple
> function) to manage the registers of Switch Core.  Should they be
> integrated into the MFD driver?

Can you cleanly attach another PCI driver to those functions?

You need to use an MFD when there is a single top level addressable
block of hardware which has multiple functions. Thank of an I2C
device, which has a single address on the bus, but multiple functions.
Access to that one address needs to be shared via multiple
drivers. The MFD framework provides the glue to share access to the
hardware.

However, PCI identification and addressing is more flexible. So long
as they are separate PCI functions, you should be able to load two
drivers and not have problems. Then you don't need an MFD.

	Andrew

