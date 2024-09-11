Return-Path: <netdev+bounces-127530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E8F975AD7
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 21:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0072283298
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 19:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9EF1AB6FF;
	Wed, 11 Sep 2024 19:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="O85F12Ly"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F146218C3E
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 19:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726083072; cv=none; b=ZXVPQMMfkTg4FFIWMqSfobwFHYnRCt1n5qSCJEsCbU+NiKp/jd9g8hYj+RYZ7FlxVJmubSXQVI29NMbjf3pGq7ROArq6R4j7jLJgZUNY+DWFRbUtPeSKfCfYjaIDpmhonhCjNG5UTnlsWf/96MWW8WPlD73b6UVTFnsgxz5biuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726083072; c=relaxed/simple;
	bh=FHEbTnBp5+7TgiYrC6JAXSlr3DErEOupHRmIx10enl4=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date; b=AXB45PtE7t+rr7zWOiSdgwphVALi27Gg3luEYeqF7TFpDjpE+GoffEJXP8s5vP5SzGKGby/blEuY6xtNY1PBG/gKbAe6aLlSpkylKuoWm6lDT2TGWsXnFz3oqTAtpLVMcfo7N+39JBvBkI4YfXPcaMPWxCL0yVVwvyhp+PsLSyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=O85F12Ly; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1726083054; x=1726687854; i=hfdevel@gmx.net;
	bh=iHGaEfRfQzTmDTdU8afcjGZKpdmQKgRW5L2Oq2i3a4g=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=O85F12LyKBw1hilchJNFtnqgva1pcLhUGEoJgq91tzZVF/sAgT6Eq3W+UiVmVv4A
	 YsmedSLXxO32FoXnmgqb8w803MToy7WsiQKOFNrhnT/+lZjto8gjiq/b33lpp0gjC
	 dLuPTtF+ZLQ6AD83l2kVM0qdxn2AXI1/BRhXyZ2c2D/YHTsw6SPjU0nbdK5i3MjdT
	 aVSBzX2+fv0XbAuzwwi54XKNxVinTQNW8/29Ymb2onuYMEg3SKkWDBrlCDagOEkli
	 upbfblLEs+eE/hTAPt8HXHkdkCYlNCklhHY8c5kyZe/FDgoZdIFTPRUc10RvHjisv
	 oSrhOUXm9Eu0HBFQcA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [77.33.175.99] ([77.33.175.99]) by web-mail.gmx.net
 (3c-app-gmx-bs04.server.lan [172.19.170.53]) (via HTTP); Wed, 11 Sep 2024
 21:30:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-0e61ef5a-b461-485b-a7ea-787ffe9b1689-1726083054223@3c-app-gmx-bs04>
From: Hans-Frieder Vogt <hfdevel@gmx.net>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 4/5] net: tn40xx: enable driver to support TN4010
 cards with AQR105 PHY
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Sep 2024 21:30:54 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:KXxVLJQdL6qX1u9igV5h9l3GWGQSFYtfjo4/ggw+bO2wjoXSueWjxxC0ciOrScjf9/T+A
 QhEqlmDjAKdkxWBFT5rlNfSiHLoAaHxSyT1v+JZ/CVQZJNmhAkagDLXwyKDQNrYQiaXHN67iZFrG
 y0CkhfBRJgbkJSZ/5DPi/bHAa++MWUagV38wgqKQ17uXjOe346KOUxOh0MIOI2zFkqwhOpzlbcDr
 G+IGaHnZR+tzvOiPqx8giRXMcBOF2cBlMywR+Xa6KJcdWaTZPvOVgr84c+qVpuar5Ecxn/+ggNOL
 us=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UeqX7MJJLRI=;DKcM56hnnPFHaEdItpCX2aUSdgI
 CaqUXGbSkcshbSOZ3tLfAfmm9fzzXmMHuG8u1E6TbOsVkaOtaNKZ/A+0q3vonlBEb0GCiqRBF
 IpPXDZ9WTgLgns3FkrpKhLrKQcfsLbBDZ2fxSzNjzXFP/WnJFSO9ZyXQMOFBp65IXeHcloHKF
 qxdAPxhr0JXN7mY/fGWzadRPg9f0YQmareAZJ5ZLXYnkiRPbo3U6gNwBOdOBkzQGF6byrfryq
 FtYQBM0M/j98tpMxjDDBGBnYVTxzejsRnGAMiL7Cx0F+2y4c8vll+3P0cB2gS15/6am7UmYXV
 G0fvM3UVu5yW8k5yzL1iCyp+uGuQhbANEiKoc99RsGKJ5h98++24kTFQqF9OjoXNizGvT/3s4
 DP69+oPbvBaNanoN42LMcoe/cOlEUc2RQFRSHNqH6Bm8p4UhokIADgf0jUoIeQR/6YETmKfFn
 eYrbPgDp7AciDNBCG5zUBwZpYZYX6Hv41N2/+9EsZnlnwxICyaEFySsP7MY9XJCh3fmYAQ+/d
 xulxr31fZJ0GMtD7viMTYB9NjfcbUFlenoiCiJ7LliB4c1sz2w599lGsi7hwmD2KdqzP0uthV
 +vg9R6/yFtaGm57oqdZuSHQoVP4zygrhScXMIeX6cbUN9mkVlqfveAITu5qdQx56+hi27KuGG
 4QJLBBa2UbKZg78CNMc247Qa8wGDGWPhwvEMgIle0g==
Content-Transfer-Encoding: quoted-printable

Prepare the tn40xx driver to load for Tehuti TN9510 cards
and set bit 3 in the TN40_REG_MDIO_CMD_STAT register, because otherwise th=
e
AQR105 PHY will not be found. The function of bit 3 is unclear, but may ha=
ve
something to do with the length of the preamble in MDIO communication.

Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
=2D--
 drivers/net/ethernet/tehuti/tn40.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/teh=
uti/tn40.c
index 259bdac24cf2..4e6f2f781ffc 100644
=2D-- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -1760,6 +1760,9 @@ static int tn40_probe(struct pci_dev *pdev, const st=
ruct pci_device_id *ent)
 		goto err_unset_drvdata;
 	}

+	/* essential for identification of some PHYs is bit 3 set */
+	ret =3D tn40_read_reg(priv, TN40_REG_MDIO_CMD_STAT);
+	tn40_write_reg(priv, TN40_REG_MDIO_CMD_STAT, ret | 0x8);
 	ret =3D tn40_mdiobus_init(priv);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to initialize mdio bus.\n");
@@ -1832,6 +1835,7 @@ static const struct pci_device_id tn40_id_table[] =
=3D {
 			 PCI_VENDOR_ID_ASUSTEK, 0x8709) },
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, 0x4022,
 			 PCI_VENDOR_ID_EDIMAX, 0x8103) },
+	{ PCI_VDEVICE(TEHUTI, 0x4025), 0 },
 	{ }
 };

=2D-
2.45.2


