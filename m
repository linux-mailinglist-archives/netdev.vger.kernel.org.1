Return-Path: <netdev+bounces-136194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B889A0F0F
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 17:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ABFE281CAA
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 15:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5BE20E021;
	Wed, 16 Oct 2024 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="BzG4JQiZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8623120CCE5;
	Wed, 16 Oct 2024 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729093923; cv=none; b=eY3oZdWgBA3wMO4kd0ojAT5ABURoEJriM1t/OwI5mlnQq+llyzFsciGKOlig2i5gk601JDKQoGruzvaE2PGKj4a3/YrFnYkmKpPI/WdwtyiEzYyDBnsgSGl7JBZVTti0Od0+i9RuDxibSU58pEAbgopHjulc6pXBSAj/n6+0cWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729093923; c=relaxed/simple;
	bh=zKV+CN4oRDPuYTsLKdyjZVaGHKxw7iSdD7MeBWyrXGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MWpf6pYCXGhWOYASUqp65ytdpwQPan7THsSeiemq8w3i6ScYJOKLi/YvJJtGr0Q/1yTpLx7a23iTVnvAiLACNZqdICuXlZXOQJdVaSVoJC6KZAA/tKoa7Lyo+2EmXXziQStYbA2E8XFl9zat4ROD4POkA9fhjK1c/LQNQunoE04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=BzG4JQiZ; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C09A514838D6;
	Wed, 16 Oct 2024 17:43:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1729093409; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=7tJSztIo9asoNqABnecSCXzHZLed1LkHJmvJttnWSz0=;
	b=BzG4JQiZFJCLM96P4AEIt52RVEsiZt+0P987nJZfXLGtCBZaVKKDO5Eo44HEzhYFJ3JIlF
	s61YYfjZwPGSc/87l0uYUdGrcJ4O0Fmc/3M5uBRhBbaXozJxFjW9295VBSMaSf8SnbDlZa
	NyGjopuvhqURnTL8Ek905+nnkWRMnTHxVLE7XICKEm3j4PR/sD4q5a2FyXL4JqLsTnzU3A
	nTL6omduEO+RwCMGGzizq3uXgBTVc48SCSL7dTqHnKXuidmZP2lQdmgxEEjHZiJdLIfPGx
	l2iAPhHiylGxatnABWjmy0Rf7pvyD0iXIbh/2ACuNlsenuwNOtJ+LxEWJspV7Q==
Date: Wed, 16 Oct 2024 17:43:22 +0200
From: Alexander Dahl <ada@thorsis.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: micrel ksz8081 RMII phy and clause-22 broadcast
Message-ID: <20241016-kissing-baffle-da66ca25d14a@thorsis.com>
Mail-Followup-To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello everyone,

migrating an old board with an SMSC LAN8720A PHY to a new hardware
revision with a Micrel KSZ8081 PHY (both Microchip now) caused me
quite some headaches this week, and I did not come to a satisfying
solution, although I tried quite some different approaches.  I got
questions.  This is all about addressing on the MDIO bus and different
PHYs behaving differently.  Maybe someone can shed some light on it?

(Note: Facing the same problem on four different boards using
different at91 socs (sam9g20, sama5d2, sam9x60), but all the using
'macb' ethernet driver.)

Old hardware revision uses the LAN8720, but unfortunately the PHYAD
strap resistors where forgotten, so that the PHY could end up with
either address 0 or 1 on the MDIO bus.  This one problem on its own
could be handled in two different ways in DTS:

        macb0: ethernet@fffc4000 {
                phy-mode = "rmii";
                status = "okay";

                /*
                 * We have to disable energy-detect because the 50 MHz
                 * ref_clk signal is used by … and must not be switched off.
                 * Disabling this through DT was introduced in Linux
                 * v4.3 and fixed in v4.5.
                 *
                 * Adding two PHY nodes here, because in schematics
                 * PHYAD pin is not explicitly pulled up or down and
                 * address thus might be one or the other.
                 */
                phy0: ethernet-phy@0 {
                        reg = <0>;
                        smsc,disable-energy-detect;
                };

                phy1: ethernet-phy@1 {
                        reg = <1>;
                        smsc,disable-energy-detect;
                };
        };

Or if the 'smsc,disable-energy-detect' is not needed, and because the
kernel (phy core or macb driver or both?) iterates over all possible
phy addresses to find a phy:

        &macb0 {
                pinctrl-names = "default";
                pinctrl-0 = <&pinctrl_macb0_default>;
                phy-mode = "rmii";
                status = "okay";
        };

Entering the new hardware, using different options, now we need irq
settings, and to not get in conflict with the old addresses we now add
another node, so it looks like this now:

        &macb0 {
                pinctrl-names = "default";
                pinctrl-0 = <&pinctrl_macb0_default>;
                phy-mode = "rmii";
                status = "okay";

                /* HW <= v0.2, LAN8720 */
                ethernet-phy@0 {
                        reg = <0x0>;
                        smsc,disable-energy-detect;
                };

                /* HW <= v0.2, LAN8720 */
                ethernet-phy@1 {
                        reg = <0x1>;
                        smsc,disable-energy-detect;
                };

                /* HW >= v1.0, KSZ8081 */
                ethernet-phy@7 {
                        reg = <0x7>;
                        interrupt-parent = <&pioA>;
                        interrupts = <PIN_PC21 IRQ_TYPE_LEVEL_LOW>;
                };
        };

The idea of this was: phy core steps through all these phy nodes,
finds only one of them present, and uses exactly that one.  I found
other .dts files doing the same IIRC.

Problem: the KSZ8081 follows the IEEE 802.3 clause 22 which states
this in section '22.2.4.5.5 PHYAD (PHY Address)':

    A PHY that is connected to the station management entity via the
    mechanical interface defined in 22.6 shall always respond to
    transactions addressed to PHY Address zero <00000>. A station
    management entity that is attached to multiple PHYs must have
    prior knowledge of the appropriate PHY Address for each PHY.

So according to standard, PHYs should all answer to address 0, even if
they are on a different address, like a broadcast.  LAN8720 does not
behave like that, KSZ8081 has flag in a vendor register to disable it,
and the 'micrel' driver actually clears that flag in .config_init aka
kszphy_config_init() - alas too late …

The sequence how I understand it, is more or less like this:

1. ethernet driver probe, that calls macb_mii_init() which leads to
creating all phy devices in one or the other way.  The one and only
KSZ8081 answers to addresses 0 and 7, thus we get two mdio/phy
devices (and none on address 1, because there is just the single PHY
chip):

    $ ls -l /sys/bus/mdio_bus/devices/
    lrwxrwxrwx    1 root     root             0 Jan  1 03:50 f802c000.ethernet-ffffffff:00 -> ../../../devices/platform/ahb/ahb:apb/f802c000.ethernet/mdio_bus/f802c000.ethernet-ffffffff/f802c000.ethernet-ffffffff:00
    lrwxrwxrwx    1 root     root             0 Jan  1 03:50 f802c000.ethernet-ffffffff:07 -> ../../../devices/platform/ahb/ahb:apb/f802c000.ethernet/mdio_bus/f802c000.ethernet-ffffffff/f802c000.ethernet-ffffffff:07

2. ethernet device (eth0) bringup, which somewhere down the call path
calls phy_init_hw() and phydev->drv->config_init() disabling that
broadcast flag.  From this point the KSZ8081 does not answer on
address 0 anymore.

3. the system (not sure which part exactly) tries to use the first phy
it finds on that mdio bus, still address 0, but that chip does not
answer anymore on that address after turning off broadcast, because it
has address 7 configured through resitor straps, this looks like this
in messages for example:

    macb f8008000.ethernet eth0: Cadence GEM rev 0x00020203 at 0xf8008000 irq 156 (a2:09:7e:80:00:02)
    macb f8008000.ethernet eth0: PHY [f8008000.ethernet-ffffffff:00] driver [Micrel KSZ8081 or KSZ8091] (irq=POLL)
    macb f8008000.ethernet eth0: configuring for phy/rmii link mode
    Micrel KSZ8081 or KSZ8091 f8008000.ethernet-ffffffff:00: phy_poll_reset failed: -110
    macb f8008000.ethernet eth0: Could not attach PHY (-110)

What did I try to solve this?  (Note: I don't like any of those
approaches for different reasons.)

1. Changing the order of nodes in .dts → no effect, this is considered
at driver loading time, not at eth0 bringup time, still get two phy
devices

2. explicitly using the phy IDs in dts as compatible string, like
'compatible = "ethernet-phy-id0007.c0f0"' for phy@0 … this leads to
using the smsc driver for the ksz8081 phy, that's probably not good?

3. tweaking kszphy_config_init() to not disable that broadcast flag,
if the address configured (you can read that from vendor register 17h
in the ksz8081) is not the same as the one of the phydev.  Leads to
communicating with that phy through broadcast address 0, not a future
proof solution IMHO.

4. disabling that broadcast flag in bootloader already: increases the
boot time quite some seconds, and adds some kind of dependency to the
bootloader: not nice.

5. returning an error in micrel PHY driver probe, well then the
generic phy driver is used, I could achieve the same by disabling
CONFIG_MICREL_PHY in kernel, but then we would not get vendor specific
tweaks for that phy, and I'm not sure that interrupt stuff would still
work.

6. using phy_register_fixup_for_uid() in the micrel driver, so
phy_scan_fixups() could return an error if phydev addr and phyad strap
address do not match.  This leads to phy@0 not being attached on eth0
bringup, but the phydev at address 0 is not removed (only
unregistered) and the other phydev for address 7 is never tried then.

What do I take home from this:

- different PHYs behave differently with regard to the IEEE standard
- I found no mechanism to disable broadcast in a PHY specific driver
  early enough so the phydev for address 0 is not created (or removed
  after creation)

Would be happy if anyone could suggest a path forward here?

(In the end, it will probably be solved with multiple devicetree files
depending on hardware revision, but that is the can of worms I wanted
to avoid in the first place.)

Thanks for reading.

Greets
Alex


