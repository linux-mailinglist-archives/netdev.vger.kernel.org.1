Return-Path: <netdev+bounces-273245-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN0PC+mWymla+QUAu9opvQ
	(envelope-from <netdev+bounces-273245-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:29:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B34A35DD9A
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 17:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9999B3067270
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE5F3446DE;
	Mon, 30 Mar 2026 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LSRALObR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9847B3431E7;
	Mon, 30 Mar 2026 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884072; cv=none; b=gttaboT+da3o+5ynEdIklroE/49YTiB9SgHkKC//qWxPyFLJ6NvzczWl2O6kWXo0+d5fWSGybFb0Japh2H05xjmtrHJi46iZ6hYIdHF6mgfYeQFznnYQ7tvwyBRJb8rlSI2eF1HaHNIBcNwVt+kCByUWOgaWwzYReMVTkB/irs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884072; c=relaxed/simple;
	bh=/Zv/LzGzn+Zw5AjQS84R2gM/G3q6GWIAfBAwe6PyxSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rECb/ttFj+boV93HZPGNRJCqurDpHgw4q8C4kZ2yb0WvixYn/6JtSVmwSTE2ISTn4jv+WpZC4UnXQSThQfxhqAYWaAMMdSKnkhra254v5kgFiodvbP5fJ9W0h+t9urACZbB5JOLg1sbXDjQw8LJ6ABQ5yE0MS64Ybly/+b35HVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LSRALObR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3D5C19423;
	Mon, 30 Mar 2026 15:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774884072;
	bh=/Zv/LzGzn+Zw5AjQS84R2gM/G3q6GWIAfBAwe6PyxSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LSRALObROJOc3vlOV8jdZ8Xte8qUYj6bHVlbYKVvNFcanIZxwJR3YySEaYpUXPKkz
	 zzFkxvfUPQp5cWXilPvDDaqxj4qTl3qadChiHvEe14+jZj864/zkqjnZ84+c6qSJ5C
	 W10s+twUT2bdRm2TPEbI0mkivf/vMM06RjDzX4bg=
Date: Mon, 30 Mar 2026 17:21:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Kees Cook <kees@kernel.org>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH RFC net-next] usb: gadget: u_ether: fix eth_get_drvinfo()
 oops
Message-ID: <2026033036-glimpse-monsieur-6c0e@gregkh>
References: <E1w6oNQ-0000000ER1E-43NU@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1w6oNQ-0000000ER1E-43NU@rmk-PC.armlinux.org.uk>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273245-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B34A35DD9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 12:32:20PM +0100, Russell King (Oracle) wrote:
> The following oops was observed on the nVidia Jetson Xavier NX1
> platform with 7.0.0-rc5, which is caused by dev->gadget becoming NULL
> while the u_ether device is still visible to userspace. Adding some
> debug reveals that we see this sequence:
> 
> net usb1: gadget detached
> tegra-xudc 3550000.usb: ep 0 disabled
> net usb1: no gadget for drvinfo
> usb1 (unregistering): left allmulticast mode
> usb1 (unregistering): left promiscuous mode
> l4tbr0: port 2(usb1) entered disabled state
> 
> Put a sticky plaster over this (it's racy!) I suspect
> gether_detach_gadget() needs to at least take the RTNL as well to
> prevent ethtool ops running concurrently with the gadget being
> detached.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 000000000000
> 00d0
> Mem abort info:
>   ESR = 0x0000000096000004
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x04: level 0 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=00000001086b1000
> [00000000000000d0] pgd=0000000000000000, p4d=0000000000000000
> Internal error: Oops: 0000000096000004 [#1]  SMP
> Modules linked in: snd_soc_tegra210_mvc snd_soc_tegra186_asrc snd_soc_tegra210_m
> ixer snd_soc_tegra210_admaif snd_soc_tegra_pcm snd_soc_tegra210_ope snd_soc_tegr
> a186_dspk snd_soc_tegra210_i2s snd_soc_simple_card_utils snd_soc_tegra210_dmic s
> nd_soc_tegra210_amx snd_soc_tegra210_adx snd_soc_tegra210_sfc rtw88_8822ce rtw88
> _8822c rtw88_pci rtw88_core mac80211 libarc4 sha256 cfg80211 snd_soc_tegra210_ah
> ub snd_soc_core snd_pcm_dmaengine snd_pcm snd_timer tegra210_adma zram tegra_drm
>  zsmalloc usb_f_ncm syscopyarea usb_f_mass_storage drm_client_lib sysfillrect sy
> simgblt ramoops fb_sys_fops reed_solomon nls_iso8859_1 drm_display_helper nls_cp437 vfat drm_kms_helper fb fat cec drm_dp_aux_bus tegra_aconnect usb_f_acm u_serial usb_f_rndis u_ether max77620_wdt realtek tegra_xudc phy_package snd phy_tegra194_p2u dwmac_dwc_qos_eth soundcore stmmac_platform pwm_tegra rtc_efi tegra186_gpc_dma virt_dma tegra_bpmp_thermal host1x pcie_tegra194 libcomposite udc_core drm drm_panel_orientation_quirks backlight efivarfs ip_tables
>  x_tables
> CPU: 1 UID: 0 PID: 4181 Comm: systemd-udevd Not tainted 7.0.0-rc5-net-next+ #640 PREEMPT
> Hardware name: NVIDIA NVIDIA Jetson Xavier NX Developer Kit/Jetson, BIOS 6.0-37391689 08/28/2024
> pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : eth_get_drvinfo+0x4c/0x80 [u_ether]
> lr : eth_get_drvinfo+0x40/0x80 [u_ether]
> sp : ffff80008484bb60
> x29: ffff80008484bb60 x28: ffff000083de18c0 x27: 0000000000000000
> x26: 0000000000000000 x25: ffff0000947da0a8 x24: 0000000000004000
> x23: ffff0000a38a5600 x22: 0000000000000000 x21: ffff80007a3a5558
> x20: ffff0000947da000 x19: ffff0000a38a5608 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffe09af760
> x14: 0000000000000000 x13: 0000000000000020 x12: 0101010101010101
> x11: 7f7f7f7f7f7f7f7f x10: 00007ffff0071c50 x9 : 0000000000000020
> x8 : 0101010101010101 x7 : ffff0000a38a5634 x6 : fefefefefefefeff
> x5 : ffff0000a38a562c x4 : 0000000000383030 x3 : 0000000000383030
> x2 : 0000000000000020 x1 : 0000000000000000 x0 : ffff0000a38a564c
> Call trace:
>  eth_get_drvinfo+0x4c/0x80 [u_ether] (P)
>  ethtool_get_drvinfo+0x54/0x1e0
>  __dev_ethtool+0x698/0x2000
>  dev_ethtool+0x90/0x1a0
>  dev_ioctl+0x37c/0x594
>  sock_ioctl+0x390/0x5bc
>  __arm64_sys_ioctl+0x408/0xeb4
>  invoke_syscall.constprop.0+0x50/0xe0
>  do_el0_svc+0x40/0xc0
>  el0_svc+0x48/0x2a0
>  el0t_64_sync_handler+0xa0/0xe4
>  el0t_64_sync+0x19c/0x1a0
> Code: 95a68811 f9468a81 d2800402 91011260 (f9406821)
> ---[ end trace 0000000000000000 ]---
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> 
> 1. get_maintainers.pl is picking up on the PSTORE folk because of the
> mention of "ramoops" in the commit message... even though this has
> nothing to do with them.
> 
> 2. I think there's more bugs here as mentioned in the commit message,
> since setting dev->gadget to NULL without taking any locking while
> the u_ether device is still published to userspace looks mightily
> dangerous. Seems to be another kernel driver that fails to obey the
> basics discussed in OLS some twenty years ago concerning the order
> of setup/publish/unpublish/teardown... and we still don't seem to
> be able to get it right. :(
> 
> 3. Patch generated against the net-next tree, because that's what I'm
> working with being focussed on stmmac at the moment - but I would like
> my test platform not to oops and reboot itself when I instead want it
> to power off.
> 
>  drivers/usb/gadget/function/u_ether.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
> index 1a9e7c495e2e..d1ae91889537 100644
> --- a/drivers/usb/gadget/function/u_ether.c
> +++ b/drivers/usb/gadget/function/u_ether.c
> @@ -113,6 +113,10 @@ static void eth_get_drvinfo(struct net_device *net, struct ethtool_drvinfo *p)
>  
>  	strscpy(p->driver, "g_ether", sizeof(p->driver));
>  	strscpy(p->version, UETH__VERSION, sizeof(p->version));
> +
> +	if (!dev->gadget)
> +		return;
> +
>  	strscpy(p->fw_version, dev->gadget->name, sizeof(p->fw_version));
>  	strscpy(p->bus_info, dev_name(&dev->gadget->dev), sizeof(p->bus_info));
>  }
> -- 
> 2.47.3

This is fixed much the same way in a patch that was sent before you, so
I'll take that one and get it into 7.0-final so that you don't trip over
this anymore.

thanks,

greg k-h

