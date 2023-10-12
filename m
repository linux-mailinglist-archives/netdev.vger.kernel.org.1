Return-Path: <netdev+bounces-40488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B32C7C787A
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 23:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50704282B1E
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7584E3E469;
	Thu, 12 Oct 2023 21:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="w+owIZKK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D0834CE2
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 21:18:42 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84939D
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 14:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=u6HT6jAkuHr2GDUHXVnGKahYCR3dVLr4Az18y+WZB1g=; b=w+owIZKK37KoRhu6gokyiIWQ90
	cMrKmoYJAzHLN0qfiehADEOmrVeKWA6vOG8BdAOKjq5bwgtLi8quw2N+8GNiNBNrZ1xFZ+zc4Gx8R
	MhIRqd6em+iYVZPKMSPt1KoPKN4ERHKtorLZH9swHcTUlHw28uzcJoQ0A2sSF80+WbCc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qr34n-0021Dx-R0; Thu, 12 Oct 2023 23:18:37 +0200
Date: Thu, 12 Oct 2023 23:18:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Michal Kubecek <mkubecek@suse.cz>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, opendmb@gmail.com,
	justin.chen@broadcom.com
Subject: Re: [PATCH net-next 1/2] ethtool: Introduce WAKE_MDA
Message-ID: <30ce4245-c98c-4e4d-9e2c-5119d23d1afc@lunn.ch>
References: <20231011221242.4180589-1-florian.fainelli@broadcom.com>
 <20231011221242.4180589-2-florian.fainelli@broadcom.com>
 <20231011230821.75axavcrjuy5islt@lion.mk-sys.cz>
 <3229ff0a-5ce5-4ee2-a79d-15007f2b6030@gmail.com>
 <78aaaa09-1b35-4ddb-8be8-b8f40cf280bc@lunn.ch>
 <0271cea4-f2ab-4d8c-aa0a-9dd65a1318db@broadcom.com>
 <779d6ab4-0c15-4564-9584-1c5332c1f5d1@lunn.ch>
 <fa09c534-95f4-4ff3-973f-33914f4e4ee6@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa09c534-95f4-4ff3-973f-33914f4e4ee6@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > But we should clearly define what we expect in terms of ordering and
> > maybe try to enforce it in the core. Can we make the rxnfc call return
> > -EBUSY or something and an extack message if WAKE_FILTER has not been
> > enabled first?
> 
> It might make sense to do it the other way around, that is you must install
> filters first and if none are installed by the time we enable WAKE_FILTER in
> .set_wol(), we error out with -EINVAL?

I was thinking the other way around would be easier for the core to
enforce. When inserting an rxnfc, it can do an ethtool.get_wol(ndev)
and check WAKE_FILTER is set. That seems simpler than doing a
get_rxnfc() and having to look through the results and try to figure
out which are for WoL?

Anyway, you seem to be volunteering to implement this, so either is
fine for me, so long as we do have some central enforcement.

     Andrew

