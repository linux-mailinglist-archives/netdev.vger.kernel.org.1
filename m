Return-Path: <netdev+bounces-132619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF439927A4
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 10:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B951F2101C
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 08:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE75A18B48F;
	Mon,  7 Oct 2024 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="y5JfrriS"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422D2136354;
	Mon,  7 Oct 2024 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728291402; cv=none; b=o8BC3o9xKyc1wS30NxfLIo+4SuqgIAwtHHKSrtruL/K9/qycIu1cwoNhs3rAEwQDpg8722McLwrHkiMRN+ESvr2gaJg9x5XzCs9aGVnCweJTvAVzjYmXq3xC1qbsleib1toYV4iJ6HU21pgPcbVYBAFpmf8VoMaqdK2frDFwDhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728291402; c=relaxed/simple;
	bh=zdL2OcUuWCghfLpMOEvzNQUziLhVJFXLB5fd3Zh4+vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9PFN4pIsut4eaMR21Y0t9LYzFkpL9EQ6eNE++aoARGSRUxWM5eFjugPX4qxOp3K/VjcbtZ0M3cmzCKPv2v6xydK6c4+44l29ihtSi3U57qOWb34y9z/T07BG9qlDbAmU+x/ULDy0nCz/w4UoBBSS2AN+u8AWaw0U8pthqCB0JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=y5JfrriS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZhAwQv8M5oa7k3C/vYB3Gden64SJwRJoj/egCMnNt54=; b=y5JfrriST8SoZsDWw+xk7OWUZo
	2/E4A40U4RSLMuLIJXLjADhPkH3qP3c1IGXaEkDL6LMo/QLT14HvP3zbSeOneza00aoGAKp9uTVhy
	zf6VkutzcyRB07qJVlPdXg2Jl3+yq84tFkGlOxPWlUP2lMK6q9Y/qN1v60HwUgCoU9m5wv0U2mErt
	GjJWtwMGyFyErSk0+1cZE6kphHiviwR5TwtlNkQ17mPBxUHcP/h2SXVoP6GANAyoHwrrl8jSc3rod
	d0I/vU/VNvS0w0+77454vxm2Gda2pPGhFDf0kMcM/R9lJ2n4JLogOJXSN+Ws/Z6PLbSlDYbnVnokX
	ik06eL8A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33786)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sxjXV-0005Qd-34;
	Mon, 07 Oct 2024 09:56:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sxjXR-00045U-2M;
	Mon, 07 Oct 2024 09:56:21 +0100
Date: Mon, 7 Oct 2024 09:56:21 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Mohammed Anees <pvmohammedanees2003@gmail.com>, davem@davemloft.net,
	edumazet@google.com, f.fainelli@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	olteanv@gmail.com, pabeni@redhat.com
Subject: Re: [PATCH] net: dsa: Fix conditional handling of Wake-on-Lan
 configuration in dsa_user_set_wol
Message-ID: <ZwOiNQSNJ7CzqbO1@shell.armlinux.org.uk>
References: <0d151801-f27c-4f53-9fb1-ce459a861b82@lunn.ch>
 <20241006161032.14393-1-pvmohammedanees2003@gmail.com>
 <32b408a4-8b2d-4425-9757-0f8cbfddf21c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32b408a4-8b2d-4425-9757-0f8cbfddf21c@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Oct 06, 2024 at 09:57:26PM +0200, Andrew Lunn wrote:
> On Sun, Oct 06, 2024 at 09:40:32PM +0530, Mohammed Anees wrote:
> > Considering the insight you've provided, I've written the code below
> > 
> > static int dsa_user_set_wol(struct net_device *dev, struct ethtool_wolinfo *w)
> > {
> > 	struct dsa_port *dp = dsa_user_to_port(dev);
> > 	struct dsa_switch *ds = dp->ds;
> > 	int ret;
> > 
> > 	ret = phylink_ethtool_set_wol(dp->pl, w);
> > 
> > 	if (ret != -EOPNOTSUPP)
> > 		return ret;
> > 
> > 	if (ds->ops->set_wol)
> > 		ret = ds->ops->set_wol(ds, dp->index, w);
> > 		if (ret != -EOPNOTSUPP)
> > 			return ret;
> 
> This can be simplified to just:
> 
> > 	if (ds->ops->set_wol)
> > 		return ds->ops->set_wol(ds, dp->index, w);
> > 
> > 	return -EOPNOTSUPP;
> > }

I don't think the above is correct. While the simplification is, the
overall logic is not.

Let's go back to what Andrew said in his previous reply:

"So userspace could say pumbagsf, with the PHY supporting pmub and the
MAC supporting agsf, and the two need to cooperate."

The above does not do this. Let's go back further:

        phylink_ethtool_set_wol(dp->pl, w);

        if (ds->ops->set_wol)
                ret = ds->ops->set_wol(ds, dp->index, w);

The original code _does_ do this, allowing the PHY and MAC to set
their modes, although the return code is not correct.

I notice V2 of the patch has been posted - in my opinion prematurely
because there's clearly the discussion on the first version has not
reached a conclusion yet.

What I would propose is the following:

	int phy_ret, mac_ret;

	phy_ret = phylink_ethtool_set_wol(dp->pl, w);
	if (phy_ret != 0 && phy_ret != -EOPNOTSUPP)
		return phy_ret;

	if (ds->ops->set_wol)
		mac_ret = ds->ops->set_wol(ds, dp->index, w);
	else
		mac_ret = -EOPNOTSUPP;

	if (mac_ret != 0 && mac_ret != -EOPNOTSUPP)
		return mac_ret;

	/* Combine the two return codes. If either returned zero,
	 * then we have been successful.
	 */
	if (phy_ret == 0 || mac_ret == 0)
		return 0;
	
	return -EOPNOTSUPP;

Which I think is the closest one can get to - there is the possibility
for phylink_ethtool_set_wol() to have modified the WoL state, but
ds->ops->set_wol() to fail with an error code, causing this to return
failure, but I don't see that as being avoidable without yet more
complexity.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

