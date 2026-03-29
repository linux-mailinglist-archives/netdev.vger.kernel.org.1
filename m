Return-Path: <netdev+bounces-272882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5eGNBNENyWlatwUAu9opvQ
	(envelope-from <netdev+bounces-272882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 13:32:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A585351CFC
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 13:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3396230125E3
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 11:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF5531353C;
	Sun, 29 Mar 2026 11:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jTS6pVyR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDC118A6A7;
	Sun, 29 Mar 2026 11:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774783949; cv=none; b=aljNuf3obYHPmuY8THAWwq+08A8WrHs0HRpd563gERBXqtz6AekTDel2spkjbt5FmsUsRh4do1erBZ1r/1ycxxCzON5N3ut0ZO4k6Q/HX27hN9b1yqPlp/6KIPyHYjbp2MDgBr4rfpAP3fcYYINyKgLQH6h9REvMk2D8tDN2poM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774783949; c=relaxed/simple;
	bh=CS1AKKELuvewejgn0DBIhyp5SikMKYpZXqpF4+4HZVw=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=j/qUCMpTO5Cs37QzXtbgonvPFU3PkUfaeo4OEtCSNZ2wT2c1r+u8kMhQlmUJSWlvhWHfi+u8Bsdq/A888AxBSBade2KMIwWPcv4Ip3WTbHCTPPoz8EscSNL1aOhhCO6k1y1+1CgDDkyhYi5U4u8q30RMP/ElkJm+z84b6S4HKrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jTS6pVyR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AxNR5KaJmzWZIX1WbAJp7aQ4tgAbVPKdjMDYmpdFN5s=; b=jTS6pVyRRG8MYv9PxPUvYR15P+
	nJ8AAwxhgPe+Q7578NPbWitGHavbLyZ+IhcpJJlV2ii/pXIM0q2dkEPjC/U4CIizyFqoZWJNdCmHi
	4KYPrJXpKNTqxqvJLtGtiYO9Sdzr5mBS9xqwoDnUnxQ6otEmQgUwrX1kapqSUUWiqifGjApQWINl9
	3QwhMAK87JMd27uudgHNEvo4VLIGvNuqfqJmZZJpNh92cmO5pueVl5tl5WdLkGYziZFjTiSio9Fh6
	2cO7HVMTfV/j3uGlnzmxhwYIGGOygf1jpDZz2W7ymHjPv8oDCT0kkdhlBi5XOJ/JuBkQ6OglXIebA
	VmBM760Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51262 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w6oNR-000000007sn-2tJK;
	Sun, 29 Mar 2026 12:32:21 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w6oNQ-0000000ER1E-43NU;
	Sun, 29 Mar 2026 12:32:20 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Kees Cook <kees@kernel.org>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH RFC net-next] usb: gadget: u_ether: fix eth_get_drvinfo() oops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w6oNQ-0000000ER1E-43NU@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 29 Mar 2026 12:32:20 +0100
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272882-lists,netdev=lfdr.de,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[get_maintainers.pl:url]
X-Rspamd-Queue-Id: 4A585351CFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following oops was observed on the nVidia Jetson Xavier NX1
platform with 7.0.0-rc5, which is caused by dev->gadget becoming NULL
while the u_ether device is still visible to userspace. Adding some
debug reveals that we see this sequence:

net usb1: gadget detached
tegra-xudc 3550000.usb: ep 0 disabled
net usb1: no gadget for drvinfo
usb1 (unregistering): left allmulticast mode
usb1 (unregistering): left promiscuous mode
l4tbr0: port 2(usb1) entered disabled state

Put a sticky plaster over this (it's racy!) I suspect
gether_detach_gadget() needs to at least take the RTNL as well to
prevent ethtool ops running concurrently with the gadget being
detached.

Unable to handle kernel NULL pointer dereference at virtual address 000000000000
00d0
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=00000001086b1000
[00000000000000d0] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 0000000096000004 [#1]  SMP
Modules linked in: snd_soc_tegra210_mvc snd_soc_tegra186_asrc snd_soc_tegra210_m
ixer snd_soc_tegra210_admaif snd_soc_tegra_pcm snd_soc_tegra210_ope snd_soc_tegr
a186_dspk snd_soc_tegra210_i2s snd_soc_simple_card_utils snd_soc_tegra210_dmic s
nd_soc_tegra210_amx snd_soc_tegra210_adx snd_soc_tegra210_sfc rtw88_8822ce rtw88
_8822c rtw88_pci rtw88_core mac80211 libarc4 sha256 cfg80211 snd_soc_tegra210_ah
ub snd_soc_core snd_pcm_dmaengine snd_pcm snd_timer tegra210_adma zram tegra_drm
 zsmalloc usb_f_ncm syscopyarea usb_f_mass_storage drm_client_lib sysfillrect sy
simgblt ramoops fb_sys_fops reed_solomon nls_iso8859_1 drm_display_helper nls_cp437 vfat drm_kms_helper fb fat cec drm_dp_aux_bus tegra_aconnect usb_f_acm u_serial usb_f_rndis u_ether max77620_wdt realtek tegra_xudc phy_package snd phy_tegra194_p2u dwmac_dwc_qos_eth soundcore stmmac_platform pwm_tegra rtc_efi tegra186_gpc_dma virt_dma tegra_bpmp_thermal host1x pcie_tegra194 libcomposite udc_core drm drm_panel_orientation_quirks backlight efivarfs ip_tables
 x_tables
CPU: 1 UID: 0 PID: 4181 Comm: systemd-udevd Not tainted 7.0.0-rc5-net-next+ #640 PREEMPT
Hardware name: NVIDIA NVIDIA Jetson Xavier NX Developer Kit/Jetson, BIOS 6.0-37391689 08/28/2024
pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : eth_get_drvinfo+0x4c/0x80 [u_ether]
lr : eth_get_drvinfo+0x40/0x80 [u_ether]
sp : ffff80008484bb60
x29: ffff80008484bb60 x28: ffff000083de18c0 x27: 0000000000000000
x26: 0000000000000000 x25: ffff0000947da0a8 x24: 0000000000004000
x23: ffff0000a38a5600 x22: 0000000000000000 x21: ffff80007a3a5558
x20: ffff0000947da000 x19: ffff0000a38a5608 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffe09af760
x14: 0000000000000000 x13: 0000000000000020 x12: 0101010101010101
x11: 7f7f7f7f7f7f7f7f x10: 00007ffff0071c50 x9 : 0000000000000020
x8 : 0101010101010101 x7 : ffff0000a38a5634 x6 : fefefefefefefeff
x5 : ffff0000a38a562c x4 : 0000000000383030 x3 : 0000000000383030
x2 : 0000000000000020 x1 : 0000000000000000 x0 : ffff0000a38a564c
Call trace:
 eth_get_drvinfo+0x4c/0x80 [u_ether] (P)
 ethtool_get_drvinfo+0x54/0x1e0
 __dev_ethtool+0x698/0x2000
 dev_ethtool+0x90/0x1a0
 dev_ioctl+0x37c/0x594
 sock_ioctl+0x390/0x5bc
 __arm64_sys_ioctl+0x408/0xeb4
 invoke_syscall.constprop.0+0x50/0xe0
 do_el0_svc+0x40/0xc0
 el0_svc+0x48/0x2a0
 el0t_64_sync_handler+0xa0/0xe4
 el0t_64_sync+0x19c/0x1a0
Code: 95a68811 f9468a81 d2800402 91011260 (f9406821)
---[ end trace 0000000000000000 ]---

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---

1. get_maintainers.pl is picking up on the PSTORE folk because of the
mention of "ramoops" in the commit message... even though this has
nothing to do with them.

2. I think there's more bugs here as mentioned in the commit message,
since setting dev->gadget to NULL without taking any locking while
the u_ether device is still published to userspace looks mightily
dangerous. Seems to be another kernel driver that fails to obey the
basics discussed in OLS some twenty years ago concerning the order
of setup/publish/unpublish/teardown... and we still don't seem to
be able to get it right. :(

3. Patch generated against the net-next tree, because that's what I'm
working with being focussed on stmmac at the moment - but I would like
my test platform not to oops and reboot itself when I instead want it
to power off.

 drivers/usb/gadget/function/u_ether.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 1a9e7c495e2e..d1ae91889537 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -113,6 +113,10 @@ static void eth_get_drvinfo(struct net_device *net, struct ethtool_drvinfo *p)
 
 	strscpy(p->driver, "g_ether", sizeof(p->driver));
 	strscpy(p->version, UETH__VERSION, sizeof(p->version));
+
+	if (!dev->gadget)
+		return;
+
 	strscpy(p->fw_version, dev->gadget->name, sizeof(p->fw_version));
 	strscpy(p->bus_info, dev_name(&dev->gadget->dev), sizeof(p->bus_info));
 }
-- 
2.47.3


