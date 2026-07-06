Return-Path: <netdev+bounces-305091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ivdMM7bZS2qlbQEAu9opvQ
	(envelope-from <netdev+bounces-305091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:37:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 296E57135C9
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:37:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b="NX ewQB/";
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305091-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305091-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD9A938C4F46
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 14:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC19397694;
	Mon,  6 Jul 2026 14:17:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD2437A836;
	Mon,  6 Jul 2026 14:17:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347472; cv=none; b=kGiNE5/WMmLbVHu+WyJRBzzUOTFnd8Wf/lAJ9GRUiyAsE5JOBWHf+hV1BM4b47SQ2TsRTr4AHwBEwK95rgYTPq91gvwl8Dxfk/cmvyF+0dSxkEHddku/mFxf75F/RYaF6pjEcgizuMOmNqP4Zm6jLQA32sKX6b7rVCrPTQO1Ni4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347472; c=relaxed/simple;
	bh=gqEN4yEuJqeft4O65ZWqzzQPhS7Hu0z60urTWCiy4jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ad3Web+TyO+yr8g2zqTLB+rcBD1KzGBnm/SMqTCiupZTHDT5rIQvpmv4dRjnTK4Fj3HduoHtFibd/gGB94rUky69K5qByPAX7tlCJclIaBRDdpQANSPXa+ITGbBT2JquGjAtYb3FFLDIlCCsovXqQPDpIq1mZ9Z439KXCLqnLoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NXewQB/V; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=t4Z7cgDJ+ry2IcOlaM3iFiga27Hfw0yB/aOf5j/AC4g=; b=NX
	ewQB/Vv8AFQa10aeCRPRDbnFxBVli6C1SNio4DmFtJOgiwCr5RRiIe61CVHrjJZG3psEs4DNahD7G
	dGlqWPwMmtNSdAQEGIewGcAB+uBBD/hFcRiT7jbJIaMJOEv1xzuxV2NhDPjfdJtqdHa3FfSQeaZ9Z
	qp+g7Opf1ZQavg4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wgk8p-00B0D2-HJ; Mon, 06 Jul 2026 16:17:47 +0200
Date: Mon, 6 Jul 2026 16:17:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 net-next] net: phy: Drop #inclusion of
 <linux/mod_devicetable.h> from <linux/mdio.h>
Message-ID: <12ec5246-4124-4edb-a5f8-f10c73b1fcb7@lunn.ch>
References: <ca270a534d0f230a939a3fb4a661808b35d6436d.1783329817.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca270a534d0f230a939a3fb4a661808b35d6436d.1783329817.git.u.kleine-koenig@baylibre.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305091-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:u.kleine-koenig@baylibre.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:from_mime,lunn.ch:dkim,lunn.ch:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 296E57135C9

On Mon, Jul 06, 2026 at 11:29:19AM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> <linux/mdio.h> itself doesn't use any of the device id structures. The
> files #including <linux/mdio.h> use a variety of them:
> 
> 	$ git grep -l '<linux/mdio.h>' | xargs grep --color  -E '\<(acpi_device_id|amba_id|ap_device_id|apr_device_id|auxiliary_device_id|bcma_device_id|ccw_device_id|cdx_device_id|coreboot_device_id|css_device_id|dfl_device_id|dmi_(device|system)_id|eisa_device_id|fsl_mc_device_id|hda_device_id|hid_device_id|hv_vmbus_device_id|i2c_device_id|i3c_device_id|ieee1394_device_id|input_device_id|ipack_device_id|isapnp_device_id|ishtp_device_id|mcb_device_id|mdio_device_id|mei_cl_device_id|mhi_device_id|mips_cdmm_device_id|of_device_id|parisc_device_id|pci_device_id|pci_epf_device_id|pcmcia_device_id|platform_device_id|pnp_(card_)?device_id|rio_device_id|rpmsg_device_id|sdio_device_id|sdw_device_id|serio_device_id|slim_device_id|spi_device_id|spmi_device_id|ssam_device_id|ssb_device_id|tb_service_id|tee_client_device_id|typec_device_id|ulpi_device_id|usb_device_id|vchiq_device_id|virtio_device_id|wmi_device_id|x86_(cpu|device)_id|zorro_device_id|cpu_feature)\>'
> 	...
> 
> but none of them relies on <linux/mdio.h>'s #include.
> 
> <linux/mod_devicetable.h> is a bad header mixing many different device
> id structures and thus is an unfortunate dependency because if e.g.
> struct wmi_device_id is modified all users of <linux/mdio.h> need to be
> recompiled despite none of them using struct wmi_device_id.
> 
> So drop the unused header.

While i agree that there are lots of unneeded dependencies here, does
this change actually solve anything? Pretty much every PHY driver
needs mdio_device_id, which is part of mod_devicetable.h. So it must
be getting included somehow.

I assume the long term plan is to move all the structure definitions
out of mod_devicetable.h, so a driver can include just the ones it
needs? Is this patch somehow a step along that path? Why not move
mdio_device_id into mod_devicetable_mdio.h and include that? It seems
like the more obvious fix.

	Andrew


