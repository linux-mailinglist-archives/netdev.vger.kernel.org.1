Return-Path: <netdev+bounces-253907-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MFlNPPNeGmNtQEAu9opvQ
	(envelope-from <netdev+bounces-253907-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 15:38:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5840B95D6F
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 15:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 749C33036617
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC438356A23;
	Tue, 27 Jan 2026 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jM5bYw+J"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E890235B65C
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524344; cv=none; b=mJVH3z7ickFV/FYaHim3nGug5g2X6JTdBmvlRg2JEWL68gm/FmJZ4g8PQNBk3MiLRXW4tWV2Xl9eYj30DDbRwr7bxlukmreNeMU1kxAu3OqsLr5c8z1W96tTbWAwIL3qdV0/0LSvfTHuTdzzWblip7O/7jHhLCyHec7mEekPZXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524344; c=relaxed/simple;
	bh=VcRUL4NbT8twQveEXMVj/8F9mmyPFmm+GhP5+Xw6znc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7lDeLE/Of7mFW+sFoZrZdw713ABxdWWrFpkkcx7vryDqt01E+WRMYs5GJYYTl8J1/NlsiEZc2MEN51e90TWki9X6AnHVtIqfTUSKyQaTZY93X5Ilx1f+AI76fHPh2MCLLFFLFLgSsxqjHN/g23PeAUGN6VqJvALZh/F+147weM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jM5bYw+J; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6A4FF4E422D4;
	Tue, 27 Jan 2026 14:32:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 327F5606F5;
	Tue, 27 Jan 2026 14:32:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CB6EC119A8647;
	Tue, 27 Jan 2026 15:32:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769524339; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=YG+evten0yorTj1PVwCqXLsem+E2MfmXhxz9xxSUXDU=;
	b=jM5bYw+JTlgYd8epvFGkND9QFXuOeyU81PbiOfBqIid6cm1V9ZCCs7kCfXqDfLANLh6hGn
	n/hSWOrZ8jzNMCksZtKWOQVAssw9aR6vdbzWDssDzwsXw4hP/CxKbqEtT0sJ/c2PhSnGOC
	AGm6vnIn/D6eaFvo4USRHXmzIvTjw0Uausb+IeI1ItHiEdIVl4fYNlBadetUn51/ITubOv
	I6VXQnALMLRzR2yu30N2DnkpRx1RwT6r8QRqVPmnwVlgY9DOTFWIilq6nECs4p/PZXUSYz
	FxU0B6EikTyUHr0DgR9ea0ypWdtOWiSp1qbKeXVwrE+i1fhnRML9iwf3Hvuh7w==
Message-ID: <13f1599a-afd7-4350-a395-83c57ab91f18@bootlin.com>
Date: Tue, 27 Jan 2026 15:32:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: micrel: fix clk warning when removing the
 driver
To: Wei Fang <wei.fang@nxp.com>, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, florian.fainelli@broadcom.com
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260126081544.983517-1-wei.fang@nxp.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260126081544.983517-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253907-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: 5840B95D6F
X-Rspamd-Action: no action

Hi,

On 26/01/2026 09:15, Wei Fang wrote:
> Since the commit 25c6a5ab151f ("net: phy: micrel: Dynamically control
> external clock of KSZ PHY"), the clock of Micrel PHY has been enabled
> by phy_driver::resume() and disabled by phy_driver::suspend(). However,
> devm_clk_get_optional_enabled() is used in kszphy_probe(), so the clock
> will automatically be disabled when the device is unbound from the bus.
> Therefore, this could cause the clock to be disabled twice, resulting
> in clk driver warnings.
> 
> For example, this issue can be reproduced on i.MX6ULL platform, and we
> can see the following logs when removing the FEC MAC drivers.
> 
> $ echo 2188000.ethernet > /sys/bus/platform/drivers/fec/unbind
> $ echo 20b4000.ethernet > /sys/bus/platform/drivers/fec/unbind
> [  109.758207] ------------[ cut here ]------------
> [  109.758240] WARNING: drivers/clk/clk.c:1188 at clk_core_disable+0xb4/0xd0, CPU#0: sh/639
> [  109.771011] enet2_ref already disabled
> [  109.793359] Call trace:
> [  109.822006]  clk_core_disable from clk_disable+0x28/0x34
> [  109.827340]  clk_disable from clk_disable_unprepare+0xc/0x18
> [  109.833029]  clk_disable_unprepare from devm_clk_release+0x1c/0x28
> [  109.839241]  devm_clk_release from devres_release_all+0x98/0x100
> [  109.845278]  devres_release_all from device_unbind_cleanup+0xc/0x70
> [  109.851571]  device_unbind_cleanup from device_release_driver_internal+0x1a4/0x1f4
> [  109.859170]  device_release_driver_internal from bus_remove_device+0xbc/0xe4
> [  109.866243]  bus_remove_device from device_del+0x140/0x458
> [  109.871757]  device_del from phy_mdio_device_remove+0xc/0x24
> [  109.877452]  phy_mdio_device_remove from mdiobus_unregister+0x40/0xac
> [  109.883918]  mdiobus_unregister from fec_enet_mii_remove+0x40/0x78
> [  109.890125]  fec_enet_mii_remove from fec_drv_remove+0x4c/0x158
> [  109.896076]  fec_drv_remove from device_release_driver_internal+0x17c/0x1f4
> [  109.962748] WARNING: drivers/clk/clk.c:1047 at clk_core_unprepare+0xfc/0x13c, CPU#0: sh/639
> [  109.975805] enet2_ref already unprepared
> [  110.002866] Call trace:
> [  110.031758]  clk_core_unprepare from clk_unprepare+0x24/0x2c
> [  110.037440]  clk_unprepare from devm_clk_release+0x1c/0x28
> [  110.042957]  devm_clk_release from devres_release_all+0x98/0x100
> [  110.048989]  devres_release_all from device_unbind_cleanup+0xc/0x70
> [  110.055280]  device_unbind_cleanup from device_release_driver_internal+0x1a4/0x1f4
> [  110.062877]  device_release_driver_internal from bus_remove_device+0xbc/0xe4
> [  110.069950]  bus_remove_device from device_del+0x140/0x458
> [  110.075469]  device_del from phy_mdio_device_remove+0xc/0x24
> [  110.081165]  phy_mdio_device_remove from mdiobus_unregister+0x40/0xac
> [  110.087632]  mdiobus_unregister from fec_enet_mii_remove+0x40/0x78
> [  110.093836]  fec_enet_mii_remove from fec_drv_remove+0x4c/0x158
> [  110.099782]  fec_drv_remove from device_release_driver_internal+0x17c/0x1f4
> 
> After analyzing the process of removing the FEC driver, as shown below,
> it can be seen that the clock was disabled twice by the PHY driver.
> 
> fec_drv_remove()
>   --> fec_enet_close()
>     --> phy_stop()
>       --> phy_suspend()
>         --> kszphy_suspend() #1 The clock is disabled
>   --> fec_enet_mii_remove()
>     --> mdiobus_unregister()
>       --> phy_mdio_device_remove()
>         --> device_del()
>           --> devm_clk_release() #2 The clock is disabled again
> 
> Therefore, devm_clk_get_optional() is used to fix the above issue. And
> to avoid the issue mentioned by the commit 985329462723 ("net: phy:
> micrel: use devm_clk_get_optional_enabled for the rmii-ref clock"), the
> clock is enabled by clk_prepare_enable() to get the correct clock rate.
> 
> Fixes: 25c6a5ab151f ("net: phy: micrel: Dynamically control external clock of KSZ PHY")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

This should fix the issue indeed. The dance of enabling/disabling then
re-enabling at resume() again feels odd, but at least it's balanced.

We may be able to avoid that entirely by dealing with the ref_mii_clk
selection only in the .resume() path, as it's also called no long after
config_init(). That would mean reading the clock rate in
kszphy_config_reset(), then performing the kszphy_rmii_clk_sel()
accordingly.

Maxime


