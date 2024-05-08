Return-Path: <netdev+bounces-94509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEBF8BFB9F
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 993B4B20FC5
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 11:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F8C8004D;
	Wed,  8 May 2024 11:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="td2zStV3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D3D763EC
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 11:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715166841; cv=none; b=GeD/l/ocwaqAICR9j0HLNTtmHfve80XX6thRBqk+PS7IfnDv+K8AmRLUYslRCYB3DzFbVoRIwzhh4muzv9jgUVOrkf7Mj4sUNBKl7eq0cjpiMxA8NazQlGl7gI8iGqHa3dKxl46eY7fnwJTM273BtkxDbsddNx+lJRJKx69gyjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715166841; c=relaxed/simple;
	bh=fRybOXPi73Hy2AP9E3imJlVNfSIwXRbcfgmZ4cXCbWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1RW9Wo7RMIECMDFILIluAh9TqA29+P3lSf5nV0h4F6fQMBDddPfsXzNqx6iHV1yypkfudZj7uUPMTqzH+g8OKUDARCytDwe6zJn86HE7OUVmKG1JtVwX/1FjRyfjQFEyX5nZcW5uDVxI3gU7tIweyXSpHfDzHcmMknPqPHE6DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=td2zStV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77978C113CC;
	Wed,  8 May 2024 11:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715166841;
	bh=fRybOXPi73Hy2AP9E3imJlVNfSIwXRbcfgmZ4cXCbWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=td2zStV3eIjywWL6/8TtBhPz4LpqRG3y6Kfwr9rVBmdQas6Dh+5WXCoNojiUo9SsE
	 k4M08cU78yHHs43/mMaWNA/slhimSalcnu4YSNNFvOvMYWWnF+D/wmTJEyy7pshnwO
	 DFar6DVqLtvxfIG1Ie59eW5+WGFaDsqmECKehH144z8P97rN1gasOde38zBKSBbmvl
	 VcTbyjjMhFrV3bZW1PV8pH6bvlXrDGHtzRaLg5AkGRGV57zQEQtIyF95820V7hGIME
	 iAb2gEcMuU7fMOdv1tjgZybaOKJfF+2Np9Bwl/S1r6bzo+PrJm08LFVDbV7pOAbyZf
	 lVJ+n9gV1bxGQ==
Date: Wed, 8 May 2024 13:13:52 +0200
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: dsa: update the unicast MAC address
 when changing conduit
Message-ID: <20240508111328.ya4ydnmd6w764q5k@kandell>
References: <20240502122922.28139-1-kabel@kernel.org>
 <20240502122922.28139-1-kabel@kernel.org>
 <20240502122922.28139-3-kabel@kernel.org>
 <20240502122922.28139-3-kabel@kernel.org>
 <20240507201827.47suw4fwcjrbungy@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240507201827.47suw4fwcjrbungy@skbuf>

On Tue, May 07, 2024 at 11:18:27PM +0300, Vladimir Oltean wrote:
> Hi Marek,
> 
> On Thu, May 02, 2024 at 02:29:22PM +0200, Marek Behún wrote:
> > When changing DSA user interface conduit while the user interface is up,
> > DSA exhibits different behavior in comparison to when the interface is
> > down. This different behavior concers the primary unicast MAC address
> 
> nitpick: concerns
> 
> > stored in the port standalone FDB and in the conduit device UC database.
> > 
> > If we put a switch port down while changing the conduit with
> >   ip link set sw0p0 down
> >   ip link set sw0p0 type dsa conduit conduit1
> >   ip link set sw0p0 up
> > we delete the address in dsa_user_close() and install the (possibly
> > different) address in dsa_user_open().
> > 
> > But when changing the conduit on the fly, the old address is not
> > deleted and the new one is not installed.
> > 
> > Since we explicitly want to support live-changing the conduit, uninstall
> > the old address before calling dsa_port_assign_conduit() and install the
> > (possibly different) new address after the call.
> > 
> > Because conduit change might also trigger address change (the user
> > interface is supposed to inherit the conudit interface MAC address if no
> 
> nitpick: conduit
> 
> > address is defined in hardware (dp->mac is a zero address)), move the
> > eth_hw_addr_inherit() call from dsa_user_change_conduit() to
> > dsa_port_change_conduit(), just before installing the new address.
> > 
> > Fixes: 95f510d0b792 ("net: dsa: allow the DSA master to be seen and changed through rtnetlink")
> > Signed-off-by: Marek Behún <kabel@kernel.org>
> > ---
> 
> Sorry for the delay. I've tested this change and basically, while there
> is clearly a bug, that bug produces no adverse effects / cannot be
> reproduced with felix (the only mainline driver with the feature to
> change conduits). So it could be sent to 'net-next' rather that 'net' on
> that very ground, if there is no other separate reason for this to go to
> stable kernels anyway, I guess.

I did send this to net-next. The question is whether I should keep the
Fixes tag.

Marek

> There are 2 reasons why with felix the bug does not manifest itself.
> 
> First is because both the 'ocelot' and the alternate 'ocelot-8021q'
> tagging protocols have the 'promisc_on_conduit = true' flag. So the
> unicast address doesn't have to be in the conduit's RX filter - neither
> the old or the new conduit.
> 
> Second, dsa_user_host_uc_install() theoretically leaves behind host FDB
> entries installed towards the wrong (old) CPU port. But in felix_fdb_add(),
> we treat any FDB entry requested towards any CPU port as if it was a
> multicast FDB entry programmed towards _all_ CPU ports. For that reason,
> it is installed towards the port mask of the PGID_CPU port group ID:
> 
> 	if (dsa_port_is_cpu(dp))
> 		port = PGID_CPU;
> 
> It would be great if this clarification would be made in the commit
> message, to give the right impression to backporters seeking a correct
> bug impact assessment.
> 
> BTW, I'm curious how this is going to be handled with Marvell. Basically
> if all switch Ethernet interfaces have the same MAC address X which
> _isn't_ inherited from their respective conduit (so it is preserved when
> changing conduit), and you have a split conduit configuration like this:
> - half the user ports are under eth0
> - half the user ports are under eth1
> 
> then you have a situation where MAC address X needs to be programmed as
> a host FDB entry both towards the CPU port next to eth0, and towards
> that next to eth1.
> 
> There isn't any specific "core awareness" in DSA about the way in which
> host FDB entries towards multiple CPU ports are handled in the Felix case.
> So the core ends up having a not very good idea of what's happening
> behind the scenes, and basically requests a migration from the old CPU
> port to the new one, when in reality none takes place. I'm wondering how
> things are handled in your new code; maybe we need to adapt the core
> logic if there is a second implementation that's similar to felix in
> this regard. Basically I'm saying that dsa_user_host_uc_install() may
> not need to call dsa_port_standalone_host_fdb_add() when changing
> conduit, if we had dedicated DSA API for .host_fdb_add() rather than
> .port_fdb_add(port == CPU port).
> 
> Anyway, I was able to coerce the code (with extra patches) into validating
> that your patch works on a driver that hypothetically does things a bit
> differently than felix. So, with the commit message reorganized:
> 
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> Tested-by: Vladimir Oltean <olteanv@gmail.com>

