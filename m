Return-Path: <netdev+bounces-186772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429E6AA105E
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 17:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CDC1920A9C
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 15:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DC9221548;
	Tue, 29 Apr 2025 15:23:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA41E21E091;
	Tue, 29 Apr 2025 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745940179; cv=none; b=ozFd4mryoPfwmC/ZjIwOhrpYgu+Wm+Dv8qqmWymF2RlY0EWd8lst3WOYxNL2KjnfUnaRYRp2sr4yBPpDITfK01jR4epmsuMLGphxcvOTXgXlyii+qmgO5kB9pgqFmaxHURrioJdjF9LUo2ovu2wY4nULq9QPR6VbytMM9DXolFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745940179; c=relaxed/simple;
	bh=llhfpFoKH8v5QXL4Jux8nct3jyloY4fKvWSZq6Ne0dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sawFKKFmhz598P+WxyIGQSpLkKjhq4OITSJgkL7f0ipQwP9gmCtNPcNJCdc7V3/AeeYQZPVrmIXhBBJkD21tPcAQ16DflDqZjWSL9pMnFUnpAOh0nsYtuz4yGsImEIBEQ6wDUElFdPt89eXqCeduhfIWhXtyuOvR84ohZaNuNkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1u9mhG-000000005QV-3RYH;
	Tue, 29 Apr 2025 15:22:30 +0000
Date: Tue, 29 Apr 2025 16:22:26 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Frank Wunderlich <frank-w@public-files.de>
Cc: linux-mediatek@lists.infradead.org, Felix Fietkau <nbd@nbd.name>,
	John Crispin <john@phrozen.org>,
	Eric Woudstra <ericwouds@gmail.com>, Elad Yifee <eladwf@gmail.com>,
	Bo-Cun Chen <bc-bocun.chen@mediatek.com>,
	Sky Huang <skylake.huang@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next] net: ethernet: mtk_eth_soc: add support for
 MT7988 internal 2.5G PHY
Message-ID: <aBDusgnaJUmZrp_v@makrotopia.org>
References: <ab77dc679ed7d9669e82d8efeab41df23b524b1f.1745617638.git.daniel@makrotopia.org>
 <aAwV4AOKYs3TljM0@makrotopia.org>
 <687380A7-A580-41EB-8278-73B9942E4280@public-files.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <687380A7-A580-41EB-8278-73B9942E4280@public-files.de>

On Tue, Apr 29, 2025 at 04:12:19PM +0200, Frank Wunderlich wrote:
> Am 26. April 2025 01:08:16 MESZ schrieb Daniel Golle <daniel@makrotopia.org>:
> >On Fri, Apr 25, 2025 at 10:51:18PM +0100, Daniel Golle wrote:
> >> The MediaTek MT7988 SoC comes with an single built-in Ethernet PHY
> >> supporting 2500Base-T/1000Base-T/100Base-TX/10Base-T link partners in
> >> addition to the built-in MT7531-like 1GE switch. The built-in PHY only
> >> supports full duplex.
> >> 
> >> Add muxes allowing to select GMAC2->2.5G PHY path and add basic support
> >> for XGMAC as the built-in 2.5G PHY is internally connected via XGMII.
> >> The XGMAC features will also be used by 5GBase-R, 10GBase-R and USXGMII
> >> SerDes modes which are going to be added once support for standalone PCS
> >> drivers is in place.
> >> 
> >> In order to make use of the built-in 2.5G PHY the appropriate PHY driver
> >> as well as (proprietary) PHY firmware has to be present as well.
> >> 
> >> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> >> ---
> >> [...]
> >> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> >> index 88ef2e9c50fc..e3a8b24dd3d3 100644
> >> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> >> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> >> [...]
> >> @@ -587,6 +603,10 @@
> >>  #define GEPHY_MAC_SEL          BIT(1)
> >>  
> >>  /* Top misc registers */
> >> +#define TOP_MISC_NETSYS_PCS_MUX	0x84
> >
> >This offset still assumes topmisc syscon to start at 0x11d10000.
> >If the pending series[1] adding that syscon at 0x11d10084 gets merged
> >first, this offset will have to be changed to
> >#define TOP_MISC_NETSYS_PCS_MUX	0x0
> >
> >[1]: https://patchwork.kernel.org/project/linux-mediatek/patch/20250422132438.15735-8-linux@fw-web.de/
> 
> Imho this should be changed as well
> 
> #define USB_PHY_SWITCH_REG	0x218
> 
> To
> 
> 0x194
> 
> It is used in mtk_eth_path.c set_mux_u3_gmac2_to_qphy

This depends on how we define topmisc for MT7981, as the MTK_U3_COPHY_V2
capability flag is set only for the MT7981 SoC (and hence I would not touch
it in a commit regarding the MT7988 SoC).

In MediaTek's SDK, it is defined as
    topmisc: topmisc@11d10000 {
            compatible = "mediatek,mt7981-topmisc", "syscon";
            reg = <0 0x11d10000 0 0x10000>;
            #clock-cells = <1>;
    };

