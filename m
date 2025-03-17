Return-Path: <netdev+bounces-175256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD48BA649F8
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 11:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76BDC3B011C
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 10:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7D723909F;
	Mon, 17 Mar 2025 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="J+GbE6C1"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8AD2376F2;
	Mon, 17 Mar 2025 10:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207085; cv=none; b=J8asXdmgqUKv+DdM2mTOR85V6tr2VgiM9gUiVPIMf3bFGMNJfK8QlvjxY+Vog8lGHuQXFSOSKvO86mukxalXp0tVoeejU+deVBh8YBT5WbxB4YG2lhdbhfpD34bOCrPItUVONiRd6F2Hdx/6Uj7JwkEwQ813U+rqNw9ne3lugcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207085; c=relaxed/simple;
	bh=nlCD2AI4xClEigMb987YjLNUYCSZ0DFUEakh+UBVyNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/OAmHhPMUq1ASHDT58vqb/SAIjMODNeHY9/WCQYWWbizJzH18xbXCRuja072Qv+XHqSYG71NiPnFlKhM1qFjAVrMJbRPpoOXtKK5XMnhk7HUcSdWC6jMmPLHj/Q4Z1+80NWo+/fB+Rt+dqi7GCOX5NoWbzk7ndZLoneKjMpI5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=J+GbE6C1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HNSydyEfg2Wb3PXmd93dXABCEL4krGbTEUi5/yWVKPc=; b=J+GbE6C1/4MDpoNoRhujOR86gT
	siauauWuCKOaoc/NrCZejL1EQR1O+daq3QLE2db+LElog01yIvqh9XKhxCkJ1SQNfXoqur8+cpgLR
	FSkz3yOVr5LLQvm52nYKJfq6VBWHFc9pfELQQK6rS/BPSO2l600UkGgMUqYv4q4EZXk5dVAzWqRbo
	5ge+2GIbKdjEkKoia/Ow/O/1hVKawGPTXSRNYKIKzRV4QZX9RrG1OVE+jWGxnFbbUTFPo5CtS7Mv+
	mpmkXSSoeFv/YK1qN5Zr6o3zBK5xVvpBcDma8iAEWbJa5pugt//E7jUQ/cyuNAgza4CfUGXC3GEAB
	JLq6kEbg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33602)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tu7e4-0003LE-0t;
	Mon, 17 Mar 2025 10:24:32 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tu7dz-0003Tx-2T;
	Mon, 17 Mar 2025 10:24:27 +0000
Date: Mon, 17 Mar 2025 10:24:27 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jim Liu <jim.t90615@gmail.com>
Cc: JJLIU0@nuvoton.com, florian.fainelli@broadcom.com, andrew@lunn.ch,
	hkallweit1@gmail.com, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, netdev@vger.kernel.org,
	giulio.benetti+tekvox@benettiengineering.com,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [v2,net] net: phy: broadcom: Correct BCM5221 PHY model detection
 failure
Message-ID: <Z9f4W86z90PgtkBc@shell.armlinux.org.uk>
References: <20250317063452.3072784-1-JJLIU0@nuvoton.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317063452.3072784-1-JJLIU0@nuvoton.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 17, 2025 at 02:34:52PM +0800, Jim Liu wrote:
> Use "BRCM_PHY_MODEL" can be applied to the entire 5221 family of PHYs.
> 
> Fixes: 3abbd0699b67 ("net: phy: broadcom: add support for BCM5221 phy")
> Signed-off-by: Jim Liu <jim.t90615@gmail.com>

Looking at BRCM_PHY_MODEL() and BRCM_PHY_REV(), I think there's more
issues with this driver. E.g.:

#define BRCM_PHY_MODEL(phydev) \
        ((phydev)->drv->phy_id & (phydev)->drv->phy_id_mask)

#define BRCM_PHY_REV(phydev) \
        ((phydev)->drv->phy_id & ~((phydev)->drv->phy_id_mask))

#define PHY_ID_BCM50610                 0x0143bd60
#define PHY_ID_BCM50610M                0x0143bd70

        if ((BRCM_PHY_MODEL(phydev) == PHY_ID_BCM50610 ||
             BRCM_PHY_MODEL(phydev) == PHY_ID_BCM50610M) &&
            BRCM_PHY_REV(phydev) >= 0x3) {

and from the PHY driver table:

        .phy_id         = PHY_ID_BCM50610,
        .phy_id_mask    = 0xfffffff0,

        .phy_id         = PHY_ID_BCM50610M,
        .phy_id_mask    = 0xfffffff0,

BRCM_PHY_REV() looks at _this_ .phy_id in the table, and tries to match
it against the revision field bits 0-3 being >= 3 - but as we can see,
this field is set to the defined value which has bits 0-3 always as
zero. So, this if() statement is always false.

So, BRCM_PHY_REV() should be:

#define BRCM_PHY_REV(phydev) \
	((phydev)->phy_id & ~(phydev)->drv->phy_id_mask)


Next, I question why BRCM_PHY_MODEL() exists in the first place.
phydev->drv->phy_id is initialised to the defined value(s), and then
we end up doing:

	(phydev->drv->phy_id & phydev->drv->phy_id_mask) ==
		one-of-those-defined-values

which is pointless, because we know that what is in phydev->drv->phy_id
/is/ one-of-those-defined-values.

Therefore, I would suggest:

#define BRCM_PHY_MODEL(phydev) ((phydev)->drv->phy_id)

is entirely sufficient, and with such a simple definition, I question
the value of BRCM_PHY_MODEL() existing.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

