Return-Path: <netdev+bounces-119245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16054954F5B
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 18:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D51351C20CD5
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 16:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BE11BF307;
	Fri, 16 Aug 2024 16:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwvsHM0x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6661BB6B3;
	Fri, 16 Aug 2024 16:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723827347; cv=none; b=bJGAzZ0czaDkwIbzpmYiCmIXZjk5R01xRyM2XCoejb362eZ4+BqgVRm3/Qwl9+d0q5VzXWYpvlbqg110dwdsefL+Rk0u7ajrWSnfdwrreeD+Ioi+ipLmVoUiaHdrqhPuPblOob4T6fn7McVWsx3rgNNSOL2+Kus281sdajxWnGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723827347; c=relaxed/simple;
	bh=9R0PtQoTwLrW6Qc6jntm+NjpdNxB1SfgI5lxGKr7Kyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaV17KXc014jgtfjnCIeBTbmC2tXLDGRznaq0q0Tm9CHR6aG1FGyUFHifxXTaEnB/Tx2aCpboAxsScuT1XNe5S5/EFEC6a96TpaTZTtzvKe29jWYQ8MJJ8DGvg9jGE97PPnLcV9xD7l6iQhrr+QPd26VST1+vI3LVqTLvbxd3pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwvsHM0x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DCEC32782;
	Fri, 16 Aug 2024 16:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723827346;
	bh=9R0PtQoTwLrW6Qc6jntm+NjpdNxB1SfgI5lxGKr7Kyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gwvsHM0x5i712xgpMGWKihCj8sjOdhmWqGuGXQ8vDAFLK5UN60dozcnrnOPJ9ATbK
	 l3cIQTEpO6OfqJSlRaL1TT1YUfdGH4d69kjKBpdjz+M3pCYSu9/mLSWaoLNgwS0OZK
	 HOIJItf4InOn1yYb8IgjNB1ZdVFUG94RoaMQYKR6rAGlBTK43GxrFu1++3nlYZNq+u
	 Lf6MTrIVqN08VkEw577fFsGQMjpUzr+1iABEixfQmpY3WL7EWN3H9Sj2PEdfzdcRA+
	 opXXSZOMtqGOzzgcAJR9bka6xUtbrB5AeY6wEelahcySGoI4JWobj5Gk8uxdJsPbZC
	 BWON+KcVyfQyg==
Date: Fri, 16 Aug 2024 17:55:41 +0100
From: Simon Horman <horms@kernel.org>
To: Parthiban.Veerasooran@microchip.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ramon.nordin.rodriguez@ferroamp.se,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next 5/7] net: phy: microchip_t1s: add support for
 Microchip's LAN867X Rev.C1
Message-ID: <20240816165541.GB632411@kernel.org>
References: <20240812134816.380688-1-Parthiban.Veerasooran@microchip.com>
 <20240812134816.380688-6-Parthiban.Veerasooran@microchip.com>
 <20240815144248.GF632411@kernel.org>
 <3235fb9a-62cf-4f9a-b21e-e0b881c79c43@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3235fb9a-62cf-4f9a-b21e-e0b881c79c43@microchip.com>

On Fri, Aug 16, 2024 at 01:21:02PM +0000, Parthiban.Veerasooran@microchip.com wrote:
> On 15/08/24 8:12 pm, Simon Horman wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Mon, Aug 12, 2024 at 07:18:14PM +0530, Parthiban Veerasooran wrote:
> >> This patch adds support for LAN8670/1/2 Rev.C1 as per the latest
> >> configuration note AN1699 released (Revision E (DS60001699F - June 2024))
> >> https://www.microchip.com/en-us/application-notes/an1699
> >>
> >> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
> >> ---
> >>   drivers/net/phy/Kconfig         |  2 +-
> >>   drivers/net/phy/microchip_t1s.c | 68 ++++++++++++++++++++++++++++++++-
> >>   2 files changed, 67 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> >> index 68db15d52355..63b45544c191 100644
> >> --- a/drivers/net/phy/Kconfig
> >> +++ b/drivers/net/phy/Kconfig
> >> @@ -282,7 +282,7 @@ config MICREL_PHY
> >>   config MICROCHIP_T1S_PHY
> >>        tristate "Microchip 10BASE-T1S Ethernet PHYs"
> >>        help
> >> -       Currently supports the LAN8670/1/2 Rev.B1 and LAN8650/1 Rev.B0/B1
> >> +       Currently supports the LAN8670/1/2 Rev.B1/C1 and LAN8650/1 Rev.B0/B1
> >>          Internal PHYs.
> >>
> >>   config MICROCHIP_PHY
> >> diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
> >> index d0af02a25d01..62f5ce548c6a 100644
> >> --- a/drivers/net/phy/microchip_t1s.c
> >> +++ b/drivers/net/phy/microchip_t1s.c
> >> @@ -3,7 +3,7 @@
> >>    * Driver for Microchip 10BASE-T1S PHYs
> >>    *
> >>    * Support: Microchip Phys:
> >> - *  lan8670/1/2 Rev.B1
> >> + *  lan8670/1/2 Rev.B1/C1
> >>    *  lan8650/1 Rev.B0/B1 Internal PHYs
> >>    */
> >>
> >> @@ -12,6 +12,7 @@
> >>   #include <linux/phy.h>
> >>
> >>   #define PHY_ID_LAN867X_REVB1 0x0007C162
> >> +#define PHY_ID_LAN867X_REVC1 0x0007C164
> >>   /* Both Rev.B0 and B1 clause 22 PHYID's are same due to B1 chip limitation */
> >>   #define PHY_ID_LAN865X_REVB 0x0007C1B3
> >>
> >> @@ -243,7 +244,7 @@ static int lan865x_revb_config_init(struct phy_device *phydev)
> >>                if (ret)
> >>                        return ret;
> >>
> >> -             if (i == 2) {
> >> +             if (i == 1) {
> >>                        ret = lan865x_setup_cfgparam(phydev, offsets);
> >>                        if (ret)
> >>                                return ret;
> > 
> > Hi Parthiban,
> > 
> > This patch is addressing LAN867X Rev.C1 support.
> > But the hunk above appears to update LAN865X Rev.B0/B1 support.
> > Is that intentional?
> 
> Hi Simon,
> 
> Sorry, there is a mistake here. It is supposed to be "i == 1" only, but 
> it should have been in the below patch onwards,
> 
> "[PATCH net-next 2/7] net: phy: microchip_t1s: update new initial 
> settings for LAN865X Rev.B0"
> 
> Thanks for pointing it out. Will correct it in the next version.

Thanks,

Other than the minor problem noted above, the patchset looked good to me.

