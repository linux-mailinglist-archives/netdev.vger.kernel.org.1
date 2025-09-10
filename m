Return-Path: <netdev+bounces-221609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F326B51285
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 11:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8FFA7ADF94
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 09:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43F1243958;
	Wed, 10 Sep 2025 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="e4xs9GQf"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E023E36124;
	Wed, 10 Sep 2025 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757496715; cv=none; b=uG4xV0m2kZX8pI3uqViAQvuR/27Sl0AymZ8UT1Kd34vdT1nzFyRICz7Vy5SAJKiOGY3QqIrtiZBXuA4/CoheSwSzt32e5XhdRNHNiiCXl4sWNxcE3ZH4Dmw3EBSyEnPPJsOA3Bd/vSZnfvI1J8eQiuAoRL/Whw4KrRMbcT5yST4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757496715; c=relaxed/simple;
	bh=HynhhExfalwC9wZNOHlbpupHuRarclEqWCaABYe7bUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p5vftwzfguSuKsjVUu2ilOSz0J9Yk0LfTzIXvNDE5hU5VvqTY9AcjTbx9a+8czXtM/OFTB0Xe7s9OzJfiSyDpA1wWZspX8Cewb/IOK11QN7TkxZy1WStYjFDPMc8+Pr5lEAhIbx5bDSuJOJtH4NS+F8a0hQvH3vVSv0E80ObHRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=e4xs9GQf; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=j3
	u9AtMloR5Ka17doQ4gI+o2dmJCjNSdE5xlewvBHaY=; b=e4xs9GQfomuJN6lpCt
	SRnwAgLiK+E08AUegptmRfj/A4sBVPbxsSDI8v7RJ8dXWpEkYQbldbgNBTckaNB0
	a1QmGaVLJsiPulkPykHtEYQLcAq/HEiKuo0sGHWQ93sOnKKWv+Ewubvq/mQRV1rI
	SGH3BU+BKax/HwdL9ROxLtI3E=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDXH6FURcFoyfjWAA--.1381S2;
	Wed, 10 Sep 2025 17:31:02 +0800 (CST)
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
Date: Wed, 10 Sep 2025 17:31:00 +0800
Message-Id: <20250910093100.3578130-1-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250910091703.3575924-1-yicongsrfy@163.com>
References: <20250910091703.3575924-1-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXH6FURcFoyfjWAA--.1381S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFy3WF1DZrW8JF4fJw4rGrg_yoWktwc_WF
	yYv3ykJw40ya47Za129r4Yqryaga97GFWUXa4DW3srXFy7ZFWxWFn8GFy7ZFWfG3429w1D
	Wryq9rZxuwnavjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUEdgtUUUUU==
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/1tbiUAjE22jBRD8frAAAsm

On Wed, 10 Sep 2025 17:17:03 +0800, yicongsrfy@163.com <> wrote:
> My thought is, if a PHY device hasn't been attached to a net_device,
> is it still necessary to go through the resume procedure?
>
> My issue context is as follows:
> After entering `mdio_bus_phy_resume`, the call flow proceeds to:
> `phy_init_hw()`
>     => `phydev->drv->config_init`
>         => `yt8521_config_init`
>
> Then, because `phydev->interface != PHY_INTERFACE_MODE_SGMII`, it attempts
> to enter `ytphy_rgmii_clk_delay_config` to configure the RGMII tx/rx delay.
> However, since this PHY device is not associated with any GMAC and is not
> connected via an RGMII interface, the function returns `-EOPNOTSUPP`.
>
> Of course, I could submit a fix patch to `motorcomm.c` to terminate
> `config_init` early. But as I mentioned at the beginning, when a PHY
> device hasn't been attached, do we really need to let it go through
> the entire resume process?

One more point: in the suspend flow as shown below:
`mdio_bus_phy_suspend`
    => `mdio_bus_phy_may_suspend`
there is also a check whether `phydev->attached_dev` is NULL.

Therefore, my idea is to make this modification to maintain consistency in the logic.


