Return-Path: <netdev+bounces-243264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 20760C9C616
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 18:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C03F1345943
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 17:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC6B2C0298;
	Tue,  2 Dec 2025 17:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="nET5sUqd"
X-Original-To: netdev@vger.kernel.org
Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF492BF00A
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764696212; cv=none; b=g0tRVYZfaPUmcGcSs+1Ue/tDATy+RLpnawE7Lxn+zKDaFwU8BCbcfvnc6u8B+yx6FpjtOZPOduqEKjTJYQ/i9tbh/TT9r6MBVFMdhurNdDTULkpQ8cFoua7sqYAg4XgVm5xt4c618MqIHvDun0OJhrfd2tkbtkhgsjniZsy561k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764696212; c=relaxed/simple;
	bh=ZmCYbo/TPdd01/hILdO601w/3qRF8jiovHPBzROjfts=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=r7S+K4qLxHN6Efkb8+1YBSo6RC+xHQzZIRhj7Qh4/ShpbkrEtQu5vTSb9SwoGPSIQxb1B6bUSvzyV/G+OMFvO0g2r+b61nerZJPKg2YIaJfEPS7ELUYin0Vl7UF6XylOm+4YPie2mcrDRWtAN/uhLx1RbYtYNlMt/QY7LF/D1wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=nET5sUqd; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
	In-Reply-To:From:Subject:Cc:To:Message-Id:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=p/v3jivEAAdtw0qYYMGFdMOIbvwaHy+fW++whQm16a8=; b=nET5sUqdTtW7RVkzIyYRiRNANc
	gfXQ8GNiOLH9uE9E0e3GCJprJfRPOUDtLsq9QGl0xPyCzbgkRzVniuj8L1UQsx8G583dRIKQYUp1m
	SM37nXzSC5pXuJmiVlauQGhPKeNrfUi331POnFEWwPEwvio4rANwf6s4WhaN2Y8pwmlpg+XW3vAPe
	1aDX286bQFKf8LS5U+xrHRUtbSXqhy4hMOJMTQWSp/eXU0fD2ND3l8dXpr4e0Tm5XsX0KQF1EpofO
	o4BgqmIi5uZtJ+LHGxNDCykxqx3CzISeRyKXyiMlng3uoV2ywqkxWAGjfsHdCYmr/LXtgTpSOxJ7d
	Fkz/CwVg==;
Date: Tue, 02 Dec 2025 18:23:28 +0100 (CET)
Message-Id: <20251202.182328.1175792352280040166.rene@exactco.de>
To: hkallweit1@gmail.com
Cc: andrew@lunn.ch, netdev@vger.kernel.org, nic_swsd@realtek.com
Subject: Re: [PATCH] r8169: fix RTL8117 Wake-on-Lan in DASH mode
From: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
In-Reply-To: <91791699-e362-4e45-af48-f59fc6d31f53@gmail.com>
References: <2d6a68c7-cad7-4a0d-9c73-03d3c217bfce@lunn.ch>
	<20251202.165654.1809368281930091194.rene@exactco.de>
	<91791699-e362-4e45-af48-f59fc6d31f53@gmail.com>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Tue, 2 Dec 2025 18:04:18 +0100, Heiner Kallweit <hkallweit1@gmail.com> wrote:

> On 12/2/2025 4:56 PM, René Rebe wrote:
> > On Tue, 2 Dec 2025 16:52:42 +0100, Andrew Lunn <andrew@lunn.ch> wrote:
> > 
> >>> Well, the argument is for wakeup to “just work”. There also
> >>> should be some consistency in Linux. Either all drivers should
> >>> enable it or disable it by default. That is why I have thrown in
> >>> the idea of a new kconfig options for downstream distros to
> >>> make a conscious global choice. E.g. we would ship it it
> >>> enabled.
> >>
> >> You might need to separate out, what is Linux doing, and what is the
> >> bootloader doing before Linux takes over the machine.
> > 
> > By Grub2 boot loader is not enabling WoL.
> > 
> >> Linux drivers sometimes don't reset WoL back to nothing enabled. They
> >> just take over how the hardware was configured. So if the bootloader
> >> has enabled Magic packet, Linux might inherit that.
> >>
> >> I _think_ Linux enabling Magic packet by default does not
> >> happen. Which is why it would be good if you give links to 5 to 10
> >> drivers, from the over 200 in the kernel, which do enable WoL by
> >> default.
> > 
> > I'm sure supporting WoL requires active code in each driver. The next
> > time I have free time I'll go compile a list with grep for you.
> > 
> > Best,
> > 
> 
> How I see it:
> At least on consumer mainboards you have to enable WoL also in the BIOS,
> doing it just in Linux typically isn't sufficient. So it takes a user
> activity anyway. Common network managers allow to specify WoL as part
> of the interface configuration which is needed anyway, releasing users
> from the burden to use e.g. ethtool to configure WoL.
> And as stated before, WoL results in higher power consumption if system
> is suspended / shut down. What apparently is less of a concern for
> "professional-grade" NIC's, whilst basically every consumer system comes
> with Realtek NIC's (apart from few systems with Intel i225/i226).

I grepped the Linux kernel and quickly found drivers explicitly
enabling WoL usually unconditionally. Nothing to do with the BIOS.
Even the "professional" Intel drivers do it:

ixgbe:
       /* WOL not supported for all devices */
        adapter->wol = 0;
        hw->eeprom.ops.read(hw, 0x2c, &adapter->eeprom_cap);
        hw->wol_enabled = ixgbe_wol_supported(adapter, pdev->device,
                                                pdev->subsystem_device);
        if (hw->wol_enabled)
                adapter->wol = IXGBE_WUFC_MAG;

e1000:
        /* initialize the wol settings based on the eeprom settings */
        adapter->wol = adapter->eeprom_wol;
        device_set_wakeup_enable(&adapter->pdev->dev, adapter->wol);

tg3:
        /* Assume an onboard device and WOL capable by default.  */
        tg3_flag_set(tp, EEPROM_WRITE_PROT);
        tg3_flag_set(tp, WOL_CAP);
	...
                if (tp->phy_flags & TG3_PHYFLG_ANY_SERDES &&
                    !(nic_cfg & NIC_SRAM_DATA_CFG_FIBER_WOL))
                        tg3_flag_clear(tp, WOL_CAP);

Again, this is the only production board I have to enable it
explicitly. And I collected a lot, ... https://t2linux.com/hardware/

But I hear your argument. I suspend all our servers for energy
savings, too. All I say is it should be consistent. And as I
acknowledged from the beginning there might be different preferences,
I offered to make it a kconfig option to unify this default decission.

Happy to do such a patch if it helps and makes everyone happy.

I could also simply patch the realtek driver to enable it by default
for us in T2/Linux.

      René

-- 
René Rebe, ExactCODE GmbH, Berlin, Germany
https://exactco.de • https://t2linux.com • https://patreon.com/renerebe

