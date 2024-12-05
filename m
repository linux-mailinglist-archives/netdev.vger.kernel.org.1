Return-Path: <netdev+bounces-149311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EB29E5196
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B38F51880381
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 09:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949FE1D63D0;
	Thu,  5 Dec 2024 09:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mZDHzZpZ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B351D47A2
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391753; cv=none; b=VN08Orko5fwgxvSGysWhsMVI02mIoXl2bNw6wItCgfVplmpcXsKEUp9OIg4UVRqILRdVcbgj4G53CnHcBRrr8kLWsrvYjmWMV1//4hLt04/G7Wd5tnF+hisWUd0bj2lR+MZ3fhWXuysTBl7Lpeq5pPBsp9MJ9D068GbN/QXkhVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391753; c=relaxed/simple;
	bh=pK++5Uw8WW0axlNhNrtnUANQBgRmxMMLW62qhkaCDhM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fRTZGV2pUYBlNOXxW4kCD1cIIdW+/0GZfjxnulMLqq+eofK4yvraSBQVBLjN8qkrw8jKH43qXg/csYig1EdxviRNbpZSFgkYMwhJOLcit655V6nqg3KGqnFAZB304zqAFoHX3+F2Cm8p+VDBpIvNdAbV4YIZc11mKPVnxbQasRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mZDHzZpZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Hj51tQUYsAKS9xS0L2qk/b2rKWVlQnqo5rEveZPtVGw=; b=mZDHzZpZ7UAggidQeG3syJ3de0
	dsAHDnsnRDbcJRJfQRz3Vos1oBdsSeVnILL9sZCTmVDFrqYSDoAKPqD6i5tJ3piMAFWr9aKo7lBCE
	14R2DIjdE2Ux6zUbl2FXl5okEUQZR+MMbU4kB/AgPbDfsdu/15cikvSQbCJ5H8nqsKS+30skHEgSm
	Pny8lL+4M4jr9GA+HwfQc7ulTogImxOAPs31fG6ibqbgOU0F/ZOKQNZu/yd5doZyUoLjtm21aQlxh
	LetfzV46pagrWINlev6EZ4CvprBNV0vA1Mn0GuaHvES/NTbTVoERHBEBI7Wi5Oc6DAtZrydZOkhLS
	VbHwLHZA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56980)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tJ8NA-0004Ta-2c;
	Thu, 05 Dec 2024 09:42:13 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tJ8N5-0006RK-0l;
	Thu, 05 Dec 2024 09:42:07 +0000
Date: Thu, 5 Dec 2024 09:42:07 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Couzens <lynxis@fe80.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/3] net: net: add negotiation of in-band
 capabilities (remainder)
Message-ID: <Z1F1b8eh8s8T627j@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

Here are the last three patches which were not included in the non-RFC
posting, but were in the RFC posting. These add the .pcs_inband()
method to the Lynx, MTK Lynx and XPCS drivers.

 drivers/net/pcs/pcs-lynx.c      | 22 ++++++++++++++++++++++
 drivers/net/pcs/pcs-mtk-lynxi.c | 16 ++++++++++++++++
 drivers/net/pcs/pcs-xpcs.c      | 28 ++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

