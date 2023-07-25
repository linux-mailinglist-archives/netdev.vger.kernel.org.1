Return-Path: <netdev+bounces-20813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EAB7611D9
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07571C20446
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 10:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF7615AC5;
	Tue, 25 Jul 2023 10:56:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4117714263
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 10:56:50 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0DC2720;
	Tue, 25 Jul 2023 03:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Zxup0ZB33r1kbm3A7ozwR394TBd/65UqUOTZ/imQrpM=; b=EV4JAqedVH1oP+vTphQdjR8flZ
	RhPLXAB2RLG7/YyJl9jozEEGlKNShGEFGp5ItcpcbufPePAwscYZ9KvP2z0RCI/VftJQsNizCihlk
	F1BuKhiIkTEXTiD+Rww55kaQoctwvYVYV3BRDxZmIOuJ9h/Nw1gNvBQ53nPvGhgOt+VdvQ5gA5+tU
	vxla2LHRtrY7dCBpa/vH90DRDyySyca5Rxq/v0zxfa9ayIcfZgFgT0dpROHeA8ttiBTuccFQ76C4x
	GWSNFqPV3X0mK1ZrM004w7+w/wmSF/FXFDQXA32BB25SvTy6N0qx1CPhamFbr/A+qxgrKObjJ/fY5
	1t/xTOqg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53228)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qOFid-0001wE-0m;
	Tue, 25 Jul 2023 11:56:43 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qOFic-0001lh-11; Tue, 25 Jul 2023 11:56:42 +0100
Date: Tue, 25 Jul 2023 11:56:41 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Ante Knezic <ante.knezic@helmholz.de>, andrew@lunn.ch,
	davem@davemloft.net, edumazet@google.com, f.fainelli@gmail.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, olteanv@gmail.com
Subject: Re: [PATCH net-next v3] net: dsa: mv88e6xxx: Add erratum 3.14 for
 88E6390X and 88E6190X
Message-ID: <ZL+qafwCqeDytFRt@shell.armlinux.org.uk>
References: <30e262679bfdfd975c2880b990fe8375b9860aab.camel@redhat.com>
 <20230725095925.25121-1-ante.knezic@helmholz.de>
 <e1cdc94be0e515a5de9d4af8fccfd99e25435b73.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1cdc94be0e515a5de9d4af8fccfd99e25435b73.camel@redhat.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 12:47:43PM +0200, Paolo Abeni wrote:
> [adding Russell]
> On Tue, 2023-07-25 at 11:59 +0200, Ante Knezic wrote:
> > On Tue, 25 Jul 2023 10:56:25 +0200 Paolo Abeni wrote
> > > It looks like you are ignoring the errors reported by
> > > mv88e6390_erratum_3_14(). Should the above be:
> > > 
> > > 		return mv88e6390_erratum_3_14(mpcs);
> > > 
> > > instead?
> > > 
> > 
> > I guess you are right. Would it make sense to do the evaluation for the 
> > 	mv88e639x_sgmii_pcs_control_pwr(mpcs, true);
> > above as well?
> 
> Good question ;) it looks like pcs_post_config() errors are always
> ignored by the core, but I guess it's better to report them as
> accurately as possible.

... because if they occur, it's way too late to attempt to unwind the
changes that have already occurred.

> @Russell, what it your preference here, should we just ignore the
> generate errors earlier, or try to propagate them to the core/phylink,
> should that later be changed to deal with them?

How would we deal with an error?

If it's a "we can't support this configuration" then that's a driver
problem, and means that the validation failed to exclude the
unsupported configuration.

If it's a communication error of some sort, then we're unlikely to
be able to back out the configuration change, because we probably
can't communicate with some device anymore - and there are paths
in phylink where these methods are called where there is no
possibility of propagating an error (due to being called in a
workqueue.)

I did decide that phylink_major_config() ought not proceed if
mac_prepare() fails, but really once mac_prepare() has been called
we're committed - and if an error happens after that, the network
interface is dead.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

