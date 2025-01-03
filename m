Return-Path: <netdev+bounces-154976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D832A00890
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 12:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50BC1884E52
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 11:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD181F9AAD;
	Fri,  3 Jan 2025 11:22:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B921527AC
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 11:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735903330; cv=none; b=h9308frWU2G56jTufywKgSgCC39Gp9cwJAvW1VLHqCJZN3dzsSqsY7lXn/6P7ZiTrQZSaXkXYglfgaqfRhGchNkb1K7Cm7Mtcr3KJOXeaIZ+6s6x0+moAFYmgLvNhpEEY8P2BelO2aUXPEhpKfRpe0kjk0TD5XuLzCMzFPRsicA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735903330; c=relaxed/simple;
	bh=hqjKIcAn/JjK8QtvzDCx75t3i05WYAf1g3x+E2dmvK4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Afi7c2XgcugPBfPv36hg3yqR1fLIfmYSwz3JaJRyBCs2Q9jtpvNnT3afSy1zclp1MxeOXZ7NQaCTD9mObNQ1642VQbhsSZc7RZMy548wvNwI8bFrMDzNa80jmyAWSRjIIAizvkMCasyLtZ4KoekaLbXPGke9u8cfOLyZW6BDPes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_128_GCM_SHA256:128)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1tTfkQ-000000005Zl-06kY;
	Fri, 03 Jan 2025 11:21:46 +0000
Date: Fri, 03 Jan 2025 11:21:41 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
CC: Alexander Couzens <lynxis@fe80.eu>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Jakub Kicinski <kuba@kernel.org>,
 Jose Abreu <joabreu@synopsys.com>, Jose Abreu <Jose.Abreu@synopsys.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next_3/6=5D_net=3A_pcs=3A_mtk-?=
 =?US-ASCII?Q?lynxi=3A_fill_in_PCS_supported=5Finterfaces?=
User-Agent: K-9 Mail for Android
In-Reply-To: <E1tTffV-007RoP-8D@rmk-PC.armlinux.org.uk>
References: <Z3fG9oTY9F9fCYHv@shell.armlinux.org.uk> <E1tTffV-007RoP-8D@rmk-PC.armlinux.org.uk>
Message-ID: <0FB3C53E-2F15-4ACB-9567-C0400762C4C0@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 3 January 2025 11:16:41 UTC, "Russell King (Oracle)" <rmk+kernel@armlin=
ux=2Eorg=2Euk> wrote:
>Fill in the new PCS supported_interfaces member with the interfaces
>that the Mediatek LynxI supports=2E
>
>Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux=2Eorg=2Euk>

Acked-by: Daniel Golle <daniel@makrotopia=2Eorg>

>---
> drivers/net/pcs/pcs-mtk-lynxi=2Ec | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/drivers/net/pcs/pcs-mtk-lynxi=2Ec b/drivers/net/pcs/pcs-mtk-=
lynxi=2Ec
>index 7de804535229=2E=2Ea6153e9999a7 100644
>--- a/drivers/net/pcs/pcs-mtk-lynxi=2Ec
>+++ b/drivers/net/pcs/pcs-mtk-lynxi=2Ec
>@@ -306,6 +306,10 @@ struct phylink_pcs *mtk_pcs_lynxi_create(struct devi=
ce *dev,
> 	mpcs->pcs=2Epoll =3D true;
> 	mpcs->interface =3D PHY_INTERFACE_MODE_NA;
>=20
>+	__set_bit(PHY_INTERFACE_MODE_SGMII, mpcs->pcs=2Esupported_interfaces);
>+	__set_bit(PHY_INTERFACE_MODE_1000BASEX, mpcs->pcs=2Esupported_interface=
s);
>+	__set_bit(PHY_INTERFACE_MODE_2500BASEX, mpcs->pcs=2Esupported_interface=
s);
>+
> 	return &mpcs->pcs;
> }
> EXPORT_SYMBOL(mtk_pcs_lynxi_create);

