Return-Path: <netdev+bounces-34083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4107A2045
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 15:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2571C20DAB
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 13:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9825510A29;
	Fri, 15 Sep 2023 13:53:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5FD10949
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 13:53:41 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29263B8
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 06:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6oQE1aYLEK1IdNuoBWg7lIbLQLaDZbwcrNkGd3/rd4s=; b=lQklDGCPF1REEPbiaq+I10DHyL
	iePuehpJIcKeDUbZBTqJamXPyzansRxxUTI7iQcjLwX2k/WSAH5OGUR9znoZHhbPDpG5yvCpmU8CJ
	xoPru/za1+W8fVNgj8qJF2TfXaRv1TITnlBa6mvDDAQiTQlZufCBaZE0M2LwkLOh+rGE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qh9GC-006Y1X-RB; Fri, 15 Sep 2023 15:53:28 +0200
Date: Fri, 15 Sep 2023 15:53:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	"Greenwalt, Paul" <paul.greenwalt@intel.com>, aelior@marvell.com,
	intel-wired-lan@lists.osuosl.org, manishc@marvell.com,
	netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 2/9] ethtool: Add forced
 speed to supported link modes maps
Message-ID: <046e07df-0ea1-4e4a-a205-29d17f637d69@lunn.ch>
References: <20230819093941.15163-1-paul.greenwalt@intel.com>
 <e6e508a7-3cbc-4568-a1f5-c13b5377f77e@lunn.ch>
 <e676df0e-b736-069c-77c4-ae58ad1e24f8@intel.com>
 <ZOZISCYNWEKqBotb@baltimore>
 <a9fee3a7-8c31-e048-32eb-ed82b8233aee@intel.com>
 <51ee86d8-5baa-4419-9419-bcf737229868@lunn.ch>
 <ZPCQ5DNU8k8mfAct@baltimore>
 <87ea2635-c0b3-4de4-bc65-cbc33a0d5814@lunn.ch>
 <ZQMYUM3F/9v9cTQM@baltimore>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQMYUM3F/9v9cTQM@baltimore>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 14, 2023 at 04:27:28PM +0200, Pawel Chmielewski wrote:
> On Sun, Sep 03, 2023 at 04:00:57PM +0200, Andrew Lunn wrote:
> > > Let me check if I understand correctly- is that what was sent with the
> > > v3 [1] , with the initialization helper (ethtool_forced_speed_maps_init)
> > > and the structure map in the ethtool code? Or do you have another helper
> > > in mind?
> > 
> > Sorry for the late reply, been on vacation.
> > 
> > The main thing is you try to reuse the table:
> > 
> > static const struct phy_setting settings[] = {}
> > 
> > If you can build your helper on top of phy_lookup_setting() even
> > better. You don't need a phy_device to use those.
> > 
> > 	Andrew
> 
> Thank for the hint Andrew! I took a look into the phy-core code,
> and a little into phylink. However, I still have the same concern
> regarding modes that are supported/unsupported by hardware (managed
> by the firmware in our case). Let's say I'm only looking for duplex
> modes and iterate over speeds with advertised modes map as an argument
> for phy_lookup_setting. In this case, I still need another table/map of
> hardware compatible link modes to check against. Theese are actually
> the maps we'd like to keep in the driver (and proposed in [1]), so
> maybe the simple intersect check between them and the advertised modes
> is sufficient?

The idea was you have a mask of link modes which your hardware
actually supports. You then ask the core code, give me a link mode
which fulfils this speed and duplex, taking into account the mask.

      Andrew

