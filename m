Return-Path: <netdev+bounces-221605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EC9B51246
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 11:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2346C465EF9
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 09:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7434B312812;
	Wed, 10 Sep 2025 09:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Wh8Yimpd"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D032877E9;
	Wed, 10 Sep 2025 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757495877; cv=none; b=kSsdz1RFPVLmXs+AwEVNvIW8UQ9nGyeyX0/lCDH0xF7zbX7iaA91DFCbSN9CDPh902kBQDsmyZTvN4whxp4SRTHx1nCakBt2f2RAVVgq5gMR/q1t440hPn75LgFr5XLBVML1HNH7wQOfueU7c1CpUgI/Uz/aMKZJ3/oeFbPU/hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757495877; c=relaxed/simple;
	bh=GGcoW1rHPYKDVIpMVNnDGCuNsRgAHDhGZ6iQD3KEJQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b12J0e9OyGLQBizPK1J9J3iGxpyPPqM2A8jbZZbK7vM4kVGBgGzqnKAuH4choW3luGqnZjsI+kXUj+5DQqELsqpImlLVc/7AjLZ0ucN4G2AChvOg9UC5qJ1IY8sNf2NnSvMwvq/2Ad/KKLJloCEDJNcOhCQjvwST4r0KbW4DTig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Wh8Yimpd; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=kW
	sJsKi4N76Tmx+Lu2+X5uhhEh4alrr77qi//eZRpHk=; b=Wh8YimpdbYux2bZ0Tm
	WiH6rPacfglByyrkNxLAiLObV0VMg8PC+2FP2WgEiy6sBzh/6BqSnR5YHy/Z6yKS
	urXYQwcFkNLjmdElYBMNrT4vgDwyXQK/60fdiC+/zBenz3vTa3A7afk/EFb7jtMH
	izbshVITI8VxHHqjJN8TkZhtc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDHL4wPQsFoNSDgAA--.35458S2;
	Wed, 10 Sep 2025 17:17:04 +0800 (CST)
From: yicongsrfy@163.com
To: linux@armlinux.org.uk
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	yicong@kylinos.cn
Subject: Re: [PATCH] net: phy: avoid config_init failure on unattached PHY during resume
Date: Wed, 10 Sep 2025 17:17:03 +0800
Message-Id: <20250910091703.3575924-1-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <aMEzv50VmUb2eUMQ@shell.armlinux.org.uk>
References: <aMEzv50VmUb2eUMQ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHL4wPQsFoNSDgAA--.35458S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uryUJr4xGw43KFy8Gr1Utrb_yoW8Kry5pr
	WxXas5ur1vqF1kGrs7A3y8Ja4jvwsIvrW3J3sxKr98CFy5uF9Y939Fqr43ZFW5Crs8Ca47
	ZF4jqayUArZruaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U7wIgUUUUU=
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/1tbiUATE22jBPCm76wAAsn

On Wed, 10 Sep 2025 09:15:59 +0100, "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
>
> On Wed, Sep 10, 2025 at 10:58:26AM +0800, yicongsrfy@163.com wrote:
> > From: Yi Cong <yicong@kylinos.cn>
> >
> > When resuming a PHY device that is not attached to a MAC (i.e.
> > phydev->attached_dev is NULL), mdio_bus_phy_resume() may call into
> > phy_init_hw() -> phydev->drv->config_init(), which can return -EOPNOTSUPP
> > (-95) if the driver does not support initialization in this state.
> >
> > This results in log messages like:
> > [ 1905.106209] YT8531S Gigabit Ethernet xxxxmac_mii_bus-XXXX:00:01:
> > PM: dpm_run_callback(): mdio_bus_phy_resume+0x0/0x180 [libphy] returns -95
> > [ 1905.106232] YT8531S Gigabit Ethernet xxxxmac_mii_bus-XXXX:00:01:
> > PM: failed to resume: error -95
> >
> > In practice, only one PHY on the bus (e.g. XXXX:00:00) is typically
> > attached to a MAC interface; others (like XXXX:00:01) are probed but
> > not used, making such resume attempts unnecessary and misleading.
> >
> > Add an early return in mdio_bus_phy_resume() when !phydev->attached_dev,
> > to prevent unneeded hardware initialization and avoids false error reports.
>
> PHYs are allowed to be attached without a net device. Your PHY
> driver needs to cope with this condition.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

Thank you for the reply!

My thought is, if a PHY device hasn't been attached to a net_device,
is it still necessary to go through the resume procedure?

My issue context is as follows:
After entering `mdio_bus_phy_resume`, the call flow proceeds to:
`phy_init_hw()`
    => `phydev->drv->config_init`
        => `yt8521_config_init`

Then, because `phydev->interface != PHY_INTERFACE_MODE_SGMII`, it attempts
to enter `ytphy_rgmii_clk_delay_config` to configure the RGMII tx/rx delay.
However, since this PHY device is not associated with any GMAC and is not
connected via an RGMII interface, the function returns `-EOPNOTSUPP`.

Of course, I could submit a fix patch to `motorcomm.c` to terminate
`config_init` early. But as I mentioned at the beginning, when a PHY
device hasn't been attached, do we really need to let it go through
the entire resume process?


