Return-Path: <netdev+bounces-133809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BBB9971B6
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69751C22F10
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 16:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF211E04A0;
	Wed,  9 Oct 2024 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="s1HufB87"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1591E1C0E;
	Wed,  9 Oct 2024 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491412; cv=none; b=bM1apDR8eDj2KvTwYLCEdN9rTz8+3J0QX6nKh7FTmWYe+ayBl+oIJMVtR5kBSdP7pNiIVLSh85ObKL4KcbL6TqoRtEknrK6uuCbLp48ue//8CtD4Yt1mCxVYUHzyAzTbHxAstlSQPN742ytb/qP5RhFQ9ZpkSC1teVC5Yb85xSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491412; c=relaxed/simple;
	bh=OUKhEcNbha5YcEa7m/rKvJ/i0OHrwmxhPF3/pG3s75w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBPkOcm10OY72DH/rygVtYD+/SAbvD1x6mrojkE4C6mRA6ZtdPCnNcHwH/I+MQ26iII7IbiwHAymKXKMJv14/PR5/xO+jh7U9F00w0Ww+eiDFKYwXFVssrBY7je0BV0Vht0ZSEB1HLJRJGp+2vePhNcMWBkOjT9mrhSE+pYHBwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=s1HufB87; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gS4ZYvrlkJu4l79k4TX2iRWC53n6J5EZUrveZPNH42U=; b=s1HufB87PdOiA1F+12cwTHYYyf
	h+bXJNWkLGGjgKUoFO6wh55sfX7GSt1/jRCifh5zAr8AitVq39DCzYbmlQW+6CUxe2oqjlUO5luwJ
	0gTK+DQsmYefSi+O5syCPBgUdBNmi8wjKSpuXCgfnvTLOlF8WcMkk69VrvW4Irwmm4eI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1syZZZ-009WHl-J2; Wed, 09 Oct 2024 18:30:01 +0200
Date: Wed, 9 Oct 2024 18:30:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Colin King (gmail)" <colin.i.king@gmail.com>,
	aryan.srivastava@alliedtelesis.co.nz
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: net: dsa: mv88e6xxx: Add devlink regions
Message-ID: <4197286c-3403-433a-8d15-3e720c0fa65a@lunn.ch>
References: <13c4d51e-7209-48c6-883b-661395798a9a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13c4d51e-7209-48c6-883b-661395798a9a@gmail.com>

On Wed, Oct 09, 2024 at 05:20:09PM +0100, Colin King (gmail) wrote:
> Hi Andrew,
> 
> Static analysis on linux-next has detected a potential issue with an
> function returning an uninitialized value from function
> mv88e6xxx_region_atu_snapshot in drivers/net/dsa/mv88e6xxx/devlink.c
> 
> The commit in question is:
> 
> commit bfb255428966e2ab2c406cf6c71d95e9e63241e4
> Author: Andrew Lunn <andrew@lunn.ch>
> Date:   Fri Sep 18 21:11:07 2020 +0200
> 
>     net: dsa: mv88e6xxx: Add devlink regions
> 
> Variable err is not being initialized at the start of the function. In the
> following while-loop err is not being assigned if id == MV88E6XXX_N_FID
> because of the early break out of the loop. This can end up with the
> function returning an uninitialized value in err.

Hi Colin

That is an old commit. I doubt that is the actual cause. What the real
problem is:

Commit ada5c3229b32e48f4c8e09b6937e5ad98cc3675f
Author: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Date:   Mon Oct 7 10:29:05 2024 +1300

    net: dsa: mv88e6xxx: Add FID map cache
    
    Add a cached FID bitmap. This mitigates the need to walk all VTU entries
    to find the next free FID.
    
    When flushing the VTU (during init), zero the FID bitmap. Use and
    manipulate this bitmap from now on, instead of reading HW for the FID
    map.
    
    The repeated VTU walks are costly and can take ~40 mins if ~4000 vlans
    are added. Caching the FID map reduces this time to <2 mins.
    
    Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
    Reviewed-by: Andrew Lunn <andrew@lunn.ch>
    Link: https://patch.msgid.link/20241006212905.3142976-1-aryan.srivastava@alliedtelesis.co.nz
    Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/dsa/mv88e6xxx/devlink.c b/drivers/net/dsa/mv88e6xxx/devlink.c
index a08dab75e0c0..ef3643bc43db 100644
--- a/drivers/net/dsa/mv88e6xxx/devlink.c
+++ b/drivers/net/dsa/mv88e6xxx/devlink.c
@@ -374,7 +374,6 @@ static int mv88e6xxx_region_atu_snapshot(struct devlink *dl,
                                         u8 **data)
 {
        struct dsa_switch *ds = dsa_devlink_to_ds(dl);
-       DECLARE_BITMAP(fid_bitmap, MV88E6XXX_N_FID);
        struct mv88e6xxx_devlink_atu_entry *table;
        struct mv88e6xxx_chip *chip = ds->priv;
        int fid = -1, count, err;
@@ -392,14 +391,8 @@ static int mv88e6xxx_region_atu_snapshot(struct devlink *dl,
 
        mv88e6xxx_reg_lock(chip);
 
-       err = mv88e6xxx_fid_map(chip, fid_bitmap);
-       if (err) {
-               kfree(table);
-               goto out;
-       }
-

The removed code used to ensure err was initialized.

Aryan, please could you fix this.

	Andrew


