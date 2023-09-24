Return-Path: <netdev+bounces-36023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 770897ACA1F
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 16:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 25663B20957
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 14:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D72D274;
	Sun, 24 Sep 2023 14:51:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD672D26D
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 14:51:23 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180E9FC
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 07:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wF8VAQkHm9aN8DanZcHbvC5q8/HPij/Ar/JZNa+ORCY=; b=RTqDnomTBtd2RJjAH6CSlzlyJR
	mM3J05j5rKGOIUKzu+LzLyMrzbEoweDsd9CMM8umrdgK/E0oz3efGS8TI/y/b8xj5aFiCwqfUODXZ
	q/+FY6X2lJVedqkfhRe5gruEv8YWPwFeXTzc2wDFizkPBRho56On09v97AbAC3UqrtzI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qkQRs-007M2R-St; Sun, 24 Sep 2023 16:51:04 +0200
Date: Sun, 24 Sep 2023 16:51:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Neftin, Sasha" <sasha.neftin@intel.com>
Cc: Prasad Koya <prasad@arista.com>, intel-wired-lan@lists.osuosl.org,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	dumazet@google.com, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	"lifshits, Vitaly" <vitaly.lifshits@intel.com>
Subject: Re: [PATCH] [iwl-net] Revert "igc: set TP bit in 'supported' and
 'advertising' fields of ethtool_link_ksettings"
Message-ID: <04bc5392-24da-49dc-a240-27e8c69c7e06@lunn.ch>
References: <20230922163804.7DDBA2440449@us122.sjc.aristanetworks.com>
 <40c11058-5065-41f0-bf09-2784b291c41b@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40c11058-5065-41f0-bf09-2784b291c41b@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Sep 24, 2023 at 10:09:17AM +0300, Neftin, Sasha wrote:
> On 22/09/2023 19:38, Prasad Koya wrote:
> > This reverts commit 9ac3fc2f42e5ffa1e927dcbffb71b15fa81459e2.
> > 
> > After the command "ethtool -s enps0 speed 100 duplex full autoneg on",
> > i.e., advertise only 100Mbps speed to the peer, "ethtool enps0" shows
> > advertised speeds as 100Mbps and 2500Mbps. Same behavior is seen
> > when changing the speed to 10Mbps or 1000Mbps.
> > 
> > This applies to I225/226 parts, which only supports copper mode.
> > Reverting to original till the ambiguity is resolved.
> > 
> > Fixes: 9ac3fc2f42e5 ("igc: set TP bit in 'supported' and
> > 'advertising' fields of ethtool_link_ksettings")
> > Signed-off-by: Prasad Koya <prasad@arista.com>
> 
> Acked-by: Sasha Neftin <sasha.neftin@intel.com>
> 
> > ---
> >   drivers/net/ethernet/intel/igc/igc_ethtool.c | 2 --
> >   1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> > index 93bce729be76..0e2cb00622d1 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> > @@ -1708,8 +1708,6 @@ static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
> >   	/* twisted pair */
> >   	cmd->base.port = PORT_TP;
> >   	cmd->base.phy_address = hw->phy.addr;
> > -	ethtool_link_ksettings_add_link_mode(cmd, supported, TP);
> > -	ethtool_link_ksettings_add_link_mode(cmd, advertising, TP);

This looks very odd. Please can you confirm this revert really does
make ethtool report the correct advertisement when it has been limited
to 100Mbps. Because looking at this patch, i have no idea how this is
going wrong.

	Andrew

