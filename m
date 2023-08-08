Return-Path: <netdev+bounces-25463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D2E77435D
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745CB1C20E85
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3083A15498;
	Tue,  8 Aug 2023 18:02:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE3714F97
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:02:43 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDC45FDDE
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 10:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2pAmFX3YeIgmyhTrYrtcDwuXaxOBustyHvj5Pwix5uU=; b=2PItYUJQUzKUDbWrpfcklsCVBp
	B9cX9UFI24DymAEiKYWUCMnSsmZ/Er0jWt3eFapdFjfXIolp50pxp+MvnD7iwYZ6GkIQgHd2wETps
	iYQJgEPTkkgYlPBroEyL5L7T/3pMFT1jioKXRXS1IxSKS9HpqYeyO5/XCF672gNyNYII=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qTPfs-003UWY-US; Tue, 08 Aug 2023 18:35:12 +0200
Date: Tue, 8 Aug 2023 18:35:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mark parsed interface mode for legacy
 switch drivers
Message-ID: <7ea0265a-516e-4bad-9eee-b65509bd236d@lunn.ch>
References: <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk>
 <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk>
 <20230808120652.fehnyzporzychfct@skbuf>
 <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk>
 <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk>
 <20230808120652.fehnyzporzychfct@skbuf>
 <ZNI1WA3mGMl93ib8@shell.armlinux.org.uk>
 <ZNI1WA3mGMl93ib8@shell.armlinux.org.uk>
 <20230808123901.3jrqsx7pe357hwkh@skbuf>
 <ZNI7x9uMe6UP2Xhr@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNI7x9uMe6UP2Xhr@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> $ git grep -l dsa_switch_ops.*= drivers/net/dsa/ | xargs grep -L '\.phylink_get_caps'
> drivers/net/dsa/dsa_loop.c
> drivers/net/dsa/mv88e6060.c
> drivers/net/dsa/realtek/rtl8366rb.c
> drivers/net/dsa/vitesse-vsc73xx-core.c
> 
> I've floated the idea to Linus W and Arinc about setting
> .mac_capabilities in the non-phylink_get_caps path as well, suggesting:
> 
> 	MAC_1000 | MAC_100 | MAC_10 | MAC_SYM_PAUSE | MAC_ASYM_PAUSE

There is a datasheet for the 6060 here:

https://www.insidegadgets.com/wp-content/uploads/2014/07/88E6060.pdf

It is Fast Ethernet only.

	Andrew

